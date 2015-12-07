module DataAbstraction::SensorData
  class Direction < Generic
    def initialize(data, meta_values = {})
      super(data, meta_values)
      @north = data['north'] ==  'magnetic' ? :magnetic : :true
      @value = DirectionValue.new(data['value'].to_f, @unit)
    end
    def to_hash
      ret = super
      ret['data']['north'] = @north
      ret
    end
    def self.unit_class
      DirectionValue
    end
  end
end
