module DataAbstraction::SensorData
  class Illuminance < Generic
    def initialize(values, meta_values = {})
      super(values, meta_values)
      @value = IlluminanceValue.new(values['value'].to_f, @unit)
    end
    def self.unit_class
      IlluminanceValue
    end
  end
end
