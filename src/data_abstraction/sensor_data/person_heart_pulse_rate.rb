module DataAbstraction::SensorData
  class PersonHeartPulseRate < Generic
    STANDARD_UNIT = "bpm"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @value = CycleValue.new(data['value'].to_i, @unit)
    end
    def self.unit_class
      CycleValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
