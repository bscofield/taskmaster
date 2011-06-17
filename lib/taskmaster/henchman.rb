require 'taskmaster'

module Taskmaster
  module Henchman
    class ScheduledJob
      def initialize(frequency, klass, options)
        @method = options.delete(:run) || :run
        @command = options.delete(:command) || :runner
        @frequency = frequency
        @options = options
        @klass = klass
      end
      
      def schedule(job_list)
        job_list.every @frequency, @options do
          job_list.send @command, "#{@klass.name}.#{@method}"
        end
      end
      
      def whenever_source
        %{every #{@frequency}, #{@options.inspect} do
  #{@command} '#{@klass.name}.#{@method}'
end}
      end
    end
    
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
        @scheduled_jobs << ScheduledJob.new(frequency, self, options)
#         method  = options.delete(:run) || :run
#         command = options.delete(:command) || :runner
#         @scheduled_jobs << "every #{frequency.to_s}, #{options.inspect} do
#   #{command.to_s} \'#{self.name}.#{method.to_s}\'
# end"
      end

      def run
        raise 'Not implemented'
      end

      def cron_output
        job_list = Whenever::JobList.new('')
        @scheduled_jobs.each{|job| job.schedule(job_list)}
        job_list.generate_cron_output
      end

      def scheduled_jobs
        @scheduled_jobs
      end
    end
  end
end
