module DataAbstraction::SensorData
  class Advertising_ID < Generic
    STANDARD_UNIT = nil
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @value = SimpleString.new(data['value'], @unit)
    end
    def self.unit_class
      SimpleString
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
