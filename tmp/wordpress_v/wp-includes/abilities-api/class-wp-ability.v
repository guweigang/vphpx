import rt

pub fn Class_WP_Ability.default_show_in_rest() bool {
	return false
}
struct Class_WP_Ability {
	rt.PhpObjectBase
pub mut:
		default_annotations rt.PhpVal = rt.new_array()
		name string
		label rt.PhpVal = rt.new_null()
		description rt.PhpVal = rt.new_null()
		category rt.PhpVal = rt.new_null()
		input_schema rt.PhpVal = rt.new_array()
		output_schema rt.PhpVal = rt.new_array()
		execute_callback rt.PhpVal = rt.new_null()
		permission_callback rt.PhpVal = rt.new_null()
		meta rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Ability) construct(name string, mut var_args Class_array)  {
	mut var_args_mutated := var_args
	this.name = name
	mut var_properties := this.prepare_properties(mut var_args_mutated)
	{
		mut iter_1 := var_properties.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property_value := item_1.val
			mut var_property_name := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('property_exists', [rt.new_object('WP_Ability', []string{}, &this), var_property_name.dup()]))))) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Property "%1$s" is not a valid property for ability "%2$s". Please check the %3$s class for allowed properties.')]), '<code>' + (rt.call_function('esc_html', [var_property_name.dup()])).str() + '</code>', '<code>' + (rt.call_function('esc_html', [this.name])).str() + '</code>', '<code>' + @STRUCT + '</code>']), rt.new_string('6.9.0')])
				continue
			}
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":188,"name":"property_name"}', var_property_value.dup())
		}
	}
}

