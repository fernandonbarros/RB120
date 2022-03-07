Q1: Ben, since when `balance` is called ruby will look for the setter method for `balance`

Q2: The code will fail because `quantity =` will create a new local variable called `quantity` instead of accessing the setter method, which is not defined. To fix it I would either define a setter method for `quantity` or add `@` in front of `quantity`.

Q3: Yes, this will allow the user to set negative quantities by calling the setter method directly. A possible solution would be to make the setter method private.

Q4: 
class Greeting
  def greet(sentence)
    puts sentence
  end
end

class Hello < Greeting
  def hi
    self.greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    self.greet("Goodbye")
  end
end

Q5:
class KrispyKreme
attr_reader :glazing, :filling_type
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    base = filling_type ? filling_type : "Plain"
    base + "{' with ' if glazing}{glazing}"
  end
end
    
Q6:
In the first snipper the `template` instance variable is being accessed directly using the `@`, whereas in the seccond snipper the setter method for `template` is being called

Q7:
The method name would be change to `status`. Adding `light_` is unnecessary since the method is already in the `Light` class.