# rubocop:disable Style/AlignParameters
server 'proconist.net',
  user: ENV['PROCONISTNET_DEPLOY_USER'],
  roles: %w(web app db),
  ssh_options: {
    user: ENV['PROCONISTNET_DEPLOY_USER'],
    keys: ENV['PROCONISTNET_DEPLOY_KEY'],
    port: ENV['PROCONISTNET_DEPLOY_PORT'],
    auth_methods: %w(publickey)
  }

set :stage, :production
set :rails_env, :production

# puma settings
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_default_hooks, false
set :puma_preload_app, false
set :prune_bundler, true

# fetch environment variable from .bashrc
set :default_shell, '/bin/bash -l'
