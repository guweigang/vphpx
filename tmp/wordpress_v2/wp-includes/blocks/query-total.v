import rt

fn render_block_core_query_total(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	mut var_query_to_use := rt.new_null()
	mut var_current_page := rt.new_null()
	mut var_page_key := rt.new_null()
	mut var_max_rows := rt.new_null()
	mut var_posts_per_page := rt.new_null()
	mut var_start := rt.new_null()
	mut var_end := rt.new_null()
	mut var_output := ''
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	if rt.is_true(if !(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('inherit'))).is_null() {
		rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('inherit'))
	} else {
		rt.new_bool(false)
	})
	{
		var_query_to_use = var_wp_query
		var_current_page = rt.call_function('max', [rt.new_int(1),
			rt.new_int((rt.call_function('get_query_var', [rt.new_string('paged'),
				rt.new_int(1)])).to_i64())])
	} else {
		var_page_key = rt.new_string((if rt.get_property(var_block, 'context').array_isset(rt.new_string('queryId')) {
			'query-' +
				(rt.get_property(var_block, 'context').array_get(rt.new_string('queryId'))).str() +
				'-page'
		} else {
			'query-page'
		}).str())
		var_current_page = rt.new_int((if !(rt.get_superglobal('_GET').array_get(var_page_key)).is_null() {
			rt.get_superglobal('_GET').array_get(var_page_key)
		} else {
			rt.new_int(1)
		}).to_i64())
		var_query_to_use = create_wp_query(rt.call_function('build_query_vars_from_query_block', [
			var_block.clone(),
			var_current_page.clone(),
		]))
	}
	var_max_rows = rt.get_property(var_query_to_use, 'found_posts')
	var_posts_per_page = rt.new_int((rt.call_method(var_query_to_use, 'get', [
		rt.new_string('posts_per_page'),
	])).to_i64())
	var_start = if rt.is_true(rt.identical(rt.new_int(0), var_max_rows)) {
		rt.new_int(0)
	} else {
		rt.add(rt.mul(rt.sub(var_current_page, rt.new_int(1)), var_posts_per_page), rt.new_int(1))
	}
	var_end = rt.call_function('min', [
		rt.sub(rt.add(var_start, var_posts_per_page), rt.new_int(1)),
		var_max_rows.clone(),
	])
	var_output = ''
	mut switch_val_1 := var_attributes.array_get(rt.new_string('displayType'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('range-display'))) {
		if rt.is_true(rt.identical(var_start, var_end)) {
			var_output = (rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Displaying %1$s of %2$s')]),
				var_start.clone(),
				var_max_rows.clone(),
			])).str()
		} else {
			var_output = (rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Displaying %1$s – %2$s of %3$s'),
				]),
				var_start.clone(),
				var_end.clone(),
				var_max_rows.clone(),
			])).str()
		}
	} else {
		var_output = (rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%d result found'),
				rt.new_string('%d results found'), var_max_rows.clone()]),
			var_max_rows.clone(),
		])).str()
	}
	return rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.clone(), rt.new_string(var_output.str()).clone()])
}

fn register_block_core_query_total() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/query-total'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_query_total' },
		]),
	])
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_query_total')])
}
