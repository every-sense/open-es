module DataAbstraction::SensorData
  class Location < Generic
    def initialize(data, meta_values = {})
      super(data, meta_values)
    end
    def build_part
      ""
    end
    def self.unit_class
      DataAbstraction::Location
    end
  end
end
