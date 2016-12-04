#\ -s puma
require './random_controller'

# run Rack::URLMap.new('/' => RandomController)
run RandomController
