Redislog is a simple application logger which uses redis as backend to
log messages.

Installation:

    gem install redislog

Usage:

    require 'redislog'
    
    ...
    
    logger = Redislog.new(:host => 'localhost',
                            :port => 6379,
                            :db = '0',
                            :prefix = 'SERVER1',
                            :logger_level = :debug)
    logger.debug("Debug msg")
    logger.info("Info msg")
    logger.error("Error msg")
    logger.critical("Critical error msg")
    
    
    Above code logs the messages in redis server.
    
    Then add the 'redislog' command to your cronjob so that the messages
    will be written to a file preiodically.
    
redislog command:
    #$redislog -d /tmp -f Applog -h localhost -p 6379 -D 0
    
    This will write all the messages to file /tmp/Applog_1326734499.log,
    where 1326734499 is the timestamp at the time of writing the file.
    

Example log message in file:

    SERVER1 | 2012-01-16 22:55:22 +0530 | info | Info Msg

Note: This have not been tested in production env yet.
