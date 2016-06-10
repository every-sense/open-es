module DataAbstraction::SensorData
  class BarometricPressure < Generic
    STANDARD_UNIT = "hPa"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @value = PressureValue.new(data['value'].to_f, @unit)
    end
    def self.unit_class
      PressureValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
