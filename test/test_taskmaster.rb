require 'helper'

class TestTaskmaster < Test::Unit::TestCase
  def test_constants_should_exist
    assert_nothing_raised do
      Taskmaster
      Taskmaster::Henchman
    end
  end

  def test_taskmaster_should_know_all_output
    output = Taskmaster.cron_output.split(/\n+/)
    assert_equal "0,10,20,30,40,50 * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''FootSoldier.run'\\'''", output[0]
    assert_equal "0 * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''SpecialSoldier.specialty'\\'''", output[1]
    assert_equal "* * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''MultiSoldier.run'\\'''", output[2]
    assert_equal "0 * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''MultiSoldier.specialty'\\'''", output[3]
  end
end
