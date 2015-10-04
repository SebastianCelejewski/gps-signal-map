module GpsSignalMap
	class GPRMC
		attr_reader :time
		attr_reader :status
		attr_reader :latitude
		attr_reader :longitude
		attr_reader :speed
		attr_reader :track_angle
		attr_reader :magnetic_variation

		def initialize(nmea_data)
			@status = nmea_data[2]
			@time = parse_nmea_time(nmea_data[9] + nmea_data[1])
			@latitude = nmea_data[3]+nmea_data[4]
			@longitude = nmea_data[5] +nmea_data[6]
			@speed = nmea_data[7]
			@track_angle = nmea_data[8]
			@magnetic_variation = nmea_data[10]
		end

		def parse_nmea_time time
			return nil if time == ""
			return nil if @status == "V"
			return DateTime.strptime(time[0..11], '%d%m%y%H%M%S')
		end
	end
end