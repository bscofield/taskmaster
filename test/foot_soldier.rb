class FootSoldier
  include Taskmaster::Henchman

  every 10.minutes

  def self.run
    # get beaten up by a superhero
  end
end
