import rt

struct Class_WP_Customize_Widgets {
	rt.PhpObjectBase
pub mut:
		manager rt.PhpVal = rt.new_null()
		core_widget_id_bases rt.PhpVal = rt.new_array()
		rendered_sidebars rt.PhpVal = rt.new_array()
		rendered_widgets rt.PhpVal = rt.new_array()
		old_sidebars_widgets rt.PhpVal = rt.new_array()
		selective_refreshable_widgets rt.PhpVal = rt.new_null()
		setting_id_patterns rt.PhpVal = rt.new_array()
		before_widget_tags_seen rt.PhpVal = rt.new_array()
		sidebar_instance_count rt.PhpVal = rt.new_array()
		context_sidebar_instance_number rt.PhpVal = rt.new_null()
		current_dynamic_sidebar_id_stack rt.PhpVal = rt.new_array()
		rendering_widget_id rt.PhpVal = rt.new_null()
		rendering_sidebar_id rt.PhpVal = rt.new_null()
		_captured_options rt.PhpVal = rt.new_array()
		_is_capturing_option_updates bool
}

fn (mut this Class_WP_Customize_Widgets) construct(var_manager rt.PhpVal)  {
	this.manager = var_manager.dup()
	rt.call_function('add_filter', [rt.new_string('customize_dynamic_setting_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_customize_dynamic_setting_args' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('widgets_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_settings' }]), rt.new_int(95)])
	rt.call_function('add_action', [rt.new_string('customize_register'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'schedule_customize_register' }]), rt.new_int(1)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))) {
		return
	}
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'override_sidebars_widgets_for_theme_switch' }])])
	rt.call_function('add_action', [rt.new_string('customize_controls_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'customize_controls_init' }])])
	rt.call_function('add_action', [rt.new_string('customize_controls_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_scripts' }])])
	rt.call_function('add_action', [rt.new_string('customize_controls_print_styles'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_styles' }])])
	rt.call_function('add_action', [rt.new_string('customize_controls_print_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_scripts' }])])
	rt.call_function('add_action', [rt.new_string('customize_controls_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_footer_scripts' }])])
	rt.call_function('add_action', [rt.new_string('customize_controls_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'output_widget_control_templates' }])])
	rt.call_function('add_action', [rt.new_string('customize_preview_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'customize_preview_init' }])])
	rt.call_function('add_filter', [rt.new_string('customize_refresh_nonces'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'refresh_nonces' }])])
	rt.call_function('add_filter', [rt.new_string('should_load_block_editor_scripts_and_styles'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'should_load_block_editor_scripts_and_styles' }])])
	rt.call_function('add_action', [rt.new_string('dynamic_sidebar'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'tally_rendered_widgets' }])])
	rt.call_function('add_filter', [rt.new_string('is_active_sidebar'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'tally_sidebars_via_is_active_sidebar_calls' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('dynamic_sidebar_has_widgets'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'tally_sidebars_via_dynamic_sidebar_calls' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('customize_dynamic_partial_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'customize_dynamic_partial_args' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('customize_preview_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'selective_refresh_init' }])])
}

fn (mut this Class_WP_Customize_Widgets) get_selective_refreshable_widgets() rt.PhpVal {
	mut var_wp_widget_factory := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('customize-selective-refresh-widgets')]))))) {
		return rt.new_array()
	}
	if !(!(this.selective_refreshable_widgets).is_null()) {
		this.selective_refreshable_widgets = rt.new_array()
		{
			mut iter_1 := rt.get_property(var_wp_widget_factory, 'widgets').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_wp_widget := item_1.val
				this.selective_refreshable_widgets.array_set(rt.get_property(var_wp_widget, 'id_base'), !(!rt.is_true(rt.get_property(var_wp_widget, 'widget_options').array_get('customize_selective_refresh'))))
			}
		}
	}
	return this.selective_refreshable_widgets
}

fn (mut this Class_WP_Customize_Widgets) is_widget_selective_refreshable(var_id_base rt.PhpVal) bool {
	mut var_id_base_mutated := var_id_base
	mut var_selective_refreshable_widgets := this.get_selective_refreshable_widgets()
	return !(!rt.is_true(var_selective_refreshable_widgets.array_get(var_id_base_mutated)))
}

