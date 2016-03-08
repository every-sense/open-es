module DataAbstraction::SensorData
  class ShortMessage < Generic
    def initialize(values, meta_values = {})
      super(values, meta_values)
      @value = SimpleString.new(values['value'], @unit)
    end
    def self.unit_class
      SimpleString
    end
  end
end
