import rt

pub fn init_wp_includes_block_patterns_social_links_shared_background_color_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
			rt.new_string('Social links with a shared background color'),
			rt.new_string('Block pattern title'),
		]) },
		rt.ArrayItem{ key: 'categories', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'buttons' },
		]) },
		rt.ArrayItem{ key: 'blockTypes', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'core/social-links' },
		]) },
		rt.ArrayItem{ key: 'viewportWidth', val: 500 },
		rt.ArrayItem{
			key: 'content'
			val: '<!-- wp:social-links {"customIconColor":"#ffffff","iconColorValue":"#ffffff","customIconBackgroundColor":"#3962e3","iconBackgroundColorValue":"#3962e3","className":"has-icon-color"} -->\n\t\t\t\t\t\t<ul class="wp-block-social-links has-icon-color has-icon-background-color"><!-- wp:social-link {"url":"https://wordpress.org","service":"wordpress"} /-->\n\t\t\t\t\t\t<!-- wp:social-link {"url":"#","service":"chain"} /-->\n\t\t\t\t\t\t<!-- wp:social-link {"url":"#","service":"mail"} /--></ul>\n\t\t\t\t\t\t<!-- /wp:social-links -->'
		},
	])
}
