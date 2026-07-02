import rt

interface IntegrationInterface {
	get_name() rt.PhpVal
	initialize() rt.PhpVal
	get_script_handles() rt.PhpVal
	get_editor_script_handles() rt.PhpVal
	get_script_data() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
