module DataAbstraction::SensorData
  class EnvironmentalSound < Generic
    STANDARD_UNIT = "dB"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @values = Array.new
      if  ( data['values'] )
        data['values'].each do | value |
          @values << SoundLevelValue.new(value.to_f, @unit)
        end
      end
      if  ( data['value'] )
        data['value'].each do | value |
          @values << SoundLevelValue.new(value.to_f, @unit)
        end
      end
    end
    def self.unit_class
      SoundLevelValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