fn (mut this Class_WP_Customize_Widgets) get_setting_type(var_setting_id rt.PhpVal) rt.PhpVal {
	mut var_cache := rt.new_null()
	mut var_setting_id_mutated := var_setting_id
	// unsupported statement: Stmt_Static
	if var_cache.array_isset(var_setting_id_mutated) {
		return var_cache.array_get(var_setting_id_mutated)
	}
	{
		mut iter_1 := this.setting_id_patterns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_pattern := item_1.val
			mut var_type := item_1.key
			if rt.is_true(rt.call_function('preg_match', [var_pattern.dup(), var_setting_id_mutated.dup()])) {
				var_cache.array_set(var_setting_id_mutated, var_type.dup())
				return var_type.dup()
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Widgets) register_settings()  {
	mut var_widget_setting_ids := rt.new_array()
	mut var_incoming_setting_ids := rt.func_array_keys(rt.call_method(this.manager, 'unsanitized_post_values', []rt.PhpVal{}))
	{
		mut iter_1 := var_incoming_setting_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_setting_id := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.get_setting_type(var_setting_id.dup()).is_null()))))) {
				var_widget_setting_ids << var_setting_id.dup()
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(this.manager, 'doing_ajax', [rt.new_string('update-widget')])) && rt.get_superglobal('_REQUEST').array_isset(rt.new_string('widget-id')))) {
		var_widget_setting_ids << this.get_setting_id(rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('widget-id')]))
	}
	mut var_settings := rt.call_method(this.manager, 'add_dynamic_settings', [rt.call_function('array_unique', [var_widget_setting_ids.dup()])])
	if rt.is_true(rt.call_method(this.manager, 'settings_previewed', []rt.PhpVal{})) {
		{
			mut iter_1 := var_settings.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_setting := item_1.val
				rt.call_method(var_setting, 'preview', []rt.PhpVal{})
			}
		}
	}
}

fn (mut this Class_WP_Customize_Widgets) filter_customize_dynamic_setting_args(var_args rt.PhpVal, var_setting_id rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_setting_id_mutated := var_setting_id
	if rt.is_true(this.get_setting_type(var_setting_id_mutated.dup())) {
		var_args_mutated = this.get_setting_args(var_setting_id_mutated.dup(), rt.new_null())
	}
	return var_args_mutated.dup()
}

fn (mut this Class_WP_Customize_Widgets) get_post_value(var_name rt.PhpVal, var_default_value rt.PhpVal) rt.PhpVal {
	if !(rt.get_superglobal('_POST').array_isset(var_name)) {
		return var_default_value.dup()
	}
	return rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(var_name)])
}

fn (mut this Class_WP_Customize_Widgets) override_sidebars_widgets_for_theme_switch()  {
	mut var_GLOBALS := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(this.manager, 'doing_ajax', []rt.PhpVal{})) || rt.is_true(rt.call_method(this.manager, 'is_theme_active', []rt.PhpVal{})))) {
		return rt.new_null()
	}
	this.old_sidebars_widgets = rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{})
	rt.call_function('add_filter', [rt.new_string('customize_value_old_sidebars_widgets_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_customize_value_old_sidebars_widgets_data' }])])
	rt.call_method(this.manager, 'set_post_value', [rt.new_string('old_sidebars_widgets_data'), this.old_sidebars_widgets])
	mut var_sidebars_widgets := this.old_sidebars_widgets
	var_sidebars_widgets = rt.call_function('retrieve_widgets', [rt.new_string('customize')])
	rt.call_function('add_filter', [rt.new_string('option_sidebars_widgets'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_option_sidebars_widgets_for_theme_switch' }]), rt.new_int(1)])
	var_GLOBALS.array_unset(rt.new_string('_wp_sidebars_widgets'))
}

fn (mut this Class_WP_Customize_Widgets) filter_customize_value_old_sidebars_widgets_data(var_old_sidebars_widgets rt.PhpVal) rt.PhpVal {
	return this.old_sidebars_widgets
}

fn (mut this Class_WP_Customize_Widgets) filter_option_sidebars_widgets_for_theme_switch(var_sidebars_widgets rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_sidebars_widgets_mutated := var_sidebars_widgets
	var_sidebars_widgets_mutated = var_GLOBALS.array_get('sidebars_widgets')
	var_sidebars_widgets_mutated.array_set('array_version', 3)
	return var_sidebars_widgets_mutated.dup()
}

fn (mut this Class_WP_Customize_Widgets) customize_controls_init()  {
	rt.call_function('do_action', [rt.new_string('load-widgets.php')])
	rt.call_function('do_action', [rt.new_string('widgets.php')])
	rt.call_function('do_action', [rt.new_string('sidebar_admin_setup')])
}

fn (mut this Class_WP_Customize_Widgets) schedule_customize_register()  {
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		this.customize_register()
	} else {
		rt.call_function('add_action', [rt.new_string('wp'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'customize_register' }])])
	}
}

