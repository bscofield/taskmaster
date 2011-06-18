require 'taskmaster'

module Taskmaster
  module Henchman
    def self.included(base)
      base.extend ClassMethods

      @including_classes ||= []
      @including_classes << base
    end

    def self.included_in
      @including_classes
    end

    module ClassMethods
      # Declares the cron job using `whenever` syntax.
      #
      # @param [Integer, #to_s] frequency any frequency defined as valid for `whenever` (e.g., 600 (seconds), 1.day, :sunday, '0 12 * * *')
      # @param [Hash] options configuration options
      # @option options [Symbol] :run (:run) the class method to call in the cron job
      # @option options [Symbol] :with (:runner) the `whenever` job type to use when defining the cron job
      # @option options [Integer, #to_s] :at a specific time to start the cron job (e.g., `every :hour, :at => 6' runs a job 6 minutes after every hour; `every :day, :at => '4:30 am' runs a job at 4:30 am every day.)
      def every(frequency, options = {})
        @scheduled_jobs ||= []
        method  = options.delete(:run) || :run
        command = options.delete(:with) || :runner
        @scheduled_jobs << "every #{frequency.to_s}, #{options.inspect} do
  #{command.to_s} \'#{self.name}.#{method.to_s}\'
end"
      end

      # Must be overridden by including classes
      def run
        raise 'Not implemented'
      end

      # Cron syntax  generated from the jobs scheduled in the including class
      #
      # @return [String] the cron syntax string
      def cron_output
        Whenever::JobList.new(@scheduled_jobs.join("\n")).generate_cron_output
      end

      # Jobs scheduled by the including class
      #
      # @return [Array] an array of whenever-syntax jobs
      def scheduled_jobs
        @scheduled_jobs
      end
    end
  end
end
