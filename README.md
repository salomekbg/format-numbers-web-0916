---
languages: ruby
tags: collect, iteration, regex, normalization, todo
resources: 3
---

# Format Numbers

## Contents

|Section|
|-------|
|[Objective](#objective)|
|[Instructions](#instructions)|
|[Pointers](#pointers)|
|[Bonus](#bonus)|
|[Resources](#resources)|

## Objective

Write a method that can take any integer and add commas. For instance:

| Argument | Return Value |
|----------|--------------|
| 35       | 35           |
| 1051     | 1,051        |
| 609124   | 609,124      |
| 23482243 | 23,482,243   |

## Instructions

While this lab is test-driven, try thinking out how you're going to approach the problem. Once you have an idea, code it out and run `rspec` and get those tests to pass.

## Pointers

To get started on this lab, it might help to think about you, as a human, do when you have to add commas to a long number. There are a couple of different, eqally valid, approaches.

Let's say you have the number pi time ten to the tenth power, rounded to the nearest integer, or `31415926536`.

### Option One

One approach is to take the unformatted number and flip it around, then every three numbers, add a comma.

* 31415926536
  * flip it 
* 63562951413
  * add first comma
* 635,62951413
  * add second comma
* 635,629,51413
  * etc.
* 635,629,514,13
  * flip back around
* 31,415,926,536

### Option Two

Another approach could be to find the length of the string. Divide the length of the string by three, the number of digits that commas sandwich. Make that many multiples of four. Negate every value. Insert commas at these indexes.

```ruby
number = "31415926536"

# find the total number of digits
num_of_digits = number.length
# => 11

# divide num of digits by three
num_of_commas = num_of_digits / 3
# => 3

# make an array that will keep track of all the indexes where commas should be inserted
indexes = []

# find num_of_commas number of multiples of four
i = 0
num_of_commas.times { indexes << i += 4 }
# indexes = [4,8,12]

# make every element in the indexes array negative
updated_indexes = indexes.map { |i| i * -1 }
# updated_indexes = [-4,-8,-12]

# insert a comma at every index
updated_indexes.each { |i| number.insert(i, ",") }

number
# => "31,415,926,536"

```

### Option Three

This functionality can also be achieved through one line of regex. Need to brush up on regex? Take a look at [Rubular](http://rubular.com/) and [Regex Crossword](http://regexcrossword.com/). If you really want to know how, try searching [Stack Overflow](http://stackoverflow.com/).

## Bonus

Once all your tests pass, take a look at [this post](http://stackoverflow.com/a/721415/2890716). What are positive lookahead assertions? How do they work? 

## Resources

* [Rubular](http://rubular.com/)
* [Regex Crossword](http://regexcrossword.com/)
* [Stack Overflow](http://stackoverflow.com/)
