import rt

fn wp_interactivity() rt.PhpVal {
	// unsupported statement: Stmt_Global
	if !(true) {
		mut var_wp_interactivity := create_wp_interactivity_api()
	}
	return mut var_wp_interactivity
}

fn wp_interactivity_process_directives(html string) string {
	return (rt.call_method(wp_interactivity(), 'process_directives', [
		rt.new_string(html),
	])).str()
}

fn wp_interactivity_state(var_store_namespace rt.PhpVal, var_state rt.PhpVal) rt.PhpVal {
	return rt.call_method(wp_interactivity(), 'state', [var_store_namespace.dup(),
		var_state.dup()])
}

fn wp_interactivity_config(store_namespace string, var_config rt.PhpVal) rt.PhpVal {
	return rt.call_method(wp_interactivity(), 'config', [rt.new_string(store_namespace),
		var_config.dup()])
}

fn wp_interactivity_data_wp_context(var_context rt.PhpVal, store_namespace string) string {
	return "data-wp-context='" + if var_store_namespace.len > 0 && var_store_namespace != '0' {
		store_namespace + '::'
	} else {
		''
	} + (if !rt.is_true(var_context) {
		rt.new_string('{}')
	} else {
		rt.call_function('wp_json_encode', [var_context.dup(), rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')), rt.get_constant('JSON_HEX_AMP'))])
	}).str() + "'"
}

fn wp_interactivity_get_context(var_store_namespace rt.PhpVal) rt.PhpVal {
	return rt.call_method(wp_interactivity(), 'get_context', [
		var_store_namespace.dup()])
}

fn wp_interactivity_get_element() rt.PhpVal {
	return rt.call_method(wp_interactivity(), 'get_element', []rt.PhpVal{})
}

struct Class_WP_Interactivity_API {
	rt.PhpObjectBase
}

fn create_wp_interactivity_api() &Class_WP_Interactivity_API {
	mut obj := &Class_WP_Interactivity_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Interactivity_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Interactivity_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Interactivity_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_interactivity_api_interactivity_api_php() {
}
