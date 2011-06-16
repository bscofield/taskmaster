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
        @schedule = "every #{frequency.to_s}, #{options.inspect} do
  runner \'#{self.name}.run\'
end"
      end

      def run
        raise 'Not implemented'
      end

      def cron_output
        Whenever::JobList.new(@schedule).generate_cron_output
      end
    end
  end
end
