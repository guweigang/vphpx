import rt

pub fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.filter_name() string {
	return 'data_source_poller_data_sources'
}
pub fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.filter_name_specs() string {
	return 'data_source_poller_specs'
}
struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller {
	rt.PhpObjectBase
pub mut:
		id rt.PhpVal = rt.new_array()
		data_sources rt.PhpVal = rt.new_array()
		args rt.PhpVal = rt.new_array()
		logger rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.get_instance()  {
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) construct(var_id rt.PhpVal, var_data_sources rt.PhpVal, var_args rt.PhpVal)  {
	mut var_id_mutated := var_id
	mut var_data_sources_mutated := var_data_sources
	this.data_sources = var_data_sources_mutated.dup()
	this.id = var_id_mutated.dup()
	mut var_arg_defaults := rt.create_array([rt.ArrayItem{ key: 'spec_key', val: 'id' }, rt.ArrayItem{ key: 'transient_name', val: 'woocommerce_admin_' + (var_id_mutated).str() + '_specs' }, rt.ArrayItem{ key: 'transient_expiry', val: rt.mul(rt.new_int(7), rt.get_constant('DAY_IN_SECONDS')) }])
	this.args = rt.call_function('wp_parse_args', [var_args.dup(), var_arg_defaults.dup()])
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.get_logger() rt.PhpVal {
	if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_null())) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) get_spec_key(var_spec rt.PhpVal) bool {
	mut var_key := this.args.array_get('spec_key')
	if !(rt.get_property(var_spec, '{"nodeType":"Expr_Variable","line":95,"name":"key"}')).is_null() {
		return (rt.get_property(var_spec, '{"nodeType":"Expr_Variable","line":96,"name":"key"}')).to_bool()
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) get_specs_from_data_sources() rt.PhpVal {
	mut var_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	mut var_specs_group := if !(rt.call_function('get_transient', [this.args.array_get('transient_name')])).is_null() { rt.call_function('get_transient', [this.args.array_get('transient_name')]) } else { rt.new_array() }
	mut var_specs := if var_specs_group.array_isset(var_locale) { var_specs_group.array_get(var_locale) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_specs.dup().is_array()))))) {
		this.read_specs_from_data_sources()
		var_specs_group = rt.call_function('get_transient', [this.args.array_get('transient_name')])
		var_specs = if var_specs_group.array_isset(var_locale) { var_specs_group.array_get(var_locale) } else { rt.new_array() }
	}
	var_specs = rt.call_function('apply_filters', [Class_Automattic_WooCommerce_Admin_RemoteSpecs_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.filter_name_specs(), var_specs.dup(), this.id])
	return if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_specs } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) get_cached_specs() rt.PhpVal {
	mut var_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	mut var_specs_group := if !(rt.call_function('get_transient', [this.args.array_get('transient_name')])).is_null() { rt.call_function('get_transient', [this.args.array_get('transient_name')]) } else { rt.new_array() }
	mut var_specs := if var_specs_group.array_isset(var_locale) { var_specs_group.array_get(var_locale) } else { rt.new_null() }
	var_specs = rt.call_function('apply_filters', [Class_Automattic_WooCommerce_Admin_RemoteSpecs_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.filter_name_specs(), var_specs.dup(), this.id])
	return if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_specs } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) read_specs_from_data_sources() bool {
	mut var_specs := rt.new_array()
	mut var_data_sources := rt.call_function('apply_filters', [Class_Automattic_WooCommerce_Admin_RemoteSpecs_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.filter_name(), this.data_sources, this.id])
	{
		mut iter_1 := var_data_sources.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_url := item_1.val
			mut var_specs_from_data_source := Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.read_data_source(var_url.dup())
			this.merge_specs(var_specs_from_data_source.dup(), var_specs.dup(), var_url.dup())
		}
	}
	if var_specs.dup().array_count() == 0 {
		return false
	}
	mut var_specs_group := rt.call_function('get_transient', [this.args.array_get('transient_name')])
	var_specs_group = if rt.is_true(rt.new_bool(var_specs_group.dup().is_array())) { var_specs_group } else { rt.new_array() }
	mut var_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	var_specs_group.array_set(var_locale, var_specs.dup())
	this.set_specs_transient(var_specs_group.dup(), (this.args.array_get('transient_expiry')).to_i64())
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) delete_specs_transient() rt.PhpVal {
	return rt.call_function('delete_transient', [this.args.array_get('transient_name')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) set_specs_transient(var_specs rt.PhpVal, expiration i64)  {
	mut var_specs_mutated := var_specs
	rt.call_function('set_transient', [this.args.array_get('transient_name'), var_specs_mutated.dup(), rt.new_int(expiration)])
}

fn Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.read_data_source(var_url rt.PhpVal) rt.PhpVal {
	mut var_logger_context := rt.create_array([rt.ArrayItem{ key: 'source', val: var_url }])
	mut var_logger := Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.get_logger()
	mut var_response := rt.call_function('wp_remote_get', [rt.call_function('add_query_arg', [rt.new_string('locale'), rt.call_function('get_user_locale', []rt.PhpVal{}), var_url.dup()]), rt.create_array([rt.ArrayItem{ key: 'timeout', val: rt.call_function('max', [rt.new_int(1), rt.call_function('absint', [rt.call_function('apply_filters', [rt.new_string('woocommerce_data_source_poller_timeout'), rt.new_int(3)])])]) }, rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' + (rt.get_constant('WC_VERSION')).str() + '; ' + (rt.call_function('home_url', [rt.new_string('/')])).str() }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) || !(var_response.array_isset(rt.new_string('body'))))) {
		rt.call_method(var_logger, 'error', [rt.new_string('Error getting data feed'), var_logger_context.dup()])
		rt.call_method(var_logger, 'error', [println(var_response.dup().to_string()), var_logger_context.dup()])
		return rt.new_array()
	}
	mut var_body := var_response.array_get('body')
	mut var_specs := rt.call_function('json_decode', [var_body.dup()])
	if rt.is_true(rt.identical(rt.new_null(), var_specs)) {
		rt.call_method(var_logger, 'error', [rt.new_string('Empty response in data feed'), var_logger_context.dup()])
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_specs.dup().is_array()))))) {
		rt.call_method(var_logger, 'error', [rt.new_string('Data feed is not an array'), var_logger_context.dup()])
		return rt.new_array()
	}
	return var_specs.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) merge_specs(var_specs_to_merge_in rt.PhpVal, var_specs rt.PhpVal, var_url rt.PhpVal)  {
	mut var_specs_mutated := var_specs
	{
		mut iter_1 := var_specs_to_merge_in.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_spec := item_1.val
			if !(this.validate_spec(var_spec.dup(), var_url.dup())) {
				continue
			}
			mut var_id := rt.new_bool(this.get_spec_key(var_spec.dup()))
			var_specs_mutated.array_set(var_id, var_spec.dup())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) validate_spec(var_spec rt.PhpVal, var_url rt.PhpVal) bool {
	mut var_logger := Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.get_logger()
	mut var_logger_context := rt.create_array([rt.ArrayItem{ key: 'source', val: var_url }])
	if !(this.get_spec_key(var_spec.dup())) {
		rt.call_method(var_logger, 'error', [rt.new_string('Spec is invalid because the id is missing in feed'), var_logger_context.dup()])
		rt.call_method(var_logger, 'error', [println(var_spec.dup().to_string()), var_logger_context.dup()])
		return false
	}
	return true
}

fn create_automattic_woocommerce_admin_remotespecs_datasourcepoller(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
		id: rt.new_array()
		data_sources: rt.new_array()
		args: rt.new_array()
		logger: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.get_instance()
			return rt.new_null()
		}
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_logger' {
			return Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.get_logger()
		}
		'get_spec_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_spec_key(dispatch_arg_0))
		}
		'get_specs_from_data_sources' {
			return this.get_specs_from_data_sources()
		}
		'get_cached_specs' {
			return this.get_cached_specs()
		}
		'read_specs_from_data_sources' {
			return rt.new_bool(this.read_specs_from_data_sources())
		}
		'delete_specs_transient' {
			return this.delete_specs_transient()
		}
		'set_specs_transient' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.set_specs_transient(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'read_data_source' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.read_data_source(dispatch_arg_0)
		}
		'merge_specs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.merge_specs(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'validate_spec' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.validate_spec(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'data_sources' { return this.data_sources }
		'args' { return this.args }
		'logger' { return this.logger }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' { this.id = val; return true }
		'data_sources' { this.data_sources = val; return true }
		'args' { this.args = val; return true }
		'logger' { this.logger = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_admin_remotespecs_datasourcepoller_php() {
}
