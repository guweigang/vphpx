import rt

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

fn init_static_wc_admin_settings() {
	rt.init_static_prop('WC_Admin_Settings', 'settings', rt.new_array())
	rt.init_static_prop('WC_Admin_Settings', 'errors', rt.new_array())
	rt.init_static_prop('WC_Admin_Settings', 'messages', rt.new_array())
}

fn Class_WC_Admin_Settings.get_settings_pages() rt.PhpVal {
	if !rt.is_true(rt.get_static_prop('WC_Admin_Settings', 'settings')) {
		mut var_settings := rt.new_array()
		rt.include_file(@DIR + '/settings/class-wc-settings-page.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-general.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-products.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-tax.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-shipping.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-payment-gateways.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-accounts.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-emails.php', '2')
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-integrations.php', '2')
		mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
		mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('launch-your-store'))
		if rt.is_true(iife_result_0) {
			var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-site-visibility.php', '2')
		}
		mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
		mut iife_result_1 := iife_temp_1.feature_is_enabled(rt.new_string('point_of_sale'))
		if rt.is_true(iife_result_1) {
			var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-point-of-sale.php', '2')
		}
		var_settings << rt.include_file(@DIR + '/settings/class-wc-settings-advanced.php', '2')
		rt.set_static_prop('WC_Admin_Settings', 'settings', rt.call_function('apply_filters', [
			rt.new_string('woocommerce_get_settings_pages'),
			rt.create_array_from_list(var_settings),
		]))
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			if rt.is_true(rt.call_function('function_exists', [
				rt.new_string('get_current_screen'),
			]))
			{
				mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
				if rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'), rt.get_property(var_screen,
					'id')))
				{
					rt.call_method(var_screen, 'remove_help_tabs', []rt.PhpVal{})
				}
			}
			return rt.new_null()
		}
		rt.call_function('add_action', [rt.new_string('admin_head'),
			rt.new_closure(closure_3_fn)])
		rt.call_function('add_action', [
			Class_Automattic_WooCommerce_Internal_Features_FeaturesController.feature_enabled_changed_action(),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'reset_settings_pages_on_feature_change' }]),
			rt.new_int(10),
			rt.new_int(2),
		])
	}
	return rt.get_static_prop('WC_Admin_Settings', 'settings')
}

fn Class_WC_Admin_Settings.reset_settings_pages_on_feature_change(var_feature_id rt.PhpVal, var_is_enabled rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_string('point_of_sale'), var_feature_id))
		&& rt.is_true(var_is_enabled) {
		rt.set_static_prop('WC_Admin_Settings', 'settings', rt.new_array())
		Class_WC_Admin_Settings.get_settings_pages()
	}
}

fn Class_WC_Admin_Settings.save() {
	mut var_current_tab := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_woocommerce'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string('You do not have permission to save settings.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_int(403),
		])
	}
	rt.call_function('check_admin_referer', [rt.new_string('woocommerce-settings')])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_settings_save_' + var_current_tab.str()),
	])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_update_options_' + var_current_tab.str()),
	])
	rt.call_function('do_action', [rt.new_string('woocommerce_update_options')])
	Class_WC_Admin_Settings.add_message(rt.call_function('__', [
		rt.new_string('Your settings have been saved.'),
		rt.new_string('woocommerce'),
	]))
	Class_WC_Admin_Settings.check_download_folder_protection()
	rt.call_function('update_option', [
		rt.new_string('woocommerce_queue_flush_rewrite_rules'),
		rt.new_string('yes'),
	])
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'),
		'init_query_vars', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'),
		'add_endpoints', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_settings_saved')])
}

fn Class_WC_Admin_Settings.add_message(var_text rt.PhpVal) {
	rt.get_static_prop('WC_Admin_Settings', 'messages').array_push(var_text.clone())
}

fn Class_WC_Admin_Settings.add_error(var_text rt.PhpVal) {
	rt.get_static_prop('WC_Admin_Settings', 'errors').array_push(var_text.clone())
}

fn Class_WC_Admin_Settings.show_messages() {
	if rt.get_static_prop('WC_Admin_Settings', 'errors').array_count() > 0 {
		mut iter_1 := rt.get_static_prop('WC_Admin_Settings', 'errors').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_error := item_1.val
			print('<div id="message" class="error inline"><p><strong>' +
				(rt.call_function('esc_html', [var_error.clone()])).str() + '</strong></p></div>')
		}
	} else if rt.get_static_prop('WC_Admin_Settings', 'messages').array_count() > 0 {
		mut iter_2 := rt.get_static_prop('WC_Admin_Settings', 'messages').iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_message := item_2.val
			print('<div id="message" class="updated inline"><p><strong>' +
				(rt.call_function('esc_html', [var_message.clone()])).str() + '</strong></p></div>')
		}
	}
}

