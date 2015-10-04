module GpsSignalMap
	class ClusteringTests < MiniTest::Test

		def test_clustering_to_integer_for_cluster_centre
			@clustering = Clustering.new 1, 1
			lat, lon = @clustering.cluster_position 0, 0

			assert_equal 0, lat
			assert_equal 0, lon
		end

		def test_clustering_to_integer_for_cluster_bottom_left_corner
			@clustering = Clustering.new 1, 1
			lat, lon = @clustering.cluster_position -0.499, -0.499
			assert_equal 0, lat
			assert_equal 0, lon
		end

		def test_clustering_to_integer_for_cluster_top_right_corner
			@clustering = Clustering.new 1, 1
			lat, lon = @clustering.cluster_position 0.499, 0.49
			assert_equal 0, lat
			assert_equal 0, lon
		end

		def test_clustering_to_integer_for_left_cluster
			@clustering = Clustering.new 1, 1
			lat, lon = @clustering.cluster_position -0.51, 0

			assert_equal -1, lat
			assert_equal 0, lon
		end

		def test_clustering_to_integer_for_top_cluster
			@clustering = Clustering.new 1, 1
			lat, lon = @clustering.cluster_position 0, 0.51

			assert_equal 0, lat
			assert_equal 1, lon
		end

		def test_clustering_to_integer_for_right_cluster
			@clustering = Clustering.new 1, 1
			lat, lon = @clustering.cluster_position 0.6, 0

			assert_equal 1, lat
			assert_equal 0, lon
		end

		def test_clustering_to_integer_for_bottom_cluster
			@clustering = Clustering.new 1, 1
			lat, lon = @clustering.cluster_position 0, -0.6

			assert_equal 0, lat
			assert_equal -1, lon
		end

		def test_clustering_to_fraction_for_cluster_centre
			@clustering = Clustering.new 0.5, 0.5
			lat, lon = @clustering.cluster_position 0, 0

			assert_equal 0, lat
			assert_equal 0, lon
		end

		def test_clustering_to_fraction_for_cluster_bottom_left_corner
			@clustering = Clustering.new 0.5, 0.5
			lat, lon = @clustering.cluster_position -0.249, -0.249
			assert_equal 0, lat
			assert_equal 0, lon
		end

		def test_clustering_to_fraction_for_cluster_top_right_corner
			@clustering = Clustering.new 0.5, 0.5
			lat, lon = @clustering.cluster_position 0.249, 0.249
			assert_equal 0, lat
			assert_equal 0, lon
		end

		def test_clustering_to_fraction_for_left_cluster
			@clustering = Clustering.new 0.5, 0.5
			lat, lon = @clustering.cluster_position -0.26, 0

			assert_equal -0.5, lat
			assert_equal 0, lon
		end

		def test_clustering_to_fraction_for_top_cluster
			@clustering = Clustering.new 0.5, 0.5
			lat, lon = @clustering.cluster_position 0, 0.26

			assert_equal 0, lat
			assert_equal 0.5, lon
		end

		def test_clustering_to_fraction_for_right_cluster
			@clustering = Clustering.new 0.5, 0.5
			lat, lon = @clustering.cluster_position 0.26, 0

			assert_equal 0.5, lat
			assert_equal 0, lon
		end

		def test_clustering_to_fraction_for_bottom_cluster
			@clustering = Clustering.new 0.5, 0.5
			lat, lon = @clustering.cluster_position 0, -0.26

			assert_equal 0, lat
			assert_equal -0.5, lon
		end
	end
end