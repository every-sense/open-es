module DataAbstraction::SensorData
  class  AirHygrometer < Generic
    STANDARD_UNIT = "%RH"
    def initialize(values, meta_values = {})
      super(values, meta_values)
      @value = HumidityValue.new(values['value'].to_f, @unit)
    end
    def self.unit_class
      HumidityValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
