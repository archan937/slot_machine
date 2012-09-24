module SlotMachine
  module Slots

    def self.included(base)
      base.class_eval do
        attr_reader :range_slots
        def self.slot_class
          @slot_class ||= name.gsub(/s$/, "").split("::").inject(Object) do |mod, name|
            mod.const_get name
          end
        end
      end
    end

    def initialize(*ranges_or_range_slots)
      @range_slots = ranges_or_range_slots.flatten.collect do |range_or_range_slot|
        if slot_instance?(range_or_range_slot)
          range_or_range_slot
        elsif range_or_range_slot.is_a?(Range)
          self.class.slot_class.new range_or_range_slot
        else
          raise ArgumentError, "Either pass a Range or #{self.class.slot_class.name} instance (#{range_or_range_slot.class.name} given)"
        end
      end.sort do |a, b|
        [a.start, a.end] <=> [b.start, b.end]
      end
    end

    def match(other, interval = nil)
      range_slots.collect{|range_slot| range_slot.match other, interval}.flatten.uniq
    end

    def +(other)
      unless other.is_a?(Range) || other.is_a?(Array) || other.class == self.class.slot_class || other.class == self.class
        raise ArgumentError, "Either subtract a Range, an Array, #{self.class.slot_class.name} or #{self.class.name} instance (#{other.class.name} given)"
      end
      *merged_ranges = (ranges = to_ranges(self).concat(to_ranges(other)).sort{|a, b| [a.first, a.last] <=> [b.first, b.last]}).shift
      ranges.each do |range|
        last_range = merged_ranges[-1]
        if last_range.last >= range.first - 1
          merged_ranges[-1] = last_range.first..[range.last, last_range.last].max
        else
          merged_ranges.push range
        end
      end
      self.class.new merged_ranges
    end

    def -(other)
      unless other.is_a?(Range) || other.is_a?(Array) || other.class == self.class.slot_class || other.class == self.class
        raise ArgumentError, "Either subtract a Range, an Array, #{self.class.slot_class.name} or #{self.class.name} instance (#{other.class.name} given)"
      end
      divided_ranges = to_ranges(self)
      to_ranges(other).each do |range|
        divided_ranges = divided_ranges.collect do |divided_range|
          if range.first <= divided_range.first && range.last > divided_range.first && range.last < divided_range.last
            # | range |
            #     | divided_range |
            range.last..divided_range.last
          elsif range.first > divided_range.first && range.first < divided_range.last && range.last >= divided_range.last
            #             | range |
            # | divided_range |
            divided_range.first..range.first
          elsif range.first > divided_range.first && range.last < divided_range.last
            #     | range |
            # | divided_range |
            [divided_range.first..range.first, range.last..divided_range.last]
          elsif range.last <= divided_range.first || range.first >= divided_range.last
            # | range |
            #           | divided_range |
            # or
            #                   | range |
            # | divided_range |
            divided_range
          end
        end.flatten.compact
      end
      self.class.new divided_ranges
    end

    def ==(other)
      ((self.class == other.class) || (other_is_an_array = other.is_a?(Array))) && begin
        range_slots.size == (other_range_slots = other_is_an_array ? other : other.range_slots).size && begin
          range_slots.each_with_index do |range_slot, index|
            return false unless range_slot == other_range_slots[index]
          end
          true
        end
      end
    end

  private

    def slot_instance?(object)
      object.class.name == self.class.slot_class.name
    end

    def to_ranges(other)
      begin
        if other.is_a?(Range) || other.class == self.class.slot_class
          [other]
        elsif other.class == self.class
          other.range_slots
        else
          other
        end
      end.collect do |entry|
        if entry.is_a?(Range)
          entry
        else
          entry.start..entry.end
        end
      end
    end

  end
end