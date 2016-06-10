module DataAbstraction::SensorData
  class Undef < Generic
    def initialize(data, meta_values = {}, unit = nil)
      @data_class_name = meta_values['data_class_name']
      @data = data
      super(data, meta_values, unit)
    end
    def data_class_name
      @data_class_name
    end
    def self.unit_class
      UnknownValue
    end
  end
end
