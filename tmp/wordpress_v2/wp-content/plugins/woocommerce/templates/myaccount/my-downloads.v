import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_downloads := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'customer'), 'get_downloadable_products', []rt.PhpVal{})
	if rt.is_true(var_downloads) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_before_available_downloads'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_my_account_my_downloads_title'),
			rt.call_function('esc_html__', [rt.new_string('Available downloads'),
				rt.new_string('woocommerce')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := var_downloads.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_download := item_1.val
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('do_action', [
				rt.new_string('woocommerce_available_download_start'),
				var_download.clone(),
			])
			if rt.is_true(rt.new_bool(
				var_download.array_get(rt.new_string('downloads_remaining')).is_long()
				|| var_download.array_get(rt.new_string('downloads_remaining')).is_double()))
			{
				rt.echo_val(rt.call_function('apply_filters', [
					rt.new_string('woocommerce_available_download_count'),
					rt.new_string('<span class="woocommerce-Count count">' +
						(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s download remaining'), rt.new_string('%s downloads remaining'), var_download.array_get(rt.new_string('downloads_remaining')), rt.new_string('woocommerce')]), var_download.array_get(rt.new_string('downloads_remaining'))])).str() +
						'</span> '),
					var_download.clone(),
				]))
			}
			rt.echo_val(rt.call_function('apply_filters', [
				rt.new_string('woocommerce_available_download_link'),
				rt.new_string('<a href="' +
					(rt.call_function('esc_url', [var_download.array_get(rt.new_string('download_url'))])).str() +
					'">' + (var_download.array_get(rt.new_string('download_name'))).str() + '</a>'),
				var_download.clone(),
			]))
			rt.call_function('do_action', [
				rt.new_string('woocommerce_available_download_end'),
				var_download.clone(),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_after_available_downloads'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
}
