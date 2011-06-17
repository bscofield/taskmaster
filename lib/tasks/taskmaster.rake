require 'fileutils'

namespace :taskmaster do
  desc "Preview the generated crontab"
  task :preview do
    output = Taskmaster.cron_output
    puts output
  end

  desc "Write the generated crontab to config/schedule.rb -- suitable for whenever to write it to the system"
  task :write do
    output = Taskmaster.aggregate_whenever
    FileUtils.mkdir_p 'config'
    FileUtils.touch   'config/schedule.rb'
    File.open('config/schedule.rb', File::WRONLY) do |file|
      file << output
    end
    puts "Your crontab has been written to config/schedule.rb. Please use the whenever script to write it to your system crontab."
  end
end