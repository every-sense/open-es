module DataAbstraction::SensorData
  class BarometricPressure < Generic
    def initialize(values, meta_values = {})
      super(values, meta_values)
      @value = PressureValue.new(values['value'].to_f, @unit)
    end
    def self.unit_class
      PressureValue
    end
  end
end
