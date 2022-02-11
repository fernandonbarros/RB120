class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color

# Invocation path
# Cat
# Animal
# Object
# Kernel
# BasicObject