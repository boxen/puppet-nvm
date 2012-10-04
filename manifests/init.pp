class nvm {
  require github::config

  $dir  = "${github::config::home}/nvm"
  $exec = "${github::config::bindir}/gh-nvm-exec"

  repository { $dir:
    require => File[$github::config::home],
    source  => 'git://github.com/creationix/nvm.git'
  }

  file { "${dir}/alias":
    ensure  => directory,
    require => Repository[$dir]
  }

  file { "${github::config::envdir}/nvm.sh":
    source  => 'puppet:///modules/nvm/nvm.sh',
    require => File[$github::config::envdir]
  }

  file { $exec:
    source => 'puppet:///modules/nvm/gh-nvm-exec.sh',
    mode   => 0755
  }

  file { "${github::config::bindir}/node":
    ensure => link,
    target => $exec
  }

  file { "${github::config::bindir}/npm":
    ensure => link,
    target => $exec
  }

  file { "${github::config::bindir}/node-waf":
    ensure => link,
    target => $exec
  }
}