fn Class_WC_Admin_Settings.output() {
	mut var_current_section := rt.new_null()
	mut var_current_tab := rt.new_null()
	mut iife_temp_3 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_3 := iife_temp_3.is_true(rt.new_string('SCRIPT_DEBUG'))
	mut var_suffix := rt.new_string((if rt.is_true(iife_result_3) { '' } else { '.min' }).str())
	rt.call_function('do_action', [rt.new_string('woocommerce_settings_start')])
	rt.call_function('wp_enqueue_script', [rt.new_string('woocommerce_settings'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/js/admin/settings' + var_suffix.str() + '.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{
				key: none
				val: 'jquery-ui-datepicker'
			}, rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' },
			rt.ArrayItem{ key: none, val: 'iris' }, rt.ArrayItem{ key: none, val: 'selectWoo' }]),
		rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version'),
		rt.new_bool(true)])
	rt.call_function('wp_localize_script', [rt.new_string('woocommerce_settings'),
		rt.new_string('woocommerce_settings_params'),
		rt.create_array([
			rt.ArrayItem{ key: 'i18n_nav_warning', val: rt.call_function('__', [
				rt.new_string('The changes you made will be lost if you navigate away from this page.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'i18n_moved_up', val: rt.call_function('__', [
				rt.new_string('Item moved up'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'i18n_moved_down', val: rt.call_function('__', [
				rt.new_string('Item moved down'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'i18n_no_specific_countries_selected', val: rt.call_function('__', [
				rt.new_string('Selecting no country / region to sell to prevents from completing the checkout. Continue anyway?'),
				rt.new_string('woocommerce'),
			]) },
		])])
	mut var_tabs := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_settings_tabs_array'),
		rt.new_array(),
	])
	rt.include_file(@DIR + '/views/html-admin-settings.php', '1')
}

fn Class_WC_Admin_Settings.get_option(var_option_name rt.PhpVal, default string) rt.PhpVal {
	mut var_option_array := rt.new_null()
	mut var_option_name_mutated := var_option_name
	mut default_mutated := default
	if rt.is_true(rt.new_bool(!(rt.is_true(var_option_name_mutated)))) {
		return rt.new_string(default_mutated)
	}
	if rt.is_true(rt.call_function('strstr', [var_option_name_mutated.clone(),
		rt.new_string('[')]))
	{
		rt.call_function('parse_str', [var_option_name_mutated.clone(),
			var_option_array.clone()])
		var_option_name_mutated = rt.call_function('current', [
			rt.func_array_keys(var_option_array.clone()),
		])
		mut var_option_values := rt.call_function('get_option', [
			var_option_name_mutated.clone(), rt.new_string('')])
		mut var_key := rt.call_function('key',
			[var_option_array.array_get(var_option_name_mutated)])
		if var_option_values.array_isset(var_key) {
			mut var_option_value := var_option_values.array_get(var_key)
		} else {
			var_option_value = rt.new_null()
		}
	} else {
		var_option_value = rt.call_function('get_option', [var_option_name_mutated.clone(),
			rt.new_null()])
	}
	if rt.is_true(rt.new_bool(var_option_value.clone().is_array())) {
		var_option_value = rt.call_function('wp_unslash', [var_option_value.clone()])
	} else if !(var_option_value.clone().is_null()) {
		var_option_value = rt.call_function('stripslashes', [
			var_option_value.clone()])
	}
	return if rt.is_true(rt.identical(rt.new_null(), var_option_value)) {
		rt.new_string(default_mutated)
	} else {
		var_option_value
	}
}

fn Class_WC_Admin_Settings.output_fields(var_options rt.PhpVal) {
	mut iter_3 := var_options.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		if !(var_value.array_isset(rt.new_string('type'))) {
			continue
		}
		if !(var_value.array_isset(rt.new_string('id'))) {
			var_value.array_set('id', '')
		}
		if !(var_value.array_isset(rt.new_string('field_name'))) {
			var_value.array_set('field_name', var_value.array_get(rt.new_string('id')))
		}
		if !(var_value.array_isset(rt.new_string('title'))) {
			var_value.array_set('title', if var_value.array_isset(rt.new_string('name')) {
				var_value.array_get(rt.new_string('name'))
			} else {
				rt.new_string('')
			})
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
		if !(!rt.is_true(var_value.array_get(rt.new_string('row_class'))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('substr', [var_value.array_get(rt.new_string('row_class')), rt.new_int(0), rt.new_int(16)]), rt.new_string('wc-settings-row-'))))) {
			var_value.array_set('row_class', 'wc-settings-row-' +
				(var_value.array_get(rt.new_string('row_class'))).str())
		}
		if !(var_value.array_isset(rt.new_string('suffix'))) {
			var_value.array_set('suffix', '')
		}
		if !(var_value.array_isset(rt.new_string('value'))) {
			var_value.array_set('value', Class_WC_Admin_Settings.get_option((var_value.array_get(rt.new_string('id'))).str(),
				var_value.array_get(rt.new_string('default'))))
		}
		if !(if !(var_value.array_get(rt.new_string('fixed_value'))).is_null() {
			var_value.array_get(rt.new_string('fixed_value'))
		} else {
			rt.new_null()
		}.is_null()) {
			var_value.array_set('value', var_value.array_get(rt.new_string('fixed_value')))
		}
		mut var_custom_attributes := rt.new_array()
		if !(!rt.is_true(var_value.array_get(rt.new_string('custom_attributes'))))
			&& var_value.array_get(rt.new_string('custom_attributes')).is_array() {
			mut iter_4 := var_value.array_get(rt.new_string('custom_attributes')).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_attribute_value := item_4.val
				mut var_attribute := item_4.key
				var_custom_attributes <<
					(rt.call_function('esc_attr', [var_attribute.clone()])).str() + '="' +
					(rt.call_function('esc_attr', [var_attribute_value.clone()])).str() + '"'
			}
		}
		mut var_field_description :=
			Class_WC_Admin_Settings.get_field_description(var_value.clone())
		mut var_description := var_field_description.array_get(rt.new_string('description'))
		mut var_tooltip_html := var_field_description.array_get(rt.new_string('tooltip_html'))
		mut switch_val_1 := var_value.array_get(rt.new_string('type'))
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('title'))) {
			if !(!rt.is_true(var_value.array_get(rt.new_string('title')))) {
				print('<h2>' +
					(rt.call_function('esc_html', [var_value.array_get(rt.new_string('title'))])).str() +
					'</h2>')
			}
			if !(!rt.is_true(var_value.array_get(rt.new_string('desc')))) {
				print('<div id="' +
					(rt.call_function('esc_attr', [rt.call_function('sanitize_title', [var_value.array_get(rt.new_string('id'))])])).str() +
					'-description">')
				rt.echo_val(rt.call_function('wp_kses_post', [
					rt.call_function('wpautop', [
						rt.call_function('wptexturize', [
							var_value.array_get(rt.new_string('desc')),
						]),
					]),
				]))
				print('</div>')
			}
			print('<table class="form-table">' + '\n\n')
			if !(!rt.is_true(var_value.array_get(rt.new_string('id')))) {
				rt.call_function('do_action', [
					rt.new_string('woocommerce_settings_' +(rt.call_function('sanitize_title', [var_value.array_get(rt.new_string('id'))])).str()),
				])
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('info'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('row_class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_value.array_get(rt.new_string('title')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('css'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [
				rt.call_function('wpautop', [
					rt.call_function('wptexturize', [var_value.array_get(rt.new_string('text'))]),
				]),
			]))
			print('</td></tr>')
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('notice'))) {
			mut var_notice_type := if !(var_value.array_get(rt.new_string('notice_type'))).is_null() {
				var_value.array_get(rt.new_string('notice_type'))
			} else {
				rt.new_string('info')
			}
			mut var_notice_text := if !(var_value.array_get(rt.new_string('text'))).is_null() {
				var_value.array_get(rt.new_string('text'))
			} else {
				rt.new_string('')
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_notice_type.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [var_notice_text.clone()]))
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('sectionend'))) {
			if !(!rt.is_true(var_value.array_get(rt.new_string('id')))) {
				rt.call_function('do_action', [
					rt.new_string('woocommerce_settings_' +
						(rt.call_function('sanitize_title', [var_value.array_get(rt.new_string('id'))])).str() +
						'_end'),
				])
			}
			print('</table>')
			if !(!rt.is_true(var_value.array_get(rt.new_string('id')))) {
				rt.call_function('do_action', [
					rt.new_string('woocommerce_settings_' +
						(rt.call_function('sanitize_title', [var_value.array_get(rt.new_string('id'))])).str() +
						'_after'),
				])
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('text')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('password')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('datetime')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('datetime-local')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('date')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('month')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('time')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('week')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('number')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('email')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('url')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('tel'))) {
			mut var_option_value := var_value.array_get(rt.new_string('value'))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('row_class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_value.array_get(rt.new_string('title')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_tooltip_html)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('sanitize_title', [var_value.array_get(rt.new_string('type'))]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('field_name')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('type')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('css'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_option_value.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('placeholder')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('implode', [rt.new_string(' '),
				rt.create_array_from_list(var_custom_attributes)]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_value.array_get(rt.new_string('suffix')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_description)
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('color'))) {
			var_option_value = var_value.array_get(rt.new_string('value'))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('row_class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_value.array_get(rt.new_string('title')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_tooltip_html)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('sanitize_title', [var_value.array_get(rt.new_string('type'))]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_option_value.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('field_name')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('css'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_option_value.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('placeholder')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('implode', [rt.new_string(' '),
				rt.create_array_from_list(var_custom_attributes)]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_description)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('textarea'))) {
			var_option_value = var_value.array_get(rt.new_string('value'))
			mut var_show_desc_at_end := if !(var_value.array_get(rt.new_string('desc_at_end'))).is_null() {
				var_value.array_get(rt.new_string('desc_at_end'))
			} else {
				rt.new_bool(false)
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('row_class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_value.array_get(rt.new_string('title')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_tooltip_html)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('sanitize_title', [var_value.array_get(rt.new_string('type'))]),
			]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!(rt.is_true(var_show_desc_at_end)))) {
				rt.echo_val(rt.call_function('wp_kses_post', [
					var_description.clone()]))
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('field_name')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('css'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('placeholder')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('implode', [rt.new_string(' '),
				rt.create_array_from_list(var_custom_attributes)]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_textarea', [var_option_value.clone()]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_show_desc_at_end) {
				rt.echo_val(rt.call_function('wp_kses_post', [
					var_description.clone()]))
			}
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('select')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('multiselect'))) {
			var_option_value = var_value.array_get(rt.new_string('value'))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('row_class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_value.array_get(rt.new_string('title')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_tooltip_html)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('sanitize_title', [var_value.array_get(rt.new_string('type'))]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('field_name')),
			]))
			print(if rt.is_true(rt.identical(rt.new_string('multiselect'),
				var_value.array_get(rt.new_string('type'))))
			{
				'[]'
			} else {
				''
			})
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('css'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('implode', [rt.new_string(' '),
				rt.create_array_from_list(var_custom_attributes)]))
			// unsupported statement: Stmt_InlineHTML
			print(if rt.is_true(rt.identical(rt.new_string('multiselect'),
				var_value.array_get(rt.new_string('type'))))
			{
				'multiple="multiple"'
			} else {
				''
			})
			// unsupported statement: Stmt_InlineHTML
			mut iter_5 := var_value.array_get(rt.new_string('options')).iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_val := item_5.val
				mut var_key := item_5.key
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.new_bool(var_option_value.clone().is_array())) {
					rt.call_function('selected', [
						rt.call_function('in_array', [rt.new_string(var_key.str()),
							var_option_value.clone(), rt.new_bool(true)]),
						rt.new_bool(true),
					])
				} else {
					rt.call_function('selected', [var_option_value.clone(),
						rt.new_string(var_key.str())])
				}
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_val.clone()]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_description)
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('radio'))) {
			var_option_value = var_value.array_get(rt.new_string('value'))
			mut var_disabled_values := if !(var_value.array_get(rt.new_string('disabled'))).is_null() {
				var_value.array_get(rt.new_string('disabled'))
			} else {
				rt.new_array()
			}
			var_show_desc_at_end = if !(var_value.array_get(rt.new_string('desc_at_end'))).is_null() {
				var_value.array_get(rt.new_string('desc_at_end'))
			} else {
				rt.new_bool(false)
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('row_class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_value.array_get(rt.new_string('title')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_tooltip_html)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('sanitize_title', [var_value.array_get(rt.new_string('type'))]),
			]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!(rt.is_true(var_show_desc_at_end)))) {
				rt.echo_val(rt.call_function('wp_kses_post', [
					var_description.clone()]))
			}
			// unsupported statement: Stmt_InlineHTML
			mut iter_6 := var_value.array_get(rt.new_string('options')).iterator()
			for {
				item_6 := iter_6.next() or { break }
				mut var_val := item_6.val
				mut var_key := item_6.key
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					var_value.array_get(rt.new_string('field_name')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.call_function('in_array', [var_key.clone(),
					var_disabled_values.clone(), rt.new_bool(true)]))
				{
					print('disabled')
				}
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					var_value.array_get(rt.new_string('css')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					var_value.array_get(rt.new_string('class')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('implode', [rt.new_string(' '),
					rt.create_array_from_list(var_custom_attributes)]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('checked', [var_key.clone(),
					var_option_value.clone()])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_val.clone()]))
				// unsupported statement: Stmt_InlineHTML
			}
			if rt.is_true(var_show_desc_at_end) {
				rt.echo_val(rt.call_function('wp_kses_post', [
					rt.new_string("<p class='description description-thin'>${var_description.to_string()}</p>"),
				]))
			}
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('checkbox'))) {
			var_option_value = var_value.array_get(rt.new_string('value'))
			mut var_visibility_class := rt.new_array()
			if !(var_value.array_isset(rt.new_string('hide_if_checked'))) {
				var_value.array_set('hide_if_checked', false)
			}
			if !(var_value.array_isset(rt.new_string('show_if_checked'))) {
				var_value.array_set('show_if_checked', false)
			}
			if rt.is_true(rt.identical(rt.new_string('yes'), var_value.array_get(rt.new_string('hide_if_checked'))))
				|| rt.is_true(rt.identical(rt.new_string('yes'), var_value.array_get(rt.new_string('show_if_checked')))) {
				var_visibility_class.array_push('hidden_option')
			}
			if rt.is_true(rt.identical(rt.new_string('option'),
				var_value.array_get(rt.new_string('hide_if_checked'))))
			{
				var_visibility_class.array_push('hide_options_if_checked')
			}
			if rt.is_true(rt.identical(rt.new_string('option'),
				var_value.array_get(rt.new_string('show_if_checked'))))
			{
				var_visibility_class.array_push('show_options_if_checked')
			}
			if rt.is_true(var_value.array_get(rt.new_string('row_class'))) {
				var_visibility_class.array_push(var_value.array_get(rt.new_string('row_class')))
			}
			mut var_must_disable := if !(var_value.array_get(rt.new_string('disabled'))).is_null() {
				var_value.array_get(rt.new_string('disabled'))
			} else {
				rt.new_bool(false)
			}
			if rt.is_true(var_must_disable) {
				var_visibility_class.array_push('disabled')
			}
			mut var_container_class := rt.call_function('implode', [
				rt.new_string(' '), var_visibility_class.clone()])
			mut var_has_title := rt.new_bool(var_value.array_isset(rt.new_string('title'))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_value.array_get(rt.new_string('title')))))))
			mut var_has_legend := rt.new_bool(var_value.array_isset(rt.new_string('legend'))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_value.array_get(rt.new_string('legend')))))))
			if !(var_value.array_isset(rt.new_string('checkboxgroup')))
				|| rt.is_true(rt.identical(rt.new_string('start'), var_value.array_get(rt.new_string('checkboxgroup')))) {
				mut var_has_tooltip := rt.new_bool(var_value.array_isset(rt.new_string('tooltip'))
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_value.array_get(rt.new_string('tooltip')))))))
				mut var_tooltip_container_class := rt.new_string((if rt.is_true(var_has_tooltip) {
					'with-tooltip'
				} else {
					''
				}).str())
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_container_class.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					var_value.array_get(rt.new_string('title')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_tooltip_container_class.clone()]))
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(var_has_tooltip) {
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('wc_help_tip', [
						rt.call_function('esc_html', [
							var_value.array_get(rt.new_string('tooltip')),
						]),
					]))
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_container_class.clone()]))
				// unsupported statement: Stmt_InlineHTML
			}
			if rt.is_true(var_has_title) || rt.is_true(var_has_legend) {
				// unsupported statement: Stmt_InlineHTML
				print(if rt.is_true(var_has_legend) { '' } else { 'screen-reader-text' })
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [if rt.is_true(var_has_legend) {
					var_value.array_get(rt.new_string('legend'))
				} else {
					var_value.array_get(rt.new_string('title'))
				}]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			print(if rt.is_true(var_must_disable) { 'disabled' } else { '' })
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('field_name')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [if var_value.array_isset(rt.new_string('class')) {
				var_value.array_get(rt.new_string('class'))
			} else {
				rt.new_string('')
			}]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [var_option_value.clone(),
				rt.new_string('yes')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('implode', [rt.new_string(' '),
				rt.create_array_from_list(var_custom_attributes)]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_description)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_tooltip_html)
			// unsupported statement: Stmt_InlineHTML
			if !(var_value.array_isset(rt.new_string('checkboxgroup')))
				|| rt.is_true(rt.identical(rt.new_string('end'), var_value.array_get(rt.new_string('checkboxgroup')))) {
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('image_width'))) {
			mut var_image_size := rt.call_function('str_replace', [
				rt.new_string('_image_size'),
				rt.new_string(''),
				var_value.array_get(rt.new_string('id')),
			])
			mut var_size := rt.call_function('wc_get_image_size', [
				var_image_size.clone()])
			mut var_width := if var_size.array_isset(rt.new_string('width')) {
				var_size.array_get(rt.new_string('width'))
			} else {
				var_value.array_get(rt.new_string('default')).array_get(rt.new_string('width'))
			}
			mut var_height := if var_size.array_isset(rt.new_string('height')) {
				var_size.array_get(rt.new_string('height'))
			} else {
				var_value.array_get(rt.new_string('default')).array_get(rt.new_string('height'))
			}
			mut var_crop := if var_size.array_isset(rt.new_string('crop')) {
				var_size.array_get(rt.new_string('crop'))
			} else {
				var_value.array_get(rt.new_string('default')).array_get(rt.new_string('crop'))
			}
			mut var_disabled_attr := rt.new_string('')
			mut var_disabled_message := rt.new_string('')
			if rt.is_true(rt.call_function('has_filter', [
				rt.new_string('woocommerce_get_image_size_' + var_image_size.str()),
			]))
			{
				var_disabled_attr = rt.new_string('disabled="disabled"')
				var_disabled_message = rt.new_string('<p><small>' +
					(rt.call_function('esc_html__', [rt.new_string('The settings of this image size have been disabled because its values are being overwritten by a filter.'), rt.new_string('woocommerce')])).str() +
					'</small></p>')
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('row_class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_value.array_get(rt.new_string('title')),
			]))
			// unsupported statement: Stmt_InlineHTML
			print(var_tooltip_html.str() + var_disabled_message.str())
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('field_name')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_disabled_attr)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_width.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_disabled_attr)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_height.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('field_name')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_disabled_attr)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [rt.new_int(1), var_crop.clone()])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Hard crop?'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('single_select_page'))) {
			mut var_args := rt.create_array([
				rt.ArrayItem{ key: 'name', val: var_value.array_get(rt.new_string('field_name')) },
				rt.ArrayItem{ key: 'id', val: var_value.array_get(rt.new_string('id')) },
				rt.ArrayItem{ key: 'sort_column', val: 'menu_order' },
				rt.ArrayItem{ key: 'sort_order', val: 'ASC' },
				rt.ArrayItem{ key: 'show_option_none', val: ' ' },
				rt.ArrayItem{ key: 'class', val: var_value.array_get(rt.new_string('class')) },
				rt.ArrayItem{ key: 'echo', val: false },
				rt.ArrayItem{ key: 'selected', val: rt.call_function('absint', [
					var_value.array_get(rt.new_string('value')),
				]) },
				rt.ArrayItem{ key: 'post_status', val: 'publish,private,draft' },
			])
			if var_value.array_isset(rt.new_string('args')) {
				var_args = rt.call_function('wp_parse_args', [
					var_value.array_get(rt.new_string('args')),
					var_args.clone(),
				])
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('row_class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_value.array_get(rt.new_string('title')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_tooltip_html)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('str_replace', [rt.new_string(' id='),
				rt.new_string(" data-placeholder='" +
					(rt.call_function('esc_attr__', [rt.new_string('Select a page&hellip;'), rt.new_string('woocommerce')])).str() +
					"' style='" +
					(var_value.array_get(rt.new_string('css'))).str() + "' class='" + (var_value.array_get(rt.new_string('class'))).str() + "' id="),
				rt.call_function('wp_dropdown_pages', [
					var_args.clone(),
				])]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_description)
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('single_select_page_with_search'))) {
			var_option_value = var_value.array_get(rt.new_string('value'))
			mut var_page := rt.call_function('get_post', [var_option_value.clone()])
			if !(var_page.clone().is_null()) {
				var_page = rt.call_function('get_post', [var_option_value.clone()])
				mut var_option_display_name := rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%1$s (ID: %2$s)'),
						rt.new_string('woocommerce')]),
					rt.get_property(var_page, 'post_title'),
					var_option_value.clone(),
				])
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('row_class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_value.array_get(rt.new_string('title')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_tooltip_html)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('sanitize_title', [var_value.array_get(rt.new_string('type'))]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('field_name')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('css'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('implode', [rt.new_string(' '),
				rt.create_array_from_list(var_custom_attributes)]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Search for a page&hellip;'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wc_esc_json', [
				rt.call_function('wp_json_encode', [
					var_value.array_get(rt.new_string('args')).array_get(rt.new_string('exclude')),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
			if !(var_page.clone().is_null()) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_option_value.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_strip_all_tags', [
					var_option_display_name.clone()]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_description)
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('single_select_country'))) {
			mut var_country_setting :=
				rt.new_string((var_value.array_get(rt.new_string('value'))).str())
			if rt.is_true(rt.call_function('strstr', [var_country_setting.clone(),
				rt.new_string(':')]))
			{
				var_country_setting = rt.call_function('explode', [
					rt.new_string(':'), var_country_setting.clone()])
				mut var_country := rt.call_function('current', [
					var_country_setting.clone()])
				mut var_state := rt.call_function('end', [var_country_setting.clone()])
			} else {
				var_country = var_country_setting.clone()
				var_state = rt.new_string('*')
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('row_class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_value.array_get(rt.new_string('title')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_tooltip_html)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('field_name')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('css'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [
				rt.new_string('Choose a country / region&hellip;'),
				rt.new_string('woocommerce'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Country / Region'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
				'country_dropdown_options', [var_country.clone(),
				var_state.clone()])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_description)
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('multi_select_countries'))) {
			mut var_selections := rt.cast_array(var_value.array_get(rt.new_string('value')))
			if !(!rt.is_true(var_value.array_get(rt.new_string('options')))) {
				mut var_countries := var_value.array_get(rt.new_string('options'))
			} else {
				var_countries = rt.get_property(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'countries')
			}
			rt.call_function('asort', [var_countries.clone()])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('row_class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_value.array_get(rt.new_string('title')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_tooltip_html)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('field_name')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [
				rt.new_string('Choose countries / regions&hellip;'),
				rt.new_string('woocommerce'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Country / Region'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			if !(!rt.is_true(var_countries)) {
				mut iter_7 := var_countries.iterator()
				for {
					item_7 := iter_7.next() or { break }
					mut var_val := item_7.val
					mut var_key := item_7.key
					print('<option value="' +
						(rt.call_function('esc_attr', [var_key.clone()])).str() + '"' +
						(rt.call_function('wc_selected', [var_key.clone(), var_selections.clone()])).str() +
						'>' + (rt.call_function('esc_html', [var_val.clone()])).str() + '</option>')
				}
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(if rt.is_true(var_description) { var_description } else { rt.new_string('') })
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Select all'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Select none'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('relative_date_selector'))) {
			mut var_periods := rt.create_array([
				rt.ArrayItem{ key: 'days', val: rt.call_function('__', [
					rt.new_string('Day(s)'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'weeks', val: rt.call_function('__', [
					rt.new_string('Week(s)'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'months', val: rt.call_function('__', [
					rt.new_string('Month(s)'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'years', val: rt.call_function('__', [
					rt.new_string('Year(s)'),
					rt.new_string('woocommerce'),
				]) },
			])
			var_option_value = rt.call_function('wc_parse_relative_date_option', [
				var_value.array_get(rt.new_string('value')),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('row_class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_value.array_get(rt.new_string('title')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_tooltip_html)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('field_name')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_option_value.array_get(rt.new_string('number')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('class')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('placeholder')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('implode', [rt.new_string(' '),
				rt.create_array_from_list(var_custom_attributes)]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('field_name')),
			]))
			// unsupported statement: Stmt_InlineHTML
			mut iter_8 := var_periods.iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_label := item_8.val
				mut var_value_shadow := item_8.key
				print('<option value="' +
					(rt.call_function('esc_attr', [var_value_shadow.clone()])).str() + '"' +
					(rt.call_function('selected', [var_option_value.array_get(rt.new_string('unit')), var_value_shadow.clone(), rt.new_bool(false)])).str() +
					'>' + (rt.call_function('esc_html', [var_label.clone()])).str() + '</option>')
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(if rt.is_true(var_description) { var_description } else { rt.new_string('') })
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('slotfill_placeholder'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.array_get(rt.new_string('id'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_value.array_get(rt.new_string('class')),
			]))
			// unsupported statement: Stmt_InlineHTML
		} else {
			rt.call_function('do_action', [
				rt.new_string('woocommerce_admin_field_' +
					(var_value.array_get(rt.new_string('type'))).str()),
				var_value.clone(),
			])
		}
	}
}

fn Class_WC_Admin_Settings.get_field_description(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_description := rt.new_string('')
	mut var_tooltip_html := rt.new_string('')
	if rt.is_true(rt.identical(rt.new_bool(true),
		var_value_mutated.array_get(rt.new_string('desc_tip'))))
	{
		var_tooltip_html = var_value_mutated.array_get(rt.new_string('desc'))
	} else if !(!rt.is_true(var_value_mutated.array_get(rt.new_string('desc_tip')))) {
		var_description = var_value_mutated.array_get(rt.new_string('desc'))
		var_tooltip_html = var_value_mutated.array_get(rt.new_string('desc_tip'))
	} else if !(!rt.is_true(var_value_mutated.array_get(rt.new_string('desc')))) {
		var_description = var_value_mutated.array_get(rt.new_string('desc'))
	}
	mut var_desc_at_end := if var_value_mutated.array_isset(rt.new_string('desc_at_end')) {
		var_value_mutated.array_get(rt.new_string('desc_at_end'))
	} else {
		rt.new_bool(false)
	}
	mut var_error_class := rt.new_string((if !(!rt.is_true(var_value_mutated.array_get(rt.new_string('description_is_error')))) {
		'is-error'
	} else {
		''
	}).str())
	if rt.is_true(var_description)
		&& rt.is_true(rt.call_function('in_array', [var_value_mutated.array_get(rt.new_string('type')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'textarea'
	}]), rt.new_bool(true)]))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_desc_at_end)))) {
		var_description = rt.new_string('<p class="description ' + var_error_class.str() +
			'" style="margin-top:0;">' +
			(rt.call_function('wp_kses_post', [var_description.clone()])).str() + '</p>')
	} else if rt.is_true(var_description)
		&& rt.is_true(rt.call_function('in_array', [var_value_mutated.array_get(rt.new_string('type')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'radio'
	}]), rt.new_bool(true)])) {
		var_description = rt.new_string('<p style="margin-top:0">' +
			(rt.call_function('wp_kses_post', [var_description.clone()])).str() + '</p>')
	} else if rt.is_true(var_description)
		&& rt.is_true(rt.call_function('in_array', [var_value_mutated.array_get(rt.new_string('type')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'checkbox'
	}]), rt.new_bool(true)])) {
		var_description = rt.call_function('wp_kses_post', [var_description.clone()])
	} else if rt.is_true(var_description) {
		var_description = rt.new_string('<p class="description ' + var_error_class.str() + '">' +
			(rt.call_function('wp_kses_post', [var_description.clone()])).str() + '</p>')
	}
	if rt.is_true(var_tooltip_html)
		&& rt.is_true(rt.call_function('in_array', [var_value_mutated.array_get(rt.new_string('type')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'checkbox'
	}]), rt.new_bool(true)])) {
		var_tooltip_html = rt.new_string('<p class="description ' + var_error_class.str() + '">' +
			var_tooltip_html.str() + '</p>')
	} else if rt.is_true(var_tooltip_html) {
		var_tooltip_html = rt.call_function('wc_help_tip', [var_tooltip_html.clone()])
	}
	return rt.create_array([rt.ArrayItem{ key: 'description', val: var_description },
		rt.ArrayItem{ key: 'tooltip_html', val: var_tooltip_html }])
}

