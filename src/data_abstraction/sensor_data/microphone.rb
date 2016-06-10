module DataAbstraction::SensorData
  class Microphone < Generic
    STANDARD_UNIT = "dB"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @value = SoundLevelValue.new(data['value'].to_f, @unit)
    end
    def self.unit_class
      SoundLevelValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
