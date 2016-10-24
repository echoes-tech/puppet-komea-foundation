class komea_foundation (

  $dashboard_metrics_url                = $komea_foundation::params::dashboard_metrics_url,
  $ksf_fqdn                             = $komea_foundation::params::ksf_fqdn,
  $superuser_login                      = $komea_foundation::params::superuser_login,
  $superuser_password                   = $komea_foundation::params::superuser_password,
  $root_ca_content                      = $komea_foundation::params::root_ca_content,
  $resources_static_locations           = $komea_foundation::params::resources_static_locations,
  $management_port                      = $komea_foundation::params::management_port,
  $server_port                          = $komea_foundation::params::server_port,
  $ksf_security_internal_remember_token = $komea_foundation::params::ksf_security_internal_remember_token,

  $redmine_api_access_key               = $komea_foundation::params::redmine_api_access_key,

  $nexus_url                            = $komea_foundation::params::nexus_url,
  $nexus_username                       = $komea_foundation::params::nexus_username,
  $nexus_password                       = $komea_foundation::params::nexus_password,
  $nexus_artifact_gav                   = $komea_foundation::params::nexus_artifact_gav,
  $nexus_artifact_repository            = $komea_foundation::params::nexus_artifact_repository,
  $nexus_artifact_output                = $komea_foundation::params::nexus_artifact_output,

  $foreman_host_smartProxyId            = $komea_foundation::params::foreman_host_smartProxyId,
  $foreman_host_computeProfileId        = $komea_foundation::params::foreman_host_computeProfileId,
  $foreman_host_computeResourceId       = $komea_foundation::params::foreman_host_computeResourceId,
  $foreman_host_architectureId          = $komea_foundation::params::foreman_host_architectureId,
  $foreman_host_domainId                = $komea_foundation::params::foreman_host_domainId,
  $foreman_host_defaultPassword         = $komea_foundation::params::foreman_host_defaultPassword,

  $foreman_hostGroup_subnetId           = $komea_foundation::params::foreman_hostGroup_subnetId,
  $foreman_hostGroup_realmId            = $komea_foundation::params::foreman_hostGroup_realmId,
  $foreman_hostGroup_ptableId           = $komea_foundation::params::foreman_hostGroup_ptableId,
  $foreman_hostGroup_mediumId           = $komea_foundation::params::foreman_hostGroup_mediumId,
  $foreman_hostGroup_operatingsystemId  = $komea_foundation::params::foreman_hostGroup_operatingsystemId,

  $foreman_provisionMethod              = $komea_foundation::params::foreman_provisionMethod,
  $foreman_imageId                      = $komea_foundation::params::foreman_imageId,

  $jenkins_use_folders                  = $komea_foundation::params::jenkins_use_folders,
  $jenkins_builds_per_job_limit         = $komea_foundation::params::jenkins_builds_per_job_limit,
  $jenkins_job_release_pattern          = $komea_foundation::params::jenkins_job_release_pattern,
  $jenkins_job_feature_pattern          = $komea_foundation::params::jenkins_job_feature_pattern,
  $jenkins_job_template                 = $komea_foundation::params::jenkins_job_template,

  $build_system_default_script          = $komea_foundation::params::build_system_default_script,
  $artifacts_publish_script             = $komea_foundation::params::artifacts_publish_script,

  $git_working_directory                = $komea_foundation::params::git_working_directory,
  $git_branch_release_pattern           = $komea_foundation::params::git_branch_release_pattern,
  $git_branch_feature_pattern           = $komea_foundation::params::git_branch_feature_pattern,


) inherits komea_foundation::params {

  anchor { "${module_name}::begin": } ->
  class { "${module_name}::install": } ->
  class { "${module_name}::config": } ->
  anchor { "${module_name}::end": }
}

