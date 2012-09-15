# SlotMachine

Ruby gem for matching available slots (time slots are also supported)

## Introduction

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

## Installation

### Add `SlotMachine` to your Gemfile

    gem "slot_machine"

### Install the gem dependencies

    $ bundle

## Usage

### SlotMachine::Slot module

The core implementation of the SlotMachine gem is written in `SlotMachine::Slot`. A module which has to be included within a Ruby class.

The gem provides the classes `Slot` and `TimeSlot` of which `Slot` is defined as follows:

    class Slot
      include SlotMachine::Slot
    end

Cool, huh? `TimeSlot` also includes the `SlotMachine::Slot` module and overrides a few methods to provide time slot specific behaviour.

### Slot

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

### TimeSlot

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

## Using the console

The SlotMachine repo is provided with `script/console` which you can use for development / testing purposes.

Run the following command in your console:

    $ script/console
    Loading development environment (SlotMachine 0.1.0)
    [1] pry(main)> s = Slot.new 0..25
    => #<Slot @start=0 @end=25>
    [2] pry(main)> s.match 15
    => [#<Slot @start=0 @end=15>, #<Slot @start=10 @end=25>]
    [3] pry(main)> s.match 10, 4
    => [#<Slot @start=0 @end=10>,
     #<Slot @start=4 @end=14>,
     #<Slot @start=8 @end=18>,
     #<Slot @start=12 @end=22>]
    [4] pry(main)> ts = TimeSlot.new 1015..1045
    => #<TimeSlot @start=1015 @end=1045>
    [5] pry(main)> ts.match 10
    => [#<TimeSlot @start=1015 @end=1025>, #<TimeSlot @start=1030 @end=1040>]
    [6] pry(main)> ts.match 10, 5
    => [#<TimeSlot @start=1015 @end=1025>,
     #<TimeSlot @start=1020 @end=1030>,
     #<TimeSlot @start=1025 @end=1035>,
     #<TimeSlot @start=1030 @end=1040>,
     #<TimeSlot @start=1035 @end=1045>]

## Testing

Run the following command for testing:

    $ rake

You can also run a single test file:

    $ ruby test/unit/test_time_slot.rb

## TODO

* Accept Time objects within TimeSlot

## Contact me

For support, remarks and requests, please mail me at [paul.engel@holder.nl](mailto:paul.engel@holder.nl).

## License

Copyright (c) 2012 Paul Engel, released under the MIT license

[http://holder.nl](http://holder.nl) - [http://codehero.es](http://codehero.es) - [http://gettopup.com](http://gettopup.com) - [http://github.com/archan937](http://github.com/archan937) - [http://twitter.com/archan937](http://twitter.com/archan937) - [paul.engel@holder.nl](mailto:paul.engel@holder.nl)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.