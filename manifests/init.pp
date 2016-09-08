class komea_foundation (

  $dashboard_metrics_url      = $komea_foundation::params::dashboard_metrics_url,
  $ksf_fqdn                   = $komea_foundation::params::ksf_fqdn,
  $superuser_login            = $komea_foundation::params::superuser_login,
  $superuser_password         = $komea_foundation::params::superuser_password,
  $root_ca_content            = $komea_foundation::params::root_ca_content,
  $resources_static_locations = $komea_foundation::params::resources_static_locations,
  $ksf_security_internal_remember_token = $komea_foundation::params::ksf_security_internal_remember_token,

) inherits komea_foundation::params {

  anchor { "${module_name}::begin": } ->
  class { "${module_name}::install": } ->
  class { "${module_name}::config": } ->
  anchor { "${module_name}::end": }
}

