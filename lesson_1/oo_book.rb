module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  attr_accessor :speed, :color
  attr_reader :model, :year
  @@number_of_vehicles = 0

  def initialize(year, color, model)
    @@number_of_vehicles += 1
    @speed = 0
    @year = year
    @color = color
    @model = model
  end
  
  def age
    "Your #{self.model} is #{years_old} years old."
  end

  def speed_up(speed_delta)
    self.speed += speed_delta
  end

  def brake(speed_delta)
    self.speed -= speed_delta
  end

  def shut_off
    self.speed = 0
  end

  def spray_paint(color)
    self.color = color
    puts "Your car is now #{color}!"
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  private
  def years_old
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  def initialize(year, color, model)
    super
  end

  def to_s
    "Your car is a #{self.year} #{self.color} #{self.model} going #{self.speed}"
  end
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
  include Towable

  def initialize(year, color, model)
    super
  end

  def to_s
    "Your truck is a #{self.year} #{self.color} #{self.model} going #{self.speed}"
  end
end

lola = MyCar.new(2015, 'blue', 'kia')
MyCar.gas_mileage(13, 351)

Vehicle.ancestors
MyCar.ancestors
MyTruck.ancestors

puts lola.age
