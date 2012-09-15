class TimeSlot
  include SlotMachine::Slot

  def self.default_interval
    @interval || 15
  end

protected

  def valid?(value)
    (value - (100 * (value / 100))) < 60
  end

  def to_array
    super.delete_if{|i| !valid?(i)}
  end

  def add(a, b)
    i = a
    b.times do |t|
      while !valid?(i += 1) do; end
    end
    i
  end

end