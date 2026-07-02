import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_autoload_entry_point := rt.new_string(@DIR + '/vendor/autoload.php')
	if rt.is_true(rt.call_function('file_exists', [var_autoload_entry_point.clone()])) {
		rt.include_file(var_autoload_entry_point.to_string(), '4')
	}
}
