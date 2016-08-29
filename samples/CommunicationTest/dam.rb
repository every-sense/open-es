# coding: utf-8
require 'rubygems'
require 'net/http'
require 'uri'
require 'cgi'
require 'json'
require 'open-uri'
require 'nokogiri'
$LOAD_PATH << "./libs"
require 'data_abstraction'
require 'every_sense_json_client'

HISTORY_DIR = './tonegawa'

PORT = 7001
SERVER = "localhost"

DAM_LIST = {
  'fujiwara' => {
    UUID: 'a53088a6-bf23-4925-8c35-c76bf8c8819f',
    URL: 'http://www.ktr.mlit.go.jp/tonedamu/teikyo/realtime/live/fujiwara.html'
  },
  'sonohara2' => {
    UUID: '6ed8dbc2-bbd6-4e04-a5d8-9675e9b52abb',
    URL: 'http://www.ktr.mlit.go.jp/tonedamu/teikyo/realtime/live/sonohara.html'
  },
  'aimata' => {
    UUID: '5c36d55a-b960-4e91-b91c-9b4f9f03cb12',
    URL: 'http://www.ktr.mlit.go.jp/tonedamu/teikyo/realtime/live/aimata.html'
  },
  'naramata' => {
    UUID: 'e4bb71cc-1f9b-40b7-a2ed-5c89e5f5e286',
    URL: 'http://www.ktr.mlit.go.jp/tonedamu/teikyo/realtime/live/naramata.html'
  },
  'yagisawa' => {
    UUID: '68174a4d-cb17-464b-9bd6-94e19212d42b',
    URL: 'http://www.ktr.mlit.go.jp/tonedamu/teikyo/realtime/live/yagisawa.html'
  },
  'kusaki' => {
    UUID: 'b5d123f4-4280-46da-8879-df25b50746b3',
    URL: 'http://www.ktr.mlit.go.jp/tonedamu/teikyo/realtime/live/kusaki.html'
  },
  'shimokubo' => {
    UUID: '10f72d3e-30ec-460b-bfdc-2aae3b8e8485',
    URL: 'http://www.ktr.mlit.go.jp/tonedamu/teikyo/realtime/live/shimokubo.html'
  },
  'watarase' => {
    UUID: '48df1ffa-843e-4720-9a30-93230b78424b',
    URL: 'http://www.ktr.mlit.go.jp/tonedamu/teikyo/realtime/live/watarase.html'
  }
}

def get_list(ent)
  p ent[:URL]
  html = ''
  today = Time.now
  open(ent[:URL]) do | f |
    html = f.read
  end
  doc = Nokogiri::HTML.parse(html)
  ret = Array.new
  doc.xpath('//tr[@align="right"]').each do | node |
    line = Array.new
    node.xpath('td').each do | sub |
      line << sub.inner_text
    end
    dt = line[0].split(' ')
    md = dt[0].split('/')
    hm = dt[1].split(':')
    if ( today.month == 1 )
      if ( md[0].to_i == 12 )
        year = today.year - 1
      else
        year = today.year
      end
    elsif ( md[0].to_i == 1 )
      if ( today.month == 1 )
        year = today.year
      else
        year = today.year - 1
      end
    else
      year = today.year
    end
    vals = Array.new
    vals << Time.local(year, md[0].to_i, md[1].to_i, 
                       hm[0].to_i, hm[1].to_i, 0)
    line[1..-1].each do | el |
      vals << el.gsub(/[\s\,]/,'').to_f
    end
    ret << vals
  end
  ret.reverse
end

DAM_LIST.each do | key, ent |
  last = Time.at(0)
  begin
    File.open("#{HISTORY_DIR}/#{key}", "r") do | file |
      file.each_line do | line |
        last = Time.at(line.to_i)
      end
    end
  rescue
  end
  print "last update = ", last.to_s, "\n"
  recs = Array.new
  get_list(ent).each do | row |
    at = row[0]
    if ( at > last )
      vals = row[1..-1]
      rec = Array.new
      rec << DataAbstraction::SensorData::WaterVolume.new({
                                                            'at' => at,
                                                            'value' => vals[0] * 1000.0,
                                                            'unit' => 'm^3'
                                                          },
                                                          'sensor_name' => 'pondage').to_hash
      rec << DataAbstraction::SensorData::WaterRate.new({
                                                          'at' => at,
                                                          'value' => vals[1],
                                                          'unit' => '%'
                                                        },
                                                        'sensor_name' => 'rate').to_hash
      if ( vals.size > 2 )
        rec << DataAbstraction::SensorData::WaterFlowVolume.new({
                                                                  'at' => at,
                                                                  'value' => vals[2],
                                                                  'unit' => 'm^3/s'
                                                                },
                                                                'sensor_name' => 'incom_flow').to_hash
        rec << DataAbstraction::SensorData::WaterFlowVolume.new({
                                                                  'at' => at,
                                                                  'value' => vals[3],
                                                                  'unit' => 'm^3/s'
                                                                },
                                                                'sensor_name' => 'generation_flow').to_hash
        rec << DataAbstraction::SensorData::WaterFlowVolume.new({
                                                                  'at' => at,
                                                                  'value' => vals[4],
                                                                  'unit' => 'm^3/s'
                                                                },
                                                                'sensor_name' => 'dam_outgo_flow').to_hash
        rec << DataAbstraction::SensorData::WaterFlowVolume.new({
                                                                  'at' => at,
                                                                  'value' => vals[5],
                                                                  'unit' => 'm^3/s'
                                                                },
                                                                'sensor_name' => 'total_outgo_flow').to_hash
      end
      last = at
      recs << rec
    end
  end
  File.open("#{HISTORY_DIR}/#{key}", "w") do | file |
    file.printf("%d", last.to_i)
  end
  server = EverySense::JsonClient.new(SERVER, PORT)
  recs.each do | rec |
    print rec.to_json, "\n"
    print server.put_device_data(ent[:UUID], rec)
  end
end
