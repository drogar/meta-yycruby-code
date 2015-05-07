## A ruby metaprogramming exercise.

Original metaprogramming exercise and tests from the SF Ruby mailing list. See https://gist.github.com/5b287544800f8a6cddf2

### The challenge

Write some code, in `solution.rb`, that will tell you how many times a particular method is called.  To use it with a script (e.g. `target.rb`)
```
   COUNT_CALLS_FOR=ClassOrModule#method ruby -r solution.rb target.rb
```
to count instance method calls, or
```
   COUNT_CALLS_FOR=ClassOrModule.class_method ruby -r solution.rb target.rb
```
to count class method calls.

### A starting point.

The file `start_solution.rb` included here is a starting point. It will annotate all standard library instance methods. You can start from there, use it as
inspiration for your own or just ignore it and start. This is based on a solution posted at: https://gist.github.com/ryanlecompte/3631742

### Testing if your solution works

First, run `bundle` to install the minitest gem.

Name your solution `solution.rb`. Run the tests with:
```
  ruby meta_counter_test.rb
```
#### Dependencies

I suggest ruby 2.2. Likely works with 2.0 and up.

```
   minitest
```