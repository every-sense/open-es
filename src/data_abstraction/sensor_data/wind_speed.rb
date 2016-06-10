module DataAbstraction::SensorData
  class WindSpeed < Generic
    STANDARD_UNIT = "m/s"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @value = SpeedValue.new(data['value'].to_f, @unit)
    end
    def self.unit_class
      SpeedValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
