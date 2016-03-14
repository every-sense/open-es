module DataAbstraction::SensorData
  class EnvironmentalSound < Generic
    def initialize(data, meta_values = {})
      super(data, meta_values)
      @values = Array.new
      data['values'].each do | value |
        @values << SoundLevelValue.new(value.to_f, @unit)
      end
      data['value'].each do | value |
        @values << SoundLevelValue.new(value.to_f, @unit)
      end
    end
    def self.unit_class
      SoundLevelValue
    end
  end
end
