# coding: utf-8
require 'rubygems'
require 'net/http'
require 'uri'
require 'cgi'
require 'json'
require 'open-uri'
$LOAD_PATH << "./libs"
require 'data_abstraction'
require 'every_sense_json_client'

HISTORY_FILE = './quakes'
UUID = '4243a93b-8672-484e-90c1-6f970addbc23'
port = 7001

def get_list
  uri = "/api/quakelist/4.json"
  ret = nil
  open("http://zish.in/#{uri}") do | f |
    ret = JSON.parse(f.read)
  end
#  p ret
  ret
end
def get_detail(id = nil)
  uri = id ? "api/quake/#{id}.json" : "api/quake.json"
  ret = nil
  open("http://zish.in/#{uri}") do | f |
    ret = JSON.parse(f.read)
  end
  ret
end

case ARGV[0]
when "local"
  history_file = './quakes.local'
  server = "localhost"
when "server"
  history_file = './quakes.server'
  server = "www.folloger.com"
else
  history_file = ARGV[0]
  server = ARGV[1]
end

ids = Hash.new
begin
  File.open(history_file, "r") do | file |
    file.each_line do | line |
      line.chop!
      ids[line] = line
    end
  end
rescue
end

  

File.open(history_file, "a+") do | file |
  rec = []
  get_list.each do | entry |
    id = entry['ID']
    if (( !ids[id] ) &&
        ( entry['TypeID'] == 2 ))
      file.print id, "\n"
      ids[id] = id
      d = get_detail(id)
      if  ( d['Depth'] =~ /ごく浅い/ )
        elevation = 0
      elsif ( d['Depth'] =~ /^(約|)(\d+)km/ )
        elevation = $2.to_i * 1000
      end
      m = DataAbstraction::SensorData::EarthQuakeMagnitude.new({
                                                                 'longitude' => d['Point']['LongInt'].to_f,
                                                                 'latitude' => d['Point']['LatInt'].to_f,
                                                                 'elevation' => - elevation,
                                                                 'at' => Time.at(d['QuakeUnixTime'].to_i),
                                                                 'value' => d['MagnitudeFloat'].to_f},
                                                               'sensor_name' => 'epicenter')
      rec << m.to_hash
    end
#    break
  end
  server = EverySense::JsonClient.new(server, port)
  print server.put_device_data(UUID, rec.reverse)
end
