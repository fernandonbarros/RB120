class Person
  attr_accessor :first_name, :last_name
  def initialize(full_name)
    names = full_name.split
    @first_name = names.first
    @last_name = names[1..].join(' ')
  end

  def name
    "#{self.first_name} #{self.last_name}".strip
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'