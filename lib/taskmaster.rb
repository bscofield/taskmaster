require 'whenever'

require 'taskmaster/henchman'
require 'taskmaster/railtie'

module Taskmaster
  def self.cron_output
    # make sure all the models that could include Henchman are loaded
    if defined?(Rails)
      Dir[Rails.root.join('app', 'models', '**', '*.rb')].each { |file| require file }
    end

    Henchman.included_in.map { |klass| klass.cron_output.strip }.join("\n")
  end
end