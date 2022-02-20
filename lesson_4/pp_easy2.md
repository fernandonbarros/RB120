Q1: It will print:
"You will ___" where ___ is one of the choices

Q2: It will print:
"You will ___" where ___ is one of the choices from the RoadTrip class

Q3: You can find that out by calling the method .ancestors on the object.

Orange, Taste, Object, Kernel, BasicObject
HotSauce, Taste, Object, Kernel, BasicObject

Q4: Add `attr_accessors` inside the class definition

Q5: 
excited_dog is a local variable
@excited_dog is an instance variable
@@excited_dog is a class variable

You can tell based on the prefix of the variable name.

Q6:
`self.manufacturer` is a class method because it is prefixed by the keyword `self.` which refers to the class itself

Q7:
The `@@cats_count` variable keeps track of the number of `Cat` objects created. Each time a new `Cat` object is instanciated, the @@cats_count is incremented.

To test this, I would create multiple `Cat` objects and then call `Cat.cats_count`. This should return the number of objects that were created.

Q8:
`class Bingo < Game`

Q9:
If a method called `play` was added to the `Bingo` class definition it would overwrite the `play` method inherited from the `Game` class.

Q10:
- Helps organize the code in a logical manner
- Increases code reusability
- Avoids code repetition
- Compartmentalizes code
- Possibly makes debugging easier
- Allows the code to be protected by only allowing users to access part of the code
- Easier to manage complex code