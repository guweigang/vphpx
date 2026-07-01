import rt

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
pub mut:
			settings rt.PhpVal = rt.new_array()
			errors rt.PhpVal = rt.new_array()
			messages rt.PhpVal = rt.new_array()
}

fn Class_WC_Admin_Settings.get_settings_pages() rt.PhpVal {
	if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		mut var_settings := []rt.PhpVal{}
		rt.include_file(@DIR + '/settings/class-wc-settings-page.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-general.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-products.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-tax.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-shipping.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-payment-gateways.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-accounts.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-emails.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-integrations.php', '2')
		if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('launch-your-store'))) {
			var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-site-visibility.php', '2')
		}
		if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('point_of_sale'))) {
			var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-point-of-sale.php', '2')
		}
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-advanced.php', '2')
		// unsupported assign target: Expr_StaticPropertyFetch
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('get_current_screen')])) {
		mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
		if rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'), rt.get_property(var_screen, 'id'))) {
			rt.call_method(var_screen, 'remove_help_tabs', []rt.PhpVal{})
		}
	}
	return rt.new_null()
	}
		rt.call_function('add_action', [rt.new_string('admin_head'), rt.new_closure(closure_1_fn)])
		rt.call_function('add_action', [Class_Automattic_WooCommerce_Internal_Features_FeaturesController.feature_enabled_changed_action(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'reset_settings_pages_on_feature_change' }]), rt.new_int(10), rt.new_int(2)])
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_WC_Admin_Settings.reset_settings_pages_on_feature_change(var_feature_id rt.PhpVal, var_is_enabled rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('point_of_sale'), var_feature_id)) && rt.is_true(var_is_enabled))) {
		// unsupported assign target: Expr_StaticPropertyFetch
		Class_WC_Admin_Settings.get_settings_pages()
	}
}

fn Class_WC_Admin_Settings.save()  {
	mut var_current_tab := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('You do not have permission to save settings.'), rt.new_string('woocommerce')]), rt.new_int(403)])
	}
	rt.call_function('check_admin_referer', [rt.new_string('woocommerce-settings')])
	rt.call_function('do_action', ['woocommerce_settings_save_' + (var_current_tab).str()])
	rt.call_function('do_action', ['woocommerce_update_options_' + (var_current_tab).str()])
	rt.call_function('do_action', [rt.new_string('woocommerce_update_options')])
	Class_WC_Admin_Settings.add_message(rt.call_function('__', [rt.new_string('Your settings have been saved.'), rt.new_string('woocommerce')]))
	Class_WC_Admin_Settings.check_download_folder_protection()
	rt.call_function('update_option', [rt.new_string('woocommerce_queue_flush_rewrite_rules'), rt.new_string('yes')])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'init_query_vars', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'add_endpoints', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_settings_saved')])
}

fn Class_WC_Admin_Settings.add_message(var_text rt.PhpVal)  {
	// unsupported expression: Expr_StaticPropertyFetch.array_push(var_text.dup())
}

fn Class_WC_Admin_Settings.add_error(var_text rt.PhpVal)  {
	// unsupported expression: Expr_StaticPropertyFetch.array_push(var_text.dup())
}

fn Class_WC_Admin_Settings.show_messages()  {
	if // unsupported expression: Expr_StaticPropertyFetch.array_count() > 0 {
		{
			mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_error := item_1.val
				print('<div id="message" class="error inline"><p><strong>' + (rt.call_function('esc_html', [var_error.dup()])).str() + '</strong></p></div>')
			}
		}
	} else if // unsupported expression: Expr_StaticPropertyFetch.array_count() > 0 {
		{
			mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_message := item_1.val
				print('<div id="message" class="updated inline"><p><strong>' + (rt.call_function('esc_html', [var_message.dup()])).str() + '</strong></p></div>')
			}
		}
	}
}

