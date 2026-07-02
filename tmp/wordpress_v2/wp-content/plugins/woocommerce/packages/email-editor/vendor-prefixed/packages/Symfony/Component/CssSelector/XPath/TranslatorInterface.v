import rt

interface TranslatorInterface {
	csstoxpath(rt.PhpVal, rt.PhpVal) rt.PhpVal
	selectortoxpath(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_cssExpr := rt.new_null()
	mut var_prefix := rt.new_null()
	mut var_selector := rt.new_null()
}
