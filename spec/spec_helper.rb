begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'tfl'
include Tfl

def asset_as_string(path)
  file = File.join(File.dirname(__FILE__), 'assets', path)
  IO.read(file)
end
