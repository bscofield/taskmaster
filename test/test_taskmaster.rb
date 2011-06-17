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

  def test_taskmaster_should_not_know_an_app_name_when_not_in_rails
    Rails.expects(:root).raises(StandardError)
    assert_equal "application", Taskmaster.application
  end

  def test_taskmaster_should_know_a_rails_app_name
    assert_equal "hydra", Taskmaster.application
  end

    def test_taskmaster_should_generate_sectioned_crontab_format
      expected = <<-OUTOUTDAMNEDSPOT
### begin Taskmaster cron for hydra - FootSoldier
0,10,20,30,40,50 * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''FootSoldier.run'\\'''
### end Taskmaster cron for hydra - FootSoldier

### begin Taskmaster cron for hydra - SpecialSoldier
0 * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''SpecialSoldier.specialty'\\'''
### end Taskmaster cron for hydra - SpecialSoldier

### begin Taskmaster cron for hydra - MultiSoldier
* * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''MultiSoldier.run'\\'''

0 * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''MultiSoldier.specialty'\\'''
### end Taskmaster cron for hydra - MultiSoldier

### begin Taskmaster cron for hydra - SpecificSoldier
20 * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''SpecificSoldier.run'\\'''
### end Taskmaster cron for hydra - SpecificSoldier

### begin Taskmaster cron for hydra - CommandSoldier
0 * * * * /bin/bash -l -c 'CommandSoldier.run'
### end Taskmaster cron for hydra - CommandSoldier

### begin Taskmaster cron for hydra - FrequencySoldier
0 * * * * /bin/bash -l -c 'FrequencySoldier.run'
### end Taskmaster cron for hydra - FrequencySoldier
OUTOUTDAMNEDSPOT

      assert_equal expected, Taskmaster.cron_output
    end
end
