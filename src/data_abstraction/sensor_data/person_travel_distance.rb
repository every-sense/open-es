module DataAbstraction::SensorData
  class PersonTravelDistance < Generic
    def initialize(data, meta_values = {})
      data['unit'] = data['unit'] ? data['unit'] : 'Km'
      super(data, meta_values)
      @value = DimensionValue.new(data['value'].to_i, @unit)
    end
    def self.unit_class
      DimensionValue
    end
  end
end
