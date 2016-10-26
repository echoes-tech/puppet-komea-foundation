# == Class: komea_foundation::params
#
# This is a container class with default parameters for Komea Foundation classes.
class komea_foundation::params {

  # default user credential
  $ksf_fqdn = "localhost"
  $dashboard_metrics_url = "undef"
  $superuser_login = "ksfuser"
  $superuser_password = "password"
  $root_ca_content = "undef"
  $resources_static_locations = '/opt/echoes/foundation/resources/'
  $ksf_security_internal_remember_token = "undef"
  $server_port = "8888"
  $management_port = "8008"
  $jenkins_job_template = "templates/job.xml"

  $redmine_api_access_key = "undef"

  $nexus_url = "undef"
  $nexus_username = "undef"
  $nexus_password = "undef"
  $nexus_artifact_gav = ""
  $nexus_artifact_repository = ""
  $nexus_artifact_output = ""

  $foreman_host_smartProxyId = ""
  $foreman_host_computeProfileId = ""
  $foreman_host_computeResourceId = ""
  $foreman_host_architectureId = ""
  $foreman_host_domainId = ""
  $foreman_host_defaultPassword = ""

  $foreman_hostGroup_subnetId = ""
  $foreman_hostGroup_realmId = ""
  $foreman_hostGroup_ptableId = ""
  $foreman_hostGroup_mediumId = ""
  $foreman_hostGroup_operatingsystemId = ""
  $foreman_provisionMethod = ""
  $foreman_imageId = ""

  $jenkins_use_folders = true
  $jenkins_builds_per_job_limit = 5
  $jenkins_job_release_pattern = "%{projectName}-release-%{releaseVersion}"
  $jenkins_job_feature_pattern = "%{projectName}-feat-%{featureId}-%{featureDescription}"

  $build_system_default_script = "build.sh"
  $artifacts_publish_script = "publish.sh"

  $git_working_directory = "/var/lib/ksf/git"
  $git_branch_release_pattern = "release-%{releaseVersion}"
  $git_branch_feature_pattern = "feat-%{featureId}-%{featureDescription}"

  $dashboard_liferay_template      = "Standard Dashboard"
  $dashboard_liferay_company_webid = "liferay.com"
  $dashboard_liferay_user_group    = "komea"
  $dashboard_metrics_average_time_on_site = false

}
