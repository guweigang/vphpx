import rt

interface Css_Inliner {
	from_html(rt.PhpVal) rt.PhpVal
	inline_css(rt.PhpVal) rt.PhpVal
	render() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_unprocessed_html := rt.new_null()
	mut var_css := rt.new_null()
}
