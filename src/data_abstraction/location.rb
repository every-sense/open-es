module DataAbstraction
  class Location
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
      @latitude = values['latitude'] ? values['latitude'].to_f : ( values['location'][0] ? values['location'][0].to_f : nil )
      @longitude = values['longitude'] ? values['longitude'].to_f : ( values['location'][1] ? values['location'][1].to_f : nil )
      @elevation = values['elevation'] ? values['elevation'].to_f : ( values['location'][2] ? values['location'][2].to_f : nil )
      @datum = ( values['datum'] ) ? values['datum'] : 'WGS84'
    end
    def location(dim = 2)
      if (( dim == 2 ) ||
          ( !@elevation ))
        [ @longitude, @latitude ]
      else
        [ @longitude, @latitude, @elevation ]
      end
    end
    def datum
      @datum
    end
    def elevation
      @elevation
    end
    def longitude
      @longitude
    end
    def latitude
      @latitude
    end
    def standard_datum
      STANDARD_DATUM
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
