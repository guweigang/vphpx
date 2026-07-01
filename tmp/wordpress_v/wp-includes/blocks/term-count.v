import rt

fn render_block_core_term_count(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if rt.get_property(var_block, 'context').array_isset(rt.new_string('termId'))
		&& rt.get_property(var_block, 'context').array_isset(rt.new_string('taxonomy')) {
		mut var_term := rt.call_function('get_term', [rt.get_property(var_block, 'context').array_get('termId'),
			rt.get_property(var_block, 'context').array_get('taxonomy')])
	} else {
		var_term = rt.call_function('get_queried_object', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_term, 'WP_Term')))))) {
			var_term = rt.new_null()
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_term))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_term.dup()]))))
	{
		return ''
	}
	mut var_term_count := rt.get_property(var_term, 'count')
	mut switch_val_1 := var_attributes.array_get('bracketType')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('none'))) {
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('round'))) {
		var_term_count = rt.new_string(rt.new_string('(${var_term_count.to_string()})'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('square'))) {
		var_term_count = rt.new_string(rt.new_string('[${var_term_count.to_string()}]'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('curly'))) {
		var_term_count = rt.new_string(rt.new_string('{${var_term_count.to_string()}}'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('angle'))) {
		var_term_count = rt.new_string(rt.new_string('<${var_term_count.to_string()}>'))
	} else {
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.dup(), var_term_count.dup()])).str()
}

fn register_block_core_term_count() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/term-count',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_term_count' },
		])])
}

pub fn init_wp_includes_blocks_term_count_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_term_count')])
}
