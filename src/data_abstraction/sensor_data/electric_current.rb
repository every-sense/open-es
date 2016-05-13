module DataAbstraction::SensorData
  class ElectricCurrent < Generic
    def initialize(values, meta_values = {})
      super(values, meta_values)
      @value = ElectricCurrentValue.new(values['value'].to_f, @unit)
    end
    def self.unit_class
      ElectricCurrentValue
    end
  end
end
