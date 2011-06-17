class FootSoldier
  include Taskmaster::Henchman

  every 10.minutes

  def self.run
    # get beaten up by a superhero
  end
end

class MultiSoldier
  include Taskmaster::Henchman

  every 1.hour, :run => :specialty

  def self.specialty
    # run this one
  end
end
