class Creature

  def initialize(life, strength, charisma, weapon, name = nil)
    @name = name || "Unknown"
    @life = life
    @strength = strength
    @charisma = charisma
    @weapon = weapon
  end

  def life
    @life
  end

  def strength
    @strength
  end

  def charisma
    @charisma
  end

  def weapon
    @weapon
  end

  def name=(new_name)
    @name = new_name
  end

  def name
    @name || "Unknown"
  end

  def self.create_random
    random_name = ('a'..'z').to_a.sample(10).join.capitalize
    Creature.new rand(1..100), rand(1..10), rand(1..100), rand(1..100), random_name
  end


  def to_s
    "#{self.class}: life = #{life}, weapon = #{weapon}"
  end
end
