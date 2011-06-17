require 'helper'

module Rails
  def self.root
    Pathname.new('/root/hydra')
  end
end

class TestTaskmaster < Test::Unit::TestCase
  def test_constants_should_exist
    assert_nothing_raised do
      Taskmaster
      Taskmaster::Henchman
    end
  end

  def test_taskmaster_should_know_all_output
    output = Taskmaster.raw_output

    assert_equal "0,10,20,30,40,50 * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''FootSoldier.run'\\'''", output['FootSoldier']
    assert_equal "0 * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''SpecialSoldier.specialty'\\'''", output['SpecialSoldier']
    assert_equal "* * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''MultiSoldier.run'\\'''", output['MultiSoldier'].split(/\n+/)[0]
    assert_equal "0 * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''MultiSoldier.specialty'\\'''", output['MultiSoldier'].split(/\n+/)[1]
  end

  def test_taskmaster_should_generate_sectioned_crontab_format
    output = Taskmaster.cron_output
    p output

    flunk 'not yet'
  end

  def test_taskmaster_should_not_know_an_app_name_when_not_in_rails
    Rails.expects(:root).raises(StandardError)
    assert_equal "application", Taskmaster.application
  end

  def test_taskmaster_should_know_a_rails_app_name
    assert_equal "hydra", Taskmaster.application
  end
end
