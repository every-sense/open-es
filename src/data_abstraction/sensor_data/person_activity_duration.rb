module DataAbstraction::SensorData
  class PersonActivityDuration < Generic
    STANDARD_UNIT = "minute"
    def initialize(data, meta_values = {}, unit = STANDARD_UNIT)
      super(data, meta_values, unit)
      @value = DurationValue.new(data['value'].to_i, @unit)
    end
    def self.unit_class
      DurationValue
    end
    def self.standard_unit
      STANDARD_UNIT
    end
  end
  class PersonFairlyActiveDuration < PersonActivityDuration
  end
  class PersonSedentaryDuration < PersonActivityDuration
  end
  class PersonSleepDuration < PersonActivityDuration
  end
  class PersonVeryActiveDuration < PersonActivityDuration
  end
  class PersonLightlyActiveDuration < PersonActivityDuration
  end
end
