# -*- coding: utf-8 -*-
module DataAbstraction
  def self.test
    p "test"
    ret = SensorData::Generic.unpack({
                                       'sensor_class_name' => 'GPSActivitySensor',
                                       'data_class_name' => 'Location',
                                       'sensor_id' => 1,
                                       'data' => {
                                         'at' => Time.now.to_s,
                                         'location' => [ 10, 100],
                                         'elevation' => 10.0,
                                         'datum' =>  'WGS84',
                                         'unit' => 'degree'
                                       }
                                     })
    p ret
    p ret.to_hash
    p ret.location

    ret = SensorData::Generic.unpack({
                                       'sensor_class_name' => 'AccelerometerSensor',
                                       'data_class_name' => 'Accelerometer',
                                       'sensor_id' => 2,
                                       'data' => {
                                         'at' => Time.now.to_s,
                                         'values' => [ 0, 0, 980],
                                         'unit' => 'cm/s^2'
                                       }
                                     })
    p ret
    p ret.to_hash
    p ret.values[0]
    p ret.values[0].value("cm/s^2")
    p ret.values[1].value("cm/s^2")
    p ret.values[2].value("cm/s^2")
    p ret.values[2].value("m/s^2")
    p ret.values[2]
    p ret.values[2].value("mm/s^2")

    ret = SensorData::Generic.unpack({
                                       'sensor_id' => 701,
                                       "sensor_class_name" => "MagnetometerSensor",
                                       "data_class_name" => "EarthMagnetometer",
                                       "data" =>{
                                         "at" => "2014-10-16 04:00:18 GMT",
                                         "north" => "magnetic",
                                         "unit"=>"microtesla",
                                         "values"=>["-23.786140", "-15.953758", "-0.214554"]}
                                     })
    p ret
    p ret.to_hash
    p ret.values[0]
    p ret.values[0].value("nanotesla")

    ret = SensorData::Generic.unpack({
                                       "sensor_id" => 698,
                                       "sensor_class_name" => "ProximitySensor",
                                       "data_class_name" => "Proximity",
                                       "data" => {
                                         "at" => "2014-10-16 04:00:18 GMT",
                                         "value" => "off",
                                         "memo" => ""}
                                     })
    p ret
    p ret.to_hash

    ret = SensorData::Generic.unpack({
                                       "sensor_id" => 660,
                                       "sensor_class_name" => "GyroscopeSensor",
                                       "data_class_name" => "AngularVelocity",
                                       "data" => {
                                         "at" => "2014-10-16 07:51:18 GMT",
                                         "memo" => "",
                                         "unit" => "deg/s",
                                         "values" => ["5.000000", "2.000000", "3.000000"]}
                                     })
    p ret
    p ret.to_hash
    p ret.values[0].value
    p ret.values[0].value("rad/s")

    ret = SensorData::Generic.unpack({
                                       "sensor_id" => 460,
                                       "sensor_class_name" => "TemperatureSensor",
                                       "data_class_name" => "AirTemperature",
                                       "data" => {
                                         "unit" => "degree Celsius",
                                         "location" => [35.708507, 138.742869],
                                         "value" => 7.1,
                                         "memo" => "温度(高価)",
                                         "at" => "2014-10-17 06:55:00"}
                                     })
    p ret
    p ret.to_hash
    p ret.value
    p ret.value.value("rad/s")
    p ret.location

    ret = SensorData::Generic.unpack({
                                       "sensor_id" => 461,
                                       "sensor_class_name" => "HygrometerSensor",
                                       "data_class_name" => "AirHygrometer",
                                       "data" => {
                                         "unit" => "%RH",
                                         "location" => [35.708507, 138.742869],
                                         "value" => 99.1,
                                         "memo" => "湿度(高価)",
                                         "at" => "2014-10-17 06:55:00"}
                                     })
    p ret
    p ret.to_hash
    p ret.value
    p ret.value.value
    p ret.location

    ret = SensorData::Generic.unpack({
                                       "sensor_id" => 571,
                                       "sensor_class_name" => "Microphone",
                                       "data_class_name" => "Microphone",
                                       "data" => {
                                         "at" => "2014-10-17 02:40:14 GMT",
                                         "value" => "-44.160496",
                                         "memo" => "",
                                         "unit" => "dB"}
                                     })
    p ret
    p ret.to_hash
    p ret.value
    p ret.value.value

    ret = SensorData::Generic.unpack({
                                       "sensor_id" => 810,
                                       "sensor_class_name" => "StepCounterSensor",
                                       "data_class_name" => "StepCount",
                                       "data" => {
                                         "at" => "2014-10-17 08:30:10 GMT",
                                         "value" => "123",
                                         "unit" => "step",
                                         "memo"=>""}
                                     })
    p ret
    p ret.to_hash
    p ret.value
    p ret.value.value

    ret = SensorData::Generic.unpack({
                                       "sensor_id" => 558,
                                       "sensor_class_name" => "利用者の状態情報(モーションアクティビティ)",
                                       "data_class_name" => "MotionActivity",
                                       "data" => {
                                         "at" => "2014-11-07 07:49:59 GMT",
                                         "value" => "unknown",
                                         "memo" => "" }
                                     })
    p ret
    p ret.to_hash
    p ret.value
    p ret.value.value

    p Unit::LocationValue.accuracy_unit
    p Unit::LocationValue.standard_unit
    p Unit::TemperatureValue.accuracy_unit
    p Unit::TemperatureValue.standard_unit
  end
end
