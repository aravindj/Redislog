require 'redis'

class Redislog

    @@levels = {
        :debug => 0,
        :info => 1,
        :error => 2,
        :critical => 3
    }
    
    attr_accessor :logger_level, :prefix
        
    def initialize(params = {})
        @logger_level = params[:logger_level] || :debug
        host = params[:host] || 'localhost'
        port = params[:port] || 6379
        db = params[:db] || 0
        @prefix = params[:prefix] || '0'
        @client = Redis.new(:host => host, :port => port, :db => db)
    end
    
    def log(msg, level = :debug)
        if @@levels[level] >= @@levels[@logger_level]
            current_time = Time.now
            key =  if @prefix.nil? then current_time else "#{@prefix}:#{current_time.to_f}" end
            log_msg = "#{@prefix} | #{current_time.to_s} | #{level} | #{msg}"
            @client.set(key, log_msg)
            @client.zadd("logger_keys", current_time.to_f, key)
        end
    end
    
    def write_log(path=".", file_prefix = "Redislog")
        count = @client.zcard("logger_keys")
        keys = @client.zrange("logger_keys", 0, count)
        
        #Export from redis to log file
        if keys.length > 0
            file = File.new("#{path}/#{file_prefix}_#{Time.now.to_i}.log", "w")
            
            values = @client.mget(*keys)
            (0 .. keys.length).each do |counter|
                file.syswrite(values[counter].to_s)
                file.syswrite("\n")
            end
            
            file.close
            
            #delete the entries of logger_keys sorted set and also
            #delete log messages
            @client.zremrangebyrank("logger_keys", 0, count)
            @client.del(*keys)
        end
    end 
end