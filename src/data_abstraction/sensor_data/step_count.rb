module DataAbstraction::SensorData
  class StepCount < Generic
    def initialize(data, meta_values = {})
      super(data, meta_values)
      @value = StepValue.new(data['value'].to_i)
    end
    def self.unit_class
      StepValue
    end
  end
end
