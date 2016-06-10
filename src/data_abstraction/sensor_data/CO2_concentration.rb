module DataAbstraction::SensorData
  class CO2Concentration < Generic
    STANDARD_UNIT = "ppm"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @value = ConcentrationValue.new(data['value'].to_i, @unit)
    end
    def self.unit_class
      ConcentrationValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
