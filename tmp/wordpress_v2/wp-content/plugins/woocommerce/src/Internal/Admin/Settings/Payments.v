import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.payments_nox_profile_key() string {
	return 'woocommerce_payments_nox_profile'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.payments_provider_state_snapshots_key() string {
	return 'woocommerce_payments_provider_state_snapshots'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.suggestions_context() string {
	return 'wc_settings_payments'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.event_prefix() string {
	return 'settings_payments_'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.from_payments_settings() string {
	return 'WCADMIN_PAYMENT_SETTINGS'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.from_payments_menu_item() string {
	return 'PAYMENTS_MENU_ITEM'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.from_payments_task() string {
	return 'WCADMIN_PAYMENT_TASK'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.from_additional_payments_task() string {
	return 'WCADMIN_ADDITIONAL_PAYMENT_TASK'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments.from_provider_onboarding() string {
	return 'PROVIDER_ONBOARDING'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments {
	rt.PhpObjectBase
pub mut:
	providers             rt.PhpVal = rt.new_null()
	extension_suggestions rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) init(mut var_payment_providers Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders, mut var_payment_extension_suggestions Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions) {
	mut var_payment_providers_mutated := var_payment_providers
	this.providers = var_payment_providers_mutated
	this.extension_suggestions = var_payment_extension_suggestions
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) get_payment_providers(location string, for_display bool, remove_shells bool) rt.PhpVal {
	mut var_payment_gateways := rt.call_method(this.providers, 'get_payment_gateways', [
		rt.new_bool(for_display),
	])
	if !var_for_display && var_remove_shells {
		var_payment_gateways = rt.call_method(this.providers, 'remove_shell_payment_gateways', [
			var_payment_gateways.clone(),
			rt.new_string(location),
		])
	}
	mut var_providers_order_map := rt.call_method(this.providers, 'get_order_map', []rt.PhpVal{})
	mut var_payment_providers := rt.new_array()
	mut var_suggestions := rt.new_array()
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')])) {
		var_suggestions = rt.call_method(this.providers, 'get_extension_suggestions', [
			rt.new_string(location),
			Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_Payments.suggestions_context(),
		])
	}
	if !(!rt.is_true(var_suggestions.array_get(rt.new_string('preferred')))) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			return rt.new_null()
		}
		rt.call_function('usort', [var_suggestions.array_get(rt.new_string('preferred')),
			rt.new_closure(closure_1_fn)])
		mut var_last_preferred_order := rt.new_int(-1)
		if var_providers_order_map.array_isset(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.gateway_id()) {
			var_last_preferred_order =
				var_providers_order_map.array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WooPayments_WooPaymentsService.gateway_id())
		}
		mut iter_1 := var_suggestions.array_get(rt.new_string('preferred')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_suggestion := item_1.val
			mut var_suggestion_order_map_id := rt.call_method(this.providers,
				'get_suggestion_order_map_id', [var_suggestion.array_get(rt.new_string('id'))])
			if !(var_providers_order_map.array_isset(var_suggestion_order_map_id)) {
				mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
				mut iife_result_1 := iife_temp_1.order_map_add_at_order(var_providers_order_map.clone(),
					var_suggestion_order_map_id.clone(), rt.add(var_last_preferred_order,
					rt.new_int(1)))
				var_providers_order_map = iife_result_1
			}
			if rt.is_true(rt.less(var_last_preferred_order,
				var_providers_order_map.array_get(var_suggestion_order_map_id)))
			{
				var_last_preferred_order =
					var_providers_order_map.array_get(var_suggestion_order_map_id)
			}
			var_suggestion.array_set('_suggestion_id',
				var_suggestion.array_get(rt.new_string('id')))
			var_suggestion.array_set('id', var_suggestion_order_map_id.clone())
			var_suggestion.array_set('_type',
				Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_suggestion())
			var_suggestion.array_set('_order',
				var_providers_order_map.array_get(var_suggestion_order_map_id))
			var_suggestion.array_unset(rt.new_string('_priority'))
			var_payment_providers.array_push(var_suggestion.clone())
		}
	}
	mut iter_2 := var_payment_gateways.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_payment_gateway := item_2.val
		if !(var_providers_order_map.array_isset(rt.get_property(var_payment_gateway, 'id'))) {
			var_providers_order_map = rt.call_method(this.providers, 'order_map_add_gateway', [
				var_providers_order_map.clone(),
				rt.get_property(var_payment_gateway, 'id'),
			])
		}
		var_payment_providers.array_push(rt.call_method(this.providers,
			'get_payment_gateway_details', [var_payment_gateway.clone(),
			var_providers_order_map.array_get(rt.get_property(var_payment_gateway, 'id')),
			rt.new_string(location)]))
	}
	if rt.is_true(rt.call_function('in_array', [
		Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_offline_pm(),
		rt.call_function('array_column', [var_payment_providers.clone(),
			rt.new_string('_type')]),
		rt.new_bool(true),
	]))
	{
		if !(var_providers_order_map.array_isset(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods_ordering_group())) {
			mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
			mut iife_result_2 := iife_temp_2.order_map_add_at_order(var_providers_order_map.clone(),
				Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods_ordering_group(),
				rt.new_int(var_payment_providers.clone().array_count()))
			var_providers_order_map = iife_result_2
		}
		mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
		mut iife_result_3 :=
			iife_temp_3.wc_payments_settings_url(rt.new_string('/' +(if rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Settings_Payment_Gateways')])) { Class_Automattic_WooCommerce_Internal_Admin_Settings_WC_Settings_Payment_Gateways.offline_section_name() } else { rt.new_string('offline') }).str()))
		var_payment_providers.array_push(rt.create_array([
			rt.ArrayItem{
				key: 'id'
				val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods_ordering_group()
			},
			rt.ArrayItem{
				key: '_type'
				val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_offline_pms_group()
			},
			rt.ArrayItem{
				key: '_order'
				val: var_providers_order_map.array_get(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.offline_methods_ordering_group())
			},
			rt.ArrayItem{ key: 'title', val: rt.call_function('esc_html__', [
				rt.new_string('Take offline payments'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('esc_html__', [
				rt.new_string('Accept payments offline using multiple different methods. These can also be used to test purchases.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'icon', val: rt.call_function('plugins_url', [
				rt.new_string('assets/images/payment_methods/cod.svg'),
				rt.get_constant('WC_PLUGIN_FILE'),
			]) },
			rt.ArrayItem{ key: 'plugin', val: rt.create_array([
				rt.ArrayItem{ key: '_type', val: 'wporg' },
				rt.ArrayItem{ key: 'slug', val: 'woocommerce' },
				rt.ArrayItem{ key: 'file', val: '' },
				rt.ArrayItem{
					key: 'status'
					val: Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_active()
				},
			]) },
			rt.ArrayItem{ key: 'management', val: rt.create_array([
				rt.ArrayItem{ key: '_links', val: rt.create_array([
					rt.ArrayItem{ key: 'settings', val: rt.create_array([
						rt.ArrayItem{ key: 'href', val: iife_result_3 },
					]) },
				]) },
			]) },
		]))
	}
	var_providers_order_map = rt.call_method(this.providers, 'enhance_order_map', [
		var_providers_order_map.clone(),
	])
	mut iter_3 := var_payment_providers.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_provider := item_3.val
		mut var_key := item_3.key
		var_payment_providers.array_get_mut(var_key).array_set('_order',
			var_providers_order_map.array_get(var_provider.array_get(rt.new_string('id'))))
	}
	rt.call_method(this.providers, 'save_order_map', [var_providers_order_map.clone()])
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.new_null()
	}
	rt.call_function('usort', [var_payment_providers.clone(),
		rt.new_closure(closure_5_fn)])
	if var_for_display {
		this.process_payment_provider_states(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_payment_providers))
	}
	return var_payment_providers.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) get_payment_extension_suggestions(location string) rt.PhpVal {
	return rt.call_method(this.providers, 'get_extension_suggestions', [
		rt.new_string(location),
		Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_Payments.suggestions_context(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) get_payment_extension_suggestion_categories() rt.PhpVal {
	return rt.call_method(this.providers, 'get_extension_suggestion_categories', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) get_country() string {
	mut var_user_nox_meta := rt.call_function('get_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_Payments.payments_nox_profile_key(),
		rt.new_bool(true),
	])
	if !(!rt.is_true(var_user_nox_meta.array_get(rt.new_string('business_country_code')))) {
		return (var_user_nox_meta.array_get(rt.new_string('business_country_code'))).str()
	}
	return (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'),
		'get_base_country', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) set_country(location string) bool {
	mut var_previous_country := rt.new_string(this.get_country())
	mut var_user_payments_nox_profile := rt.call_function('get_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_Payments.payments_nox_profile_key(),
		rt.new_bool(true),
	])
	if !rt.is_true(var_user_payments_nox_profile) {
		var_user_payments_nox_profile = rt.new_array()
	} else {
		var_user_payments_nox_profile = rt.call_function('maybe_unserialize', [
			var_user_payments_nox_profile.clone(),
		])
	}
	var_user_payments_nox_profile.array_set('business_country_code', location)
	mut var_result := rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('update_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_Payments.payments_nox_profile_key(),
		var_user_payments_nox_profile.clone(),
	]))))
	if rt.is_true(var_result)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_previous_country, rt.new_string(location))))) {
		this.record_event('business_location_update', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
			rt.ArrayItem{ key: 'business_country', val: location },
			rt.ArrayItem{ key: 'previous_business_country', val: var_previous_country },
		])))
	}
	return var_result.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) update_payment_providers_order_map(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array) bool {
	mut var_result := rt.call_method(this.providers, 'update_payment_providers_order_map', [
		var_order_map,
	])
	if rt.is_true(var_result) {
		this.record_event('payment_providers_order_map_updated', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
			rt.ArrayItem{ key: 'order_map', val: rt.call_function('implode', [
				rt.new_string(', '),
				rt.func_array_keys(rt.call_method(this.providers, 'get_order_map', []rt.PhpVal{})),
			]) },
		])))
	}
	return var_result.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) attach_payment_extension_suggestion(id string) bool {
	mut var_result := rt.call_method(this.providers, 'attach_extension_suggestion', [
		rt.new_string(id),
	])
	if rt.is_true(var_result) {
		this.record_event('extension_suggestion_attached', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
			rt.ArrayItem{ key: 'suggestion_id', val: id },
		])))
	}
	return var_result.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) hide_payment_extension_suggestion(id string) bool {
	mut var_result := rt.call_method(this.providers, 'hide_extension_suggestion', [
		rt.new_string(id),
	])
	if rt.is_true(var_result) {
		this.record_event('extension_suggestion_hidden', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
			rt.ArrayItem{ key: 'suggestion_id', val: id },
		])))
	}
	return var_result.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) dismiss_extension_suggestion_incentive(suggestion_id string, incentive_id string, context string, do_not_track bool) bool {
	mut var_result := rt.call_method(this.extension_suggestions, 'dismiss_incentive', [
		rt.new_string(incentive_id),
		rt.new_string(suggestion_id),
		rt.new_string(context),
	])
	if !var_do_not_track && rt.is_true(var_result) {
		this.record_event('incentive_dismiss', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
			rt.ArrayItem{ key: 'suggestion_id', val: suggestion_id },
			rt.ArrayItem{ key: 'incentive_id', val: incentive_id },
			rt.ArrayItem{ key: 'display_context', val: context },
		])))
	}
	return var_result.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) record_event(name string, mut var_properties Class_Automattic_WooCommerce_Internal_Admin_Settings_array) {
	mut name_mutated := name
	mut var_properties_mutated := var_properties
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_admin_record_tracks_event'),
	])))))
	{
		return
	}
	if name_mutated == '' {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
		rt.new_string(name_mutated).clone(),
		Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_Payments.event_prefix(),
	])))))
	{
		name_mutated =
			(Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_Payments.event_prefix()).str() + name_mutated
	}
	var_properties_mutated = rt.call_function('array_merge', [var_properties_mutated,
		rt.create_array([
			rt.ArrayItem{ key: 'business_country', val: this.get_country() },
		])])
	rt.call_function('wc_admin_record_tracks_event', [rt.new_string(name_mutated).clone(),
		var_properties_mutated])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) process_payment_provider_states(mut var_payment_providers Class_Automattic_WooCommerce_Internal_Admin_Settings_array) {
	mut var_payment_providers_mutated := var_payment_providers
	mut var_snapshots := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_Payments.payments_provider_state_snapshots_key(),
		rt.new_array(),
	])
	if !(var_snapshots.clone().is_array()) {
		var_snapshots = rt.new_array()
	}
	mut var_default_snapshot := rt.create_array([
		rt.ArrayItem{ key: 'extension_active', val: false },
		rt.ArrayItem{ key: 'account_connected', val: false },
		rt.ArrayItem{ key: 'account_test_mode', val: false },
		rt.ArrayItem{ key: 'needs_setup', val: false },
		rt.ArrayItem{ key: 'test_mode', val: false },
	])
	mut var_new_snapshots := rt.new_array()
	mut iter_4 := var_payment_providers_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_provider := item_4.val
		if !rt.is_true(var_provider.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug')))
			|| !rt.is_true(var_provider.array_get(rt.new_string('id')))
			|| !rt.is_true(var_provider.array_get(rt.new_string('state')))
			|| !(var_provider.array_get(rt.new_string('state')).is_array())
			|| !rt.is_true(var_provider.array_get(rt.new_string('onboarding')).array_get(rt.new_string('state')))
			|| !(var_provider.array_get(rt.new_string('onboarding')).array_get(rt.new_string('state')).is_array())
			|| !rt.is_true(var_provider.array_get(rt.new_string('_type')))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.type_gateway(), var_provider.array_get(rt.new_string('_type'))))))
			|| !rt.is_true(var_provider.array_get(rt.new_string('_suggestion_id'))) {
			continue
		}
		mut var_snapshot_key :=
			var_provider.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug'))
		if var_new_snapshots.array_isset(var_snapshot_key) {
			continue
		}
		if !(var_snapshots.array_isset(var_snapshot_key)) {
			var_snapshots.array_set(var_snapshot_key, var_default_snapshot.clone())
		} else {
			var_snapshots.array_set(var_snapshot_key, rt.call_function('array_merge', [
				var_default_snapshot.clone(),
				var_snapshots.array_get(var_snapshot_key),
			]))
			mut var_snapshot_keys := rt.func_array_keys(var_default_snapshot.clone())
			mut iter_5 := var_snapshots.array_get(var_snapshot_key).iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_v := item_5.val
				mut var_key := item_5.key
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
					var_key.clone(),
					var_snapshot_keys.clone(),
					rt.new_bool(true),
				])))))
				{
					var_snapshots.array_get(var_snapshot_key).array_unset(var_key)
				}
			}
			rt.call_function('ksort', [var_snapshots.array_get(var_snapshot_key)])
		}
		var_new_snapshots.array_set(var_snapshot_key, rt.create_array([
			rt.ArrayItem{ key: 'extension_active', val: true },
			rt.ArrayItem{
				key: 'account_connected'
				val: if !(var_provider.array_get(rt.new_string('state')).array_get(rt.new_string('account_connected'))).is_null() {
					var_provider.array_get(rt.new_string('state')).array_get(rt.new_string('account_connected'))
				} else {
					var_default_snapshot.array_get(rt.new_string('account_connected'))
				}
			},
			rt.ArrayItem{
				key: 'account_test_mode'
				val: if !(var_provider.array_get(rt.new_string('onboarding')).array_get(rt.new_string('state')).array_get(rt.new_string('test_mode'))).is_null() {
					var_provider.array_get(rt.new_string('onboarding')).array_get(rt.new_string('state')).array_get(rt.new_string('test_mode'))
				} else {
					var_default_snapshot.array_get(rt.new_string('account_test_mode'))
				}
			},
			rt.ArrayItem{
				key: 'needs_setup'
				val: if !(var_provider.array_get(rt.new_string('state')).array_get(rt.new_string('needs_setup'))).is_null() {
					var_provider.array_get(rt.new_string('state')).array_get(rt.new_string('needs_setup'))
				} else {
					var_default_snapshot.array_get(rt.new_string('needs_setup'))
				}
			},
			rt.ArrayItem{
				key: 'test_mode'
				val: if !(var_provider.array_get(rt.new_string('state')).array_get(rt.new_string('test_mode'))).is_null() {
					var_provider.array_get(rt.new_string('state')).array_get(rt.new_string('test_mode'))
				} else {
					var_default_snapshot.array_get(rt.new_string('test_mode'))
				}
			},
		]))
		rt.call_function('ksort', [var_new_snapshots.array_get(var_snapshot_key)])
	}
	mut iter_6 := var_snapshots.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_old_snapshot := item_6.val
		mut var_snapshot_key := item_6.key
		if !(var_new_snapshots.array_isset(var_snapshot_key)) {
			var_new_snapshots.array_set(var_snapshot_key, var_old_snapshot.clone())
			var_new_snapshots.array_get_mut(var_snapshot_key).array_set('extension_active', false)
		}
	}
	rt.call_function('ksort', [var_new_snapshots.clone()])
	mut var_result := rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Settings_Automattic_WooCommerce_Internal_Admin_Settings_Payments.payments_provider_state_snapshots_key(),
		var_new_snapshots.clone(),
		rt.new_bool(false),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return
	}
	this.maybe_track_providers_state_change(mut var_payment_providers_mutated, mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_snapshots), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_new_snapshots))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Admin_Settings_Throwable') {
		mut var_exception := var_e_1.clone()
		mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{}
		mut iife_result_5 := iife_temp_5.wc_get_logger()
		rt.call_method(iife_result_5, 'error', [
			rt.new_string('Failed to track payment providers state change: ' +
				(rt.call_method(var_exception, 'getMessage', []rt.PhpVal{})).str()),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'settings-payments' }]),
		])
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) maybe_track_providers_state_change(mut var_providers Class_Automattic_WooCommerce_Internal_Admin_Settings_array, mut var_old_snapshots Class_Automattic_WooCommerce_Internal_Admin_Settings_array, mut var_new_snapshots Class_Automattic_WooCommerce_Internal_Admin_Settings_array) {
	mut var_new_snapshots_mutated := var_new_snapshots
	mut iter_7 := var_new_snapshots_mutated.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_new_snapshot := item_7.val
		mut var_provider_extension_slug := item_7.key
		if !(var_old_snapshots.array_isset(var_provider_extension_slug)) {
			continue
		}
		if rt.is_true(rt.identical(rt.call_function('maybe_serialize', [
			var_old_snapshots.array_get(var_provider_extension_slug),
		]), rt.call_function('maybe_serialize', [var_new_snapshot.clone()])))
		{
			continue
		}
		mut var_provider := rt.new_null()
		mut iter_8 := var_providers.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_p := item_8.val
			if var_p.array_get(rt.new_string('plugin')).array_isset(rt.new_string('slug'))
				&& rt.is_true(rt.identical(var_p.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug')), var_provider_extension_slug)) {
				var_provider = var_p
				break
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_provider)))) {
			var_provider = rt.call_method(this.providers,
				'get_extension_suggestion_by_plugin_slug', [var_provider_extension_slug.clone()])
			if !(!rt.is_true(var_provider.array_get(rt.new_string('id')))) {
				var_provider.array_set('_suggestion_id',
					var_provider.array_get(rt.new_string('id')))
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_provider)))) {
			continue
		}
		this.maybe_track_provider_state_change(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_provider), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_old_snapshots.array_get(var_provider_extension_slug)), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_new_snapshot))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) maybe_track_provider_state_change(mut var_provider Class_Automattic_WooCommerce_Internal_Admin_Settings_array, mut var_old_snapshot Class_Automattic_WooCommerce_Internal_Admin_Settings_array, mut var_new_snapshot Class_Automattic_WooCommerce_Internal_Admin_Settings_array) {
	mut var_provider_mutated := var_provider
	if rt.is_true(var_old_snapshot.array_get(rt.new_string('extension_active')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_new_snapshot.array_get(rt.new_string('extension_active')))))) {
		this.record_event('provider_extension_deactivated', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
			rt.ArrayItem{
				key: 'provider_id'
				val: var_provider_mutated.array_get(rt.new_string('id'))
			},
			rt.ArrayItem{
				key: 'suggestion_id'
				val: var_provider_mutated.array_get(rt.new_string('_suggestion_id'))
			},
			rt.ArrayItem{
				key: 'provider_extension_slug'
				val: var_provider_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug'))
			},
		])))
		if !(!rt.is_true(var_provider_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('status'))))
			&& rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders.extension_not_installed(), var_provider_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('status')))) {
			this.record_event('provider_extension_uninstalled', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
				rt.ArrayItem{
					key: 'provider_id'
					val: var_provider_mutated.array_get(rt.new_string('id'))
				},
				rt.ArrayItem{
					key: 'suggestion_id'
					val: var_provider_mutated.array_get(rt.new_string('_suggestion_id'))
				},
				rt.ArrayItem{
					key: 'provider_extension_slug'
					val: var_provider_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug'))
				},
			])))
		}
	} else if
		rt.is_true(rt.new_bool(!(rt.is_true(var_old_snapshot.array_get(rt.new_string('extension_active'))))))
		&& rt.is_true(var_new_snapshot.array_get(rt.new_string('extension_active'))) {
		this.record_event('provider_extension_activated', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
			rt.ArrayItem{
				key: 'provider_id'
				val: var_provider_mutated.array_get(rt.new_string('id'))
			},
			rt.ArrayItem{
				key: 'suggestion_id'
				val: var_provider_mutated.array_get(rt.new_string('_suggestion_id'))
			},
			rt.ArrayItem{
				key: 'provider_extension_slug'
				val: var_provider_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug'))
			},
		])))
	}
	if rt.is_true(var_old_snapshot.array_get(rt.new_string('account_connected')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_new_snapshot.array_get(rt.new_string('account_connected')))))) {
		this.record_event('provider_account_disconnected', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
			rt.ArrayItem{
				key: 'provider_id'
				val: var_provider_mutated.array_get(rt.new_string('id'))
			},
			rt.ArrayItem{
				key: 'suggestion_id'
				val: var_provider_mutated.array_get(rt.new_string('_suggestion_id'))
			},
			rt.ArrayItem{
				key: 'provider_extension_slug'
				val: var_provider_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug'))
			},
			rt.ArrayItem{
				key: 'provider_account_test_mode'
				val: if rt.is_true(var_old_snapshot.array_get(rt.new_string('account_test_mode'))) {
					'yes'
				} else {
					'no'
				}
			},
		])))
	} else if
		rt.is_true(rt.new_bool(!(rt.is_true(var_old_snapshot.array_get(rt.new_string('account_connected'))))))
		&& rt.is_true(var_new_snapshot.array_get(rt.new_string('account_connected'))) {
		this.record_event('provider_account_connected', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
			rt.ArrayItem{
				key: 'provider_id'
				val: var_provider_mutated.array_get(rt.new_string('id'))
			},
			rt.ArrayItem{
				key: 'suggestion_id'
				val: var_provider_mutated.array_get(rt.new_string('_suggestion_id'))
			},
			rt.ArrayItem{
				key: 'provider_extension_slug'
				val: var_provider_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug'))
			},
			rt.ArrayItem{
				key: 'provider_account_test_mode'
				val: if rt.is_true(var_new_snapshot.array_get(rt.new_string('account_test_mode'))) {
					'yes'
				} else {
					'no'
				}
			},
		])))
	}
	if rt.is_true(var_old_snapshot.array_get(rt.new_string('needs_setup')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_new_snapshot.array_get(rt.new_string('needs_setup')))))) {
		this.record_event('provider_setup_completed', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
			rt.ArrayItem{
				key: 'provider_id'
				val: var_provider_mutated.array_get(rt.new_string('id'))
			},
			rt.ArrayItem{
				key: 'suggestion_id'
				val: var_provider_mutated.array_get(rt.new_string('_suggestion_id'))
			},
			rt.ArrayItem{
				key: 'provider_extension_slug'
				val: var_provider_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug'))
			},
		])))
	} else if
		rt.is_true(rt.new_bool(!(rt.is_true(var_old_snapshot.array_get(rt.new_string('needs_setup'))))))
		&& rt.is_true(var_new_snapshot.array_get(rt.new_string('needs_setup'))) {
		this.record_event('provider_setup_required', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
			rt.ArrayItem{
				key: 'provider_id'
				val: var_provider_mutated.array_get(rt.new_string('id'))
			},
			rt.ArrayItem{
				key: 'suggestion_id'
				val: var_provider_mutated.array_get(rt.new_string('_suggestion_id'))
			},
			rt.ArrayItem{
				key: 'provider_extension_slug'
				val: var_provider_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug'))
			},
		])))
	}
	if rt.is_true(var_new_snapshot.array_get(rt.new_string('account_connected'))) {
		if rt.is_true(var_old_snapshot.array_get(rt.new_string('test_mode')))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_new_snapshot.array_get(rt.new_string('test_mode')))))) {
			this.record_event('provider_live_payments_enabled', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
				rt.ArrayItem{
					key: 'provider_id'
					val: var_provider_mutated.array_get(rt.new_string('id'))
				},
				rt.ArrayItem{
					key: 'suggestion_id'
					val: var_provider_mutated.array_get(rt.new_string('_suggestion_id'))
				},
				rt.ArrayItem{
					key: 'provider_extension_slug'
					val: var_provider_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug'))
				},
			])))
		} else if
			rt.is_true(rt.new_bool(!(rt.is_true(var_old_snapshot.array_get(rt.new_string('test_mode'))))))
			&& rt.is_true(var_new_snapshot.array_get(rt.new_string('test_mode'))) {
			this.record_event('provider_test_payments_enabled', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
				rt.ArrayItem{
					key: 'provider_id'
					val: var_provider_mutated.array_get(rt.new_string('id'))
				},
				rt.ArrayItem{
					key: 'suggestion_id'
					val: var_provider_mutated.array_get(rt.new_string('_suggestion_id'))
				},
				rt.ArrayItem{
					key: 'provider_extension_slug'
					val: var_provider_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug'))
				},
			])))
		}
	}
	if rt.is_true(var_new_snapshot.array_get(rt.new_string('account_connected'))) {
		if rt.is_true(var_old_snapshot.array_get(rt.new_string('account_test_mode')))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_new_snapshot.array_get(rt.new_string('account_test_mode')))))) {
			this.record_event('provider_account_live_mode_enabled', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
				rt.ArrayItem{
					key: 'provider_id'
					val: var_provider_mutated.array_get(rt.new_string('id'))
				},
				rt.ArrayItem{
					key: 'suggestion_id'
					val: var_provider_mutated.array_get(rt.new_string('_suggestion_id'))
				},
				rt.ArrayItem{
					key: 'provider_extension_slug'
					val: var_provider_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug'))
				},
			])))
		} else if
			rt.is_true(rt.new_bool(!(rt.is_true(var_old_snapshot.array_get(rt.new_string('account_test_mode'))))))
			&& rt.is_true(var_new_snapshot.array_get(rt.new_string('account_test_mode'))) {
			this.record_event('provider_account_test_mode_enabled', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](rt.create_array([
				rt.ArrayItem{
					key: 'provider_id'
					val: var_provider_mutated.array_get(rt.new_string('id'))
				},
				rt.ArrayItem{
					key: 'suggestion_id'
					val: var_provider_mutated.array_get(rt.new_string('_suggestion_id'))
				},
				rt.ArrayItem{
					key: 'provider_extension_slug'
					val: var_provider_mutated.array_get(rt.new_string('plugin')).array_get(rt.new_string('slug'))
				},
			])))
		}
	}
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_payments(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments{
		PhpObjectBase:         rt.PhpObjectBase{}
		providers:             rt.new_null()
		extension_suggestions: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_logging_safeglobalfunctionproxy(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy {
	mut obj := &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Suggestions_PaymentsExtensionSuggestions](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_payment_providers' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_payment_providers(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_payment_extension_suggestions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_payment_extension_suggestions(dispatch_arg_0)
		}
		'get_payment_extension_suggestion_categories' {
			return this.get_payment_extension_suggestion_categories()
		}
		'get_country' {
			return rt.new_string(this.get_country())
		}
		'set_country' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.set_country(dispatch_arg_0))
		}
		'update_payment_providers_order_map' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.update_payment_providers_order_map(mut dispatch_arg_0))
		}
		'attach_payment_extension_suggestion' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.attach_payment_extension_suggestion(dispatch_arg_0))
		}
		'hide_payment_extension_suggestion' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hide_payment_extension_suggestion(dispatch_arg_0))
		}
		'dismiss_extension_suggestion_incentive' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.dismiss_extension_suggestion_incentive(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'record_event' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.record_event(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'process_payment_provider_states' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.process_payment_provider_states(mut dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_track_providers_state_change' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.maybe_track_providers_state_change(mut dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2)
			return rt.new_null()
		}
		'maybe_track_provider_state_change' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.maybe_track_provider_state_change(mut dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'providers' { return this.providers }
		'extension_suggestions' { return this.extension_suggestions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Payments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'providers' {
			this.providers = val
			return true
		}
		'extension_suggestions' {
			this.extension_suggestions = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Logging_SafeGlobalFunctionProxy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
