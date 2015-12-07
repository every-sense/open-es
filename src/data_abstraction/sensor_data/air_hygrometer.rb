module DataAbstraction::SensorData
  class  AirHygrometer < Generic
    def initialize(values, meta_values = {})
      super(values, meta_values)
      @value = HumidityValue.new(values['value'].to_f, @unit)
    end
    def self.unit_class
      HumidityValue
    end
  end
end
