module DataAbstraction::SensorData
  class Proximity < Generic
    def initialize(data, meta_values = {})
      super(data, meta_values)
      @value = SymbolicValue.new(data['value'])
    end
    def self.unit_class
      SymbolicValue
    end
  end
end
