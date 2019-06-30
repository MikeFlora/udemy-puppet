class cockpit {
  package { 'cockpit-package':
    name => 'cockpit',
    ensure => present,
  }
  
  file { 'cockpit-config':
    path => '/etc/cockpit/cockpit.conf',
    ensure => file,
    source => 'puppet:///modules/cockpit/cockpit.conf',
    owner => root,
    group => root,
    mode => '0644',
    require => Package['cockpit-package'],
    notify => Service['cockpit-service'],
  }
  
  service { 'cockpit-service':
    name => 'cockpit.service',
    ensure => running,
    enable => true,
    hasrestart => true,
    require => [File['cockpit-config']],
  }
}
