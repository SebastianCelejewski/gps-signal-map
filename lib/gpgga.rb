module GpsSignalMap
	class GPGGA
		attr_reader :time
		attr_reader :latitude
		attr_reader :longitude
		attr_reader :alititude
		attr_reader :horizontal_dilution
		attr_reader :number_of_satellites
		attr_reader :quality

		def initialize(nmea_data)
			@time = nmea_data[1]
			@latitude = parse_latitude(nmea_data[2] + nmea_data[3])
			@longitude = parse_longitude(nmea_data[4] + nmea_data[5])
			@quality = nmea_data[6].to_i
			@number_of_satellites = nmea_data[7].to_i
			@horizontal_dilution = nmea_data[8].to_f
			@altitude = nmea_data[9].to_f
		end

		def parse_latitude latitude_str
			degrees = latitude_str[0..1]
			minutes = latitude_str[2..9]
			ns = latitude_str[10]
			result = degrees.to_f + minutes.to_f / 60
			result = -result if ns == "S"
			return result
		end

		def parse_longitude longitude_str
			degrees = longitude_str[0..2]
			minutes = longitude_str[3..10]
			ew = longitude_str[11]
			result = degrees.to_f + minutes.to_f / 60
			result = -result if ew == "W"
			return result
		end	
	end
end