fn Class_WC_Admin_Settings.output()  {
	mut var_current_section := rt.new_null()
	mut var_current_tab := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_suffix := rt.new_string(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('SCRIPT_DEBUG'))) { rt.new_string('') } else { rt.new_string('.min') })
	rt.call_function('do_action', [rt.new_string('woocommerce_settings_start')])
	rt.call_function('wp_enqueue_script', [rt.new_string('woocommerce_settings'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/js/admin/settings' + (var_suffix).str() + '.js', rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{ key: none, val: 'jquery-ui-datepicker' }, rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' }, rt.ArrayItem{ key: none, val: 'iris' }, rt.ArrayItem{ key: none, val: 'selectWoo' }]), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version'), rt.new_bool(true)])
	rt.call_function('wp_localize_script', [rt.new_string('woocommerce_settings'), rt.new_string('woocommerce_settings_params'), rt.create_array([rt.ArrayItem{ key: 'i18n_nav_warning', val: rt.call_function('__', [rt.new_string('The changes you made will be lost if you navigate away from this page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_moved_up', val: rt.call_function('__', [rt.new_string('Item moved up'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_moved_down', val: rt.call_function('__', [rt.new_string('Item moved down'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_no_specific_countries_selected', val: rt.call_function('__', [rt.new_string('Selecting no country / region to sell to prevents from completing the checkout. Continue anyway?'), rt.new_string('woocommerce')]) }])])
	mut var_tabs := rt.call_function('apply_filters', [rt.new_string('woocommerce_settings_tabs_array'), []rt.PhpVal{}])
	rt.include_file(@DIR + '/views/html-admin-settings.php', '1')
}

fn Class_WC_Admin_Settings.get_option(var_option_name rt.PhpVal, default string) rt.PhpVal {
	mut var_option_array := rt.new_null()
	mut var_option_name_mutated := var_option_name
	mut default_mutated := default
	if rt.is_true(rt.new_bool(!(rt.is_true(var_option_name_mutated)))) {
		return rt.new_string(default_mutated)
	}
	if rt.is_true(rt.call_function('strstr', [var_option_name_mutated.dup(), rt.new_string('[')])) {
		rt.call_function('parse_str', [var_option_name_mutated.dup(), var_option_array.dup()])
		var_option_name_mutated = rt.call_function('current', [rt.func_array_keys(var_option_array.dup())])
		mut var_option_values := rt.call_function('get_option', [var_option_name_mutated.dup(), rt.new_string('')])
		mut var_key := rt.call_function('key', [var_option_array.array_get(var_option_name_mutated)])
		if var_option_values.array_isset(var_key) {
			mut var_option_value := var_option_values.array_get(var_key)
		} else {
			var_option_value = rt.new_null()
		}
	} else {
		var_option_value = rt.call_function('get_option', [var_option_name_mutated.dup(), rt.new_null()])
	}
	if rt.is_true(rt.new_bool(var_option_value.dup().is_array())) {
		var_option_value = rt.call_function('wp_unslash', [var_option_value.dup()])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_option_value.dup().is_null()))))) {
		var_option_value = rt.call_function('stripslashes', [var_option_value.dup()])
	}
	return if rt.is_true(rt.identical(rt.new_null(), var_option_value)) { rt.new_string(default_mutated) } else { var_option_value }
}

fn Class_WC_Admin_Settings.output_fields(var_options rt.PhpVal)  {
	{
		mut iter_1 := var_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			if !(var_value.array_isset(rt.new_string('type'))) {
				continue
			}
			if !(var_value.array_isset(rt.new_string('id'))) {
				var_value.array_set('id', '')
			}
			if !(var_value.array_isset(rt.new_string('field_name'))) {
				var_value.array_set('field_name', var_value.array_get('id'))
			}
			if !(var_value.array_isset(rt.new_string('title'))) {
				var_value.array_set('title', if var_value.array_isset(rt.new_string('name')) { var_value.array_get('name') } else { rt.new_string('') })
			}
			if !(var_value.array_isset(rt.new_string('class'))) {
				var_value.array_set('class', '')
			}
			if !(var_value.array_isset(rt.new_string('css'))) {
				var_value.array_set('css', '')
			}
			if !(var_value.array_isset(rt.new_string('default'))) {
				var_value.array_set('default', '')
			}
			if !(var_value.array_isset(rt.new_string('desc'))) {
				var_value.array_set('desc', '')
			}
			if !(var_value.array_isset(rt.new_string('desc_tip'))) {
				var_value.array_set('desc_tip', false)
			}
			if !(var_value.array_isset(rt.new_string('placeholder'))) {
				var_value.array_set('placeholder', '')
			}
			if !(var_value.array_isset(rt.new_string('row_class'))) {
				var_value.array_set('row_class', '')
			}
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_value.array_get('row_class'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_value.array_set('row_class', 'wc-settings-row-' + (var_value.array_get('row_class')).str())
			}
			if !(var_value.array_isset(rt.new_string('suffix'))) {
				var_value.array_set('suffix', '')
			}
			if !(var_value.array_isset(rt.new_string('value'))) {
				var_value.array_set('value', Class_WC_Admin_Settings.get_option((var_value.array_get('id')).str(), var_value.array_get('default')))
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(if !(var_value.array_get('fixed_value')).is_null() { var_value.array_get('fixed_value') } else { rt.new_null() }.is_null()))))) {
				var_value.array_set('value', var_value.array_get('fixed_value'))
			}
			mut var_custom_attributes := []rt.PhpVal{}
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_value.array_get('custom_attributes'))) && rt.is_true(rt.new_bool(var_value.array_get('custom_attributes').is_array())))) {
				{
					mut iter_2 := var_value.array_get('custom_attributes').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_attribute_value := item_2.val
						mut var_attribute := item_2.key
						var_custom_attributes << (rt.call_function('esc_attr', [var_attribute.dup()])).str() + '="' + (rt.call_function('esc_attr', [var_attribute_value.dup()])).str() + '"'
					}
				}
			}
			mut var_field_description := Class_WC_Admin_Settings.get_field_description(var_value.dup())
			mut var_description := var_field_description.array_get('description')
			mut var_tooltip_html := var_field_description.array_get('tooltip_html')
			mut switch_val_1 := var_value.array_get('type')
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('title'))) {
				if !(!rt.is_true(var_value.array_get('title'))) {
					print('<h2>' + (rt.call_function('esc_html', [var_value.array_get('title')])).str() + '</h2>')
				}
				if !(!rt.is_true(var_value.array_get('desc'))) {
					print('<div id="' + (rt.call_function('esc_attr', [rt.call_function('sanitize_title', [var_value.array_get('id')])])).str() + '-description">')
					rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_function('wptexturize', [var_value.array_get('desc')])])]))
					print('</div>')
				}
				print('<table class="form-table">' + '\n\n')
				if !(!rt.is_true(var_value.array_get('id'))) {
					rt.call_function('do_action', ['woocommerce_settings_' + (rt.call_function('sanitize_title', [var_value.array_get('id')])).str()])
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('info'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_value.array_get('row_class')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_value.array_get('title')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [.array_get()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val()
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else if rt.is_true(rt.equal(switch_val_1, )) {
			} else {
			}
		}
	}
}

