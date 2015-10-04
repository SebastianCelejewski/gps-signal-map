module GpsSignalMap
	class DataPoint
		attr_reader :time
		attr_reader :latitude
		attr_reader :longitude
		attr_reader :satellite_prn
		attr_reader :snr

		def initialize(time, latitude, longitude, satellite_prn, snr)
			@time = time
			@latitude = latitude
			@longitude = longitude
			@satellite_prn = satellite_prn
			@snr = snr
		end
	end
end