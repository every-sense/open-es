module DataAbstraction::SensorData
  class Undef < Generic
    def initialize(values, meta_values = {})
      @data_class_name = meta_values['data_class_name']
      @data = values
      super(values, meta_values)
    end
    def data_class_name
      @data_class_name
    end
    def self.unit_class
      UnknownValue
    end
#    def to_hash
#      ret = super
#      ret['data'] = @data
#      ret
#    end
  end
end
