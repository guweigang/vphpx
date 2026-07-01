import rt
import crypto.md5

pub fn Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger.block_added() string {
	return 'block_added'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger.block_removed() string {
	return 'block_removed'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger.block_modified() string {
	return 'block_modified'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger.block_added_to_detached_container() string {
	return 'block_added_to_detached_container'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger.hide_condition_added() string {
	return 'hide_condition_added'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger.hide_condition_removed() string {
	return 'hide_condition_removed'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger.hide_condition_added_to_detached_block() string {
	return 'hide_condition_added_to_detached_block'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger.error_after_block_added() string {
	return 'error_after_block_added'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger.error_after_block_removed() string {
	return 'error_after_block_removed'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger.log_hash_transient_base_name() string {
	return 'wc_block_template_events_log_hash_'
}
struct Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger {
	rt.PhpObjectBase
pub mut:
		event_types rt.PhpVal = rt.new_array()
		instance rt.PhpVal = rt.new_null()
		logger rt.PhpVal = rt.new_null()
		all_template_events rt.PhpVal = rt.new_array()
		templates rt.PhpVal = rt.new_array()
		threshold_severity rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) construct()  {
	this.logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
	mut var_threshold := rt.call_function('get_option', [rt.new_string('woocommerce_block_template_logging_threshold'), Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_WC_Log_Levels.warning()])
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_WC_Log_Levels{}; return temp.is_valid_level(arg_0) }(var_threshold.dup()))))) {
		var_threshold = Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_WC_Log_Levels.info()
	}
	this.threshold_severity = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_WC_Log_Levels{}; return temp.get_level_severity(arg_0) }(var_threshold.dup())
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_block := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_is_detached := rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('method_exists', [rt.call_method(var_block, 'get_parent', []rt.PhpVal{}), rt.new_string('is_detached')])) && rt.is_true(rt.call_method(rt.call_method(var_block, 'get_parent', []rt.PhpVal{}), 'is_detached', []rt.PhpVal{}))))
	this.log((if rt.is_true(var_is_detached) { Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_{"nodeType":"Expr_Variable","line":136,"name":"this"}.block_added_to_detached_container() } else { Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_{"nodeType":"Expr_Variable","line":137,"name":"this"}.block_added() }).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface](var_block), rt.new_null())
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_block_template_after_add_block'), rt.new_closure(closure_1_fn), rt.new_int(0)])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_block := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	this.log((Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_{"nodeType":"Expr_Variable","line":148,"name":"this"}.block_removed()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface](var_block), rt.new_null())
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_block_template_after_remove_block'), rt.new_closure(closure_2_fn), rt.new_int(0)])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_block := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	this.log((if rt.is_true(rt.call_method(var_block, 'is_detached', []rt.PhpVal{})) { Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_{"nodeType":"Expr_Variable","line":160,"name":"this"}.hide_condition_added_to_detached_block() } else { Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_{"nodeType":"Expr_Variable","line":161,"name":"this"}.hide_condition_added() }).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface](var_block), rt.new_null())
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_block_template_after_add_hide_condition'), rt.new_closure(closure_3_fn), rt.new_int(0)])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_block := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	this.log((Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_{"nodeType":"Expr_Variable","line":172,"name":"this"}.hide_condition_removed()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface](var_block), rt.new_null())
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_block_template_after_remove_hide_condition'), rt.new_closure(closure_4_fn), rt.new_int(0)])
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_block := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_action := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_exception := if args.len > 2 { args[2].dup() } else { rt.new_null() }
	this.log((Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_{"nodeType":"Expr_Variable","line":183,"name":"this"}.error_after_block_added()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface](var_block), rt.create_array([rt.ArrayItem{ key: 'action', val: var_action }, rt.ArrayItem{ key: 'exception', val: var_exception }]))
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_block_template_after_add_block_error'), rt.new_closure(closure_5_fn), rt.new_int(0), rt.new_int(3)])
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_block := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_action := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_exception := if args.len > 2 { args[2].dup() } else { rt.new_null() }
	this.log((Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_{"nodeType":"Expr_Variable","line":199,"name":"this"}.error_after_block_removed()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface](var_block), rt.create_array([rt.ArrayItem{ key: 'action', val: var_action }, rt.ArrayItem{ key: 'exception', val: var_exception }]))
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_block_template_after_remove_block_error'), rt.new_closure(closure_6_fn), rt.new_int(0), rt.new_int(3)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) template_events_to_json(template_id string) rt.PhpVal {
	mut template_id_mutated := template_id
	if !(this.all_template_events.array_isset(rt.new_string(template_id_mutated))) {
		return rt.new_array()
	}
	mut var_template_events := this.all_template_events.array_get(template_id_mutated)
	return this.to_json(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](var_template_events))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) to_json(mut var_template_events Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array) rt.PhpVal {
	mut var_template_events_mutated := var_template_events
	mut var_json := rt.new_array()
	{
		mut iter_1 := var_template_events_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_template_event := item_1.val
			mut var_container := var_template_event.array_get('container')
			mut var_block := var_template_event.array_get('block')
			var_json.array_push(rt.create_array([rt.ArrayItem{ key: 'level', val: var_template_event.array_get('level') }, rt.ArrayItem{ key: 'event_type', val: var_template_event.array_get('event_type') }, rt.ArrayItem{ key: 'message', val: var_template_event.array_get('message') }, rt.ArrayItem{ key: 'container', val: if rt.is_true(rt.new_bool(rt.instance_of(var_container, 'Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface'))) { rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_container, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'name', val: rt.call_method(var_container, 'get_name', []rt.PhpVal{}) }]) } else { rt.new_null() } }, rt.ArrayItem{ key: 'block', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_block, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'name', val: rt.call_method(var_block, 'get_name', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'additional_info', val: this.format_info(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](var_template_event.array_get('additional_info'))) }]))
		}
	}
	return var_json.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) log_template_events_to_file(template_id string)  {
	mut template_id_mutated := template_id
	if !(this.all_template_events.array_isset(rt.new_string(template_id_mutated))) {
		return rt.new_null()
	}
	mut var_template_events := this.all_template_events.array_get(template_id_mutated)
	mut var_hash := rt.new_string(this.generate_template_events_hash(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](var_template_events)))
	if rt.is_true(rt.new_bool(!(rt.is_true(this.has_template_events_changed(template_id_mutated, (var_hash).str()))))) {
		return rt.new_null()
	}
	this.set_template_events_log_hash(template_id_mutated, (var_hash).str())
	mut var_template := this.templates.array_get(template_id_mutated)
	{
		mut iter_1 := var_template_events.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_template_event := item_1.val
			mut var_info := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'template', val: var_template }, rt.ArrayItem{ key: 'container', val: var_template_event.array_get('container') }, rt.ArrayItem{ key: 'block', val: var_template_event.array_get('block') }]), var_template_event.array_get('additional_info')])
			mut var_message := rt.new_string(this.format_message((var_template_event.array_get('message')).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](var_info)))
			rt.call_method(this.logger, 'log', [var_template_event.array_get('level'), var_message.dup(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'block_template' }])])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) has_template_events_changed(template_id string, events_hash string) rt.PhpVal {
	mut template_id_mutated := template_id
	mut var_previous_hash := rt.call_function('get_transient', [(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger.log_hash_transient_base_name()).str() + template_id_mutated])
	return // unsupported expression: Expr_BinaryOp_NotIdentical
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) generate_template_events_hash(mut var_template_events Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array) string {
	mut var_template_events_mutated := var_template_events
	return md5.hexhash(rt.call_function('wp_json_encode', [this.to_json(mut var_template_events_mutated)]).to_string())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) set_template_events_log_hash(template_id string, hash string)  {
	mut template_id_mutated := template_id
	mut hash_mutated := hash
	rt.call_function('set_transient', [(Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger.log_hash_transient_base_name()).str() + template_id_mutated, rt.new_string(hash_mutated).dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) log(event_type string, mut var_block Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface, var_additional_info rt.PhpVal)  {
	mut var_block_mutated := var_block
	if !(// unsupported expression: Expr_StaticPropertyFetch.array_isset(rt.new_string(event_type))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s was called with an invalid event type "%2$s".'), rt.new_string('woocommerce')]), rt.new_string('<code>BlockTemplateLogger::log</code>'), rt.new_string(event_type)]), rt.new_string('8.4')])
	}
	mut var_event_type_info := if // unsupported expression: Expr_StaticPropertyFetch.array_isset(rt.new_string(event_type)) { rt.call_function('array_merge', [// unsupported expression: Expr_StaticPropertyFetch.array_get(event_type), rt.create_array([rt.ArrayItem{ key: 'event_type', val: event_type }])]) } else { rt.create_array([rt.ArrayItem{ key: 'level', val: Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_WC_Log_Levels.error() }, rt.ArrayItem{ key: 'event_type', val: event_type }, rt.ArrayItem{ key: 'message', val: 'Unknown error.' }]) }
	if rt.is_true(rt.new_bool(!(rt.is_true(this.should_handle(var_event_type_info.array_get('level')))))) {
		return rt.new_null()
	}
	mut var_template := rt.call_method(var_block_mutated, 'get_root_template', []rt.PhpVal{})
	mut var_container := rt.call_method(var_block_mutated, 'get_parent', []rt.PhpVal{})
	this.add_template_event(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](var_event_type_info), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface](var_template), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_ContainerInterface](var_container), mut var_block_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](var_additional_info))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) should_handle(var_level rt.PhpVal) rt.PhpVal {
	return rt.less_equal(this.threshold_severity, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_WC_Log_Levels{}; return temp.get_level_severity(arg_0) }(var_level.dup()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) add_template_event(mut var_event_type_info Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array, mut var_template Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface, mut var_container Class_Automattic_WooCommerce_Admin_BlockTemplates_ContainerInterface, mut var_block Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface, mut var_additional_info Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array)  {
	mut var_template_events := rt.new_null()
	mut var_event_type_info_mutated := var_event_type_info
	mut var_template_mutated := var_template
	mut var_container_mutated := var_container
	mut var_block_mutated := var_block
	mut var_template_id := rt.call_method(var_template_mutated, 'get_id', []rt.PhpVal{})
	if !(this.all_template_events.array_isset(var_template_id)) {
		this.all_template_events.array_set(var_template_id, rt.new_array())
		this.templates.array_set(var_template_id, var_template_mutated.dup())
	}
	// unsupported expression: Expr_AssignRef
	var_template_events.array_push(rt.create_array([rt.ArrayItem{ key: 'level', val: var_event_type_info_mutated.array_get('level') }, rt.ArrayItem{ key: 'event_type', val: var_event_type_info_mutated.array_get('event_type') }, rt.ArrayItem{ key: 'message', val: var_event_type_info_mutated.array_get('message') }, rt.ArrayItem{ key: 'container', val: var_container_mutated }, rt.ArrayItem{ key: 'block', val: var_block_mutated }, rt.ArrayItem{ key: 'additional_info', val: var_additional_info }]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) format_message(message string, mut var_info Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array) string {
	mut message_mutated := message
	mut var_info_mutated := var_info
	mut var_formatted_message := rt.call_function('sprintf', [rt.new_string('%s\n%s'), rt.new_string(message_mutated).dup(), println(this.format_info(mut var_info_mutated).to_string())])
	return (var_formatted_message).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) format_info(mut var_info Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array) rt.PhpVal {
	mut var_info_mutated := var_info
	mut var_formatted_info := var_info_mutated.dup()
	if rt.is_true(rt.new_bool(var_info_mutated.array_isset(rt.new_string('exception')) && rt.is_true(rt.new_bool(rt.instance_of(var_info_mutated.array_get('exception'), 'Automattic_WooCommerce_Internal_Admin_BlockTemplates_Exception'))))) {
		var_formatted_info.array_set('exception', this.format_exception(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Exception](var_info_mutated.array_get('exception'))))
	}
	if var_info_mutated.array_isset(rt.new_string('container')) {
		if rt.is_true(rt.new_bool(rt.instance_of(var_info_mutated.array_get('container'), 'Automattic_WooCommerce_Admin_BlockTemplates_BlockContainerInterface'))) {
			var_formatted_info.array_set('container', this.format_block(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface](var_info_mutated.array_get('container'))))
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_info_mutated.array_get('container'), 'Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface'))) {
			var_formatted_info.array_set('container', this.format_template(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface](var_info_mutated.array_get('container'))))
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_info_mutated.array_get('container'), 'Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface'))) {
			var_formatted_info.array_set('container', this.format_block(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface](var_info_mutated.array_get('container'))))
		}
	}
	if rt.is_true(rt.new_bool(var_info_mutated.array_isset(rt.new_string('block')) && rt.is_true(rt.new_bool(rt.instance_of(var_info_mutated.array_get('block'), 'Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface'))))) {
		var_formatted_info.array_set('block', this.format_block(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface](var_info_mutated.array_get('block'))))
	}
	if rt.is_true(rt.new_bool(var_info_mutated.array_isset(rt.new_string('template')) && rt.is_true(rt.new_bool(rt.instance_of(var_info_mutated.array_get('template'), 'Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface'))))) {
		var_formatted_info.array_set('template', this.format_template(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface](var_info_mutated.array_get('template'))))
	}
	return var_formatted_info.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) format_exception(mut var_exception Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Exception) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'message', val: var_exception.getmessage() }, rt.ArrayItem{ key: 'source', val: rt.concat(rt.concat(var_exception.getfile(), rt.new_string(': ')), var_exception.getline()) }, rt.ArrayItem{ key: 'trace', val: println(this.format_exception_trace(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](var_exception.gettrace())).to_string()) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) format_exception_trace(mut var_trace Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array) rt.PhpVal {
	mut var_formatted_trace := rt.new_array()
	{
		mut iter_1 := var_trace.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_source := item_1.val
			var_formatted_trace.array_push(rt.concat(rt.concat(var_source.array_get('file'), rt.new_string(': ')), var_source.array_get('line')))
		}
	}
	return var_formatted_trace.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) format_template(mut var_template Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface) string {
	mut var_template_mutated := var_template
	return rt.concat(rt.concat(rt.concat(rt.call_method(var_template_mutated, 'get_id', []rt.PhpVal{}), rt.new_string(' (area: ')), rt.call_method(var_template_mutated, 'get_area', []rt.PhpVal{})), rt.new_string(')'))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) format_block(mut var_block Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface) string {
	mut var_block_mutated := var_block
	return rt.concat(rt.concat(rt.concat(rt.call_method(var_block_mutated, 'get_id', []rt.PhpVal{}), rt.new_string(' (name: ')), rt.call_method(var_block_mutated, 'get_name', []rt.PhpVal{})), rt.new_string(')'))
}

