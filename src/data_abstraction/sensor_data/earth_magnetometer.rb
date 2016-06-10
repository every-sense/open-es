module DataAbstraction::SensorData
  class EarthMagnetometer < Generic
    STANDARD_UNIT = "nT"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @values = Array.new
      @values[0] = MagneticValue.new(data['values'][0].to_f, @unit)
      @values[1] = MagneticValue.new(data['values'][1].to_f, @unit)
      @values[2] = MagneticValue.new(data['values'][2].to_f, @unit)
    end
    def build_part
      "\"values\":[#{@values[0].value},#{@values[1].value},#{@values[2].value}],\"unit\":\"#{@unit}\""
    end
    def self.unit_class
      MagneticValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
