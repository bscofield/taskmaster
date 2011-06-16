require 'helper'

class TestTaskmaster < Test::Unit::TestCase
  def test_constants_should_exist
    assert_nothing_raised do
      Taskmaster
      Taskmaster::Henchman
    end
  end

  def test_taskmaster_should_know_all_output
    assert_equal "0,10,20,30,40,50 * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''FootSoldier.run'\\'''", Taskmaster.cron_output.strip
  end
end
