module DataAbstraction::SensorData
  class HeadCount < Generic
    def initialize(data, meta_values = {})
      super(data, meta_values)
      @value = CountValue.new(data['value'].to_i, "person")
    end
    def self.unit_class
      CountValue
    end
  end
end
