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
      def every(frequency, options = {})
        @scheduled_jobs ||= []
        method  = options.delete(:run) || :run
        command = options.delete(:command) || :runner
        @scheduled_jobs << "every #{frequency.to_s}, #{options.inspect} do
  #{command.to_s} \'#{self.name}.#{method.to_s}\'
end"
      end

      def run
        raise 'Not implemented'
      end

      def cron_output
        Whenever::JobList.new(@scheduled_jobs.join("\n")).generate_cron_output
      end
    end
  end
end