fn (mut this Class_WP_Customize_Widgets) customize_register()  {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_wp_registered_widget_controls := rt.new_null()
	mut var_wp_registered_sidebars := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_use_widgets_block_editor := rt.call_function('wp_use_widgets_block_editor', []rt.PhpVal{})
	rt.call_function('add_filter', [rt.new_string('sidebars_widgets'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'preview_sidebars_widgets' }]), rt.new_int(1)])
	mut var_sidebars_widgets := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'wp_inactive_widgets', val: rt.new_array() }]), rt.call_function('array_fill_keys', [rt.func_array_keys(var_wp_registered_sidebars.dup()), rt.new_array()]), rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{})])
	mut var_new_setting_ids := rt.new_array()
	{
		mut iter_1 := rt.func_array_keys(var_wp_registered_widgets.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_widget_id := item_1.val
			mut var_setting_id := this.get_setting_id(var_widget_id.dup())
			mut var_setting_args := this.get_setting_args(var_setting_id.dup(), rt.new_null())
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.manager, 'get_setting', [var_setting_id.dup()]))))) {
				rt.call_method(this.manager, 'add_setting', [var_setting_id.dup(), var_setting_args.dup()])
			}
			var_new_setting_ids << var_setting_id.dup()
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.manager, 'is_theme_active', []rt.PhpVal{}))))) {
		mut var_setting_id := rt.new_string(rt.new_string('old_sidebars_widgets_data'))
		mut var_setting_args := this.get_setting_args(var_setting_id.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'global_variable' }, rt.ArrayItem{ key: 'dirty', val: true }]))
		rt.call_method(this.manager, 'add_setting', [var_setting_id.dup(), var_setting_args.dup()])
	}
	rt.call_method(this.manager, 'add_panel', [rt.new_string('widgets'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'widgets' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Widgets')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Widgets are independent sections of content that can be placed into widgetized areas provided by your theme (commonly called sidebars).')]) }, rt.ArrayItem{ key: 'priority', val: 110 }, rt.ArrayItem{ key: 'active_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Widgets', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'is_panel_active' }]) }, rt.ArrayItem{ key: 'auto_expand_sole_section', val: true }, rt.ArrayItem{ key: 'theme_supports', val: 'widgets' }])])
	{
		mut iter_1 := var_sidebars_widgets.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_sidebar_widget_ids := item_1.val
			mut var_sidebar_id := item_1.key
			if !rt.is_true(var_sidebar_widget_ids) {
				var_sidebar_widget_ids = rt.new_array()
			}
			mut var_is_registered_sidebar := rt.call_function('is_registered_sidebar', [var_sidebar_id.dup()])
			mut var_is_inactive_widgets := rt.identical(rt.new_string('wp_inactive_widgets'), var_sidebar_id)
			mut var_is_active_sidebar := rt.new_bool(rt.new_bool(rt.is_true(var_is_registered_sidebar) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_inactive_widgets))))))
			if rt.is_true(rt.new_bool(rt.is_true(var_is_registered_sidebar) || rt.is_true(var_is_inactive_widgets))) {
				var_setting_id = rt.call_function('sprintf', [rt.new_string('sidebars_widgets[%s]'), var_sidebar_id.dup()])
				var_setting_args = this.get_setting_args(var_setting_id.dup(), rt.new_null())
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.manager, 'get_setting', [var_setting_id.dup()]))))) {
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.manager, 'is_theme_active', []rt.PhpVal{}))))) {
						var_setting_args.array_set('dirty', true)
					}
					rt.call_method(this.manager, 'add_setting', [var_setting_id.dup(), var_setting_args.dup()])
				}
				var_new_setting_ids << var_setting_id.dup()
				mut var_section_id := rt.call_function('sprintf', [rt.new_string('sidebar-widgets-%s'), var_sidebar_id.dup()])
				if rt.is_true(var_is_active_sidebar) {
					mut var_section_args := rt.create_array([rt.ArrayItem{ key: 'title', val: var_wp_registered_sidebars.array_get(var_sidebar_id).array_get('name') }, rt.ArrayItem{ key: 'priority', val: rt.call_function('array_search', [var_sidebar_id.dup(), rt.func_array_keys(var_wp_registered_sidebars.dup()), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'panel', val: 'widgets' }, rt.ArrayItem{ key: 'sidebar_id', val: var_sidebar_id }])
					if rt.is_true(var_use_widgets_block_editor) {
						var_section_args.array_set('description', '')
					} else {
						var_section_args.array_set('description', var_wp_registered_sidebars.array_get(var_sidebar_id).array_get('description'))
					}
					var_section_args = rt.call_function('apply_filters', [rt.new_string('customizer_widgets_section_args'), var_section_args.dup(), var_section_id.dup(), var_sidebar_id.dup()])
					mut var_section := create_wp_customize_sidebar_section(this.manager, var_section_id.dup(), var_section_args.dup())
					rt.call_method(this.manager, 'add_section', [var_section])
					if rt.is_true(var_use_widgets_block_editor) {
						mut var_control := 
					} else {
						
					}
					
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true()))) {
				{
					mut iter_2 := .iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_widget_id := item_2.val
						mut var_i := item_2.key
					}
				}
			}
		}
	}
	if rt.is_true() {
	}
}

