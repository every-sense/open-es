module DataAbstraction::SensorData
  class PersonSleepDuration < Generic
    def initialize(data, meta_values = {})
      data['unit'] = data['unit'] ? data['unit'] : 'hours'
      super(data, meta_values)
      @value = DurationValue.new(data['value'].to_i, @unit)
    end
    def self.unit_class
      DurationValue
    end
  end
end
