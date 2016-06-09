module DataAbstraction::SensorData
  class PersonFloorNumber < Generic
    def initialize(data, meta_values = {})
      data['unit'] = data['unit'] ? data['unit'] : 'floor'
      super(data, meta_values)
      @value = CountValue.new(data['value'].to_i, @unit)
    end
    def self.unit_class
      CountValue
    end
  end
end
