module DataAbstraction::SensorData
  class Generic
    include DataAbstraction::Unit
    def initialize(values, meta_values = {})
      @sensor_class_name = meta_values['sensor_class_name']  if ( meta_values['sensor_class_name'] )
      @sensor_name = meta_values['sensor_name']  if ( meta_values['sensor_name'] )
      @accuracy = values['accuracy'].to_f if ( values['accuracy'] )
      @unit = values['unit'] if ( values['unit'] )
      @memo = values['memo'] if ( values['memo'] )
      @sensor_id = meta_values['sensor_id'].to_i if ( meta_values['sensor_id'] )
      @device_uuid = meta_values['device_uuid'] if ( meta_values['device_uuid'] )
      @farm_uuid = meta_values['farm_uuid'] if ( meta_values['farm_uuid'] )
      if ( values['at'] )
        at = values['at']
        if ( at.instance_of? Time )
          @at = at
        elsif ( at.instance_of? String )
          @at = Time.parse(at)
        end
      end
      if  (( values['location'] ) ||
           ( values['longtude'] ) ||
           ( values['latitude'] ) ||
           ( values['elevation'] ))
        @location = DataAbstraction::Location.new(values)
      end
    end
    def farm_uuid
      @farm_uuid
    end
    def set_properties(hash)
      if ( hash.instance_of? Hash )
        @device_uuid = hash['device_uuid'] if hash['device_uuid']
        @farm_uuid = hash['farm_uuid'] if hash['farm_uuid']
        @sensor_name = hash['sensor_name'] if hash['sensor_name']
        @sensor_class_name = hash['sensor_class_name'] if hash['sensor_class_name']
      end
    end
    def self.unpack(entry)
      #p entry['data_class_name']
      begin
        DataAbstraction::SensorData.const_get(entry['data_class_name'].to_sym).new(entry['data'], entry)
      rescue NameError
        print "invalid data_class_name '#{entry['data_class_name']}' use Undef class"
        Undef.new(entry['data'], entry)
      rescue => e
        print e.to_s
        print $@.join("\n")
#        print "exit"
#        exit
      end
    end
    def data_class_name
      self.class.to_s[29..-1]
    end
    def sensor_class_name
      @sensor_class_name
    end
    def sensor_class_name=(name)
      @sensor_class_name = name
    end
    def sensor_name
      @sensor_name
    end
    def sensor_name=(name)
      @sensor_name = name
    end
    def at
      @at
    end
    def at=(value)
      if ( value.instance_of? Time )
        @at = value
      elsif ( value.instance_of? String )
        @at = Time.parse(value)
      end
    end
    def unit
      @unit
    end
    def location
      if ( defined? @location )
        @location
      else
        nil
      end
    end
    def longitude
      if ( defined? @location )
        @location.longitude
      else
        nil
      end
    end
    def latitude
      if ( defined? @location )
        @location.latitude
      else
        nil
      end
    end
    def elevation
      if ( define? @location )
        @location.elevation
      else
        nil
      end
    end
    def value
      if ( defined? @value )
        @value
      else
        nil
      end
    end
    def values
      if ( defined? @values )
        @values
      else
        nil
      end
    end
    def memo
      @memo
    end
    def to_requested!(unit = nil)
      if ( unit )
        if  ( defined? @value )
          @value = @value.to_requested(unit)
        elsif ( defined? @values )
          values = Array.new
          @values.each do | value |
            values << value.to_requested(unit)
          end
          @values = values
        end
        @unit = unit
      end
    end
    def to_s
      at = @at ? @at.utc : Time.now.utc
      "{\"sensor_name\":\"#{self.sensor_name}\"," +
        "\"data\":{\"at\":\"#{at.year}-#{at.mon}-#{at.day} #{at.hour}:#{at.min}:#{at.sec}.#{at.usec/1000} +0000\"," +
        "#{self.build_part}}" +
        ( @location ) ? ",\"location\":[\"#{@location[0]}\",\"#{@location[1]}\",\"#{@location[2]}\"],\"datum\":\"#{@datum}\"" : "" +
        "}"
    end
    def build_part
      @value.to_json_part
    end
    def to_hash
      ret = Hash.new
      ret['device_uuid'] = @device_uuid if @device_uuid
      ret['farm_uuid'] = @farm_uuid if @farm_uuid
      ret['sensor_class_name'] = self.sensor_class_name if  ( self.sensor_class_name )
      ret['sensor_name'] = self.sensor_name if ( self.sensor_name )
      ret['data_class_name'] = self.data_class_name
      
      ret['data'] = self.to_simple_hash
      ret
    end
    def to_simple_hash
      data = Hash.new
      if ( defined? @at )
        data['at'] = @at.to_s
      end
      data['memo'] = @memo
      if ( defined? @location )
        data['location'] = @location.to_hash
      end
      if (( defined? @value ) &&
          ( @value ))
        if  ( @value.value.instance_of? Array )
        data['values'] = Array.new
          @value.value.each do | value |
            if  ( value )
              data['values'] << value.value
            end
          end
        else
          data['value'] = @value.value
        end
        data['unit'] = @value.unit if @value.unit
      else
        data['unit'] = @unit if @unit
      end
      if ( defined? @values )
        data['values'] = Array.new
        @values.each do | value |
          if  ( value )
            data['values'] << value.value
          end
        end
      end
      #debug_message "result ---"
      #debug_message data
      #debug_message "---"
      data
    end
  end
end
