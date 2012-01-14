Gem::Specification.new do |s|
  s.name        = 'redislog'
  s.version     = '1.0.0'
  s.date        = '2012-01-14'
  s.summary     = "Redis based application logger."
  s.description = "Redislog is an application logger with redis as backend instead of file."
  s.authors     = ["Aravind"]
  s.email       = 'aravindkumar.leo@gmail.com'
  s.files       = ["lib/redislog.rb", "bin/redislog"]
  s.executables = ["redislog"]
  s.add_runtime_dependency  'redis'
  s.add_runtime_dependency  'choice'
  s.homepage = ""
end
