require 'whenever'

require 'taskmaster/command_line'
require 'taskmaster/henchman'
require 'taskmaster/railtie'

module Taskmaster
  def self.raw_output
    load_rails_models
    hash = Henchman.included_in.inject({}) do |hash, klass|
      hash[klass.name] = klass.cron_output.strip
      hash
    end
      hash
  end

  def self.section(key, cron)
    buffer = []
    buffer << "#-- begin Taskmaster cron for #{application} - #{key}"
    buffer << cron
    buffer << "#-- end Taskmaster cron for #{application} - #{key}\n"
    buffer
  end

  def self.cron_output
    load_rails_models
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