import rt

pub fn Class_WC_Admin_Marketplace_Promotions.cron_name() string {
	return 'woocommerce_marketplace_cron_fetch_promotions'
}
pub fn Class_WC_Admin_Marketplace_Promotions.transient_name() string {
	return 'woocommerce_marketplace_promotions_v2'
}
pub fn Class_WC_Admin_Marketplace_Promotions.transient_life_span() rt.PhpVal {
	return rt.get_constant('DAY_IN_SECONDS')
}
pub fn Class_WC_Admin_Marketplace_Promotions.promotions_api_url() string {
	return 'https://woocommerce.com/wp-json/wccom-extensions/3.0/promotions'
}
struct Class_WC_Admin_Marketplace_Promotions {
	rt.PhpObjectBase
pub mut:
		locale rt.PhpVal = rt.new_null()
}

fn Class_WC_Admin_Marketplace_Promotions.init()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_marketplace_fetch_promotions'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'clear_deprecated_action' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_marketplace_fetch_promotions_clear'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'clear_deprecated_scheduled_event' }])])
	rt.call_function('add_action', [Class_WC_Admin_Marketplace_Promotions.cron_name(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'update_promotions' }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('DOING_AJAX')])) && rt.is_true(rt.get_constant('DOING_AJAX')))) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('DOING_CRON')])) && rt.is_true(rt.get_constant('DOING_CRON')))))) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')])) && rt.is_true(rt.get_constant('WP_CLI')))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	Class_WC_Admin_Marketplace_Promotions.schedule_cron_event()
	rt.call_function('register_deactivation_hook', [rt.get_constant('WC_PLUGIN_FILE'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'clear_cron_event' }])])
	// unsupported assign target: Expr_StaticPropertyFetch
	Class_WC_Admin_Marketplace_Promotions.maybe_show_bubble_promotions()
}

fn Class_WC_Admin_Marketplace_Promotions.schedule_cron_event()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [Class_WC_Admin_Marketplace_Promotions.cron_name()]))))) {
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}), rt.new_string('twicedaily'), Class_WC_Admin_Marketplace_Promotions.cron_name()])
	}
}

fn Class_WC_Admin_Marketplace_Promotions.update_promotions()  {
	mut var_promotions := Class_WC_Admin_Marketplace_Promotions.fetch_marketplace_promotions()
	rt.call_function('set_transient', [Class_WC_Admin_Marketplace_Promotions.transient_name(), var_promotions.dup(), Class_WC_Admin_Marketplace_Promotions.transient_life_span()])
}

fn Class_WC_Admin_Marketplace_Promotions.get_active_promotions() rt.PhpVal {
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_marketplace_suppress_promotions'), rt.new_bool(false)])) {
		return rt.new_array()
	}
	mut var_promotions := rt.call_function('get_transient', [Class_WC_Admin_Marketplace_Promotions.transient_name()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_promotions)))) {
		return rt.new_array()
	}
	var_promotions = Class_WC_Admin_Marketplace_Promotions.merge_promos(mut rt.cast_object_ptr[Class_?array](var_promotions))
	return Class_WC_Admin_Marketplace_Promotions.filter_out_inactive_promotions(var_promotions.dup())
}

fn Class_WC_Admin_Marketplace_Promotions.fetch_marketplace_promotions() rt.PhpVal {
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_marketplace_suppress_promotions'), rt.new_bool(false)])) {
		return rt.new_array()
	}
	mut var_fetch_options := { 'auth': true, 'country': true }
	mut var_raw_promotions := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Addons{}; return temp.fetch(arg_0, arg_1) }(rt.new_string(Class_WC_Admin_Marketplace_Promotions.promotions_api_url()), var_fetch_options.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_raw_promotions.dup()])) {
		rt.call_function('do_action', [rt.new_string('woocommerce_page_wc-addons_connection_error'), rt.call_method(var_raw_promotions, 'get_error_message', []rt.PhpVal{})])
	}
	mut var_response_code := // unsupported expression: Expr_Cast_Int
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('do_action', [rt.new_string('woocommerce_page_wc-addons_connection_error'), var_response_code.dup()])
	}
	mut var_promotions := rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_raw_promotions.dup()]), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_promotions.dup().is_array()))))) {
		var_promotions = rt.new_array()
		rt.call_function('do_action', [rt.new_string('woocommerce_page_wc-addons_connection_error'), rt.new_string('Malformed response')])
	}
	return var_promotions.dup()
}

