require 'fileutils'
require 'tempfile'

module Taskmaster
  class CommandLine < Whenever::CommandLine
    def initialize(options={})
      task_file = Tempfile.new('taskmaster_tmp_cron').path
      File.open(task_file, File::WRONLY | File::APPEND) do |file|
        file << Taskmaster.cron_output
      end
      options = options.merge(:file => task_file)
      p options
      super(options)
    end
  end
end