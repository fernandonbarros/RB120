Q1. All are objects. You can find out their class through the .class method.

Q2.  Add `include Speed` to the class definitions. A possible way to check if a
car or truck can `go_fast` is to create an instance of each class and attempt to
call the `go_fast` method.

Q3. This is done by adding `#{self.class}` to the `go_fast` output string. The
keyword `self` is referencing the object calling the `go_fast` method. The
`class` method is then used to get the class of the object. 

Q4. A new instance can be create as follows:
`cat = AngryCat.new`

Q5. The `Pizza` class has an instance variable, since `@name` is prefixed by the
`@` symbol

Q6. We can add `attr_accessor :volume`

Q7. The default return value of `to_s` is a string containing the class name,
object ID, and instance variables and values

Q8. `self` refers to the instance of Cat which is calling the
`make_one_year_older` method.

Q9. In this context `self` refers to the `Cat` class, making `self.cats_count`
a class method

Q10. `Bag.new('brown', 'paper')`