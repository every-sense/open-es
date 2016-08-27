Root = ENV['ROOT'] || "."

$LOAD_PATH << "../../src"
require 'data_abstraction'

%w{
AccelerationValue
AngularAccelerationValue
AngularVelocityValue
CycleValue
DimensionValue
DirectionValue
HumidityValue
IlluminanceValue
MagneticValue
PowerValue
PressureValue
SoundLevelValue
SpeedValue
StepValue
SymbolicValue
TemperatureValue
ConductivityValue
LocationValue
FigureValue
SimpleString
ElectricCurrentValue
CountValue
MagnitudeValue
DurationValue
EnergyValue
VolumeValue
ConcentrationValue
RateValue
FlowVolumeValue
}.each do | name |
  klass = DataAbstraction::Unit.const_get(name.to_sym)
  print "#{klass} ---\n"
  klass.units.each do | unit_a |
    val = klass.new(1, unit_a[1])
    print "---\n"
    print val.to_s, "\n"
    print "\t", val.to_standard.to_s, " (standard unit)\n"
    klass.units.each do | unit_b |
      print "\t", val.to_requested(unit_b[1]).to_s, "\n"
    end
  end
end
