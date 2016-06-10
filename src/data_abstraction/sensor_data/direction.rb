module DataAbstraction::SensorData
  class Direction < Generic
    STANDARD_UNIT = "degree"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
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
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
