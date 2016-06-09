module DataAbstraction::SensorData
  class PersonVeryActiveDuration < Generic
    def initialize(data, meta_values = {})
      data['unit'] = data['unit'] ? data['unit'] : 'minute'
      super(data, meta_values)
      @value = DurationValue.new(data['value'].to_i, @unit)
    end
    def self.unit_class
      DurationValue
    end
  end
end
