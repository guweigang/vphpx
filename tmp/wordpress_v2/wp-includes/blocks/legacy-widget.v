import rt

fn render_block_core_legacy_widget(var_attributes rt.PhpVal) string {
	mut var_wp_widget_factory := rt.new_null()
	mut var_sidebar_id := rt.new_null()
	mut var_id_base := rt.new_null()
	mut var_widget_key := rt.new_null()
	mut var_widget_object := rt.new_null()
	mut var_serialized_instance := rt.new_null()
	mut var_instance := rt.new_null()
	mut var_args := map[string]rt.PhpVal{}
	if var_attributes.array_isset(rt.new_string('id')) {
		var_sidebar_id = rt.call_function('wp_find_widgets_sidebar', [
			var_attributes.array_get(rt.new_string('id')),
		])
		return (rt.call_function('wp_render_widget', [var_attributes.array_get(rt.new_string('id')),
			var_sidebar_id.clone()])).str()
	}
	if !(var_attributes.array_isset(rt.new_string('idBase'))) {
		return ''
	}
	var_id_base = var_attributes.array_get(rt.new_string('idBase'))
	var_widget_key = rt.call_method(var_wp_widget_factory, 'get_widget_key', [
		var_id_base.clone()])
	var_widget_object = rt.call_method(var_wp_widget_factory, 'get_widget_object', [
		var_id_base.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_widget_key))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_widget_object)))) {
		return ''
	}
	if var_attributes.array_get(rt.new_string('instance')).array_isset(rt.new_string('encoded'))
		&& var_attributes.array_get(rt.new_string('instance')).array_isset(rt.new_string('hash')) {
		var_serialized_instance = rt.call_function('base64_decode', [
			var_attributes.array_get(rt.new_string('instance')).array_get(rt.new_string('encoded')),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [
			rt.call_function('wp_hash', [var_serialized_instance.clone()]),
			rt.new_string((var_attributes.array_get(rt.new_string('instance')).array_get(rt.new_string('hash'))).str()),
		])))))
		{
			return ''
		}
		var_instance = rt.call_function('unserialize', [var_serialized_instance.clone()])
	} else {
		var_instance = rt.new_array()
	}
	var_args = {
		'widget_id':   rt.get_property(var_widget_object, 'id')
		'widget_name': rt.get_property(var_widget_object, 'name')
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('the_widget', [var_widget_key.clone(), var_instance.clone(),
		rt.create_array_from_native_map(var_args)])
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn register_block_core_legacy_widget() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/legacy-widget'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_legacy_widget' },
		]),
	])
}

fn handle_legacy_widget_preview_iframe() {
	mut var_registry := rt.new_null()
	mut var_block := rt.new_null()
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('legacy-widget-preview'))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		return
	}
	rt.call_function('define', [rt.new_string('IFRAME_REQUEST'),
		rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('charset')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_head', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('body_class', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_0 := Class_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_registry = iife_result_0
	var_block = rt.call_method(var_registry, 'get_registered', [
		rt.new_string('core/legacy-widget'),
	])
	rt.echo_val(rt.call_method(var_block, 'render', [
		rt.get_superglobal('_GET').array_get(rt.new_string('legacy-widget-preview')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_footer', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	exit(0)
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_legacy_widget')])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.new_string('handle_legacy_widget_preview_iframe'),
		rt.new_int(20)])
}
