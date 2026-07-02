import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_uploads := rt.call_function('wp_get_upload_dir', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wp_nonce_url', [
			rt.call_function('add_query_arg', [rt.new_string('wc-hide-notice'),
				rt.new_string('uploads_directory_is_unprotected')]),
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
				rt.new_string('Your store\'s uploads directory is <a href="%1$s">browsable via the web</a>. We strongly recommend <a href="%2$s">configuring your web server to prevent directory indexing</a>.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_url', [
				rt.new_string(
					(var_uploads.array_get(rt.new_string('baseurl'))).str() + '/woocommerce_uploads'),
			]),
			rt.new_string('https://woocommerce.com/document/digital-downloadable-product-handling/#protecting-your-uploads-directory'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
}
