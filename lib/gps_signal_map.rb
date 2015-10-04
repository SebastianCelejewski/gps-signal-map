require 'date'

Dir['./lib/**/*.rb'].each do |dep|
	require dep
end