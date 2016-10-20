module DataAbstraction::SensorData
  class RainAccumlation < Generic
    STANDARD_UNIT = "mm"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @value = DimensionValue.new(data['value'].to_f, @unit)
      @duration = DurationValue.new(data['duration'].to_f, data['duration_unit'] || "s");
    end
    def self.unit_class
      DimensionValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
    def to_hash
      ret = super
      ret['data']['duration'] = @duration.value
      ret['data']['duration_unit'] = @duration.unit
      ret
    end
  end
end
