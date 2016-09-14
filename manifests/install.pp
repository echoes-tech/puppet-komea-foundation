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
  
  exec { "create_git_working_directory":
    command => "/bin/mkdir -p ${git_working_directory}",
  } ->
  file { "${git_working_directory}":
    ensure => 'directory',
    mode   => '0755',
    owner   => "${superuser_login}",
    group   => "${superuser_login}"
  }

  file { '/etc/init.d/foundation':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/komea_foundation/application.sh',
    notify  => Service['foundation']
  }

  file { "/home/${superuser_login}/unused_ip.sh":
    ensure  => 'present',
    owner   => "${superuser_login}",
    group   => "${superuser_login}",
    mode    => '0744',
    source  => 'puppet:///modules/komea_foundation/unused_ip.sh'
  }

  file { "/home/${superuser_login}/install_module.sh":
    ensure  => 'present',
    owner   => "${superuser_login}",
    group   => "${superuser_login}",
    mode    => '0744',
    source  => 'puppet:///modules/komea_foundation/ssh_install_module.sh'
  }

  file { "/opt/echoes/foundation/application.properties":
    ensure  => file,
    content => template("${module_name}/application.properties.erb"),
    notify  => Service['foundation']
  }

  file { "${komea_foundation::resources_static_locations}":
    ensure => 'directory'
  } ->
  file { "${komea_foundation::resources_static_locations}/rootCA.crt":
    ensure  => 'present',
    owner   => "${superuser_login}",
    group   => "${superuser_login}",
    mode    => '0744',
    content => "${root_ca_content}"
  }
 
  $install_module_sh = '/tmp/install_module.sh'
 
  file { $install_module_sh:
    source => 'puppet:///modules/komea_foundation/install_module.sh'
  }

  exec { "copy_install_module":
    command => "/usr/bin/scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${install_module_sh} ${superuser_login}@foreman:/home/${superuser_login}",
    user => "${superuser_login}"
  } ->
  exec { "chmod_install_module":
    command => "/usr/bin/ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${superuser_login}@foreman /bin/chmod 700 /home/${superuser_login}/install_module.sh",
    user => "${superuser_login}"
  }

  service { 'foundation':
    ensure => running,
    restart => "/etc/init.d/foundation restart",
    start   => "/etc/init.d/foundation start",
    stop    => "/etc/init.d/foundation stop",
    #status  => '/etc/init.d/foundation status',
    status  => "/etc/init.d/foundation status | /bin/grep -q 'is running'",
  }

  class {'nexus_artifact':
    url      => "${nexus_url}",
    password => "${nexus_password}",
    username => "${nexus_username}",
  }

  nexus_artifact::artifact {'komea-foundation':
    gav        => "${nexus_artifact_gav}",
    repository => "${nexus_artifact_repository}",
    output     => "${nexus_artifact_output}",
    ensure     => content,
    notify     => Service['foundation'],
    mode       => 0700 
  }
 
}

