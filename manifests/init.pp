# -- Class: ci_server::jenkins::jobs
#
# A class for defining jenkins jobs
#
class ci_example (
  $jobs = undef,
) {

  $command_to_run = "/usr/bin/uptime"

  # Make sure the base directory exists
  file { '/var/lib/jenkins/jobs':
    ensure  => directory,
    owner   => 'jenkins',
    group   => 'jenkins',
    mode    => '0755',
    require => Class['jenkins'],
  }

  # Directories and config files for the various jobs
  file { "/var/lib/jenkins/jobs/test_job":
    ensure  => directory,
    owner   => 'jenkins',
    group   => 'jenkins',
    mode    => '0755',
    require => File['/var/lib/jenkins/jobs'],
  }

  file { "/var/lib/jenkins/jobs/test_job/config.xml":
    ensure  => file,
    owner   => 'jenkins',
    group   => 'jenkins',
    mode    => '0644',
    content => template('ci_example/test_job_config.xml.erb'),
    require => File["/var/lib/jenkins/jobs/test_job"],
  }

}
