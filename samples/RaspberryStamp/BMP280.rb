class BMP280
  def initialize(dev, address = 0x76)
    @device = dev
    @address = address

    @device.reg_write(@address, 0xE0, 0xB6)
    sleep(1)
    @dig_T1 = @device.reg_read_uint16(@address,0x88)
    @dig_T2 = @device.reg_read_int16(@address,0x8A)
    @dig_T3 = @device.reg_read_int16(@address,0x8C)

    @dig_P1 = @device.reg_read_uint16(@address,0x8E)
    @dig_P2 = @device.reg_read_int16(@address,0x90)
    @dig_P3 = @device.reg_read_int16(@address,0x92)
    @dig_P4 = @device.reg_read_int16(@address,0x94)
    @dig_P5 = @device.reg_read_int16(@address,0x96)
    @dig_P6 = @device.reg_read_int16(@address,0x98)
    @dig_P7 = @device.reg_read_int16(@address,0x9A)
    @dig_P8 = @device.reg_read_int16(@address,0x9C)
    @dig_P9 = @device.reg_read_int16(@address,0x9E)
  end
  def t_fine
    @device.reg_write(@address, 0xF4, 0b00100101)
    sleep(0.01)
    buff = []
    buff << @device.reg_read(@address, 0xFA)
    buff << @device.reg_read(@address, 0xFB)
    buff << @device.reg_read(@address, 0xFC)
    adc_T = ( buff[0] * 4096.0 ) + ( buff[1] * 16.0 ) + ( ( buff[2] & 0xF0 ) / 16.0 )

    var1 = (adc_T/16384.0 - @dig_T1/1024.0) * @dig_T2
    var2 = ((adc_T/131072.0 - @dig_T1/8192.0) *
            (adc_T/131072.0 - @dig_T1/8192.0)) * @dig_T3
    return var1 + var2
  end
end
class BMP280_Temp < BMP280
  def initialize(dev, name = "BMP280_Temp")
    @name = name
    super(dev)
  end
  def get(at = Time.now)
    @device.reg_write(@address, 0xF4, 0b00100101)
    sleep(0.01)
    buff = []
    buff << @device.reg_read(@address, 0xFA)
    buff << @device.reg_read(@address, 0xFB)
    buff << @device.reg_read(@address, 0xFC)
    adc_T = ( buff[0] * 4096.0 ) + ( buff[1] * 16.0 ) + ( ( buff[2] & 0xF0 ) / 16.0 )

    var1 = (adc_T/16384.0 - @dig_T1/1024.0) * @dig_T2
    var2 = ((adc_T/131072.0 - @dig_T1/8192.0) *
            (adc_T/131072.0 - @dig_T1/8192.0)) * @dig_T3
    @t_fine = var1 + var2
    value = (var1 + var2) / 5120.0
    DataAbstraction::SensorData::AirTemperature.new({
                                                      'value' => value,
                                                      'unit' => 'degree Celsius',
                                                      'at' => at
                                                    },{
                                                      'sensor_name' => @name
                                                    })    
  end
end
class BMP280_Press < BMP280
  def initialize(dev, name = "BMP280_Barometric")
    @name = name
    super(dev)
  end
  def get(at = Time.now)
    @device.reg_write(@address, 0xF4, 0b00100101)
    sleep(0.01)
    buff = []
    buff << @device.reg_read(@address, 0xF7)
    buff << @device.reg_read(@address, 0xF8)
    buff << @device.reg_read(@address, 0xF9)
    adc_P = ( buff[0] * 4096.0 ) + ( buff[1] * 16.0 ) + ( ( buff[2] & 0xF0 ) / 16.0 )

    var1 = ( t_fine / 2.0 ) - 64000.0
    var2 = var1 * var1 * @dig_P6 / 32768.0
    var2 = var2 + var1 * @dig_P5 * 2.0
    var2 = ( var2 / 4.0 ) + (@dig_P4 * 65536.0)
    var1 = ( @dig_P3 * var1 * var1 / 524288.0 + ( @dig_P2 * var1) ) / 524288.0
    var1 = (1.0 + var1 / 32768.0 ) * @dig_P1
    if (var1 == 0.0)
      return 0 # avoid exception caused by division by zero
    end
    p = 1048576.0 - adc_P
    p = (p - (var2 / 4096.0)) * 6250.0 / var1
    var1 = @dig_P9 * p * p / 2147483648.0
    var2 = p * @dig_P8 / 32768.0
    p = p + (var1 + var2 + @dig_P7) / 16.0
    value = p / 100.0
    DataAbstraction::SensorData::BarometricPressure.new({
                                                          'value' => value,
                                                          'unit' => 'hPa',
                                                          'at' => at
                                                        },{
                                                          'sensor_name' => @name
                                                        })
  end
end
