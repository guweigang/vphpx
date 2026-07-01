import rt

struct Class_Automattic_WooCommerce_Admin_ReportsSync {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_ReportsSync.init()  {
	{
		mut iter_1 := Class_Automattic_WooCommerce_Admin_ReportsSync.get_schedulers().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_scheduler := item_1.val
			fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":24,"name":"scheduler"}{}; return temp.init() }()
		}
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_update_product'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'clear_stock_count_cache' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_new_product'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'clear_stock_count_cache' }])])
	rt.call_function('add_action', [rt.new_string('update_option_woocommerce_notify_low_stock_amount'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'clear_stock_count_cache' }])])
	rt.call_function('add_action', [rt.new_string('update_option_woocommerce_notify_no_stock_amount'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'clear_stock_count_cache' }])])
	rt.call_function('add_action', [rt.new_string('trashed_post'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_clear_stock_count_cache_for_post' }])])
	rt.call_function('add_action', [rt.new_string('untrashed_post'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_clear_stock_count_cache_for_post' }])])
	rt.call_function('add_action', [rt.new_string('delete_post'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_clear_stock_count_cache_for_post' }])])
}

fn Class_Automattic_WooCommerce_Admin_ReportsSync.get_schedulers() rt.PhpVal {
	mut var_schedulers := rt.call_function('apply_filters', [rt.new_string('woocommerce_analytics_report_schedulers'), rt.create_array([rt.ArrayItem{ key: none, val: create_automattic_woocommerce_internal_admin_schedulers_customersscheduler() }, rt.ArrayItem{ key: none, val: create_automattic_woocommerce_internal_admin_schedulers_ordersscheduler() }])])
	{
		mut iter_1 := var_schedulers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_scheduler := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subclass_of', [var_scheduler.dup(), rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Schedulers\\ImportScheduler')]))))) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Admin_Exception', []string{}, create_automattic_woocommerce_admin_exception(rt.call_function('__', [rt.new_string('Report sync schedulers should be derived from the Automattic\\WooCommerce\\Internal\\Admin\\Schedulers\\ImportScheduler class.'), rt.new_string('woocommerce')]))))
			}
		}
	}
	return var_schedulers.dup()
}

fn Class_Automattic_WooCommerce_Admin_ReportsSync.is_importing() bool {
	{
		mut iter_1 := Class_Automattic_WooCommerce_Admin_ReportsSync.get_schedulers().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_scheduler := item_1.val
			if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":66,"name":"scheduler"}{}; return temp.is_importing() }()) {
				return true
			}
		}
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_ReportsSync.regenerate_report_data(var_days rt.PhpVal, var_skip_existing rt.PhpVal) rt.PhpVal {
	if rt.is_true(Class_Automattic_WooCommerce_Admin_ReportsSync.is_importing()) {
		return create_automattic_woocommerce_admin_wp_error(rt.new_string('wc_admin_import_in_progress'), rt.call_function('__', [rt.new_string('An import is already in progress. Please allow the previous import to complete before beginning a new one.'), rt.new_string('woocommerce')]))
	}
	Class_Automattic_WooCommerce_Admin_ReportsSync.reset_import_stats(var_days.dup(), var_skip_existing.dup())
	{
		mut iter_1 := Class_Automattic_WooCommerce_Admin_ReportsSync.get_schedulers().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_scheduler := item_1.val
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":87,"name":"scheduler"}{}; return temp.schedule_action(arg_0, arg_1) }(rt.new_string('import_batch_init'), rt.create_array([rt.ArrayItem{ key: none, val: var_days }, rt.ArrayItem{ key: none, val: var_skip_existing }]))
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_analytics_regenerate_init'), var_days.dup(), var_skip_existing.dup()])
	return rt.call_function('__', [rt.new_string('Report table data is being rebuilt. Please allow some time for data to fully populate.'), rt.new_string('woocommerce')])
}

fn Class_Automattic_WooCommerce_Admin_ReportsSync.reset_import_stats(var_days rt.PhpVal, var_skip_existing rt.PhpVal)  {
	mut var_import_stats := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_stats_option(), rt.new_array()])
	mut var_totals := Class_Automattic_WooCommerce_Admin_ReportsSync.get_import_totals(var_days.dup(), var_skip_existing.dup())
	{
		mut iter_1 := Class_Automattic_WooCommerce_Admin_ReportsSync.get_schedulers().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_scheduler := item_1.val
			var_import_stats.array_get_mut(// unsupported expression: Expr_StaticPropertyFetch).array_set('imported', 0)
			var_import_stats.array_get_mut(// unsupported expression: Expr_StaticPropertyFetch).array_set('total', var_totals.array_get(// unsupported expression: Expr_StaticPropertyFetch))
		}
	}
	mut var_previous_import_date := if var_import_stats.array_isset(rt.new_string('imported_from')) { var_import_stats.array_get('imported_from') } else { rt.new_null() }
	mut var_current_import_date := if rt.is_true(var_days) { rt.call_function('gmdate', [rt.new_string('Y-m-d 00:00:00'), rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.get_constant('DAY_IN_SECONDS'), var_days))]) } else { // unsupported expression: Expr_UnaryMinus }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_previous_import_date)))) || rt.is_true(rt.identical(// unsupported expression: Expr_UnaryMinus, var_current_import_date)))) || rt.is_true(rt.greater(create_automattic_woocommerce_admin_datetime(var_previous_import_date.dup()), create_automattic_woocommerce_admin_datetime(var_current_import_date.dup()))))) {
		var_import_stats.array_set('imported_from', var_current_import_date.dup())
	}
	rt.call_function('update_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_stats_option(), var_import_stats.dup()])
}

