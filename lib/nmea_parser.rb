module GpsSignalMap
	class NmeaParser
		def handle_gpgga nmea_data
			return GPGGA.new(nmea_data)
		end

		def handle_gpgsv nmea_data
			result = Array.new
			number_of_records = (nmea_data.length - 4).to_f / 4
			(0..number_of_records-1).each do |i|
				gsv = GPGSV.new(nmea_data[i*4+4..i*4+7])
				result << gsv
			end
			return result
		end

		def handle_gprmc nmea_data
			return GPRMC.new(nmea_data)
		end
	end
end