class Creature

  def initialize(opts)
    opts = if opts.is_a?(Hash)
             opts
           elsif opts.is_a?(Array)
             Hash[ [:life, :strength, :charisma, :weapon, :name].zip(opts)  ]
           else
             raise "Learn to use the options!"
           end
    @name = opts[:name]
    @life = opts[:life]
    @strength = opts[:strength]
    @charisma = opts[:charisma]
    @weapon = opts[:weapon]
  end


  attr_reader :life, :strength, :charisma, :weapon, :name
  #attr_writer :name
  attr_accessor :name
  
  alias :life_points :life

  def self.create_random
    random_name = ('a'..'z').to_a.sample(10).join.capitalize
    Creature.new [rand(1..100), rand(1..10), rand(1..100), rand(1..100), random_name]
  end


  def to_s
    "#{name}: life = #{life}, weapon = #{weapon}"
  end

  def dead?
    @life <= 0
  end

  def alive?
    @life > 0
  end

  def hit(damage)
    p_up = rand( charisma )
     if p_up % 9 == 7
       @life += p_up / 4
       puts "[#{ name } magick powers up #{ p_up }!]" 
     end 
     @life -= damage
     puts "[#{ name } has died.]" if dead?
  end

  alias :get_hit :hit

  def fight( enemy, weapon = nil )
   weapon ||= @weapon
   if dead?
     puts "[#{ name } is too dead to fight!]" 
     return
   end

   # Attack the opponent
   your_hit = rand( strength + weapon )
   puts "[#{name} hits #{enemy.name} with #{ your_hit } points of damage!]" 
   enemy.hit( your_hit )

   # Retaliation
   p enemy
   if enemy.alive?
     enemy_hit = rand( enemy.strength + enemy.weapon )
     puts "[ #{enemy.name} hits #{name}  back with #{ enemy_hit } points of damage!]" 
     self.hit( enemy_hit )
   end
  end

  alias :attack :fight
end
