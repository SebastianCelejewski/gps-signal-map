module GpsSignalMap
	class GPGSV
		attr_reader :satellite_prn
		attr_reader :elevation
		attr_reader :azimuth
		attr_reader :snr

		def initialize(nmea_data)
			@satellite_prn = nmea_data[0]
			@elevation = nmea_data[1]
			@azimuth = nmea_data[2]
			@snr = nmea_data[3]
			@snr = "0" if @snr == ""
		end
	end
end