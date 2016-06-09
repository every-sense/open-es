module DataAbstraction::SensorData
  class PersonExpenditureCalory < Generic
    def initialize(data, meta_values = {})
      data['unit'] = data['unit'] ? data['unit'] : 'kcal'
      super(data, meta_values)
      @value = EnergyValue.new(data['value'].to_i, @unit)
    end
    def self.unit_class
      EnergyValue
    end
  end
end
