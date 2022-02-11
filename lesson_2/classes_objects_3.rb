class Person
  attr_accessor :first_name, :last_name
  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{self.first_name} #{self.last_name}".strip
  end

  def name=(names)
    self.parse_full_name(names)
  end

  def parse_full_name(names)
    parts = names.split

    self.first_name = parts.first
    self.last_name = parts[1..].join(' ') if parts.length > 1
  end
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'