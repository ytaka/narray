$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'ext'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'rspec/autorun'
require 'narray'
