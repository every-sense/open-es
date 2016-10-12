module DataAbstraction::SensorData
  class WiFiList < Generic
    STANDARD_UNIT = "dBm"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @values = Array.new
      if  ( data['values'] )
        data['values'].each do | value |
          @values << {
            'SSID' => SymbolicValue.new(value['SSID']),
            'RSSI' => ReceiveSignalLevelValue.new(value['RSSI'].to_f, @unit),
            'capabilities' => SimpleString.new(value['capabilities'])
          }
        end
      end
      if  ( data['value'] )
        data['value'].each do | value |
          @values << {
            'SSID' => SymbolicValue.new(value['SSID']),
            'RSSI' => ReceiveSignalLevelValue.new(value['RSSI'].to_f, @unit),
            'capabilities' => SimpleString.new(value['capabilities'])
          }
        end
      end
    end
    def to_requested!(unit = nil)
      new_values = Array.new
      @values.each do | value |
        new_values << {
          'SSID' => value['SSID'],
          'RSSI' => value['RSSI'].to_requested(unit),
          'capabilities' => value['capabilities']
        }
      end
      @values = new_values
      @unit = unit
    end
    def self.unit_class
      ReceiveSignalLevelValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
end
