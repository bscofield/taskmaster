require 'whenever'

require 'taskmaster/henchman'
require 'taskmaster/railtie'

module Taskmaster
  def self.aggregate
    load_rails_models
    hash = Henchman.included_in.inject({}) do |hash, klass|
      hash[klass.name] = klass.cron_output.strip
      hash
    end
    hash
  end

  def self.aggregate_whenever
    load_rails_models
    array = Henchman.included_in.inject([]) do |arr, klass|
      arr += klass.scheduled_jobs.map(&:whenever_source)
      arr
    end
    array.flatten.join("\n")
  end

  def self.section(key, cron)
    buffer = []
    buffer << "#-- begin Taskmaster cron for #{application} - #{key}"
    buffer << cron
    buffer << "#-- end Taskmaster cron for #{application} - #{key}\n"
    buffer
  end

  def self.cron_output
    raw_output = aggregate
    raw_output.keys.map { |key| section(key, raw_output[key]) }.join("\n")
  end

  def self.application
    Rails.root.basename.to_s
  rescue
    "application"
  end

  private
  def self.load_rails_models
    if defined?(Rails)
      Dir[Rails.root.join('app', 'models', '**', '*.rb')].each { |file| require file }
    end
  end
end