fn (mut this Class_WP_Customize_Widgets) is_panel_active() bool {
	mut var_wp_registered_sidebars := rt.new_null()
	// unsupported statement: Stmt_Global
}

fn (mut this Class_WP_Customize_Widgets) get_setting_id(var_widget_id rt.PhpVal) rt.PhpVal {
	mut var_widget_id_mutated := var_widget_id
}

fn (mut this Class_WP_Customize_Widgets) is_wide_widget(var_widget_id rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_widget_controls := rt.new_null()
	mut var_widget_id_mutated := var_widget_id
}

fn (mut this Class_WP_Customize_Widgets) parse_widget_id(var_widget_id rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_widget_id_mutated := var_widget_id
}

fn (mut this Class_WP_Customize_Widgets) parse_widget_setting_id(var_setting_id rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_setting_id_mutated := var_setting_id
}

fn (mut this Class_WP_Customize_Widgets) print_styles()  {
}

fn (mut this Class_WP_Customize_Widgets) print_scripts()  {
}

fn (mut this Class_WP_Customize_Widgets) enqueue_scripts()  {
	mut var_wp_scripts := rt.new_null()
	mut var_wp_registered_sidebars := rt.new_null()
	mut var_wp_registered_widgets := rt.new_null()
}

fn (mut this Class_WP_Customize_Widgets) output_widget_control_templates()  {
}

fn (mut this Class_WP_Customize_Widgets) print_footer_scripts()  {
}

fn (mut this Class_WP_Customize_Widgets) get_setting_args(var_id rt.PhpVal, var_overrides rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
}

fn (mut this Class_WP_Customize_Widgets) sanitize_sidebar_widgets(var_widget_ids rt.PhpVal) rt.PhpVal {
	mut var_widget_ids_mutated := var_widget_ids
}

fn (mut this Class_WP_Customize_Widgets) get_available_widgets() rt.PhpVal {
	mut var_available_widgets := []rt.PhpVal{}
	mut var_wp_registered_widgets := rt.new_null()
	mut var_wp_registered_widget_controls := rt.new_null()
}

