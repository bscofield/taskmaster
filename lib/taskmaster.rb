require 'whenever'

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

  def self.cron_output
    load_rails_models
    buffer = []
    raw_output.keys.each do |key|
      buffer << "### begin Taskmaster cron for #{application} - #{key}"
      buffer << raw_output[key]
      buffer << "### end Taskmaster cron for #{application} - #{key}\n"
    end
    buffer.join("\n")
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