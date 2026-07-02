import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wp_nonce_url', [
			rt.call_function('add_query_arg', [rt.new_string('wc-hide-notice'),
				rt.new_string('redirect_download_method')]),
			rt.new_string('woocommerce_hide_notices_nonce'),
			rt.new_string('_wc_notice_nonce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Dismiss'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your store is configured to serve digital products using "Redirect only" method. This method is deprecated, <a href="%s">please switch to a different method instead.</a><br><em>If you use a remote server for downloadable files (such as Google Drive, Dropbox, Amazon S3), you may optionally wish to "allow using redirects as a last resort". Enabling that and/or selecting any of the other options will make this notice go away.</em>'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'page', val: 'wc-settings' },
					rt.ArrayItem{ key: 'tab', val: 'products' },
					rt.ArrayItem{ key: 'section', val: 'downloadable' }]),
				rt.call_function('admin_url', [rt.new_string('admin.php')]),
			]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
}
