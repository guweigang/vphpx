import rt

fn render_block_core_calendar(var_attributes rt.PhpVal) string {
	mut var_previous_monthnum := rt.new_null()
	mut var_previous_year := rt.new_null()
	mut var_permalink_structure := rt.new_null()
	mut var_monthnum := rt.new_null()
	mut var_year := rt.new_null()
	mut var_color_block_styles := map[string]rt.PhpVal{}
	mut var_preset_text_color := rt.new_null()
	mut var_custom_text_color := rt.new_null()
	mut var_preset_background_color := rt.new_null()
	mut var_custom_background_color := rt.new_null()
	mut var_styles := rt.new_null()
	mut var_inline_styles := rt.new_null()
	mut var_classnames := rt.new_null()
	mut var_calendar := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	mut var_output := rt.new_null()
	if !(block_core_calendar_has_published_posts()) {
		if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
			return '<div>' +
				(rt.call_function('__', [rt.new_string('The calendar block is hidden because there are no published posts.')])).str() +
				'</div>'
		}
		return ''
	}
	var_previous_monthnum = var_monthnum.clone()
	var_previous_year = var_year.clone()
	if var_attributes.array_isset(rt.new_string('month'))
		&& var_attributes.array_isset(rt.new_string('year')) {
		var_permalink_structure = rt.call_function('get_option', [
			rt.new_string('permalink_structure'),
		])
		if rt.is_true(rt.call_function('str_contains', [var_permalink_structure.clone(), rt.new_string('%monthnum%')]))
			&& rt.is_true(rt.call_function('str_contains', [var_permalink_structure.clone(), rt.new_string('%year%')])) {
			var_monthnum = var_attributes.array_get(rt.new_string('month'))
			var_year = var_attributes.array_get(rt.new_string('year'))
		}
	}
	var_color_block_styles = map[string]rt.PhpVal{}
	var_preset_text_color = if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_attributes).array_isset(rt.new_string('textColor')))) {
		rt.concat(rt.new_string('var:preset|color|'),
			var_attributes.array_get(rt.new_string('textColor')))
	} else {
		rt.new_null()
	}
	var_custom_text_color = if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))
	} else {
		rt.new_null()
	}
	var_color_block_styles['text'] = if rt.is_true(var_preset_text_color) {
		var_preset_text_color
	} else {
		var_custom_text_color
	}
	var_preset_background_color = if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_attributes).array_isset(rt.new_string('backgroundColor')))) {
		rt.concat(rt.new_string('var:preset|color|'),
			var_attributes.array_get(rt.new_string('backgroundColor')))
	} else {
		rt.new_null()
	}
	var_custom_background_color = if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('background'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('color')).array_get(rt.new_string('background'))
	} else {
		rt.new_null()
	}
	var_color_block_styles['background'] = if rt.is_true(var_preset_background_color) {
		var_preset_background_color
	} else {
		var_custom_background_color
	}
	var_styles = rt.call_function('wp_style_engine_get_styles', [
		rt.create_array([rt.ArrayItem{ key: 'color', val: var_color_block_styles }]),
		rt.create_array([rt.ArrayItem{ key: 'convert_vars_to_classnames', val: true }]),
	])
	var_inline_styles = if !rt.is_true(var_styles.array_get(rt.new_string('css'))) { rt.new_string('') } else { rt.call_function('sprintf', [
			rt.new_string(' style="%s"'),
			rt.call_function('esc_attr', [var_styles.array_get(rt.new_string('css'))]),
		]) }
	var_classnames = rt.new_string((if !rt.is_true(var_styles.array_get(rt.new_string('classnames'))) {
		''
	} else {
		' ' +(rt.call_function('esc_attr', [var_styles.array_get(rt.new_string('classnames'))])).str()
	}).str())
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')) {
		var_classnames = rt.concat(var_classnames, rt.new_string(' has-link-color'))
	}
	var_calendar = rt.call_function('str_replace', [rt.new_string('<table'),
		rt.new_string('<table' + var_inline_styles.str()),
		rt.call_function('get_calendar', [
			rt.new_bool(true),
			rt.new_bool(false),
		])])
	var_calendar = rt.call_function('str_replace', [
		rt.new_string('class="wp-calendar-table'),
		rt.new_string('class="wp-calendar-table' + var_classnames.str()),
		var_calendar.clone(),
	])
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	var_output = rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.clone(), var_calendar.clone()])
	var_monthnum = var_previous_monthnum.clone()
	var_year = var_previous_year.clone()
	return var_output.str()
}

fn register_block_core_calendar() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/calendar'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_calendar' },
		]),
	])
}

fn block_core_calendar_has_published_posts() bool {
	mut var_has_published_posts := rt.new_null()
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		return rt.new_bool(0 < rt.new_int((rt.call_function('get_option', [
			rt.new_string('post_count'),
		])).to_i64()))
	}
	var_has_published_posts = rt.call_function('get_option', [
		rt.new_string('wp_calendar_block_has_published_posts'),
		rt.new_null(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_has_published_posts)))) {
		return var_has_published_posts.to_bool()
	}
	return (block_core_calendar_update_has_published_posts()).to_bool()
}

fn block_core_calendar_update_has_published_posts() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_has_published_posts := rt.new_null()
	var_has_published_posts = rt.new_bool((rt.call_method(var_wpdb, 'get_var', [
		rt.concat(rt.concat(rt.new_string('SELECT 1 as test FROM '), rt.get_property(var_wpdb,
			'posts')),
			rt.new_string(" WHERE post_type = 'post' AND post_status = 'publish' LIMIT 1")),
	])).to_bool())
	rt.call_function('update_option', [
		rt.new_string('wp_calendar_block_has_published_posts'),
		var_has_published_posts.clone(),
	])
	return var_has_published_posts.clone()
}

fn block_core_calendar_update_has_published_post_on_delete(var_post_id rt.PhpVal) {
	mut var_post := rt.new_null()
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post, 'post_status')))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_post, 'post_type'))))) {
		return
	}
	block_core_calendar_update_has_published_posts()
}

fn block_core_calendar_update_has_published_post_on_transition_post_status(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_post rt.PhpVal) {
	if rt.is_true(rt.identical(var_new_status, var_old_status)) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), rt.call_function('get_post_type', [
		var_post.clone(),
	])))))
	{
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), var_new_status))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), var_old_status)))) {
		return
	}
	block_core_calendar_update_has_published_posts()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('register_block_core_calendar')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		rt.call_function('add_action', [rt.new_string('delete_post'),
			rt.new_string('block_core_calendar_update_has_published_post_on_delete')])
		rt.call_function('add_action', [rt.new_string('transition_post_status'),
			rt.new_string('block_core_calendar_update_has_published_post_on_transition_post_status'),
			rt.new_int(10), rt.new_int(3)])
	}
}
