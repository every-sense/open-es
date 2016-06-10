module DataAbstraction::SensorData
  class ElectricCurrent < Generic
    STANDARD_UNIT = "A"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @value = ElectricCurrentValue.new(data['value'].to_f, @unit)
    end
    def self.unit_class
      ElectricCurrentValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
