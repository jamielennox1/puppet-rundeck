# == Define: rundeck::config::job
#
define rundeck::config::job(
  $project_name = undef,
  $job_path     = undef,
  ) {

  include ::rundeck

  validate_string($project_name)
  validate_absolute_path($job_path)

  if $project_name == undef {
    fail('project_name must be specified')
  }

  exec { $job_path:
    command   => "sleep 30 && rd-jobs load -p ${project_name} -f ${job_path}",
    path      => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    logoutput => on_failure,
    try_sleep => 10,
    tries     => 5,
    require   => Service['rundeckd'],
  }

}