fn Class_WC_Admin_Marketplace_Promotions.maybe_show_bubble_promotions()  {
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_marketplace_suppress_promotions'), rt.new_bool(false)])) {
		return rt.new_null()
	}
	mut var_promotions := rt.call_function('get_transient', [Class_WC_Admin_Marketplace_Promotions.transient_name()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_promotions)))) {
		return rt.new_null()
	}
	mut var_bubble_promotions := Class_WC_Admin_Marketplace_Promotions.get_promotions_of_format(var_promotions.dup(), 'menu_bubble')
	if !rt.is_true(var_bubble_promotions) {
		return rt.new_null()
	}
	mut var_now_date_time := create_datetime(rt.new_string('now'), create_datetimezone(rt.new_string('UTC')))
	{
		mut iter_1 := var_bubble_promotions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_promotion := item_1.val
			if !(var_promotion.array_isset(rt.new_string('date_to_gmt'))) {
				continue
			}
			mut var_date_to_gmt := create_datetime(var_promotion.array_get('date_to_gmt'), create_datetimezone(rt.new_string('UTC')))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Exception') {
				mut var_ex := var_e_1.dup()
				continue
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
			if rt.is_true(rt.less(var_now_date_time, var_date_to_gmt)) {
				closure_1_fn := fn [var_promotion] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_marketplace_pages := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return Class_WC_Admin_Marketplace_Promotions.filter_marketplace_menu_items(var_marketplace_pages.dup(), var_promotion.dup())
	}
				rt.call_function('add_filter', [rt.new_string('woocommerce_marketplace_menu_items'), rt.new_closure(closure_1_fn)])
				break
			}
		}
	}
}

fn Class_WC_Admin_Marketplace_Promotions.get_promotions_of_format(var_promotions rt.PhpVal, format string) rt.PhpVal {
	mut var_promotions_mutated := var_promotions
	if !rt.is_true(var_promotions_mutated) || format == '' {
		return rt.new_array()
	}
	closure_2_fn := fn [var_format] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_promotion := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(var_promotion.array_isset(rt.new_string('format')) && rt.is_true(rt.identical(rt.new_string(format), var_promotion.array_get('format'))))
	}
	return rt.call_function('array_filter', [var_promotions_mutated.dup(), rt.new_closure(closure_2_fn)])
}

fn Class_WC_Admin_Marketplace_Promotions.filter_out_inactive_promotions(var_promotions rt.PhpVal) rt.PhpVal {
	mut var_promotions_mutated := var_promotions
	mut var_now_date_time := create_datetime(rt.new_string('now'), create_datetimezone(rt.new_string('UTC')))
	mut var_active_promotions := rt.new_array()
	{
		mut iter_1 := var_promotions_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_promotion := item_1.val
			if !(var_promotion.array_isset(rt.new_string('date_from_gmt'))) || !(var_promotion.array_isset(rt.new_string('date_to_gmt'))) {
				continue
			}
			mut var_date_from_gmt := create_datetime(var_promotion.array_get('date_from_gmt'), create_datetimezone(rt.new_string('UTC')))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			mut var_date_to_gmt := create_datetime(var_promotion.array_get('date_to_gmt'), create_datetimezone(rt.new_string('UTC')))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			unsafe { goto end_label_2 }

catch_label_2:
			mut var_e_2 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_2, 'Exception') {
				mut var_ex := var_e_2.dup()
				continue
				unsafe { goto end_label_2 }
			}
			else {
				rt.throw_exception(var_e_2)
				unsafe { goto end_label_2 }
			}

end_label_2:
			if rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_now_date_time, var_date_from_gmt)) && rt.is_true(rt.less_equal(var_now_date_time, var_date_to_gmt)))) {
				var_active_promotions << var_promotion.dup()
			}
		}
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return // unsupported expression: Expr_BinaryOp_Spaceship
	}
	rt.call_function('usort', [var_active_promotions.dup(), rt.new_closure(closure_3_fn)])
	return var_active_promotions.dup()
}

fn Class_WC_Admin_Marketplace_Promotions.merge_promos(mut var_promotions Class_?array) rt.PhpVal {
	mut var_promotions_mutated := var_promotions
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_promotions_mutated.array_get('promos'))) && rt.is_true(rt.new_bool(var_promotions_mutated.array_get('promos').is_array())))) {
		var_promotions_mutated = rt.call_function('array_merge', [var_promotions_mutated.dup(), var_promotions_mutated.array_get('promos')])
		var_promotions_mutated.array_unset(rt.new_string('promos'))
	}
	return rt.new_object('?array', []string{}, var_promotions_mutated)
}

fn Class_WC_Admin_Marketplace_Promotions.filter_marketplace_menu_items(var_menu_items rt.PhpVal, var_promotion rt.PhpVal) rt.PhpVal {
	if !(var_promotion.array_isset(rt.new_string('menu_item_id'))) || !(var_promotion.array_isset(rt.new_string('content'))) {
		return var_menu_items.dup()
	}
	{
		mut iter_1 := var_menu_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_menu_item := item_1.val
			mut var_index := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('woocommerce'), var_menu_item.array_get('parent'))) && rt.is_true(rt.identical(var_promotion.array_get('menu_item_id'), var_menu_item.array_get('id'))))) {
				mut var_bubble_text := if !(var_promotion.array_get('content').array_get(// unsupported expression: Expr_StaticPropertyFetch)).is_null() { var_promotion.array_get('content').array_get(// unsupported expression: Expr_StaticPropertyFetch) } else { if !(var_promotion.array_get('content').array_get('en_US')).is_null() { var_promotion.array_get('content').array_get('en_US') } else { rt.call_function('__', [rt.new_string('Sale'), rt.new_string('woocommerce')]) } }
				var_menu_items.array_get_mut(var_index).array_set('title', Class_WC_Admin_Marketplace_Promotions.append_bubble((var_menu_item.array_get('title')).str(), (var_bubble_text).str()))
				break
			}
		}
	}
	return var_menu_items.dup()
}

