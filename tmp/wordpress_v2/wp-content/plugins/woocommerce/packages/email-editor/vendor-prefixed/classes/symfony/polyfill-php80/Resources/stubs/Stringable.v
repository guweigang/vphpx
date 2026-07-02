import rt

interface EmailEditorVendor_Stringable {
	magic_tostring() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
	}
}