fn (mut this Class_WP_Customize_Widgets) _sort_name_callback(var_widget_a rt.PhpVal, var_widget_b rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Customize_Widgets) get_widget_control(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Customize_Widgets) get_widget_control_parts(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Customize_Widgets) customize_preview_init()  {
}

fn (mut this Class_WP_Customize_Widgets) refresh_nonces(var_nonces rt.PhpVal) rt.PhpVal {
	mut var_nonces_mutated := var_nonces
}

fn (mut this Class_WP_Customize_Widgets) should_load_block_editor_scripts_and_styles(var_is_block_editor_screen rt.PhpVal) bool {
}

fn (mut this Class_WP_Customize_Widgets) preview_sidebars_widgets(var_sidebars_widgets rt.PhpVal) rt.PhpVal {
	mut var_sidebars_widgets_mutated := var_sidebars_widgets
}

fn (mut this Class_WP_Customize_Widgets) customize_preview_enqueue()  {
}

fn (mut this Class_WP_Customize_Widgets) print_preview_css()  {
}

fn (mut this Class_WP_Customize_Widgets) export_preview_data()  {
	mut var_wp_registered_sidebars := rt.new_null()
	mut var_wp_registered_widgets := rt.new_null()
}

fn (mut this Class_WP_Customize_Widgets) tally_rendered_widgets(var_widget rt.PhpVal)  {
}

fn (mut this Class_WP_Customize_Widgets) is_widget_rendered(var_widget_id rt.PhpVal) bool {
	mut var_widget_id_mutated := var_widget_id
}

fn (mut this Class_WP_Customize_Widgets) is_sidebar_rendered(var_sidebar_id rt.PhpVal) bool {
}

fn (mut this Class_WP_Customize_Widgets) tally_sidebars_via_is_active_sidebar_calls(var_is_active rt.PhpVal, var_sidebar_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Customize_Widgets) tally_sidebars_via_dynamic_sidebar_calls(var_has_widgets rt.PhpVal, var_sidebar_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Customize_Widgets) get_instance_hash_key(var_serialized_instance rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Customize_Widgets) sanitize_widget_instance(var_value rt.PhpVal, var_id_base rt.PhpVal) rt.PhpVal {
	mut var_wp_widget_factory := rt.new_null()
	mut var_value_mutated := var_value
	mut var_id_base_mutated := var_id_base
}

fn (mut this Class_WP_Customize_Widgets) sanitize_widget_js_instance(var_value rt.PhpVal, var_id_base rt.PhpVal) rt.PhpVal {
	mut var_wp_widget_factory := rt.new_null()
	mut var_value_mutated := var_value
	mut var_id_base_mutated := var_id_base
}

fn (mut this Class_WP_Customize_Widgets) sanitize_sidebar_widgets_js_instance(var_widget_ids rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_widget_ids_mutated := var_widget_ids
}

fn (mut this Class_WP_Customize_Widgets) call_widget_update(var_widget_id rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_widget_updates := rt.new_null()
	mut var_wp_registered_widget_controls := rt.new_null()
	mut var_widget_id_mutated := var_widget_id
}

fn (mut this Class_WP_Customize_Widgets) wp_ajax_update_widget()  {
}

fn (mut this Class_WP_Customize_Widgets) customize_dynamic_partial_args(var_partial_args rt.PhpVal, var_partial_id rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_partial_args_mutated := var_partial_args
}

fn (mut this Class_WP_Customize_Widgets) selective_refresh_init()  {
}

fn (mut this Class_WP_Customize_Widgets) filter_dynamic_sidebar_params(var_params rt.PhpVal) rt.PhpVal {
	mut var_params_mutated := var_params
}

fn (mut this Class_WP_Customize_Widgets) filter_wp_kses_allowed_data_attributes(var_allowed_html rt.PhpVal) rt.PhpVal {
	mut var_allowed_html_mutated := var_allowed_html
}

fn (mut this Class_WP_Customize_Widgets) start_dynamic_sidebar(var_index rt.PhpVal)  {
}

