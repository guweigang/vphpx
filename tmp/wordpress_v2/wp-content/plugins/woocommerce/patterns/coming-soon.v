import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_store_pages_only := (rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_store_pages_only'),
		rt.new_string('no'),
	]))).to_bool()
	mut var_default_pattern := if var_store_pages_only {
		'coming-soon-store-only'
	} else {
		'page-coming-soon-default'
	}
	// unsupported statement: Stmt_InlineHTML
	print(var_default_pattern)
	// unsupported statement: Stmt_InlineHTML
}
