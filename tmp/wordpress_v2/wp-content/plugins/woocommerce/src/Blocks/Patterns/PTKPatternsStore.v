import rt

pub fn Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.option_name() string {
	return 'ptk_patterns'
}

pub fn Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.fetch_patterns_action() string {
	return 'fetch_patterns'
}

pub fn Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.category_mapping() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'testimonials', val: 'reviews' }])
}

struct Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore {
	rt.PhpObjectBase
pub mut:
	ptk_client rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) construct(mut var_ptk_client Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient) {
	this.ptk_client = var_ptk_client
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('pattern-toolkit-full-composability'))
	if rt.is_true(iife_result_0) {
		rt.call_function('add_action', [rt.new_string('woocommerce_activated_plugin'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'flush_or_fetch_patterns' },
			]),
			rt.new_int(10), rt.new_int(2)])
		rt.call_function('add_action', [
			rt.new_string('update_option_woocommerce_allow_tracking'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'flush_or_fetch_patterns' },
			]),
			rt.new_int(10),
			rt.new_int(2),
		])
		rt.call_function('add_action', [rt.new_string('deactivated_plugin'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'flush_cached_patterns' },
			]),
			rt.new_int(10), rt.new_int(2)])
		rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'fetch_patterns_on_plugin_update' },
			]),
			rt.new_int(10), rt.new_int(2)])
		rt.call_function('add_action', [
			rt.new_string('action_scheduler_ensure_recurring_actions'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'ensure_recurring_fetch_patterns_if_enabled' },
			]),
		])
		rt.call_function('add_action', [
			Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.fetch_patterns_action(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'fetch_patterns' },
			]),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) flush_or_fetch_patterns() {
	if this.allowed_tracking_is_enabled() {
		this.schedule_fetch_patterns()
		return
	}
	this.flush_cached_patterns()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) schedule_fetch_patterns() {
	if rt.is_true(rt.call_function('did_action', [rt.new_string('action_scheduler_init')])) {
		this.schedule_action_if_not_pending(Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.fetch_patterns_action())
	} else {
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			this.schedule_action_if_not_pending(Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.fetch_patterns_action())
			return rt.new_null()
		}
		rt.call_function('add_action', [rt.new_string('action_scheduler_init'),
			rt.new_closure(closure_2_fn)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) ensure_recurring_fetch_patterns_if_enabled() {
	if !(this.allowed_tracking_is_enabled()) {
		return
	}
	this.schedule_action_if_not_pending(Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.fetch_patterns_action())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) schedule_action_if_not_pending(var_action rt.PhpVal) {
	if rt.is_true(rt.call_function('as_has_scheduled_action', [
		var_action.clone(), rt.new_array(), rt.new_string('woocommerce')]))
	{
		return
	}
	rt.call_function('as_schedule_recurring_action', [
		rt.call_function('time', []rt.PhpVal{}),
		rt.get_constant('DAY_IN_SECONDS'),
		var_action.clone(),
		rt.new_array(),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) get_patterns() rt.PhpVal {
	mut var_patterns := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.option_name(),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_patterns))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.ptk_client, 'is_valid_schema', [var_patterns.clone()]))))) {
		this.schedule_fetch_patterns()
		return rt.new_array()
	}
	return var_patterns.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) filter_patterns(mut var_patterns Class_Automattic_WooCommerce_Blocks_Patterns_array) rt.PhpVal {
	mut var_patterns_mutated := var_patterns
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_pattern := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_pattern.array_isset(rt.new_string('ID'))) {
			return rt.new_bool(true)
		}
		if var_pattern.array_isset(rt.new_string('post_type'))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wp_block'), var_pattern.array_get(rt.new_string('post_type')))))) {
			return rt.new_bool(false)
		}
		if this.has_external_dependencies(var_pattern.clone()) {
			return rt.new_bool(false)
		}
		return rt.new_bool(true)
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_pattern := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_pattern.array_isset(rt.new_string('ID'))) {
			return rt.new_bool(true)
		}
		if var_pattern.array_isset(rt.new_string('post_type'))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wp_block'), var_pattern.array_get(rt.new_string('post_type')))))) {
			return rt.new_bool(false)
		}
		if this.has_external_dependencies(var_pattern.clone()) {
			return rt.new_bool(false)
		}
		return rt.new_bool(true)
	}
	return rt.call_function('array_values', [
		rt.call_function('array_filter', [var_patterns_mutated, rt.new_closure(closure_3_fn)]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) fetch_patterns_on_plugin_update(var_upgrader_object rt.PhpVal, var_options rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_string('update'), var_options.array_get(rt.new_string('action'))))
		&& rt.is_true(rt.identical(rt.new_string('plugin'), var_options.array_get(rt.new_string('type'))))
		&& var_options.array_isset(rt.new_string('plugins')) {
		mut iter_1 := var_options.array_get(rt.new_string('plugins')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			if rt.is_true(rt.call_function('str_contains', [var_plugin.clone(),
				rt.new_string('woocommerce.php')]))
			{
				this.schedule_fetch_patterns()
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) flush_cached_patterns() {
	rt.call_function('delete_option', [
		Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.option_name(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('as_unschedule_all_actions'),
	])))))
	{
		return
	}
	if rt.is_true(rt.call_function('did_action', [rt.new_string('action_scheduler_init')])) {
		rt.call_function('as_unschedule_all_actions', [
			Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.fetch_patterns_action(),
			rt.new_array(),
			rt.new_string('woocommerce'),
		])
	} else {
		closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			rt.call_function('as_unschedule_all_actions', [
				Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.fetch_patterns_action(),
				rt.new_array(),
				rt.new_string('woocommerce'),
			])
			return rt.new_null()
		}
		rt.call_function('add_action', [rt.new_string('action_scheduler_init'),
			rt.new_closure(closure_5_fn)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) fetch_patterns() {
	if !(this.allowed_tracking_is_enabled()) {
		return
	}
	mut var_patterns := rt.call_method(this.ptk_client, 'fetch_patterns', [
		rt.create_array([
			rt.ArrayItem{ key: 'site', val: 'wooblockpatterns.wpcomstaging.com' },
			rt.ArrayItem{ key: 'categories', val: rt.create_array([
				rt.ArrayItem{ key: none, val: '_woo_intro' },
				rt.ArrayItem{ key: none, val: '_woo_featured_selling' },
				rt.ArrayItem{ key: none, val: '_woo_about' },
				rt.ArrayItem{ key: none, val: '_woo_reviews' },
				rt.ArrayItem{ key: none, val: '_woo_social_media' },
				rt.ArrayItem{ key: none, val: '_woo_woocommerce' },
				rt.ArrayItem{ key: none, val: '_dotcom_imported_intro' },
				rt.ArrayItem{ key: none, val: '_dotcom_imported_about' },
				rt.ArrayItem{ key: none, val: '_dotcom_imported_services' },
				rt.ArrayItem{ key: none, val: '_dotcom_imported_reviews' },
			]) },
		]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_patterns.clone()])) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Failed to get WooCommerce patterns from the PTK: "%s"'),
					rt.new_string('woocommerce'),
				]),
				rt.call_method(var_patterns, 'get_error_message', []rt.PhpVal{}),
			]),
		])
		return
	}
	var_patterns =
		this.filter_patterns(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Patterns_array](var_patterns))
	var_patterns =
		this.map_categories(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Patterns_array](var_patterns))
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.option_name(),
		var_patterns.clone(),
		rt.new_bool(false),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) allowed_tracking_is_enabled() bool {
	return (rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_allow_tracking'),
	]))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) map_categories(mut var_patterns Class_Automattic_WooCommerce_Blocks_Patterns_array) rt.PhpVal {
	mut var_patterns_mutated := var_patterns
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_pattern := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if var_pattern.array_isset(rt.new_string('categories')) {
			mut iter_2 := var_pattern.array_get(rt.new_string('categories')).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_category := item_2.val
				mut var_key := item_2.key
				if var_category.array_isset(rt.new_string('slug'))
					&& Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.category_mapping().array_isset(var_key) {
					mut var_new_category :=
						Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.category_mapping().array_get(var_key)
					var_pattern.array_get(rt.new_string('categories')).array_unset(var_key)
					var_pattern.array_get_mut('categories').array_get_mut(var_new_category).array_set('slug',
						var_new_category.clone())
					var_pattern.array_get_mut('categories').array_get_mut(var_new_category).array_set('title', rt.call_function('ucfirst', [
						var_new_category.clone(),
					]))
				}
			}
		}
		return var_pattern.clone()
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_pattern := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if var_pattern.array_isset(rt.new_string('categories')) {
			mut iter_3 := var_pattern.array_get(rt.new_string('categories')).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_category := item_3.val
				mut var_key := item_3.key
				if var_category.array_isset(rt.new_string('slug'))
					&& Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.category_mapping().array_isset(var_key) {
					mut var_new_category :=
						Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.category_mapping().array_get(var_key)
					var_pattern.array_get(rt.new_string('categories')).array_unset(var_key)
					var_pattern.array_get_mut('categories').array_get_mut(var_new_category).array_set('slug',
						var_new_category.clone())
					var_pattern.array_get_mut('categories').array_get_mut(var_new_category).array_set('title', rt.call_function('ucfirst', [
						var_new_category.clone(),
					]))
				}
			}
		}
		return var_pattern.clone()
	}
	return rt.call_function('array_map', [rt.new_closure(closure_6_fn), var_patterns_mutated])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) has_external_dependencies(var_pattern rt.PhpVal) bool {
	if !(var_pattern.array_isset(rt.new_string('dependencies')))
		|| !(var_pattern.array_get(rt.new_string('dependencies')).is_array()) {
		return false
	}
	mut iter_4 := var_pattern.array_get(rt.new_string('dependencies')).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_dependency := item_4.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce'),
			var_dependency))))
		{
			return true
		}
	}
	return false
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_patterns_ptkpatternsstore(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore{
		PhpObjectBase: rt.PhpObjectBase{}
		ptk_client:    rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'flush_or_fetch_patterns' {
			this.flush_or_fetch_patterns()
			return rt.new_null()
		}
		'schedule_fetch_patterns' {
			this.schedule_fetch_patterns()
			return rt.new_null()
		}
		'ensure_recurring_fetch_patterns_if_enabled' {
			this.ensure_recurring_fetch_patterns_if_enabled()
			return rt.new_null()
		}
		'schedule_action_if_not_pending' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.schedule_action_if_not_pending(dispatch_arg_0)
			return rt.new_null()
		}
		'get_patterns' {
			return this.get_patterns()
		}
		'filter_patterns' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Patterns_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.filter_patterns(mut dispatch_arg_0)
		}
		'fetch_patterns_on_plugin_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.fetch_patterns_on_plugin_update(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'flush_cached_patterns' {
			this.flush_cached_patterns()
			return rt.new_null()
		}
		'fetch_patterns' {
			this.fetch_patterns()
			return rt.new_null()
		}
		'allowed_tracking_is_enabled' {
			return rt.new_bool(this.allowed_tracking_is_enabled())
		}
		'map_categories' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Patterns_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.map_categories(mut dispatch_arg_0)
		}
		'has_external_dependencies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_external_dependencies(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'ptk_client' { return this.ptk_client }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'ptk_client' {
			this.ptk_client = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
