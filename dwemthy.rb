require './meta'
class Creature
  include CreatureBuilder
  def name
    self.class
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

module Dwemthy
  GREETING = %Q{
    In this game, you are a rabbit who is going to die.
    A dragon is going to do it. Deep in Dwemthy's Array.
  }
  def self.greet
    puts GREETING
  end

  class Dungeon < Array
    def method_missing( meth, *args )
      answer = first.send( meth, *args )
      if first.dead?
        shift
        if empty?
          puts "[Whoa.  You decimated Dwemthy's Array!]"
        else
          puts "[Get ready. #{ first.name } has emerged.]"
        end
      end
      answer || 0
    end
  end
end
