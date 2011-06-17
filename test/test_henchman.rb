require 'helper'

class TestHenchman < Test::Unit::TestCase
  def test_class_should_be_definable
    assert_nothing_raised do
      FootSoldier
      SpecialSoldier
    end
  end

  def test_the_base_case_should_work
    assert_equal "0,10,20,30,40,50 * * * * /bin/bash -l -c 'cd #{whenever_cd_path} && script/runner -e production '\\''FootSoldier.run'\\'''", FootSoldier.cron_output.strip
  end

  def test_scheduled_methods_should_be_overradble
    assert_equal "0 * * * * /bin/bash -l -c 'cd #{whenever_cd_path} && script/runner -e production '\\''SpecialSoldier.specialty'\\'''", SpecialSoldier.cron_output.strip
  end

  def test_multiple_tasks_can_live_in_a_class
    output = MultiSoldier.cron_output.split(/\n+/)
    assert_equal 2, output.size

    assert_equal "* * * * * /bin/bash -l -c 'cd #{whenever_cd_path} && script/runner -e production '\\''MultiSoldier.run'\\'''", output[0]
    assert_equal "0 * * * * /bin/bash -l -c 'cd #{whenever_cd_path} && script/runner -e production '\\''MultiSoldier.specialty'\\'''", output[1]
  end

  def test_whenever_options_should_be_respected
    assert_equal "20 * * * * /bin/bash -l -c 'cd #{whenever_cd_path} && script/runner -e production '\\''SpecificSoldier.run'\\'''", SpecificSoldier.cron_output.strip
  end

  def test_different_whenever_commands_should_be_usable
    assert_equal "0 * * * * /bin/bash -l -c 'CommandSoldier.run'", CommandSoldier.cron_output.strip
  end

  def test_whenever_alternative_names_should_be_usable
    assert_equal "0 * * * * /bin/bash -l -c 'FrequencySoldier.run'", FrequencySoldier.cron_output.strip
  end
end
