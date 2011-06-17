require 'taskmaster'

module Taskmaster
  if defined? Rails::Railtie
    require 'rails'
    class Railtie < Rails::Railtie
      rake_tasks do
        load "tasks/taskmaster.rake"
      end
    end
  end
end