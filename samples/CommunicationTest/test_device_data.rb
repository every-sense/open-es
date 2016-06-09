require 'rubygems'
require 'json'
require 'msgpack/rpc'

$LOAD_PATH << "../../src"

require 'data_abstraction'
require 'every_sense_msgpack_client'
require 'every_sense_json_client'

HOST = "api.every-sense.com"
PORT = 7000

#cli = EverySense::MsgPackClient.new(HOST, PORT)
#p res = cli.get_message2('uuid' => 'ea78c9f0-351e-4cd0-935b-5193db147c0b',
#                         'login_name' => 'optnet',
#                         'password' => 'satoshi109',
#                         'from' => '2016-05-25 08:59:26 +0000',
#                         'to' => '2016-05-25 09:14:26 +0000')

# GET /device_data/3475e7ac-6ada-46c8-8980-4a574a1d0b25?from=2016-05-27%2008%3A35%3A49&limit=100&login_name=koden&password=jj1cei/1&to=2016-05-27%2009%3A35%3A49

cli = EverySense::JsonClient.new(HOST, 7001)
p res = cli.device_data('3475e7ac-6ada-46c8-8980-4a574a1d0b25', {
                          'login_name' => 'koden',
                          'password' => 'jj1cei/1',
                          'from' => '2016-05-29 08:59:26 +0000',
                          'to' => '2016-05-29 9:14:26 +0000'})

