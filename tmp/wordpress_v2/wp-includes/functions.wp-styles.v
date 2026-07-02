import rt

fn wp_styles() rt.PhpVal {
	mut var_wp_styles := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wp_styles, 'WP_Styles')))))) {
		var_wp_styles = create_wp_styles()
	}
	return var_wp_styles.clone()
}

fn wp_print_styles(handles bool) rt.PhpVal {
	mut var_handles := handles
	mut var_wp_styles := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_bool(var_handles))) {
		var_handles = false
	}
	if !var_handles {
		rt.call_function('do_action', [rt.new_string('wp_print_styles')])
	}
	rt.call_function('_wp_scripts_maybe_doing_it_wrong', [rt.new_string(@FN)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wp_styles, 'WP_Styles')))))) {
		if !var_handles {
			return rt.new_array()
		}
	}
	return rt.call_method(wp_styles(), 'do_items', [rt.new_bool(var_handles)])
}

fn wp_add_inline_style(var_handle rt.PhpVal, var_data_arg rt.PhpVal) rt.PhpVal {
	mut var_data := var_data_arg
	rt.call_function('_wp_scripts_maybe_doing_it_wrong', [rt.new_string(@FN),
		var_handle.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [
		rt.new_string(var_data.str()).clone(),
		rt.new_string('</style>'),
	])))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Do not pass %1$s tags to %2$s.')]),
				rt.new_string('<code>&lt;style&gt;</code>'),
				rt.new_string('<code>wp_add_inline_style()</code>'),
			]),
			rt.new_string('3.7.0')])
		var_data = (rt.call_function('preg_replace', [
			rt.new_string('#<style[^>]*>(.*)</style>#is'),
			rt.new_string('$1'),
			rt.new_string(var_data.str()).clone(),
		])).str().trim_space()
	}
	return rt.call_method(wp_styles(), 'add_inline_style', [var_handle.clone(),
		rt.new_string(var_data.str()).clone()])
}

fn wp_register_style(var_handle rt.PhpVal, var_src rt.PhpVal, var_deps rt.PhpVal, ver bool, media string) rt.PhpVal {
	mut var_ver := ver
	mut var_media := media
	rt.call_function('_wp_scripts_maybe_doing_it_wrong', [rt.new_string(@FN),
		var_handle.clone()])
	return rt.call_method(wp_styles(), 'add', [var_handle.clone(),
		var_src.clone(), var_deps.clone(), rt.new_bool(ver), rt.new_string(media)])
}

fn wp_deregister_style(var_handle rt.PhpVal) {
	rt.call_function('_wp_scripts_maybe_doing_it_wrong', [rt.new_string(@FN),
		var_handle.clone()])
	rt.call_method(wp_styles(), 'remove', [var_handle.clone()])
}

fn wp_enqueue_style(var_handle rt.PhpVal, src string, var_deps rt.PhpVal, ver bool, media string) {
	mut var_src := src
	mut var_ver := ver
	mut var_media := media
	mut var_wp_styles := rt.new_null()
	mut var__handle := rt.new_null()
	rt.call_function('_wp_scripts_maybe_doing_it_wrong', [rt.new_string(@FN),
		var_handle.clone()])
	var_wp_styles = wp_styles()
	if var_src.len > 0 && var_src != '0' {
		var__handle = rt.call_function('explode', [rt.new_string('?'),
			var_handle.clone()])
		rt.call_method(var_wp_styles, 'add', [var__handle.array_get(rt.new_int(0)),
			rt.new_string(src), var_deps.clone(), rt.new_bool(ver),
			rt.new_string(media)])
	}
	rt.call_method(var_wp_styles, 'enqueue', [var_handle.clone()])
}

fn wp_dequeue_style(var_handle rt.PhpVal) {
	rt.call_function('_wp_scripts_maybe_doing_it_wrong', [rt.new_string(@FN),
		var_handle.clone()])
	rt.call_method(wp_styles(), 'dequeue', [var_handle.clone()])
}

fn wp_style_is(var_handle rt.PhpVal, status string) bool {
	mut var_status := status
	rt.call_function('_wp_scripts_maybe_doing_it_wrong', [rt.new_string(@FN),
		var_handle.clone()])
	return (rt.call_method(wp_styles(), 'query', [var_handle.clone(),
		rt.new_string(status)])).to_bool()
}

fn wp_style_add_data(var_handle rt.PhpVal, var_key rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	return rt.call_method(wp_styles(), 'add_data', [var_handle.clone(),
		var_key.clone(), var_value.clone()])
}

struct Class_WP_Styles {
	rt.PhpObjectBase
}

fn create_wp_styles(_args ...rt.PhpVal) &Class_WP_Styles {
	mut obj := &Class_WP_Styles{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Styles) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Styles) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Styles) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