fn (mut this Class_WP_Customize_Widgets) end_dynamic_sidebar(var_index rt.PhpVal)  {
}

fn (mut this Class_WP_Customize_Widgets) filter_sidebars_widgets_for_rendering_widget(var_sidebars_widgets rt.PhpVal) rt.PhpVal {
	mut var_sidebars_widgets_mutated := var_sidebars_widgets
}

fn (mut this Class_WP_Customize_Widgets) render_widget_partial(var_partial rt.PhpVal, var_context rt.PhpVal) bool {
	mut var_context_mutated := var_context
}

fn (mut this Class_WP_Customize_Widgets) is_option_capture_ignored(var_option_name rt.PhpVal) rt.PhpVal {
	mut var_option_name_mutated := var_option_name
}

fn (mut this Class_WP_Customize_Widgets) get_captured_options() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Widgets) get_captured_option(var_option_name rt.PhpVal, default_value bool) rt.PhpVal {
	mut var_option_name_mutated := var_option_name
}

fn (mut this Class_WP_Customize_Widgets) count_captured_options() i64 {
}

fn (mut this Class_WP_Customize_Widgets) start_capturing_option_updates()  {
}

fn (mut this Class_WP_Customize_Widgets) capture_filter_pre_update_option(var_new_value rt.PhpVal, var_option_name rt.PhpVal, var_old_value rt.PhpVal) rt.PhpVal {
	mut var_option_name_mutated := var_option_name
}

fn (mut this Class_WP_Customize_Widgets) capture_filter_pre_get_option(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_Customize_Widgets) stop_capturing_option_updates()  {
}

fn (mut this Class_WP_Customize_Widgets) setup_widget_addition_previews()  {
}

fn (mut this Class_WP_Customize_Widgets) prepreview_added_sidebars_widgets()  {
}

fn (mut this Class_WP_Customize_Widgets) prepreview_added_widget_instance()  {
}

fn (mut this Class_WP_Customize_Widgets) remove_prepreview_filters()  {
}

struct Class_WP_Customize_Sidebar_Section {
	rt.PhpObjectBase
}

