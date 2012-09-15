module SlotMachine
  module Abstract
    module Slot

      def self.included(base)
        base.class_eval do
          attr_reader :start, :end, :length
        end
      end

      def initialize(range_or_length)
        if range_or_length.is_a? Range
          @type = :range
          self.start = range_or_length.first
          self.end   = range_or_length.last
        else
          @type = :length
          self.length = range_or_length
        end
      end

      def range?
        @type == :range
      end

      def length?
        @type == :length
      end

      def start=(value)
        @start = abs!(lt!(value, @end)) if range?
      end

      def end=(value)
        @end = abs!(gt!(value, @start)) if range?
      end

      def length=(value)
        @length = abs!(value) if length?
      end

      def match(other)
        # do something
      end

    private

      def gt!(value, compared)
        typecast! value, :>, compared
      end

      def lt!(value, compared)
        typecast! value, :<, compared
      end

      def abs!(value)
        typecast! value, :>=, 0
      end

      def typecast!(value, operator, compared)
        Integer(value.to_s).tap do |value|
          raise ArgumentError, "Passed value should be #{operator} #{compared} (#{value} given)" if compared && !value.send(operator, compared)
        end
      end

    end
  end
end