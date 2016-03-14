module DataAbstraction::SensorData
  class Switch < Generic
    def initialize(data, meta_values = {})
      super(data, meta_values)
      if  (( data['value'] =~ /^ON/i )
           ( data['value'] =~ /^TRUE/i )
           ( data['value'] == true ))
        @value = SymbolicValue.new(true)
      else
        @value = SymbolicValue.new(false)
      end
    end
    def self.unit_class
      SymbolicValue
    end
  end
end
