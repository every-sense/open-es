module DataAbstraction::SensorData
  class  EarthQuakeMagnitude < Generic
    def initialize(values, meta_values = {})
      super(values, meta_values)
      @value = MagnitudeValue.new(values['value'].to_f, @unit)
    end
    def self.unit_class
      MagnitudeValue
    end
  end
end
