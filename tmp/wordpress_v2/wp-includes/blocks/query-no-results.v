import rt

fn render_block_core_query_no_results(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_wp_query := rt.new_null()
	mut var_page_key := rt.new_null()
	mut var_page := rt.new_null()
	mut var_use_global_query := false
	mut var_query := rt.new_null()
	mut var_query_args := rt.new_null()
	mut var_classes := ''
	mut var_wrapper_attributes := rt.new_null()
	if var_content.clone().to_string().trim_space() == '' {
		return ''
	}
	var_page_key = rt.new_string((if rt.get_property(var_block, 'context').array_isset(rt.new_string('queryId')) {
		'query-' +
			(rt.get_property(var_block, 'context').array_get(rt.new_string('queryId'))).str() +
			'-page'
	} else {
		'query-page'
	}).str())
	var_page = rt.new_int(if !rt.is_true(rt.get_superglobal('_GET').array_get(var_page_key)) {
		1
	} else {
		rt.new_int((rt.get_superglobal('_GET').array_get(var_page_key)).to_i64())
	})
	var_use_global_query =
		rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_isset(rt.new_string('inherit'))
		&& rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('inherit')))
	if var_use_global_query {
		var_query = var_wp_query
	} else {
		var_query_args = rt.call_function('build_query_vars_from_query_block', [
			var_block.clone(),
			var_page.clone(),
		])
		var_query = create_wp_query(var_query_args.clone())
	}
	if rt.is_true(rt.greater(rt.get_property(var_query, 'post_count'), rt.new_int(0))) {
		return ''
	}
	var_classes = if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')) {
		'has-link-color'
	} else {
		''
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes }]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.clone(), var_content.clone()])).str()
}

fn register_block_core_query_no_results() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/query-no-results'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_query_no_results' },
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
		rt.new_string('register_block_core_query_no_results')])
}
