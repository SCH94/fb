begin
  require 'coveralls/rake/task'
  Coveralls::RakeTask.new
rescue LoadError => e
  raise e unless ENV['RAILS_ENV'] == "production"
end
