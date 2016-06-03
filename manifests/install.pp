# Private class
class komea_foundation::install inherits komea_foundation {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { '/etc/init.d':
    ensure => 'directory',
    mode   => '0755'
  }

  file { [ '/opt/echoes', '/opt/echoes/foundation' ]:
    ensure  => 'directory',
    mode    => '0755',
  }

  file { '/etc/init.d/foundation':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/komea_foundation/application.sh',
    notify  => Service['foundation']
  }

  service { 'foundation':
    ensure => running,
    start   => "/etc/init.d/foundation start",
    stop    => "/etc/init.d/foundation stop",
    status  => "/etc/init.d/foundation status",
  } 
}
