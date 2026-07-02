import rt

interface StepExporter {
	export() rt.PhpVal
	get_step_name() rt.PhpVal
	check_step_capabilities() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
