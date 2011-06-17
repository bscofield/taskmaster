require 'whenever'

require 'taskmaster/henchman'

module Taskmaster
  def self.cron_output
    Henchman.included_in.map { |klass| klass.cron_output.strip }.join("\n")
  end
end