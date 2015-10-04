require './lib/gps_signal_map'

module GpsSignalMap

	if ARGV.length != 3
		puts "Usage: parse_nmea <input_data_directory> <latitude_step> <longitude_step>"
		puts "Example: parse_nmea input 0.005 0.01"
		abort
	end

	input_data_directory = ARGV[0]
	latitude_step = ARGV[1].to_f
	longitude_step = ARGV[2].to_f
	output_file = "result.kml"

	data = Array.new
	clustering = Clustering.new(latitude_step, longitude_step)
	nmea_parser = NmeaParser.new

	puts "Loading input files from directory #{input_data_directory}"
	input_files = Dir.glob("#{input_data_directory}/**.*")

	puts "Found #{input_files.length} input files"
	input_files.each do |file|
		puts "Loading file #{file}"

		lines = File.read(file).split(/\n/)

		time = nil
		latitude = nil
		longitude = nil

		lines.each do |line|
			nmea_line_match = /(\$.*)\*/.match(line)
			next if nmea_line_match == nil
			nmea_line = nmea_line_match[1]
			nmea_command = nmea_line[0..5]
			nmea_data = nmea_line.split(/,/, -1)

			if nmea_command == "$GPRMC"
				rmc = nmea_parser.handle_gprmc(nmea_data)

				if rmc.status == "A"
					time = rmc.time
				end
			end

			if nmea_command == "$GPGGA"
				gga = nmea_parser.handle_gpgga(nmea_data)
				if gga.quality > 0
					latitude, longitude = clustering.cluster_position(gga.latitude, gga.longitude)
				end
			end

			if nmea_command == "$GPGSV"
				if latitude != nil and longitude != nil
					gsvs = nmea_parser.handle_gpgsv(nmea_data) 
					gsvs.each do |gsv|
						data_point = DataPoint.new(time, latitude, longitude, gsv.satellite_prn, gsv.snr)
						data << data_point
					end
				end
			end
		end
	end

	normalized_data = Hash.new { |map,key| map[key] = Array.new}

	data.each do |data_point|
		key = {:latitude => data_point.latitude, :longitude => data_point.longitude}
		normalized_data[key] << data_point
	end

	puts "Number of loaded data points: #{data.length}"
	puts "Number of clusters: #{normalized_data.length}"

	kml_template = File.read('kml_templates/kml_document.kml')
	placemark_template = File.read('kml_templates/placemark_polygon.kml')
	placemarks = ""

	puts "Calculating clusters information"
	normalized_data.each do |keyValue|
		latitude = keyValue[0][:latitude]
		longitude = keyValue[0][:longitude]

		data_points = keyValue[1]
		snrs = Array.new
		data_points.each do |data_point|
			snrs << data_point.snr
		end

		snr_max = snrs.max
		snr_min = snrs.min
		snr_avg = snrs.inject(0) {|x,y| x + y.to_i}.to_f / snrs.length

		info = "#{snr_avg.to_i}"

		placemark_coordinates = "#{longitude - longitude_step/2},#{latitude - latitude_step/2},0\n"
		placemark_coordinates += "#{longitude + longitude_step/2},#{latitude - latitude_step/2},0\n"
		placemark_coordinates += "#{longitude + longitude_step/2},#{latitude+ latitude_step/2},0\n"
		placemark_coordinates += "#{longitude - longitude_step/2},#{latitude+ latitude_step/2},0\n"

		style_name = "#msn_shaded_dot_#{snr_avg.round(-1)}"

		placemark = placemark_template.clone
		placemark["\$name"] = info
		placemark["\$coordinates"] = placemark_coordinates
		placemark["\$styleName"] = style_name
		placemarks += placemark
	end

	kml_file = kml_template.clone
	kml_file["\$placemarks"] = placemarks

	puts "Saving results to #{output_file}"
	File.open(output_file,'w') do |file|
		file.write(kml_file)
	end

	puts "Done"

end