import rt

fn options_discussion_add_js() {
	// unsupported statement: Stmt_InlineHTML
}

fn options_general_add_js() {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_json_encode', [
		rt.call_function('get_home_url', []rt.PhpVal{}),
		rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES')),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn options_reading_add_js() {
	// unsupported statement: Stmt_InlineHTML
}

fn options_reading_blog_charset() {
	print('<input name="blog_charset" type="text" id="blog_charset" value="' +
		(rt.call_function('esc_attr', [rt.call_function('get_option', [rt.new_string('blog_charset')])])).str() +
		'" class="regular-text" />')
	print('<p class="description">' +
		(rt.call_function('__', [rt.new_string('The <a href="https://wordpress.org/documentation/article/wordpress-glossary/#character-set">character encoding</a> of your site (UTF-8 is recommended)')])).str() +
		'</p>')
}

fn main() {
	defer {
		rt.shutdown()
	}
}
