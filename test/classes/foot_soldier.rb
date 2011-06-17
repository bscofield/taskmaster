class FootSoldier
  include Taskmaster::Henchman

  every 10.minutes

  def self.run
    # get beaten up by a superhero
  end
end

class SpecialSoldier
  include Taskmaster::Henchman

  every 1.hour, :run => :specialty

  def self.specialty
    # run this one
  end
end

class MultiSoldier
  include Taskmaster::Henchman

  every 1.minute
  every 1.hour, :run => :specialty

  def self.specialty
    # run this one
  end

  def self.run
    # do something cool
  end
end

class SpecificSoldier
  include Taskmaster::Henchman

  every 1.hour, :at => 20

  def self.run
    # get beaten up by a superhero
  end
end

class CommandSoldier
  include Taskmaster::Henchman

  every 1.hour, :command => :command

  def self.run
    # nothing to see here
  end
end

class FrequencySoldier
  include Taskmaster::Henchman

  every 1.hour, :command => :command

  def self.run
    # nothing to see here
  end
end