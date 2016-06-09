module DataAbstraction::SensorData
  class PersonHeartPulseRate < Generic
    def initialize(data, meta_values = {})
      data['unit'] = data['unit'] ? data['unit'] : 'bpm'
      super(data, meta_values)
      @value = CycleValue.new(data['value'].to_i, @unit)
    end
    def self.unit_class
      CycleValue
    end
  end
end
