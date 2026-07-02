import rt

interface FeedInterface {
	start() rt.PhpVal
	add_entry(rt.PhpVal) rt.PhpVal
	end() rt.PhpVal
	get_file_path() rt.PhpVal
	get_file_url() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_entry := rt.new_null()
}
