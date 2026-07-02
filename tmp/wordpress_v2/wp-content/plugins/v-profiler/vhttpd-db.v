import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/v-profiler/vhttpd-db.php', '4')
}
