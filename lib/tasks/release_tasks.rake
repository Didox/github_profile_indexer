namespace :heroku do
  desc "Run tasks after deploy"
  task :run_tasks => :environment do
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end
end
