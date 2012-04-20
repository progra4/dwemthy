module Meta
  def lector(attr)
    define_method attr do
      instance_variable_get "@#{attr}"
    end
  end

  def escritor(attr)
    define_method "#{attr}=" do |val|
      instance_variable_set "@#{attr}", val
    end
  end

  def accesor(attr)
    lector attr
    escritor attr
  end
end

module CreatureBuilder
  def self.included(includer)
    includer.send :extend, ClassMethods

    define_method :initialize do
      self.class.instance_variable_get("@traits").each do |trait, value|
        instance_variable_set "@#{trait}", value
      end
    end
  end

  module ClassMethods
    %w(life charisma strength weapon).each do |trait|
      define_method trait do |default_value|
        attr_reader trait
        @traits ||= {}
        @traits[trait] = default_value
      end
    end
  end
end

module Familiar
  def linaje
    puts "Me llamo #{self.class} y mis ancestros son #{self.class.ancestors.join(", ")}"
  end
end