struct Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_WC_Log_Levels {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_blocktemplates_blocktemplatelogger() &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger{
		PhpObjectBase: rt.PhpObjectBase{}
		event_types: rt.new_array()
		instance: rt.new_null()
		logger: rt.new_null()
		all_template_events: rt.new_array()
		templates: rt.new_array()
		threshold_severity: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_blocktemplates_wc_log_levels() &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_WC_Log_Levels {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_WC_Log_Levels{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'template_events_to_json' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.template_events_to_json(dispatch_arg_0)
		}
		'to_json' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.to_json(mut dispatch_arg_0)
		}
		'log_template_events_to_file' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.log_template_events_to_file(dispatch_arg_0)
			return rt.new_null()
		}
		'has_template_events_changed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.has_template_events_changed(dispatch_arg_0, dispatch_arg_1)
		}
		'generate_template_events_hash' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.generate_template_events_hash(mut dispatch_arg_0))
		}
		'set_template_events_log_hash' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.set_template_events_log_hash(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'log' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.log(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'should_handle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.should_handle(dispatch_arg_0)
		}
		'add_template_event' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_ContainerInterface](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](if args.len > 4 { args[4] } else { rt.new_null() })
			this.add_template_event(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'format_message' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.format_message(dispatch_arg_0, mut dispatch_arg_1))
		}
		'format_info' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.format_info(mut dispatch_arg_0)
		}
		'format_exception' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_Exception](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.format_exception(mut dispatch_arg_0)
		}
		'format_exception_trace' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.format_exception_trace(mut dispatch_arg_0)
		}
		'format_template' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.format_template(mut dispatch_arg_0))
		}
		'format_block' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.format_block(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'event_types' { return this.event_types }
		'instance' { return this.instance }
		'logger' { return this.logger }
		'all_template_events' { return this.all_template_events }
		'templates' { return this.templates }
		'threshold_severity' { return this.threshold_severity }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_BlockTemplateLogger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'event_types' { this.event_types = val; return true }
		'instance' { this.instance = val; return true }
		'logger' { this.logger = val; return true }
		'all_template_events' { this.all_template_events = val; return true }
		'templates' { this.templates = val; return true }
		'threshold_severity' { this.threshold_severity = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_WC_Log_Levels) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_WC_Log_Levels) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_WC_Log_Levels) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_blocktemplates_blocktemplatelogger_php() {
}
