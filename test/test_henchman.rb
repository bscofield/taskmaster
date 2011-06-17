require 'helper'

class TestHenchman < Test::Unit::TestCase
  def test_class_should_be_definable
    assert_nothing_raised do
      FootSoldier
      SpecialSoldier
    end
  end

  def test_footsoldier_should_have_expected_cron_output
    assert_equal "0,10,20,30,40,50 * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''FootSoldier.run'\\'''", FootSoldier.cron_output.strip
  end

  def test_specialsoldier_should_have_expected_cron_output
    assert_equal "0 * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''SpecialSoldier.specialty'\\'''", SpecialSoldier.cron_output.strip
  end

  def test_multisoldier_should_have_multiple_cron_jobs
    output = MultiSoldier.cron_output.split(/\n+/)
    assert_equal 2, output.size

    assert_equal "* * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''MultiSoldier.run'\\'''", output[0]
    assert_equal "0 * * * * /bin/bash -l -c 'cd /Users/benscofield/personal/util/taskmaster && script/runner -e production '\\''MultiSoldier.specialty'\\'''", output[1]
  end
end
