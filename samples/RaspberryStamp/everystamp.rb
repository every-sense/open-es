# -*- coding: utf-8 -*-
require 'rubygems'
require 'json'

Home = ENV['HOME'] || "/home/ogochan"
Root = ENV['ROOT'] || "."
I2C_DEV = "/dev/i2c-1"

#SERVER = "api.every-sense.com"
SERVER = "172.16.28.131"
#UUID = "8c3e712c-2aae-43df-868f-fcfc4b1f85c9"	# for api.every-sense.com
UUID = "fb5830ec-2c92-4188-8be6-6246777bd765"	# NOC1
#UUID = "fb70c83e-94dd-4b48-9baa-e542e3c1852f"	# NOC3
#UUID = "b082a6fd-ec06-41a2-a92e-fef88f4f462d"	# NOC7
#UUID = "a75bad15-03da-4141-be73-9e5cda8f8606"	# NOC12
#UUID = "eddf0ab8-f29b-4a3f-b8cf-70b24dc5bc15"	# NOC13
#UUID = "a6136df8-6978-4cb7-868f-c98a3b8b496a"	# NOC15
#UUID = "5d8c286b-d18f-44d2-b1fb-979c296da777"	# NOC16

Period = 60 # 1min

$LOAD_PATH << "#{Root}"

require 'sensors'

$LOAD_PATH << "../open-es/src"

require 'data_abstraction'
require 'every_sense_json_client'

puts 'Ready'

i2c = I2C.create(I2C_DEV)
sensors = [
           SHTxx_Temp.new(i2c, "SHT25_Temp"),
           SHTxx_Hum.new(i2c, "SHT25_Hum"),
           #BMP280_Temp.new(i2c,"BMP-180_Temp"),
           BMP280_Press.new(i2c, "BMP-180_Barometric")
          ]

at = Time.now
rec = []
sensors.each do | sensor |
  rec << sensor.get(at).to_hash
end
puts rec.to_json
server = EverySense::JsonClient.new(SERVER)
p server.put_message(UUID, rec)
