module GpsSignalMap
	class Clustering
		def initialize latitude_step, longitude_step
			@latitude_step = latitude_step
			@longitude_step = longitude_step
		end

		def cluster_position latitude, longitude
			return cluster(latitude, @latitude_step), cluster(longitude, @longitude_step)
		end

		def cluster x, step
			y = x + step.to_f/2
			a = y / step
			b = a.floor
			c = b * step
			return c
		end
	end
end