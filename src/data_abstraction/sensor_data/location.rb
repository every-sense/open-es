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
    def initialize(data, meta_values = {}, datum = STANDARD_DATUM)
      data['datum'] = data['datum'] ? data['datum'] : datum
      super(data, meta_values, nil)
      @value = DataAbstraction::Location.new(data)
    end
    def self.unit_class
      DataAbstraction::Unit::LocationValue
    end
    def self.standard_unit
      STANDARD_DATUM
    end
  end
end
