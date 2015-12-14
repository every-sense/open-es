module I2C
  class Dev
    def sysread(size)
      return @device.sysread(size)
    end
    def reg_write(address, reg, val)
      write(address, reg, val)
    end
    def reg_read(address, reg)
      read(address, 1, reg).getbyte(0)
    end
    def reg_read_uint16(address, reg)
      lo = reg_read(address, reg)
      hi = reg_read(address, reg+1)
      return hi * 256 + lo
    end
    def reg_read_int16(address, reg)
      lo = reg_read(address, reg)
      hi = reg_read(address, reg+1)
      ret = hi * 256 + lo
      if ( ret > 32768 )
        ret -= 65536
      end
      ret
    end
  end
end
