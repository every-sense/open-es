module DataAbstraction::SensorData
  class CO2Concentration < Generic
    def initialize(data, meta_values = {})
      super(data, meta_values)
      @value = ConcentrationValue.new(data['value'].to_i, @unit)
    end
    def self.unit_class
      ConcentrationValue
    end
  end
end
