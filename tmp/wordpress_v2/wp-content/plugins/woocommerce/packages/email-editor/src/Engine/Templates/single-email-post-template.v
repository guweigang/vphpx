import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_template_html := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_editor_preview_post_template_html'),
		rt.call_function('get_post', []rt.PhpVal{}),
	])
	rt.echo_val(var_template_html)
}
