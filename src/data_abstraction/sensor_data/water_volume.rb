module DataAbstraction::SensorData
  class WaterVolume < Generic
    STANDARD_UNIT = "m^3"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @value = VolumeValue.new(data['value'].to_f, @unit)
    end
    def self.unit_class
      VolumeValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
