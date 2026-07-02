import rt

interface WC_Importer_Interface {
	import() rt.PhpVal
	get_raw_keys() rt.PhpVal
	get_mapped_keys() rt.PhpVal
	get_raw_data() rt.PhpVal
	get_parsed_data() rt.PhpVal
	get_file_position() rt.PhpVal
	get_percent_complete() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
