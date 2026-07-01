import rt

fn twentytwentyfive_post_format_setup() {
	rt.call_function('add_theme_support', [rt.new_string('post-formats'), rt.create_array([rt.ArrayItem{ key: none, val: 'aside' }, rt.ArrayItem{ key: none, val: 'audio' }, rt.ArrayItem{ key: none, val: 'chat' }, rt.ArrayItem{ key: none, val: 'gallery' }, rt.ArrayItem{ key: none, val: 'image' }, rt.ArrayItem{ key: none, val: 'link' }, rt.ArrayItem{ key: none, val: 'quote' }, rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'video' }])])
}

fn twentytwentyfive_editor_style() {
	rt.call_function('add_editor_style', [rt.new_string('assets/css/editor-style.css')])
}

fn twentytwentyfive_enqueue_styles() {
	mut var_suffix := if rt.is_true(rt.get_constant('SCRIPT_DEBUG')) { '' } else { '.min' }
	mut var_src := rt.new_string('style' + var_suffix + '.css')
	rt.call_function('wp_enqueue_style', [rt.new_string('twentytwentyfive-style'), rt.call_function('get_parent_theme_file_uri', [var_src.dup()]), rt.new_array(), rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}), 'get', [rt.new_string('Version')])])
	rt.call_function('wp_style_add_data', [rt.new_string('twentytwentyfive-style'), rt.new_string('path'), rt.call_function('get_parent_theme_file_path', [var_src.dup()])])
}

fn twentytwentyfive_block_styles() {
	rt.call_function('register_block_style', [rt.new_string('core/list'), rt.create_array([rt.ArrayItem{ key: 'name', val: 'checkmark-list' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Checkmark'), rt.new_string('twentytwentyfive')]) }, rt.ArrayItem{ key: 'inline_style', val: '\n\t\t\t\tul.is-style-checkmark-list {\n\t\t\t\t\tlist-style-type: "\\2713";\n\t\t\t\t}\n\n\t\t\t\tul.is-style-checkmark-list li {\n\t\t\t\t\tpadding-inline-start: 1ch;\n\t\t\t\t}' }])])
}

fn twentytwentyfive_pattern_categories() {
	rt.call_function('register_block_pattern_category', [rt.new_string('twentytwentyfive_page'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Pages'), rt.new_string('twentytwentyfive')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A collection of full page layouts.'), rt.new_string('twentytwentyfive')]) }])])
	rt.call_function('register_block_pattern_category', [rt.new_string('twentytwentyfive_post-format'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Post formats'), rt.new_string('twentytwentyfive')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A collection of post format patterns.'), rt.new_string('twentytwentyfive')]) }])])
}

fn twentytwentyfive_register_block_bindings() {
	rt.call_function('register_block_bindings_source', [rt.new_string('twentytwentyfive/format'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Post format name'), rt.new_string('Label for the block binding placeholder in the editor'), rt.new_string('twentytwentyfive')]) }, rt.ArrayItem{ key: 'get_value_callback', val: 'twentytwentyfive_format_binding' }])])
}

fn twentytwentyfive_format_binding() rt.PhpVal {
	mut var_post_format_slug := rt.call_function('get_post_format', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(var_post_format_slug) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.call_function('get_post_format_string', [var_post_format_slug.dup()])
	}
	return rt.new_null()
}



pub fn init_wp_content_themes_twentytwentyfive_functions_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('twentytwentyfive_post_format_setup')]))))) {
	}
	rt.call_function('add_action', [rt.new_string('after_setup_theme'), rt.new_string('twentytwentyfive_post_format_setup')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('twentytwentyfive_editor_style')]))))) {
	}
	rt.call_function('add_action', [rt.new_string('after_setup_theme'), rt.new_string('twentytwentyfive_editor_style')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('twentytwentyfive_enqueue_styles')]))))) {
	}
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'), rt.new_string('twentytwentyfive_enqueue_styles')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('twentytwentyfive_block_styles')]))))) {
	}
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('twentytwentyfive_block_styles')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('twentytwentyfive_pattern_categories')]))))) {
	}
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('twentytwentyfive_pattern_categories')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('twentytwentyfive_register_block_bindings')]))))) {
	}
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('twentytwentyfive_register_block_bindings')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('twentytwentyfive_format_binding')]))))) {
	}
}
