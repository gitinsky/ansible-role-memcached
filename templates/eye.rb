Eye.application 'memcached-{{ port }}' do
  working_dir '/etc'
  stdall '/var/log/eye/memcached-{{ port }}-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes

  process :memcached_{{ port }} do
    pid_file '/var/run/memcached-{{ port }}.pid'
    start_command '/usr/bin/memcached -m {{ memory }} -p {{ port }} -u {{ user }}'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
