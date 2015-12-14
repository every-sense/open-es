module DataAbstraction::SensorData
  class UV_Figure < Generic
    def initialize(values, meta_values = {})
      super(values, meta_values)
      @value = FigureValue.new(values['value'].to_f, @unit)
    end
    def self.unit_class
      FigureValue
    end
  end
end
