module DataAbstraction::SensorData
  class WindDirection < Generic
    def initialize(values, meta_values = {})
      super(values, meta_values)
      @value = DirectionValue.new(values['value'].to_f, @unit)
    end
    def self.unit_class
      DirectionValue
    end
  end
end
