module DataAbstraction::SensorData
  class MotionActivity < Generic
    STANDARD_UNIT = nil
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @value = SymbolicValue.new(data['value'])
    end
    def self.unit_class
      SymbolicValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
