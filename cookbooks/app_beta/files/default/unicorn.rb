worker_processes 4
timeout 10
preload_app true
pid "./tmp/pids/rack.pid"
#listen 8902
listen "/apps/beta/current/tmp/sockets/unicorn.beta.sock"