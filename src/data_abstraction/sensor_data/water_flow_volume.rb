module DataAbstraction::SensorData
  class WaterFlowVolume < Generic
    STANDARD_UNIT = "L/s"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @value = FlowVolumeValue.new(data['value'].to_f, @unit)
    end
    def self.unit_class
      FlowVolumeValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
