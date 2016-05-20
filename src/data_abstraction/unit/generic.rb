module DataAbstraction::Unit
  class Generic
    def self.unit_table(a)
      h = Hash.new
      a.each do | ent |
        val = ent[0]
        ent[1..-1].each do | e |
          h[e] = val
        end
      end
      h
    end
    def value(unit = @unit)
      unit = unit.to_s if ( unit.instance_of? Symbol )
      if ( unit == @unit )
        @value
      else
        value = self.to_standard
        if ( unit == self.standard_unit )
          value.value
        else
          value.to_requested(unit)
        end
      end
    end
    def self.accuracy_unit
      self.standard_unit
    end
    def unit
      @unit
    end
    def to_s
      "#{@value} #{@unit}"
    end
    def to_json_part
      "\"value\":\"#{@value}\"" + ( @unit ? ",\"unit\":\"#{@unit}\"" : "" )
    end
    def to_hash
      if  ( @unit )
        {
          "value" => @value,
          "unit" => @unit
        }
      else
        {
          "value" => @value
        }
      end
    end
  end
end

