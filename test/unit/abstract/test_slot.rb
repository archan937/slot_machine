require File.expand_path("../../../test_helper", __FILE__)

module Unit
  module Abstract
    class TestSlot < MiniTest::Unit::TestCase

      class Foo
        include SlotMachine::Abstract::Slot
      end

      describe SlotMachine::Abstract::Slot do
        describe "instance methods" do
          it "should have the expected instance methods" do
            assert Foo.instance_methods.include?(:range?)
            assert Foo.instance_methods.include?(:length?)
            assert Foo.instance_methods.include?(:start)
            assert Foo.instance_methods.include?(:start=)
            assert Foo.instance_methods.include?(:end)
            assert Foo.instance_methods.include?(:end=)
            assert Foo.instance_methods.include?(:length)
            assert Foo.instance_methods.include?(:length=)
            assert Foo.instance_methods.include?(:match)
          end
        end

        describe "initialization" do
          it "should accept a range" do
            foo = Foo.new 10..20
            assert_equal 10, foo.start
            assert_equal 20, foo.end
          end

          it "should accept a length" do
            foo = Foo.new 10
            assert_equal 10, foo.length
          end

          it "should raise an exception when invalid" do
            assert_raises ArgumentError do
              Foo.new
            end
            assert_raises ArgumentError do
              Foo.new "bar"
            end
            assert_raises ArgumentError do
              Foo.new 1.."bar"
            end
            assert_raises ArgumentError do
              Foo.new "bar"..1
            end
            assert_raises ArgumentError do
              Foo.new "foo".."bar"
            end
          end

          it "should return whether it's a range or a length" do
            foo = Foo.new 10..20
            assert foo.range?
            assert !foo.length?

            foo = Foo.new 10
            assert !foo.range?
            assert foo.length?
          end
        end

        describe "range slots" do
          it "should only set start or end (not length) and typecast the passed argument" do
            foo = Foo.new 10..20

            foo.start = 0
            assert_equal 0, foo.start

            assert_raises ArgumentError do
              foo.start = "bar"
            end

            foo.end = 10
            assert_equal 10, foo.end

            assert_raises ArgumentError do
              foo.end = "bar"
            end

            foo.length = 30
            assert_nil foo.length

            foo.length = "bar"
            assert_nil foo.length
          end

          it "should validate the assigned value" do
            assert_raises ArgumentError do
              Foo.new -10..10
            end

            assert_raises ArgumentError do
              Foo.new 10..1
            end

            foo = Foo.new 10..20

            assert_raises ArgumentError do
              foo.start = -10
            end

            assert_equal 10, foo.start

            assert_raises ArgumentError do
              foo.start = 30
            end
          end
        end

        describe "length slots" do
          it "should only set length (not start or end) and typecast the passed argument" do
            foo = Foo.new 10

            foo.start = 0
            assert_nil foo.start

            foo.start = "bar"
            assert_nil foo.start

            foo.end = 10
            assert_nil foo.end

            foo.end = "bar"
            assert_nil foo.end

            foo.length = 30
            assert_equal 30, foo.length

            assert_raises ArgumentError do
              foo.length = "bar"
            end
          end

          it "should validate the assigned value" do
            assert_raises ArgumentError do
              Foo.new -10
            end

            foo = Foo.new 10

            assert_raises ArgumentError do
              foo.length = -10
            end
          end
        end
      end

    end
  end
end