class nvm {
  require boxen::config

  $dir  = "${boxen::config::home}/nvm"
  $exec = "${boxen::config::bindir}/boxen-nvm-exec"

  repository { $dir:
    require  => File[$boxen::config::home],
    source   => 'creationix/nvm',
    protocol => 'git'
  }

  file { "${dir}/alias":
    ensure  => directory,
    require => Repository[$dir]
  }

  file { "${boxen::config::envdir}/nvm.sh":
    source  => 'puppet:///modules/nvm/nvm.sh',
    require => File[$boxen::config::envdir]
  }

  file { $exec:
    source => 'puppet:///modules/nvm/boxen-nvm-exec.sh',
    mode   => 0755
  }

  file { "${boxen::config::bindir}/node":
    ensure => link,
    target => $exec
  }

  file { "${boxen::config::bindir}/npm":
    ensure => link,
    target => $exec
  }

  file { "${boxen::config::bindir}/node-waf":
    ensure => link,
    target => $exec
  }
}
