module DataAbstraction::SensorData
  class Microphone < Generic
    def initialize(data, meta_values = {})
      super(data, meta_values)
      @value = SoundLevelValue.new(data['value'].to_f, @unit)
    end
    def self.unit_class
      SoundLevelValue
    end
  end
end
