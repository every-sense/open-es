module DataAbstraction::SensorData
  class AirTemperature < Generic
    def initialize(values, meta_values = {})
      super(values, meta_values)
      @value = TemperatureValue.new(values['value'].to_f, @unit)
    end
    def self.unit_class
      TemperatureValue
    end
  end
end
