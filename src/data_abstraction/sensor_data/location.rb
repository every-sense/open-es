module DataAbstraction::SensorData
  class Location < Generic
    STANDARD_DATUM = "WGS84"
    DATUMS = [
              [ "wgs84", "WGS84" ],
              [ "jgd2000", "JGD2000" ],
              [ "jgd2011", "JGD2011" ],
              [ "tokyo", "Tokyo Datum" ]
             ]

    def self.datum_table(a)
      h = Hash.new
      a.each do | ent |
        val = ent[0]
        ent[1..-1].each do | e |
          h[e] = val
        end
      end
      h
    end
    @@datum_table = datum_table(DATUMS)
    def initialize(data, meta_values = {})
      super(data, meta_values)
      if  ( data['values'] )
        @values = Array.new
        if ( data['values'].instance_of? Array )
          @values[0] = LocationValue.new(data['values'][0].to_f, @unit)
          @values[1] = LocationValue.new(data['values'][1].to_f, @unit)
          @values[2] = DimensionValue.new(data['values'][2].to_f, @unit)
        elsif ( data['values'].instance_of? Hash )
          @values[0] = LocationValue.new(data['values']['latitude'].to_f, @unit)
          @values[1] = LocationValue.new(data['values']['longitude'].to_f, @unit)
          @values[2] = DimensionValue.new(data['values']['elevation'].to_f @unit)
        end
      else
        @value = LocationValue.new(data['value'], @unit)
      end
      @datum = ( data['datum'] ) ? data['datum'] : 'WGS84'
    end
    def build_part
      if ( @values )
        "\"values\":[#{@values[0].value},#{@values[1].value},#{@values[2].value}],\"unit\":\"#{@unit}\",\"datum\":\"#{@datum}\""
      else
        "\"value\":\"#{@value.value}\",\"unit\":\"#{@unit}\",\"datum\":\"#{@datum}\""
      end
    end
    def self.unit_class
      DataAbstraction::Unit::LocationValue
    end
  end
end