fn create_wp_customize_widgets(arg_0 rt.PhpVal) &Class_WP_Customize_Widgets {
	mut obj := &Class_WP_Customize_Widgets{
		PhpObjectBase: rt.PhpObjectBase{}
		manager: rt.new_null()
		core_widget_id_bases: rt.new_array()
		rendered_sidebars: rt.new_array()
		rendered_widgets: rt.new_array()
		old_sidebars_widgets: rt.new_array()
		selective_refreshable_widgets: rt.new_null()
		setting_id_patterns: rt.new_array()
		before_widget_tags_seen: rt.new_array()
		sidebar_instance_count: rt.new_array()
		context_sidebar_instance_number: rt.new_null()
		current_dynamic_sidebar_id_stack: rt.new_array()
		rendering_widget_id: rt.new_null()
		rendering_sidebar_id: rt.new_null()
		_captured_options: rt.new_array()
		_is_capturing_option_updates: false
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_customize_sidebar_section() &Class_WP_Customize_Sidebar_Section {
	mut obj := &Class_WP_Customize_Sidebar_Section{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Widgets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_selective_refreshable_widgets' {
			return this.get_selective_refreshable_widgets()
		}
		'is_widget_selective_refreshable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_widget_selective_refreshable(dispatch_arg_0))
		}
		'get_setting_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_setting_type(dispatch_arg_0)
		}
		'register_settings' {
			this.register_settings()
			return rt.new_null()
		}
		'filter_customize_dynamic_setting_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_customize_dynamic_setting_args(dispatch_arg_0, dispatch_arg_1)
		}
		'get_post_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_post_value(dispatch_arg_0, dispatch_arg_1)
		}
		'override_sidebars_widgets_for_theme_switch' {
			this.override_sidebars_widgets_for_theme_switch()
			return rt.new_null()
		}
		'filter_customize_value_old_sidebars_widgets_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_customize_value_old_sidebars_widgets_data(dispatch_arg_0)
		}
		'filter_option_sidebars_widgets_for_theme_switch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_option_sidebars_widgets_for_theme_switch(dispatch_arg_0)
		}
		'customize_controls_init' {
			this.customize_controls_init()
			return rt.new_null()
		}
		'schedule_customize_register' {
			this.schedule_customize_register()
			return rt.new_null()
		}
		'customize_register' {
			this.customize_register()
			return rt.new_null()
		}
		'is_panel_active' {
			return rt.new_bool(this.is_panel_active())
		}
		'get_setting_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_setting_id(dispatch_arg_0)
		}
		'is_wide_widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_wide_widget(dispatch_arg_0)
		}
		'parse_widget_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_widget_id(dispatch_arg_0)
		}
		'parse_widget_setting_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_widget_setting_id(dispatch_arg_0)
		}
		'print_styles' {
			this.print_styles()
			return rt.new_null()
		}
		'print_scripts' {
			this.print_scripts()
			return rt.new_null()
		}
		'enqueue_scripts' {
			this.enqueue_scripts()
			return rt.new_null()
		}
		'output_widget_control_templates' {
			this.output_widget_control_templates()
			return rt.new_null()
		}
		'print_footer_scripts' {
			this.print_footer_scripts()
			return rt.new_null()
		}
		'get_setting_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_setting_args(dispatch_arg_0, dispatch_arg_1)
		}
		'sanitize_sidebar_widgets' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_sidebar_widgets(dispatch_arg_0)
		}
		'get_available_widgets' {
			return this.get_available_widgets()
		}
		'_sort_name_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._sort_name_callback(dispatch_arg_0, dispatch_arg_1)
		}
		'get_widget_control' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_widget_control(dispatch_arg_0)
		}
		'get_widget_control_parts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_widget_control_parts(dispatch_arg_0)
		}
		'customize_preview_init' {
			this.customize_preview_init()
			return rt.new_null()
		}
		'refresh_nonces' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.refresh_nonces(dispatch_arg_0)
		}
		'should_load_block_editor_scripts_and_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.should_load_block_editor_scripts_and_styles(dispatch_arg_0))
		}
		'preview_sidebars_widgets' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.preview_sidebars_widgets(dispatch_arg_0)
		}
		'customize_preview_enqueue' {
			this.customize_preview_enqueue()
			return rt.new_null()
		}
		'print_preview_css' {
			this.print_preview_css()
			return rt.new_null()
		}
		'export_preview_data' {
			this.export_preview_data()
			return rt.new_null()
		}
		'tally_rendered_widgets' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.tally_rendered_widgets(dispatch_arg_0)
			return rt.new_null()
		}
		'is_widget_rendered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_widget_rendered(dispatch_arg_0))
		}
		'is_sidebar_rendered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_sidebar_rendered(dispatch_arg_0))
		}
		'tally_sidebars_via_is_active_sidebar_calls' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.tally_sidebars_via_is_active_sidebar_calls(dispatch_arg_0, dispatch_arg_1)
		}
		'tally_sidebars_via_dynamic_sidebar_calls' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.tally_sidebars_via_dynamic_sidebar_calls(dispatch_arg_0, dispatch_arg_1)
		}
		'get_instance_hash_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_instance_hash_key(dispatch_arg_0)
		}
		'sanitize_widget_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.sanitize_widget_instance(dispatch_arg_0, dispatch_arg_1)
		}
		'sanitize_widget_js_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.sanitize_widget_js_instance(dispatch_arg_0, dispatch_arg_1)
		}
		'sanitize_sidebar_widgets_js_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_sidebar_widgets_js_instance(dispatch_arg_0)
		}
		'call_widget_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.call_widget_update(dispatch_arg_0)
		}
		'wp_ajax_update_widget' {
			this.wp_ajax_update_widget()
			return rt.new_null()
		}
		'customize_dynamic_partial_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.customize_dynamic_partial_args(dispatch_arg_0, dispatch_arg_1)
		}
		'selective_refresh_init' {
			this.selective_refresh_init()
			return rt.new_null()
		}
		'filter_dynamic_sidebar_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_dynamic_sidebar_params(dispatch_arg_0)
		}
		'filter_wp_kses_allowed_data_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_wp_kses_allowed_data_attributes(dispatch_arg_0)
		}
		'start_dynamic_sidebar' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.start_dynamic_sidebar(dispatch_arg_0)
			return rt.new_null()
		}
		'end_dynamic_sidebar' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.end_dynamic_sidebar(dispatch_arg_0)
			return rt.new_null()
		}
		'filter_sidebars_widgets_for_rendering_widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_sidebars_widgets_for_rendering_widget(dispatch_arg_0)
		}
		'render_widget_partial' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.render_widget_partial(dispatch_arg_0, dispatch_arg_1))
		}
		'is_option_capture_ignored' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_option_capture_ignored(dispatch_arg_0)
		}
		'get_captured_options' {
			return this.get_captured_options()
		}
		'get_captured_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_captured_option(dispatch_arg_0, dispatch_arg_1)
		}
		'count_captured_options' {
			return rt.new_int(this.count_captured_options())
		}
		'start_capturing_option_updates' {
			this.start_capturing_option_updates()
			return rt.new_null()
		}
		'capture_filter_pre_update_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.capture_filter_pre_update_option(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'capture_filter_pre_get_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.capture_filter_pre_get_option(dispatch_arg_0)
		}
		'stop_capturing_option_updates' {
			this.stop_capturing_option_updates()
			return rt.new_null()
		}
		'setup_widget_addition_previews' {
			this.setup_widget_addition_previews()
			return rt.new_null()
		}
		'prepreview_added_sidebars_widgets' {
			this.prepreview_added_sidebars_widgets()
			return rt.new_null()
		}
		'prepreview_added_widget_instance' {
			this.prepreview_added_widget_instance()
			return rt.new_null()
		}
		'remove_prepreview_filters' {
			this.remove_prepreview_filters()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Customize_Widgets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'manager' { return this.manager }
		'core_widget_id_bases' { return this.core_widget_id_bases }
		'rendered_sidebars' { return this.rendered_sidebars }
		'rendered_widgets' { return this.rendered_widgets }
		'old_sidebars_widgets' { return this.old_sidebars_widgets }
		'selective_refreshable_widgets' { return this.selective_refreshable_widgets }
		'setting_id_patterns' { return this.setting_id_patterns }
		'before_widget_tags_seen' { return this.before_widget_tags_seen }
		'sidebar_instance_count' { return this.sidebar_instance_count }
		'context_sidebar_instance_number' { return this.context_sidebar_instance_number }
		'current_dynamic_sidebar_id_stack' { return this.current_dynamic_sidebar_id_stack }
		'rendering_widget_id' { return this.rendering_widget_id }
		'rendering_sidebar_id' { return this.rendering_sidebar_id }
		'_captured_options' { return this._captured_options }
		'_is_capturing_option_updates' { return rt.new_bool(this._is_capturing_option_updates) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Widgets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'manager' { this.manager = val; return true }
		'core_widget_id_bases' { this.core_widget_id_bases = val; return true }
		'rendered_sidebars' { this.rendered_sidebars = val; return true }
		'rendered_widgets' { this.rendered_widgets = val; return true }
		'old_sidebars_widgets' { this.old_sidebars_widgets = val; return true }
		'selective_refreshable_widgets' { this.selective_refreshable_widgets = val; return true }
		'setting_id_patterns' { this.setting_id_patterns = val; return true }
		'before_widget_tags_seen' { this.before_widget_tags_seen = val; return true }
		'sidebar_instance_count' { this.sidebar_instance_count = val; return true }
		'context_sidebar_instance_number' { this.context_sidebar_instance_number = val; return true }
		'current_dynamic_sidebar_id_stack' { this.current_dynamic_sidebar_id_stack = val; return true }
		'rendering_widget_id' { this.rendering_widget_id = val; return true }
		'rendering_sidebar_id' { this.rendering_sidebar_id = val; return true }
		'_captured_options' { this._captured_options = val; return true }
		'_is_capturing_option_updates' { this._is_capturing_option_updates = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Customize_Sidebar_Section) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Sidebar_Section) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Sidebar_Section) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_customize_widgets_php() {
}
