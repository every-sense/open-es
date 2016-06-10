module DataAbstraction::SensorData
  class AngularVelocity < Generic
    STANDARD_UNIT = "deg/s"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @values = Array.new
      @values[0] = AngularVelocityValue.new(data['values'][0].to_f, @unit)
      @values[1] = AngularVelocityValue.new(data['values'][1].to_f, @unit)
      @values[2] = AngularVelocityValue.new(data['values'][2].to_f, @unit)
    end
    def build_part
      "\"values\":[#{@values[0].value},#{@values[1].value},#{@values[2].value}],\"unit\":\"#{@unit}\""
    end
    def self.unit_class
      AngularVelocityValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
