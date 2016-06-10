module DataAbstraction::SensorData
  class PersonExpenditureCalory < Generic
    STANDARD_UNIT = "kcal"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @value = EnergyValue.new(data['value'].to_i, @unit)
    end
    def self.unit_class
      EnergyValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
