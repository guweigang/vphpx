import rt

interface WithHttpTransporterInterface {
	sethttptransporter(rt.PhpVal) rt.PhpVal
	gethttptransporter() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_transporter := rt.new_null()
}