fn Class_Automattic_WooCommerce_Admin_ReportsSync.get_import_stats() rt.PhpVal {
	mut var_import_stats := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_stats_option(), rt.new_array()])
	var_import_stats.array_set('is_importing', Class_Automattic_WooCommerce_Admin_ReportsSync.is_importing())
	return var_import_stats.dup()
}

fn Class_Automattic_WooCommerce_Admin_ReportsSync.get_import_totals(var_days rt.PhpVal, var_skip_existing rt.PhpVal) rt.PhpVal {
	mut var_totals := rt.new_array()
	{
		mut iter_1 := Class_Automattic_WooCommerce_Admin_ReportsSync.get_schedulers().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_scheduler := item_1.val
			mut var_items := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":150,"name":"scheduler"}{}; return temp.get_items(arg_0, arg_1, arg_2, arg_3) }(rt.new_int(1), rt.new_int(1), var_days.dup(), var_skip_existing.dup())
			var_totals.array_set(// unsupported expression: Expr_StaticPropertyFetch, rt.get_property(var_items, 'total'))
		}
	}
	return var_totals.dup()
}

fn Class_Automattic_WooCommerce_Admin_ReportsSync.clear_queued_actions()  {
	{
		mut iter_1 := Class_Automattic_WooCommerce_Admin_ReportsSync.get_schedulers().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_scheduler := item_1.val
			fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":162,"name":"scheduler"}{}; return temp.clear_queued_actions() }()
		}
	}
}

fn Class_Automattic_WooCommerce_Admin_ReportsSync.delete_report_data() rt.PhpVal {
	Class_Automattic_WooCommerce_Admin_ReportsSync.clear_queued_actions()
	{
		mut iter_1 := Class_Automattic_WooCommerce_Admin_ReportsSync.get_schedulers().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_scheduler := item_1.val
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":176,"name":"scheduler"}{}; return temp.schedule_action(arg_0, arg_1) }(rt.new_string('delete_batch_init'), rt.new_array())
		}
	}
	rt.call_function('delete_option', [Class_Automattic_WooCommerce_Internal_Admin_Schedulers_ImportScheduler.import_stats_option()])
	return rt.call_function('__', [rt.new_string('Report table data is being deleted.'), rt.new_string('woocommerce')])
}

fn Class_Automattic_WooCommerce_Admin_ReportsSync.maybe_clear_stock_count_cache_for_post(var_post_id rt.PhpVal)  {
	mut var_post := rt.call_function('get_post', [var_post_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(var_post) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)])))) {
		Class_Automattic_WooCommerce_Admin_ReportsSync.clear_stock_count_cache(var_post_id.dup())
	}
}

