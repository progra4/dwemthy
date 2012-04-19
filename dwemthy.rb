class Creature

  def initialize(life, strength, charisma, weapon, name = nil)
    @name = name || "Unknown"
    @life = life
    @strength = strength
    @charisma = charisma
    @weapon = weapon
  end

  attr_reader :life, :strength, :charisma, :weapon, :name
  #attr_writer :name
  attr_accessor :name
  
  def self.create_random
    random_name = ('a'..'z').to_a.sample(10).join.capitalize
    Creature.new rand(1..100), rand(1..10), rand(1..100), rand(1..100), random_name
  end


  def to_s
    "#{self.class}: life = #{life}, weapon = #{weapon}"
  end
end