fn Class_WC_Admin_Settings.save_fields(var_options rt.PhpVal, var_data rt.PhpVal) bool {
	mut var_option_name_array := rt.new_null()
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(var_data_mutated.clone().is_null())) {
		var_data_mutated = rt.get_superglobal('_POST')
	}
	if !rt.is_true(var_data_mutated) {
		return false
	}
	mut var_update_options := rt.new_array()
	mut var_autoload_options := rt.new_array()
	mut iter_9 := var_options.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_option := item_9.val
		if !(var_option.array_isset(rt.new_string('id')))
			|| !(var_option.array_isset(rt.new_string('type')))
			|| (var_option.array_isset(rt.new_string('is_option'))
			&& rt.is_true(rt.identical(rt.new_bool(false), var_option.array_get(rt.new_string('is_option'))))) {
			continue
		}
		mut var_option_name := if !(var_option.array_get(rt.new_string('field_name'))).is_null() {
			var_option.array_get(rt.new_string('field_name'))
		} else {
			var_option.array_get(rt.new_string('id'))
		}
		if rt.is_true(rt.call_function('strstr', [var_option_name.clone(),
			rt.new_string('[')]))
		{
			rt.call_function('parse_str', [var_option_name.clone(),
				var_option_name_array.clone()])
			var_option_name = rt.call_function('current', [
				rt.func_array_keys(var_option_name_array.clone()),
			])
			mut var_setting_name := rt.call_function('key', [
				var_option_name_array.array_get(var_option_name),
			])
			mut var_raw_value := if var_data_mutated.array_get(var_option_name).array_isset(var_setting_name) { rt.call_function('wp_unslash', [
					var_data_mutated.array_get(var_option_name).array_get(var_setting_name),
				]) } else { rt.new_null() }
		} else {
			var_setting_name = rt.new_string('')
			var_raw_value = if var_data_mutated.array_isset(var_option_name) { rt.call_function('wp_unslash', [
					var_data_mutated.array_get(var_option_name),
				]) } else { rt.new_null() }
		}
		mut switch_val_2 := var_option.array_get(rt.new_string('type'))
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('checkbox'))) {
			mut var_value := rt.new_string((if
				rt.is_true(rt.identical(rt.new_string('1'), var_raw_value))
				|| rt.is_true(rt.identical(rt.new_string('yes'), var_raw_value)) {
				'yes'
			} else {
				'no'
			}).str())
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('textarea'))) {
			var_value = rt.call_function('wp_kses_post', [
				rt.new_string(var_raw_value.clone().to_string().trim_space()),
			])
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('multiselect')))
			|| rt.is_true(rt.equal(switch_val_2, rt.new_string('multi_select_countries'))) {
			var_value = rt.call_function('array_filter', [
				rt.call_function('array_map', [rt.new_string('wc_clean'),
					rt.cast_array(var_raw_value)]),
			])
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('image_width'))) {
			var_value = rt.new_array()
			if var_raw_value.array_isset(rt.new_string('width')) {
				var_value.array_set('width', rt.call_function('wc_clean', [
					var_raw_value.array_get(rt.new_string('width')),
				]))
				var_value.array_set('height', rt.call_function('wc_clean', [
					var_raw_value.array_get(rt.new_string('height')),
				]))
				var_value.array_set('crop', if var_raw_value.array_isset(rt.new_string('crop')) {
					1
				} else {
					0
				})
			} else {
				var_value.array_set('width',
					var_option.array_get(rt.new_string('default')).array_get(rt.new_string('width')))
				var_value.array_set('height',
					var_option.array_get(rt.new_string('default')).array_get(rt.new_string('height')))
				var_value.array_set('crop',
					var_option.array_get(rt.new_string('default')).array_get(rt.new_string('crop')))
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('select'))) {
			mut var_allowed_values := if !rt.is_true(var_option.array_get(rt.new_string('options'))) { rt.new_array() } else { rt.call_function('array_map', [
					rt.new_string('strval'),
					rt.func_array_keys(var_option.array_get(rt.new_string('options'))),
				]) }
			if !rt.is_true(var_option.array_get(rt.new_string('default')))
				&& !rt.is_true(var_allowed_values) {
				var_value = rt.new_null()
			}
			mut var_default := if !rt.is_true(var_option.array_get(rt.new_string('default'))) {
				var_allowed_values.array_get(rt.new_int(0))
			} else {
				var_option.array_get(rt.new_string('default'))
			}
			var_value = if rt.is_true(rt.call_function('in_array', [
				var_raw_value.clone(), var_allowed_values.clone(),
				rt.new_bool(true)]))
			{ var_raw_value } else { var_default }
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('relative_date_selector'))) {
			var_value = rt.call_function('wc_parse_relative_date_option', [
				var_raw_value.clone()])
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('password'))) {
			var_value = if var_raw_value.clone().is_string() {
				rt.new_string(var_raw_value.clone().to_string().trim_space())
			} else {
				rt.new_null()
			}
		} else {
			var_value = rt.call_function('wc_clean', [var_raw_value.clone()])
		}
		if rt.is_true(rt.call_function('has_action', [
			rt.new_string('woocommerce_update_option_' +(rt.call_function('sanitize_title', [var_option.array_get(rt.new_string('type'))])).str()),
		]))
		{
			rt.call_function('wc_deprecated_function', [
				rt.new_string('The woocommerce_update_option_X action'),
				rt.new_string('2.4.0'),
				rt.new_string('woocommerce_admin_settings_sanitize_option filter'),
			])
			rt.call_function('do_action', [
				rt.new_string('woocommerce_update_option_' +(rt.call_function('sanitize_title', [var_option.array_get(rt.new_string('type'))])).str()),
				var_option.clone(),
			])
			continue
		}
		var_value = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_admin_settings_sanitize_option'),
			var_value.clone(),
			var_option.clone(),
			var_raw_value.clone(),
		])
		var_value = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_admin_settings_sanitize_option_${var_option_name.to_string()}'),
			var_value.clone(),
			var_option.clone(),
			var_raw_value.clone(),
		])
		if rt.is_true(rt.new_bool(var_value.clone().is_null())) {
			continue
		}
		if rt.is_true(var_option_name) && rt.is_true(var_setting_name) {
			if !(var_update_options.array_isset(var_option_name)) {
				var_update_options.array_set(var_option_name, rt.call_function('get_option', [
					var_option_name.clone(),
					rt.new_array(),
				]))
			}
			if !(var_update_options.array_get(var_option_name).is_array()) {
				var_update_options.array_set(var_option_name, rt.new_array())
			}
			var_update_options.array_get_mut(var_option_name).array_set(var_setting_name,
				var_value.clone())
		} else {
			var_update_options.array_set(var_option_name, var_value.clone())
		}
		var_autoload_options.array_set(var_option_name, if var_option.array_isset(rt.new_string('autoload')) {
			(var_option.array_get(rt.new_string('autoload'))).to_bool()
		} else {
			true
		})
		rt.call_function('do_action', [rt.new_string('woocommerce_update_option'),
			var_option.clone()])
	}
	mut iter_10 := var_update_options.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_value := item_10.val
		mut var_name := item_10.key
		rt.call_function('update_option', [var_name.clone(), var_value.clone(),
			rt.new_string((if rt.is_true(var_autoload_options.array_get(var_name)) {
				'yes'
			} else {
				'no'
			}).str())])
	}
	return true
}

