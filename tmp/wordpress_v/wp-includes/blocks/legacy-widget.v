import rt

fn render_block_core_legacy_widget(var_attributes rt.PhpVal) string {
	mut var_wp_widget_factory := rt.new_null()
	// unsupported statement: Stmt_Global
	if var_attributes.array_isset(rt.new_string('id')) {
		mut var_sidebar_id := rt.call_function('wp_find_widgets_sidebar', [var_attributes.array_get('id')])
		return (rt.call_function('wp_render_widget', [var_attributes.array_get('id'), var_sidebar_id.dup()])).str()
	}
	if !(var_attributes.array_isset(rt.new_string('idBase'))) {
		return ''
	}
	mut var_id_base := var_attributes.array_get('idBase')
	mut var_widget_key := rt.call_method(var_wp_widget_factory, 'get_widget_key', [var_id_base.dup()])
	mut var_widget_object := rt.call_method(var_wp_widget_factory, 'get_widget_object', [var_id_base.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_widget_key)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_widget_object)))))) {
		return ''
	}
	if var_attributes.array_get('instance').array_isset(rt.new_string('encoded')) && var_attributes.array_get('instance').array_isset(rt.new_string('hash')) {
		mut var_serialized_instance := rt.call_function('base64_decode', [var_attributes.array_get('instance').array_get('encoded')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [rt.call_function('wp_hash', [var_serialized_instance.dup()]), // unsupported expression: Expr_Cast_String]))))) {
			return ''
		}
		mut var_instance := rt.call_function('unserialize', [var_serialized_instance.dup()])
	} else {
		var_instance = rt.new_array()
	}
	mut var_args := { 'widget_id': rt.get_property(var_widget_object, 'id'), 'widget_name': rt.get_property(var_widget_object, 'name') }
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('the_widget', [var_widget_key.dup(), var_instance.dup(), var_args.dup()])
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn register_block_core_legacy_widget() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/legacy-widget', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_legacy_widget' }])])
}

fn handle_legacy_widget_preview_iframe() {
	if !rt.is_true(rt.get_superglobal('_GET').array_get('legacy-widget-preview')) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))) {
		return rt.new_null()
	}
	rt.call_function('define', [rt.new_string('IFRAME_REQUEST'), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('charset')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_head', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('body_class', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	mut var_registry := fn () rt.PhpVal { mut temp := Class_WP_Block_Type_Registry{}; return temp.get_instance() }()
	mut var_block := rt.call_method(var_registry, 'get_registered', [rt.new_string('core/legacy-widget')])
	rt.echo_val(rt.call_method(var_block, 'render', [rt.get_superglobal('_GET').array_get('legacy-widget-preview')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_footer', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	// unsupported expression: Expr_Exit
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

fn create_wp_block_type_registry() &Class_WP_Block_Type_Registry {
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




pub fn init_wp_includes_blocks_legacy_widget_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_legacy_widget')])
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.new_string('handle_legacy_widget_preview_iframe'), rt.new_int(20)])
}
