namespace :taskmaster do

  desc "Generate crontab"
  task :generate do
    output = Taskmaster.cron_output
    puts output
  end
end