fn Class_WC_Admin_Settings.get_field_description(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn Class_WC_Admin_Settings.save_fields(var_options rt.PhpVal, var_data rt.PhpVal) bool {
	mut var_option_name_array := rt.new_null()
	mut var_data_mutated := var_data
}

fn Class_WC_Admin_Settings.check_download_folder_protection()  {
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_admin_settings() &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
		settings: rt.new_array()
		errors: rt.new_array()
		messages: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_settings_pages' {
			return Class_WC_Admin_Settings.get_settings_pages()
		}
		'reset_settings_pages_on_feature_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Admin_Settings.reset_settings_pages_on_feature_change(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'save' {
			Class_WC_Admin_Settings.save()
			return rt.new_null()
		}
		'add_message' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Admin_Settings.add_message(dispatch_arg_0)
			return rt.new_null()
		}
		'add_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Admin_Settings.add_error(dispatch_arg_0)
			return rt.new_null()
		}
		'show_messages' {
			Class_WC_Admin_Settings.show_messages()
			return rt.new_null()
		}
		'output' {
			Class_WC_Admin_Settings.output()
			return rt.new_null()
		}
		'get_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_WC_Admin_Settings.get_option(dispatch_arg_0, dispatch_arg_1)
		}
		'output_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Admin_Settings.output_fields(dispatch_arg_0)
			return rt.new_null()
		}
		'get_field_description' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Admin_Settings.get_field_description(dispatch_arg_0)
		}
		'save_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Admin_Settings.save_fields(dispatch_arg_0, dispatch_arg_1))
		}
		'check_download_folder_protection' {
			Class_WC_Admin_Settings.check_download_folder_protection()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'settings' { return this.settings }
		'errors' { return this.errors }
		'messages' { return this.messages }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'settings' { this.settings = val; return true }
		'errors' { this.errors = val; return true }
		'messages' { this.messages = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_settings_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Settings'), rt.new_bool(false)]))))) {
	}
}
