class SHTxx
  def initialize(dev, address = 0x40)
    @device = dev
    @address = address
    @device.write(@address, 0xFE)
    sleep(0.1)
  end
end
class SHTxx_Temp < SHTxx
  def initialize(dev, name = 'SHT22_Temp')
    @name = name
    super(dev)
  end
  def get(at = Time.now)
    @device.write(@address, 0xF3)
    sleep(0.1)
    buff = @device.sysread(3)
	data = - 46.85 + 175.72 / 65536.0 * ( buff.getbyte(0) * 256.0 + buff.getbyte(1) )
    DataAbstraction::SensorData::AirTemperature.new({
                                                      'value' => data,
                                                      'unit' => 'degree Celsius',
                                                      'at' => at
                                                    },{
                                                      'sensor_name' => @name
                                                    })
  end
end
class SHTxx_Hum < SHTxx
  def initialize(dev, name = 'SHT22_Hum')
    @name = name
    super(dev)
  end
  def get(at = Time.now)
    @device.write(@address, 0xF5)
    sleep(0.1)
    buff = @device.sysread(3)
    printf("%02X %02X\n", buff.getbyte(0), buff.getbyte(1))
	data = - 6.0 + 125.0 / 65536.0 * ( buff.getbyte(0) * 256.0 + buff.getbyte(1) )
    DataAbstraction::SensorData::AirHygrometer.new({
                                                     'value' => data,
                                                     'unit' => '%RH',
                                                     'at' => at
                                                   },{
                                                     'sensor_name' => @name
                                                   })
  end
end