fn Class_Automattic_WooCommerce_Admin_ReportsSync.clear_stock_count_cache(var_id rt.PhpVal)  {
	rt.call_function('delete_transient', [rt.new_string('wc_admin_stock_count_lowstock')])
	rt.call_function('delete_transient', [rt.new_string('wc_admin_product_count')])
	mut var_status_options := rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})
	{
		mut iter_1 := var_status_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			mut var_status := item_1.key
			rt.call_function('delete_transient', ['wc_admin_stock_count_' + (var_status).str()])
		}
	}
}

struct Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":24,"name":"scheduler"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":66,"name":"scheduler"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":87,"name":"scheduler"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_DateTime {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":150,"name":"scheduler"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":162,"name":"scheduler"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":176,"name":"scheduler"} {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_reportssync() &Class_Automattic_WooCommerce_Admin_ReportsSync {
	mut obj := &Class_Automattic_WooCommerce_Admin_ReportsSync{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_{"nodetype":"expr_variable","line":24,"name":"scheduler"}() &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":24,"name":"scheduler"} {
	mut obj := &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":24,"name":"scheduler"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_customersscheduler() &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_schedulers_ordersscheduler() &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_exception() &Class_Automattic_WooCommerce_Admin_Exception {
	mut obj := &Class_Automattic_WooCommerce_Admin_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_{"nodetype":"expr_variable","line":66,"name":"scheduler"}() &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":66,"name":"scheduler"} {
	mut obj := &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":66,"name":"scheduler"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_wp_error() &Class_Automattic_WooCommerce_Admin_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_{"nodetype":"expr_variable","line":87,"name":"scheduler"}() &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":87,"name":"scheduler"} {
	mut obj := &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":87,"name":"scheduler"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_datetime() &Class_Automattic_WooCommerce_Admin_DateTime {
	mut obj := &Class_Automattic_WooCommerce_Admin_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_{"nodetype":"expr_variable","line":150,"name":"scheduler"}() &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":150,"name":"scheduler"} {
	mut obj := &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":150,"name":"scheduler"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_{"nodetype":"expr_variable","line":162,"name":"scheduler"}() &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":162,"name":"scheduler"} {
	mut obj := &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":162,"name":"scheduler"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_{"nodetype":"expr_variable","line":176,"name":"scheduler"}() &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":176,"name":"scheduler"} {
	mut obj := &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":176,"name":"scheduler"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportsSync) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Admin_ReportsSync.init()
			return rt.new_null()
		}
		'get_schedulers' {
			return Class_Automattic_WooCommerce_Admin_ReportsSync.get_schedulers()
		}
		'is_importing' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_ReportsSync.is_importing())
		}
		'regenerate_report_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_ReportsSync.regenerate_report_data(dispatch_arg_0, dispatch_arg_1)
		}
		'reset_import_stats' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_ReportsSync.reset_import_stats(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_import_stats' {
			return Class_Automattic_WooCommerce_Admin_ReportsSync.get_import_stats()
		}
		'get_import_totals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_ReportsSync.get_import_totals(dispatch_arg_0, dispatch_arg_1)
		}
		'clear_queued_actions' {
			Class_Automattic_WooCommerce_Admin_ReportsSync.clear_queued_actions()
			return rt.new_null()
		}
		'delete_report_data' {
			return Class_Automattic_WooCommerce_Admin_ReportsSync.delete_report_data()
		}
		'maybe_clear_stock_count_cache_for_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_ReportsSync.maybe_clear_stock_count_cache_for_post(dispatch_arg_0)
			return rt.new_null()
		}
		'clear_stock_count_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_ReportsSync.clear_stock_count_cache(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_ReportsSync) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportsSync) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":24,"name":"scheduler"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":24,"name":"scheduler"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":24,"name":"scheduler"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_CustomersScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Schedulers_OrdersScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":66,"name":"scheduler"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":66,"name":"scheduler"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":66,"name":"scheduler"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":87,"name":"scheduler"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":87,"name":"scheduler"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":87,"name":"scheduler"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":150,"name":"scheduler"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":150,"name":"scheduler"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":150,"name":"scheduler"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":162,"name":"scheduler"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":162,"name":"scheduler"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":162,"name":"scheduler"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":176,"name":"scheduler"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":176,"name":"scheduler"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_{"nodeType":"Expr_Variable","line":176,"name":"scheduler"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_reportssync_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
