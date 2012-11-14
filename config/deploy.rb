require "bundler/capistrano"
require "rvm/capistrano" 

set :application, "Who to Vote?"
set :repository,  "https://github.com/rystraum/who2vote"

set :scm, :git
set :deploy_via, :remote_cache

set :use_sudo, false
set :rvm_ruby_string, '1.9.3@default'
set :rvm_type, :system  # Copy the exact line. I really mean :system here

ssh_options[:keys] = [File.join(ENV["HOME"],".ssh","blank")]
ssh_options[:forward_agent] = true

set :deploy_to, "/home/ubuntu/who2vote"
set :user, "ubuntu"

set :rails_env, "production"
set :domain, "ec2-175-41-151-85.ap-southeast-1.compute.amazonaws.com"
server "ec2-175-41-151-85.ap-southeast-1.compute.amazonaws.com", :app, :web, :db, :primary => true 
 
namespace :deploy do
  task :restart, :roles => :web do
    run "touch #{ current_path }/tmp/restart.txt"
  end
end

namespace :assets do
  desc "Compress assets in a local file"
  task :compress_assets do
    set :rails_env, "staging"
    run_locally("rm -rf public/assets/*")
    run_locally("bundle exec rake assets:precompile")
    run_locally("touch assets.tgz && rm assets.tgz")
    run_locally("tar zcvf assets.tgz public/assets/")
    run_locally("mv assets.tgz public/assets/")
  end

  desc "Upload assets"
  task :upload_assets do
    upload("public/assets/assets.tgz", release_path + '/assets.tgz')
    run "cd #{release_path}; tar zxvf assets.tgz; rm assets.tgz"
    run_locally("rm -rf public/assets/*")
  end
end

before "deploy:update_code", "assets:compress_assets"
after "deploy:create_symlink", "assets:upload_assets"