module DataAbstraction::SensorData
  class Accelerometer < Generic
    def initialize(data, meta_values = {})
      super(data, meta_values)
      @values = Array.new
      @values[0] = AccelerationValue.new(data['values'][0].to_f, @unit)
      @values[1] = AccelerationValue.new(data['values'][1].to_f, @unit)
      @values[2] = AccelerationValue.new(data['values'][2].to_f, @unit)
    end
    def build_part
      "\"values\":[#{@values[0].value},#{@values[1].value},#{@values[2].value}],\"unit\":\"#{@unit}\""
    end
    def self.unit_class
      AccelerationValue
    end
  end
end
