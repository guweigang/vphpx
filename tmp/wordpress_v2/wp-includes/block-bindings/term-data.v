import rt

fn _block_bindings_term_data_get_value(var_source_args rt.PhpVal, var_block_instance rt.PhpVal) rt.PhpVal {
	mut var_block_name := rt.new_null()
	mut var_is_navigation_block := rt.new_null()
	mut var_term_id := rt.new_null()
	mut var_type := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_term := rt.new_null()
	mut var_taxonomy_object := rt.new_null()
	mut var_term_link := rt.new_null()
	if !rt.is_true(var_source_args.array_get(rt.new_string('field'))) {
		return rt.new_null()
	}
	var_block_name = if !(rt.get_property(var_block_instance, 'name')).is_null() {
		rt.get_property(var_block_instance, 'name')
	} else {
		rt.new_string('')
	}
	var_is_navigation_block = rt.call_function('in_array', [var_block_name.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'core/navigation-link' },
			rt.ArrayItem{ key: none, val: 'core/navigation-submenu' }]),
		rt.new_bool(true)])
	if rt.is_true(var_is_navigation_block) {
		var_term_id = if !(rt.get_property(var_block_instance, 'attributes').array_get(rt.new_string('id'))).is_null() {
			rt.get_property(var_block_instance, 'attributes').array_get(rt.new_string('id'))
		} else {
			rt.new_null()
		}
		var_type = if !(rt.get_property(var_block_instance, 'attributes').array_get(rt.new_string('type'))).is_null() {
			rt.get_property(var_block_instance, 'attributes').array_get(rt.new_string('type'))
		} else {
			rt.new_string('')
		}
		var_taxonomy = if rt.is_true(rt.identical(rt.new_string('tag'), var_type)) {
			rt.new_string('post_tag')
		} else {
			var_type
		}
	} else {
		var_term_id = if !(rt.get_property(var_block_instance, 'context').array_get(rt.new_string('termId'))).is_null() {
			rt.get_property(var_block_instance, 'context').array_get(rt.new_string('termId'))
		} else {
			rt.new_null()
		}
		var_taxonomy = if !(rt.get_property(var_block_instance, 'context').array_get(rt.new_string('taxonomy'))).is_null() {
			rt.get_property(var_block_instance, 'context').array_get(rt.new_string('taxonomy'))
		} else {
			rt.new_string('')
		}
	}
	if !rt.is_true(var_term_id) || !rt.is_true(var_taxonomy) {
		return rt.new_null()
	}
	var_term = rt.call_function('get_term', [var_term_id.clone(),
		var_taxonomy.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
		return rt.new_null()
	}
	var_taxonomy_object = rt.call_function('get_taxonomy', [var_taxonomy.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy_object))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_taxonomy_object, 'publicly_queryable'))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('read'),
		])))))
		{
			return rt.new_null()
		}
	}
	mut switch_val_1 := var_source_args.array_get(rt.new_string('field'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('id'))) {
		return rt.call_function('esc_html', [rt.new_string(var_term_id.str())])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('name'))) {
		return rt.call_function('esc_html', [rt.get_property(var_term, 'name')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('link'))) {
		var_term_link = rt.call_function('get_term_link', [var_term.clone()])
		return if rt.is_true(rt.call_function('is_wp_error', [
			var_term_link.clone()]))
		{ rt.new_null() } else { rt.call_function('esc_url', [
				var_term_link.clone()]) }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('slug'))) {
		return rt.call_function('esc_html', [rt.get_property(var_term, 'slug')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('description'))) {
		return rt.call_function('wp_kses_post', [
			rt.get_property(var_term, 'description'),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('parent'))) {
		return rt.call_function('esc_html', [
			rt.new_string((rt.get_property(var_term, 'parent')).str()),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('count'))) {
		return rt.call_function('esc_html', [
			rt.new_string((rt.get_property(var_term, 'count')).str()),
		])
	} else {
		return rt.new_null()
	}
	return rt.new_null()
}

fn _register_block_bindings_term_data_source() {
	if rt.is_true(rt.call_function('get_block_bindings_source', [
		rt.new_string('core/term-data'),
	]))
	{
		return
	}
	rt.call_function('register_block_bindings_source', [rt.new_string('core/term-data'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Term Data'),
				rt.new_string('block bindings source'),
			]) },
			rt.ArrayItem{ key: 'get_value_callback', val: '_block_bindings_term_data_get_value' },
			rt.ArrayItem{ key: 'uses_context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'termId' },
				rt.ArrayItem{ key: none, val: 'taxonomy' },
			]) },
		])])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('_register_block_bindings_term_data_source')])
}