fn Class_WC_Admin_Settings.check_download_folder_protection() {
	mut var_upload_dir := rt.call_function('wp_get_upload_dir', []rt.PhpVal{})
	mut var_downloads_path := rt.new_string(
		(var_upload_dir.array_get(rt.new_string('basedir'))).str() + '/woocommerce_uploads')
	mut var_download_method := rt.call_function('get_option', [
		rt.new_string('woocommerce_file_download_method'),
	])
	mut var_file_path := rt.new_string(var_downloads_path.str() + '/.htaccess')
	mut var_file_content := rt.new_string((if rt.is_true(rt.identical(rt.new_string('redirect'),
		var_download_method))
	{
		'Options -Indexes'
	} else {
		'deny from all'
	}).str())
	mut var_create := rt.new_bool(false)
	if rt.is_true(rt.call_function('wp_mkdir_p', [var_downloads_path.clone()]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_file_path.clone()]))))) {
		var_create = rt.new_bool(true)
	} else {
		mut var_current_content := rt.call_function('file_get_contents', [
			var_file_path.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_current_content, var_file_content)))) {
			rt.call_function('unlink', [var_file_path.clone()])
			var_create = rt.new_bool(true)
		}
	}
	if rt.is_true(var_create) {
		mut var_file_handle := rt.call_function('fopen', [var_file_path.clone(),
			rt.new_string('wb')])
		if rt.is_true(var_file_handle) {
			rt.call_function('fwrite', [var_file_handle.clone(),
				var_file_content.clone()])
			rt.call_function('fclose', [var_file_handle.clone()])
		}
	}
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

fn create_wc_admin_settings(_args ...rt.PhpVal) &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
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
			Class_WC_Admin_Settings.reset_settings_pages_on_feature_change(dispatch_arg_0,
				dispatch_arg_1)
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
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Admin_Settings'),
		rt.new_bool(false),
	])))))
	{
	}
}
