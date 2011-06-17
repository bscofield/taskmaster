= taskmaster

Make your Ruby classes cron-aware!


== Example

The base case is simple -- just include the `Taskmaster::Henchman` module, define a `run` class method, and use `whenever` syntax to specify when and how often the method should run:

    require 'taskmaster'

    class FootSoldier
      include Taskmaster::Henchman

      every 10.minutes, :at => 5

      def self.run
        # do super cool and important stuff
      end
    end

    puts FootSoldier.cron_output # => "5,15,25,35,45,55 * * * * /bin/bash -l -c 'cd /... && script/runner -e production '\''BulkTask.run'\'''"

You can override various pieces of this, including the name of the class method to run:

    every 10.minutes, :run => :special_method

    def self.special_method
      # I'm not the default!
    end

Check the documentation on `Taskmaster::Henchman.every` for details on all the allowed options.

== TODO

* Update the README

== Contributing to taskmaster

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright (c) 2011 Ben Scofield. See LICENSE.txt for
further details.

