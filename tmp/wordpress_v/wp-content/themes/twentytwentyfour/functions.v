import rt

fn twentytwentyfour_block_styles() {
	rt.call_function('register_block_style', [rt.new_string('core/details'),
		rt.create_array([rt.ArrayItem{ key: 'name', val: 'arrow-icon-details' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Arrow icon'),
				rt.new_string('twentytwentyfour'),
			]) }, rt.ArrayItem{
				key: 'inline_style'
				val: '\n\t\t\t\t.is-style-arrow-icon-details {\n\t\t\t\t\tpadding-top: var(--wp--preset--spacing--10);\n\t\t\t\t\tpadding-bottom: var(--wp--preset--spacing--10);\n\t\t\t\t}\n\n\t\t\t\t.is-style-arrow-icon-details summary {\n\t\t\t\t\tlist-style-type: "\\2193\\00a0\\00a0\\00a0";\n\t\t\t\t}\n\n\t\t\t\t.is-style-arrow-icon-details[open]>summary {\n\t\t\t\t\tlist-style-type: "\\2192\\00a0\\00a0\\00a0";\n\t\t\t\t}'
			}])])
	rt.call_function('register_block_style', [rt.new_string('core/post-terms'),
		rt.create_array([rt.ArrayItem{ key: 'name', val: 'pill' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Pill'),
				rt.new_string('twentytwentyfour'),
			]) }, rt.ArrayItem{
				key: 'inline_style'
				val: '\n\t\t\t\t.is-style-pill a,\n\t\t\t\t.is-style-pill span:not([class], [data-rich-text-placeholder]) {\n\t\t\t\t\tdisplay: inline-block;\n\t\t\t\t\tbackground-color: var(--wp--preset--color--base-2);\n\t\t\t\t\tpadding: 0.375rem 0.875rem;\n\t\t\t\t\tborder-radius: var(--wp--preset--spacing--20);\n\t\t\t\t}\n\n\t\t\t\t.is-style-pill a:hover {\n\t\t\t\t\tbackground-color: var(--wp--preset--color--contrast-3);\n\t\t\t\t}'
			}])])
	rt.call_function('register_block_style', [rt.new_string('core/list'),
		rt.create_array([rt.ArrayItem{ key: 'name', val: 'checkmark-list' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Checkmark'),
				rt.new_string('twentytwentyfour'),
			]) }, rt.ArrayItem{
				key: 'inline_style'
				val: '\n\t\t\t\tul.is-style-checkmark-list {\n\t\t\t\t\tlist-style-type: "\\2713";\n\t\t\t\t}\n\n\t\t\t\tul.is-style-checkmark-list li {\n\t\t\t\t\tpadding-inline-start: 1ch;\n\t\t\t\t}'
			}])])
	rt.call_function('register_block_style', [rt.new_string('core/navigation-link'),
		rt.create_array([rt.ArrayItem{ key: 'name', val: 'arrow-link' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('With arrow'),
				rt.new_string('twentytwentyfour'),
			]) }, rt.ArrayItem{
				key: 'inline_style'
				val: '\n\t\t\t\t.is-style-arrow-link .wp-block-navigation-item__label:after {\n\t\t\t\t\tcontent: "\\2197";\n\t\t\t\t\tpadding-inline-start: 0.25rem;\n\t\t\t\t\tvertical-align: middle;\n\t\t\t\t\ttext-decoration: none;\n\t\t\t\t\tdisplay: inline-block;\n\t\t\t\t}'
			}])])
	rt.call_function('register_block_style', [rt.new_string('core/heading'),
		rt.create_array([rt.ArrayItem{ key: 'name', val: 'asterisk' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('With asterisk'),
				rt.new_string('twentytwentyfour'),
			]) }, rt.ArrayItem{
				key: 'inline_style'
				val: "\n\t\t\t\t.is-style-asterisk:before {\n\t\t\t\t\tcontent: '';\n\t\t\t\t\twidth: 1.5rem;\n\t\t\t\t\theight: 3rem;\n\t\t\t\t\tbackground: var(--wp--preset--color--contrast-2, currentColor);\n\t\t\t\t\tclip-path: path('M11.93.684v8.039l5.633-5.633 1.216 1.23-5.66 5.66h8.04v1.737H13.2l5.701 5.701-1.23 1.23-5.742-5.742V21h-1.737v-8.094l-5.77 5.77-1.23-1.217 5.743-5.742H.842V9.98h8.162l-5.701-5.7 1.23-1.231 5.66 5.66V.684h1.737Z');\n\t\t\t\t\tdisplay: block;\n\t\t\t\t}\n\n\t\t\t\t/* Hide the asterisk if the heading has no content, to avoid using empty headings to display the asterisk only, which is an A11Y issue */\n\t\t\t\t.is-style-asterisk:empty:before {\n\t\t\t\t\tcontent: none;\n\t\t\t\t}\n\n\t\t\t\t.is-style-asterisk:-moz-only-whitespace:before {\n\t\t\t\t\tcontent: none;\n\t\t\t\t}\n\n\t\t\t\t.is-style-asterisk.has-text-align-center:before {\n\t\t\t\t\tmargin: 0 auto;\n\t\t\t\t}\n\n\t\t\t\t.is-style-asterisk.has-text-align-right:before {\n\t\t\t\t\tmargin-left: auto;\n\t\t\t\t}\n\n\t\t\t\t.rtl .is-style-asterisk.has-text-align-left:before {\n\t\t\t\t\tmargin-right: auto;\n\t\t\t\t}"
			}])])
}

fn twentytwentyfour_block_stylesheets() {
	rt.call_function('wp_enqueue_block_style', [rt.new_string('core/button'),
		rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'twentytwentyfour-button-style-outline' },
			rt.ArrayItem{ key: 'src', val: rt.call_function('get_parent_theme_file_uri', [
				rt.new_string('assets/css/button-outline.css'),
			]) },
			rt.ArrayItem{ key: 'ver', val: rt.call_method(rt.call_function('wp_get_theme', [
				rt.call_function('get_template', []rt.PhpVal{}),
			]), 'get', [
				rt.new_string('Version'),
			]) },
			rt.ArrayItem{ key: 'path', val: rt.call_function('get_parent_theme_file_path', [
				rt.new_string('assets/css/button-outline.css'),
			]) },
		])])
}

fn twentytwentyfour_pattern_categories() {
	rt.call_function('register_block_pattern_category', [
		rt.new_string('twentytwentyfour_page'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Pages'),
				rt.new_string('Block pattern category'),
				rt.new_string('twentytwentyfour'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('A collection of full page layouts.'),
				rt.new_string('twentytwentyfour'),
			]) },
		]),
	])
}

pub fn init_wp_content_themes_twentytwentyfour_functions_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('twentytwentyfour_block_styles'),
	])))))
	{
	}
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('twentytwentyfour_block_styles')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('twentytwentyfour_block_stylesheets'),
	])))))
	{
	}
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('twentytwentyfour_block_stylesheets')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('twentytwentyfour_pattern_categories'),
	])))))
	{
	}
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('twentytwentyfour_pattern_categories')])
}
