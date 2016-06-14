require_relative 'unit'
module DataAbstraction
  class Location
    include ::DataAbstraction::Unit
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

    def initialize(values)
      if  ( values.instance_of? Hash )
        @dimension_unit = values['dimension_unit'] ? values['dimension_unit']  : "m"
        @unit = values['unit'] ? values['unit'] : "degree"
        @datum = ( values['datum'] ) ? values['datum'] : 'WGS84'
        @values = Array.new
        if ( values['values'] )
          @values[0] = LocationValue.new(values['values'][0].to_f, @unit)
          @values[1] = LocationValue.new(values['values'][1].to_f, @unit)
          if  ( values['elevation'] )
            @values[2] = DimensionValue.new(values['elevation'].to_f, @dimansion_unit)
          else
            if  ( values['values'].size == 3 )
              @values[2] = DimensionValue.new(values['values'][2].to_f, @dimansion_unit)
            else
              @values[2] = DimensionValue.new(0.0, @dimansion_unit)
            end
          end
        else
          @values[0] = LocationValue.new(values['latitude'].to_f, @unit)
          @values[1] = LocationValue.new(values['longitude'].to_f, @unit)
          @values[2] = DimensionValue.new(values['elevation'].to_f, @dimansion_unit)
        end
      elsif ( values.instance_of? Array )
        @values = Array.new
        @values[0] = LocationValue.new(values[0].to_f, @unit)
        @values[1] = LocationValue.new(values[1].to_f, @unit)
        if  ( values.size == 3 )
          @values[2] = DimensionValue.new(values[2].to_f, @dimansion_unit)
        else
          @values[2] = DimensionValue.new(0.0, @dimansion_unit)
        end
      else
      end
    end
    def location(dim = 2)
      if ( dim == 2 )
        [ @values[0], @values[1] ]
      else
        [ @values[0], @values[1], @values[2] ]
      end
    end
    def values
      @values
    end
    def value
      @values
    end
    def datum
      @datum
    end
    def unit
      @unit
    end
    def elevation
      @values[2]
    end
    def longitude
      @values[1]
    end
    def latitude
      @values[0]
    end
    def standard_datum
      STANDARD_DATUM
    end
    def self.standard_unit
      standard_datum
    end
    def standard_unit
      standard_datum
    end
    def self.datums
      DATUMS
    end
    def self.units
      datums
    end
    def to_hash
      { 'latitude' => @values[0].value,
        'longitude' => @values[1].value,
        'elevation' => @values[2].value,
        'datum' => @datum }
    end
    def to_standard
      case @@datum_table[@datum]
      when "tokyo"
        Location.new('latitude' => @latitude - 0.00010695 * @latitude + 0.000017464 * @longitude + 0.0046017,
                     'longitude' => @longitude - 0.000046038 * @longitude - 0.000083043 * @latitude + 0.010040,
                     'elevation' => @elevation,
                     'datum' => STANDARD_DATUM)
      else
        self
      end
    end
    def to_requested(datum = STANDARD_UNIT)
      if  ( datum != @datum )
        standard = self.to_standard
        case @@datum_table[datum]
        when "tokyo"
          Location.new('latitude' => @latitude + @latitude * 0.00010696 - @longitude * 0.000017467 - 0.0046020,
                       'longitude' => @longitude + @longitude * 0.000046047 + @latitude * 0.000083049 - 0.010041,
                       'elevatuon' => @elevation,
                       'datum' => datum)
        when "wgs84"
          standard
        else
          nil
        end
      else
        self
      end
    end
  end
end
