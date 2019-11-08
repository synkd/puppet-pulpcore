# @summary Install pulpcore packages
# Currently this is done with pip3. This should have the option to also install via RPMs.
# @api private
class pulpcore::install {

  $system_packages = ['gcc', 'postgresql-devel', 'python3-pip', 'python3-devel', 'centos-release-scl-rh']

  ensure_packages($system_packages)

  package { 'pulpcore':
    ensure   => present,
    provider => 'pip3',
    require  => Package[$system_packages],
  }

  user { $pulpcore::pulp_user:
    ensure     => present,
    gid        => $pulpcore::pulp_group,
    home       => $pulpcore::pulp_user_home,
    managehome => false,
  }

  group { $pulpcore::pulp_group:
    ensure => present,
  }

}