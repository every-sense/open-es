require 'json'

$LOAD_PATH << "../../src"

require 'data_abstraction'

i = 0
sensors = [
           {
             'data_class_name' => 'Accelerometer',
             'data' => {
               'values' => [ 1, 2, 3],
               'unit' => 'm/s^2' }
           },{
             'data_class_name' => 'AirHygrometer',
             'data' => {
               'value' => 40,
               'unit' => '%RH' }
           },{
             'data_class_name' => 'AirTemperature',
             'data' => {
               'value' => 24,
               'unit' => 'degree Celsius' }
           },{
             'data_class_name' => 'AngularVelocity',
             'data' => {
               'values' => [ 30, 40, 50],
               'unit' => 'deg/s' }
           },{
             'data_class_name' => 'BarometricPressure',
             'data' => {
               'value' => 1009,
               'unit' => 'hPa' }
           },{
             'data_class_name' => 'Direction',
             'data' => {
               'value' => 120,
               'unit' => 'degree' }
           },{
             'data_class_name' => 'EarthMagnetometer',
             'data' => {
               'values' => [ 30, 40, 50],
               'unit' => 'nT' }
           },{
             'data_class_name' => 'Illuminance',
             'data' => {
               'value' => 700,
               'unit' => 'lx' }
           },{
             'data_class_name' => 'Location',
             'data' => {}
           },{
             'data_class_name' => 'Microphone',
             'data' => {
               'value' => 45,
               'unit' => 'dB' }
           },{
             'data_class_name' => 'MotionActivity',
             'data' => {
               'value' => "move" }
           },{
             'data_class_name' => 'Proximity',
             'data' => {
               'value' => "run" }
           },{
             'data_class_name' => 'StepCount',
             'data' => {
               'value' => 100 }
           },{
             'data_class_name' => 'WindDirection',
             'data' => {
               'value' => 120,
               'unit' => 'degree' }
           },{
             'data_class_name' => 'WindSpeed',
             'data' => {
               'value' => 10,
               'unit' => 'm/s' }
           }, {
             'data_class_name' => 'UV_Figure',
             'data' => {
               'value' => 3
             }
           }, {
             'data_class_name' => 'ShortMessage',
             'data' => {
               'value' => 'message'
             }
           }, {
             'data_class_name' => 'EnvironmentalSound',
             'data' => {
               'values' => [1,2,3,4,5,6,7,8,9,10],
               'unit' => 'dB'
             }
           }, {
             'data_class_name' => 'Switch',
             'data' => {
               'value' => 'on',
             }
           }, {
             'data_class_name' => 'HeadCount',
             'data' => {
               'value' => 20
             }
           }, {
             'data_class_name' => 'EarthQuakeMagnitude',
             'data' => {
               'value' => 5.2,
               'unit' => 'M'
             }
           }, {
             'data_class_name' => 'CO2Concentration',
             'data' => {
               'value' => 75,
               'unit' => 'ppm'
             }
           }, {
             'data_class_name' => 'ElectricCurrent',
             'data' => {
               'value' => 25,
               'unit' => 'mA'
             }
           }, {
             'data_class_name' => 'Identifier',
             'data' => {
               'value' => "aaabbbcccddd"
             }
           }, {
             'data_class_name' => 'PersonStayPlace',
             'data' => {
               'sensor' => "aaabbbcccddd",
               'receiver' => "XXXX"
             }
           }, {
             'data_class_name' => 'PersonHeartPulseRate',
             'data' => {
               'value' => 60,
               'unit' => "bpm"
             }
           }, {
             'data_class_name' => 'PersonHeartPulseRate',
             'data' => {
               'value' => 60
             }
           }, {
             'data_class_name' => 'PersonTravelDistance',
             'data' => {
               'value' => 500
             }
           }, {
             'data_class_name' => 'PersonFloorNumber',
             'data' => {
               'value' => 10
             }
           }, {
             'data_class_name' => 'PersonExpenditureCalory',
             'data' => {
               'value' => 200
             }
           }, {
             'data_class_name' => 'PersonSleepDuration',
             'data' => {
               'value' => 8
             }
           }, {
             'data_class_name' => 'PersonSleepQuality',
             'data' => {
               'value' => "aaa"
             }
           }, {
             'data_class_name' => 'PersonExerciseKind',
             'data' => {
               'value' => "running"
             }
           }, {
             'data_class_name' => 'PersonSedentaryDuration',
             'data' => {
               'value' => 20
             }
           }, {
             'data_class_name' => 'PersonLightlyActiveDuration',
             'data' => {
               'value' => 20
             }
           }, {
             'data_class_name' => 'PersonFairlyActiveDuration',
             'data' => {
               'value' => 20
             }
           }, {
             'data_class_name' => 'PersonVeryActiveDuration',
             'data' => {
               'value' => 20
             }
           }
          ]

sensors.each do | entry |
  print entry['data_class_name'], "\n"
  entry['sensor_class_name'] = entry['data_class_name'].downcase
  entry['sensor_name'] = "test_#{entry['data_class_name']}"
  entry['sensor_id'] = i
  entry['data']['at'] = Time.now
  entry['data']['location'] = {
    'values' => [ 10, 20, 3],
    'elevation' => 5
  }
  entry['data']['memo'] = "memo memo memo #{i}"
  val = DataAbstraction::SensorData::Generic.unpack(entry)
  print "#{val.class} -----\n"
  print "#{val.class.unit_class} -----\n"
  print "#{val.class.unit_class.units} -----\n"
  print "#{val.class.standard_unit} -----\n"
  #p val
  p val.to_hash
  print val.to_hash.to_json, "\n"
  #print val.build_part, "\n"
  i += 1
end
