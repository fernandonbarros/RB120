class Cat
  @@cat_count = 0

  def self.total
    puts @@cat_count
  end

  def initialize
    @@cat_count += 1
  end
end

kitty1 = Cat.new
kitty2 = Cat.new

Cat.total