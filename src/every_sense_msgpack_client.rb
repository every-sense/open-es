require 'rubygems'
require 'msgpack/rpc'
require 'debug_message'

module EverySense
  class MsgPackClient
    DS_HOST = "127.0.0.1"
    DS_PORT = 7000
    DS_TIMEOUT = 60
    RETRY_MAX = 5
    RETRY_INTERVAL = 5

    def initialize(host = DS_HOST, port = DS_PORT, timeout = DS_TIMEOUT,
                   retry_max = RETRY_MAX, retry_interval = RETRY_INTERVAL)
      debug_message("initialize #{self.class}")
      @cli = MessagePack::RPC::Client.new(host, port)
      @cli.timeout = timeout
      @retry_max = retry_max
      @retry_interval = retry_interval
    end
    def set_timeout(open_timeout, read_timeout = open_timeout)
      @cli.timeout = open_timeout
    end
    def set_retry(max_retry)
      @max_retry = max_retry
    end
    def exec(name, args = nil)
      _exec(name, args)
    end
    def method_missing(name, *args)
      _exec(name, args)
    end
  private
    def _exec(name, args = nil)
      begin
        retry_count = @retry_max
        begin
          if ( args )
            if ( args.size > 0 )
              if ( $DEBUG )
                p @cli.call(name, *args)
              else
                @cli.call(name, *args)
              end
            else
              if ( $DEBUG )
                p @cli.call(name)
              else
                @cli.call(name)
              end
            end
          else
            if ( $DEBUG )
              p @cli.call(name)
            else
              @cli.call(name)
            end
          end
        rescue MessagePack::RPC::TimeoutError, MessagePack::RPC::TransportError => e
          raise if ( retry_count -= 1 ) == 0
          @cli.close
          $stderr.puts e
          sleep @retry_interval
          retry
        end
      rescue MessagePack::RPC::RPCError => e
        $stderr.puts e
        {
          code: -40,
          reason: "too many retry(#{@retry_max})",
          message: "exec #{name} args #{args}"
        }
      ensure
        @cli.close
      end
    end
  end
end
