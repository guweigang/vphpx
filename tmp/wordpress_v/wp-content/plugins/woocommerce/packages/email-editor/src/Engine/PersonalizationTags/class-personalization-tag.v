import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag {
	rt.PhpObjectBase
pub mut:
		name string
		token string
		category string
		callback rt.PhpVal = rt.new_null()
		attributes rt.PhpVal = rt.new_null()
		value_to_insert rt.PhpVal = rt.new_null()
		post_types rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) construct(name string, token string, category string, mut var_callback Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_callable, mut var_attributes Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_array, mut var_value_to_insert Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_?string, mut var_post_types Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_array)  {
	mut var_value_to_insert_mutated := var_value_to_insert
	this.name = name
	this.token = if rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(token), rt.new_string('[')]), rt.new_int(0))) { token } else { "[${var_token}]" }
	this.category = category
	this.callback = var_callback.dup()
	this.attributes = var_attributes.dup()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_value_to_insert_mutated)))) {
		if rt.is_true(this.attributes) {
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return
	}
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return
	}
			var_value_to_insert_mutated = rt.new_string((rt.call_function('substr', [this.token, rt.new_int(0), // unsupported expression: Expr_UnaryMinus])).str() + ' ' + (rt.call_function('implode', [rt.new_string(' '), rt.call_function('array_map', [rt.new_closure(closure_1_fn), rt.func_array_keys(this.attributes)])])).str() + ']')
		} else {
			var_value_to_insert_mutated = rt.new_string(this.token)
		}
	}
	this.value_to_insert = var_value_to_insert_mutated.dup()
	this.post_types = var_post_types.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) magic_unserialize(mut var_data Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_array)  {
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Exception', []string{}, create_automattic_woocommerce_emaileditor_engine_personalizationtags_exception(rt.new_string('Deserialization of Personalization_Tag is not allowed for security reasons.'))))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) get_name() string {
	return this.name
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) get_token() string {
	return this.token
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) get_category() string {
	return this.category
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) get_attributes() rt.PhpVal {
	return this.attributes
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) get_value_to_insert() string {
	return (this.value_to_insert).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) get_post_types() rt.PhpVal {
	return this.post_types
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) get_callback() rt.PhpVal {
	return this.callback
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) execute_callback(var_context rt.PhpVal, var_args rt.PhpVal) string {
	return (rt.call_function('call_user_func', [this.callback, rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: var_context }]), rt.create_array([rt.ArrayItem{ key: none, val: var_args }])])])).str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(name string, token string, category string, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal, arg_6 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag{
		PhpObjectBase: rt.PhpObjectBase{}
		name: ''
		token: ''
		category: ''
		callback: rt.new_null()
		attributes: rt.new_null()
		value_to_insert: rt.new_null()
		post_types: rt.new_null()
	}
	obj.construct(name, token, category, arg_3, arg_4, arg_5, arg_6)
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_personalizationtags_exception() &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Exception {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_callable](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_array](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_?string](if args.len > 5 { args[5] } else { rt.new_null() })
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_array](if args.len > 6 { args[6] } else { rt.new_null() })
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6)
			return rt.new_null()
		}
		'__unserialize' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.magic_unserialize(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_name' {
			return rt.new_string(this.get_name())
		}
		'get_token' {
			return rt.new_string(this.get_token())
		}
		'get_category' {
			return rt.new_string(this.get_category())
		}
		'get_attributes' {
			return this.get_attributes()
		}
		'get_value_to_insert' {
			return rt.new_string(this.get_value_to_insert())
		}
		'get_post_types' {
			return this.get_post_types()
		}
		'get_callback' {
			return this.get_callback()
		}
		'execute_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.execute_callback(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return rt.new_string(this.name) }
		'token' { return rt.new_string(this.token) }
		'category' { return rt.new_string(this.category) }
		'callback' { return this.callback }
		'attributes' { return this.attributes }
		'value_to_insert' { return this.value_to_insert }
		'post_types' { return this.post_types }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' { this.name = (val).str(); return true }
		'token' { this.token = (val).str(); return true }
		'category' { this.category = (val).str(); return true }
		'callback' { this.callback = val; return true }
		'attributes' { this.attributes = val; return true }
		'value_to_insert' { this.value_to_insert = val; return true }
		'post_types' { this.post_types = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_personalizationtags_class_personalization_tag_php() {
	// unsupported statement: Stmt_Declare
}
