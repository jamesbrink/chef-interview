worker_processes 4
timeout 10
preload_app true
pid "./tmp/pids/rack.pid"
#listen 8901
listen "/apps/alpha/current/tmp/sockets/unicorn.alpha.sock"