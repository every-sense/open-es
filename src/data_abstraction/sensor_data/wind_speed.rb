module DataAbstraction::SensorData
  class WindSpeed < Generic
    def initialize(values, meta_values = {})
      super(values, meta_values)
      @value = SpeedValue.new(values['value'].to_f, @unit)
    end
    def self.unit_class
      SpeedValue
    end
  end
end