fn Class_WC_Admin_Marketplace_Promotions.append_bubble(menu_item_text string, bubble_text string) string {
	mut menu_item_text_mutated := menu_item_text
	mut bubble_text_mutated := bubble_text
	menu_item_text_mutated = (rt.call_function('preg_replace', [rt.new_string('|<span class="update-plugins count-[\\d]+">[A-z0-9 <>="-]+</span>|'), rt.new_string(''), rt.new_string(menu_item_text_mutated).dup()])).str()
	return menu_item_text_mutated + '<span class="update-plugins remaining-tasks-badge woocommerce-task-list-remaining-tasks-badge">' + (rt.call_function('esc_html', [rt.new_string(bubble_text_mutated).dup()])).str() + '</span>'
}

fn Class_WC_Admin_Marketplace_Promotions.clear_cron_event()  {
	mut var_timestamp := rt.call_function('wp_next_scheduled', [Class_WC_Admin_Marketplace_Promotions.cron_name()])
	rt.call_function('wp_unschedule_event', [var_timestamp.dup(), Class_WC_Admin_Marketplace_Promotions.cron_name()])
}

fn Class_WC_Admin_Marketplace_Promotions.clear_deprecated_scheduled_event()  {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('as_unschedule_all_actions')])) {
		rt.call_function('as_unschedule_all_actions', [rt.new_string('woocommerce_marketplace_fetch_promotions')])
	}
}

fn Class_WC_Admin_Marketplace_Promotions.clear_deprecated_action()  {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('as_schedule_single_action')])) {
		rt.call_function('as_schedule_single_action', [rt.call_function('time', []rt.PhpVal{}), rt.new_string('woocommerce_marketplace_fetch_promotions_clear')])
	}
}

struct Class_WC_Admin_Addons {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

fn create_wc_admin_marketplace_promotions() &Class_WC_Admin_Marketplace_Promotions {
	mut obj := &Class_WC_Admin_Marketplace_Promotions{
		PhpObjectBase: rt.PhpObjectBase{}
		locale: rt.new_null()
	}
	return obj
}

fn create_wc_admin_addons() &Class_WC_Admin_Addons {
	mut obj := &Class_WC_Admin_Addons{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime() &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone() &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Marketplace_Promotions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Admin_Marketplace_Promotions.init()
			return rt.new_null()
		}
		'schedule_cron_event' {
			Class_WC_Admin_Marketplace_Promotions.schedule_cron_event()
			return rt.new_null()
		}
		'update_promotions' {
			Class_WC_Admin_Marketplace_Promotions.update_promotions()
			return rt.new_null()
		}
		'get_active_promotions' {
			return Class_WC_Admin_Marketplace_Promotions.get_active_promotions()
		}
		'fetch_marketplace_promotions' {
			return Class_WC_Admin_Marketplace_Promotions.fetch_marketplace_promotions()
		}
		'maybe_show_bubble_promotions' {
			Class_WC_Admin_Marketplace_Promotions.maybe_show_bubble_promotions()
			return rt.new_null()
		}
		'get_promotions_of_format' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_WC_Admin_Marketplace_Promotions.get_promotions_of_format(dispatch_arg_0, dispatch_arg_1)
		}
		'filter_out_inactive_promotions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Admin_Marketplace_Promotions.filter_out_inactive_promotions(dispatch_arg_0)
		}
		'merge_promos' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WC_Admin_Marketplace_Promotions.merge_promos(mut dispatch_arg_0)
		}
		'filter_marketplace_menu_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Admin_Marketplace_Promotions.filter_marketplace_menu_items(dispatch_arg_0, dispatch_arg_1)
		}
		'append_bubble' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_WC_Admin_Marketplace_Promotions.append_bubble(dispatch_arg_0, dispatch_arg_1))
		}
		'clear_cron_event' {
			Class_WC_Admin_Marketplace_Promotions.clear_cron_event()
			return rt.new_null()
		}
		'clear_deprecated_scheduled_event' {
			Class_WC_Admin_Marketplace_Promotions.clear_deprecated_scheduled_event()
			return rt.new_null()
		}
		'clear_deprecated_action' {
			Class_WC_Admin_Marketplace_Promotions.clear_deprecated_action()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Admin_Marketplace_Promotions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'locale' { return this.locale }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_Marketplace_Promotions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'locale' { this.locale = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Admin_Addons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Addons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Addons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_marketplace_promotions_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Admin_Marketplace_Promotions' }, rt.ArrayItem{ key: none, val: 'init' }])]))))) {
		rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Admin_Marketplace_Promotions' }, rt.ArrayItem{ key: none, val: 'init' }]), rt.new_int(11)])
	}
}