fn (mut this Class_WP_Ability) prepare_properties(mut var_args Class_array) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!rt.is_true(var_args_mutated.array_get('label')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get('label').is_string()))))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [rt.new_string('The ability properties must contain a `label` string.')]))))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_args_mutated.array_get('description')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get('description').is_string()))))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [rt.new_string('The ability properties must contain a `description` string.')]))))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_args_mutated.array_get('category')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get('category').is_string()))))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [rt.new_string('The ability properties must contain a `category` string.')]))))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.call_function('get_class', [rt.new_object('WP_Ability', []string{}, &this)]), Class_WP_Ability.class())) && rt.is_true(rt.new_bool(!rt.is_true(var_args_mutated.array_get('execute_callback')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_args_mutated.array_get('execute_callback')]))))))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [rt.new_string('The ability properties must contain a valid `execute_callback` function.')]))))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.call_function('get_class', [rt.new_object('WP_Ability', []string{}, &this)]), Class_WP_Ability.class())) && rt.is_true(rt.new_bool(!rt.is_true(var_args_mutated.array_get('permission_callback')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_args_mutated.array_get('permission_callback')]))))))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [rt.new_string('The ability properties must provide a valid `permission_callback` function.')]))))
	}
	if rt.is_true(rt.new_bool(var_args_mutated.array_isset(rt.new_string('input_schema')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get('input_schema').is_array()))))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [rt.new_string('The ability properties should provide a valid `input_schema` definition.')]))))
	}
	if rt.is_true(rt.new_bool(var_args_mutated.array_isset(rt.new_string('output_schema')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get('output_schema').is_array()))))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [rt.new_string('The ability properties should provide a valid `output_schema` definition.')]))))
	}
	if rt.is_true(rt.new_bool(var_args_mutated.array_isset(rt.new_string('meta')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get('meta').is_array()))))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [rt.new_string('The ability properties should provide a valid `meta` array.')]))))
	}
	if rt.is_true(rt.new_bool(var_args_mutated.array_get('meta').array_isset(rt.new_string('annotations')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get('meta').array_get('annotations').is_array()))))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [rt.new_string('The ability meta should provide a valid `annotations` array.')]))))
	}
	if rt.is_true(rt.new_bool(var_args_mutated.array_get('meta').array_isset(rt.new_string('show_in_rest')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get('meta').array_get('show_in_rest').is_bool()))))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('__', [rt.new_string('The ability meta should provide a valid `show_in_rest` boolean.')]))))
	}
	var_args_mutated.array_set('meta', rt.call_function('wp_parse_args', [if !(var_args_mutated.array_get('meta')).is_null() { var_args_mutated.array_get('meta') } else { rt.new_array() }, rt.create_array([rt.ArrayItem{ key: 'annotations', val: // unsupported expression: Expr_StaticPropertyFetch }, rt.ArrayItem{ key: 'show_in_rest', val: Class_WP_Ability.default_show_in_rest() }])]))
	var_args_mutated.array_get_mut('meta').array_set('annotations', rt.call_function('wp_parse_args', [var_args_mutated.array_get('meta').array_get('annotations'), // unsupported expression: Expr_StaticPropertyFetch]))
	return rt.new_object('array', []string{}, var_args_mutated)
}

fn (mut this Class_WP_Ability) get_name() string {
	return this.name
}

fn (mut this Class_WP_Ability) get_label() string {
	return (this.label).str()
}

fn (mut this Class_WP_Ability) get_description() string {
	return (this.description).str()
}

fn (mut this Class_WP_Ability) get_category() string {
	return (this.category).str()
}

fn (mut this Class_WP_Ability) get_input_schema() rt.PhpVal {
	return this.input_schema
}

fn (mut this Class_WP_Ability) get_output_schema() rt.PhpVal {
	return this.output_schema
}

fn (mut this Class_WP_Ability) get_meta() rt.PhpVal {
	return this.meta
}

fn (mut this Class_WP_Ability) get_meta_item(key string, var_default_value rt.PhpVal) rt.PhpVal {
	return if rt.is_true(rt.new_bool(this.meta.array_isset(rt.new_string(key)))) { this.meta.array_get(key) } else { var_default_value }
}

fn (mut this Class_WP_Ability) normalize_input(var_input rt.PhpVal) rt.PhpVal {
	mut var_input_mutated := var_input
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_input_mutated.dup()
	}
	mut var_input_schema := this.get_input_schema()
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_input_schema)) && rt.is_true(rt.new_bool(var_input_schema.dup().array_isset(rt.new_string('default')))))) {
		return var_input_schema.array_get('default')
	}
	return rt.new_null()
}

fn (mut this Class_WP_Ability) validate_input(var_input rt.PhpVal) bool {
	mut var_input_mutated := var_input
	mut var_input_schema := this.get_input_schema()
	if !rt.is_true(var_input_schema) {
		if rt.is_true(rt.identical(rt.new_null(), var_input_mutated)) {
			return true
		}
		return (create_wp_error(rt.new_string('ability_missing_input_schema'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Ability "%s" does not define an input schema required to validate the provided input.')]), rt.call_function('esc_html', [this.name])]))).to_bool()
	}
	mut var_valid_input := rt.call_function('rest_validate_value_from_schema', [var_input_mutated.dup(), var_input_schema.dup(), rt.new_string('input')])
	if rt.is_true(rt.call_function('is_wp_error', [var_valid_input.dup()])) {
		return (create_wp_error(rt.new_string('ability_invalid_input'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Ability "%1$s" has invalid input. Reason: %2$s')]), rt.call_function('esc_html', [this.name]), rt.call_method(var_valid_input, 'get_error_message', []rt.PhpVal{})]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_Ability) invoke_callback(mut var_callback Class_callable, var_input rt.PhpVal) rt.PhpVal {
	mut var_input_mutated := var_input
	mut var_args := rt.new_array()
	if !(!rt.is_true(this.get_input_schema())) {
		var_args.array_push(var_input_mutated.dup())
	}
	return rt.call_callable(var_callback, [var_args.dup()])
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Throwable') {
		mut var_e := var_e_1.dup()
		return create_wp_error(rt.new_string('ability_callback_exception'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Ability "%1$s" callback threw an exception: %2$s')]), rt.call_function('esc_html', [this.name]), rt.call_function('esc_html', [rt.call_method(var_e, 'getMessage', []rt.PhpVal{})])]))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_WP_Ability) check_permissions(var_input rt.PhpVal) rt.PhpVal {
	mut var_input_mutated := var_input
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [this.permission_callback]))))) {
		return create_wp_error(rt.new_string('ability_invalid_permission_callback'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Ability "%s" does not have a valid permission callback.')]), rt.call_function('esc_html', [this.name])]))
	}
	return this.invoke_callback(mut rt.cast_object_ptr[Class_callable](this.permission_callback), var_input_mutated.dup())
}

fn (mut this Class_WP_Ability) do_execute(var_input rt.PhpVal) rt.PhpVal {
	mut var_input_mutated := var_input
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [this.execute_callback]))))) {
		return create_wp_error(rt.new_string('ability_invalid_execute_callback'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Ability "%s" does not have a valid execute callback.')]), rt.call_function('esc_html', [this.name])]))
	}
	return this.invoke_callback(mut rt.cast_object_ptr[Class_callable](this.execute_callback), var_input_mutated.dup())
}

fn (mut this Class_WP_Ability) validate_output(var_output rt.PhpVal) bool {
	mut var_output_schema := this.get_output_schema()
	if !rt.is_true(var_output_schema) {
		return true
	}
	mut var_valid_output := rt.call_function('rest_validate_value_from_schema', [var_output.dup(), var_output_schema.dup(), rt.new_string('output')])
	if rt.is_true(rt.call_function('is_wp_error', [var_valid_output.dup()])) {
		return (create_wp_error(rt.new_string('ability_invalid_output'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Ability "%1$s" has invalid output. Reason: %2$s')]), rt.call_function('esc_html', [this.name]), rt.call_method(var_valid_output, 'get_error_message', []rt.PhpVal{})]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_Ability) execute(var_input rt.PhpVal) rt.PhpVal {
	mut var_input_mutated := var_input
	var_input_mutated = this.normalize_input(var_input_mutated.dup())
	mut var_is_valid := rt.new_bool(this.validate_input(var_input_mutated.dup()))
	if rt.is_true(rt.call_function('is_wp_error', [var_is_valid.dup()])) {
		return var_is_valid.dup()
	}
	mut var_has_permissions := this.check_permissions(var_input_mutated.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.call_function('is_wp_error', [var_has_permissions.dup()])) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('esc_html', [rt.call_method(var_has_permissions, 'get_error_message', []rt.PhpVal{})]), rt.new_string('6.9.0')])
		}
		return create_wp_error(rt.new_string('ability_invalid_permissions'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Ability "%s" does not have necessary permission.')]), rt.call_function('esc_html', [this.name])]))
	}
	rt.call_function('do_action', [rt.new_string('wp_before_execute_ability'), this.name, var_input_mutated.dup()])
	mut var_result := this.do_execute(var_input_mutated.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		return var_result.dup()
	}
	var_is_valid = rt.new_bool(this.validate_output(var_result.dup()))
	if rt.is_true(rt.call_function('is_wp_error', [var_is_valid.dup()])) {
		return var_is_valid.dup()
	}
	rt.call_function('do_action', [rt.new_string('wp_after_execute_ability'), this.name, var_input_mutated.dup(), var_result.dup()])
	return var_result.dup()
}

fn (mut this Class_WP_Ability) magic_wakeup()  {
	rt.throw_exception(rt.new_object('LogicException', []string{}, create_logicexception(@STRUCT + ' should never be unserialized.')))
}

fn (mut this Class_WP_Ability) magic_sleep()  {
	rt.throw_exception(rt.new_object('LogicException', []string{}, create_logicexception(@STRUCT + ' should never be serialized.')))
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_LogicException {
	rt.PhpObjectBase
}

fn create_wp_ability(name string, arg_1 rt.PhpVal) &Class_WP_Ability {
	mut obj := &Class_WP_Ability{
		PhpObjectBase: rt.PhpObjectBase{}
		default_annotations: rt.new_array()
		name: ''
		label: rt.new_null()
		description: rt.new_null()
		category: rt.new_null()
		input_schema: rt.new_array()
		output_schema: rt.new_array()
		execute_callback: rt.new_null()
		permission_callback: rt.new_null()
		meta: rt.new_null()
	}
	obj.construct(name, arg_1)
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_logicexception() &Class_LogicException {
	mut obj := &Class_LogicException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Ability) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'prepare_properties' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.prepare_properties(mut dispatch_arg_0)
		}
		'get_name' {
			return rt.new_string(this.get_name())
		}
		'get_label' {
			return rt.new_string(this.get_label())
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		'get_category' {
			return rt.new_string(this.get_category())
		}
		'get_input_schema' {
			return this.get_input_schema()
		}
		'get_output_schema' {
			return this.get_output_schema()
		}
		'get_meta' {
			return this.get_meta()
		}
		'get_meta_item' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_meta_item(dispatch_arg_0, dispatch_arg_1)
		}
		'normalize_input' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.normalize_input(dispatch_arg_0)
		}
		'validate_input' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_input(dispatch_arg_0))
		}
		'invoke_callback' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_callable](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.invoke_callback(mut dispatch_arg_0, dispatch_arg_1)
		}
		'check_permissions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.check_permissions(dispatch_arg_0)
		}
		'do_execute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.do_execute(dispatch_arg_0)
		}
		'validate_output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_output(dispatch_arg_0))
		}
		'execute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.execute(dispatch_arg_0)
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'__sleep' {
			this.magic_sleep()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Ability) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'default_annotations' { return this.default_annotations }
		'name' { return rt.new_string(this.name) }
		'label' { return this.label }
		'description' { return this.description }
		'category' { return this.category }
		'input_schema' { return this.input_schema }
		'output_schema' { return this.output_schema }
		'execute_callback' { return this.execute_callback }
		'permission_callback' { return this.permission_callback }
		'meta' { return this.meta }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Ability) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'default_annotations' { this.default_annotations = val; return true }
		'name' { this.name = (val).str(); return true }
		'label' { this.label = val; return true }
		'description' { this.description = val; return true }
		'category' { this.category = val; return true }
		'input_schema' { this.input_schema = val; return true }
		'output_schema' { this.output_schema = val; return true }
		'execute_callback' { this.execute_callback = val; return true }
		'permission_callback' { this.permission_callback = val; return true }
		'meta' { this.meta = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_LogicException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_LogicException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_LogicException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_abilities_api_class_wp_ability_php() {
	// unsupported statement: Stmt_Declare
}
