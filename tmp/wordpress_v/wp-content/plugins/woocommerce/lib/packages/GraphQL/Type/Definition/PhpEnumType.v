import rt

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType.multiple_descriptions_disallowed() string {
	return 'Using more than 1 Description attribute is not supported.'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType.multiple_deprecations_disallowed() string {
	return 'Using more than 1 Deprecated attribute is not supported.'
}
struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType {
	rt.PhpObjectBase
pub mut:
		enumClass string
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType) construct(enumClass string, mut var_name Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?string, mut var_description Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?string, mut var_astNode Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?EnumTypeDefinitionNode, mut var_extensionASTNodes Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?array)  {
	this.enumClass = enumClass
	mut var_reflection := create_automattic_woocommerce_vendor_graphql_type_definition_reflectionenum(rt.new_string(enumClass).dup())
	mut var_enumDefinitions := rt.new_array()
	{
		mut iter_1 := var_reflection.getcases().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_case := item_1.val
			var_enumDefinitions.array_set(rt.get_property(var_case, 'name'), rt.create_array([rt.ArrayItem{ key: 'value', val: rt.call_method(var_case, 'getValue', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'description', val: this.extractdescription(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_{"nodeType":"UnionType","line":106,"types":["ReflectionClassConstant","ReflectionClass"]}](var_case)) }, rt.ArrayItem{ key: 'deprecationReason', val: this.deprecationreason(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ReflectionClassConstant](var_case)) }]))
		}
	}
	this.Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType.construct(rt.create_array([rt.ArrayItem{ key: 'name', val: if !(var_name).is_null() { var_name } else { this.basename(enumClass) } }, rt.ArrayItem{ key: 'values', val: var_enumDefinitions }, rt.ArrayItem{ key: 'description', val: if !(var_description).is_null() { var_description } else { this.extractdescription(mut var_reflection) } }, rt.ArrayItem{ key: 'astNode', val: var_astNode }, rt.ArrayItem{ key: 'extensionASTNodes', val: var_extensionASTNodes }]))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType) serialize(var_value rt.PhpVal) string {
	if rt.is_true(rt.new_bool(rt.instance_of(var_value, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_{"nodeType":"Expr_PropertyFetch","line":64,"var":{"nodeType":"Expr_Variable","line":64,"name":"this"},"name":"enumClass"}'))) {
		return (rt.get_property(var_value, 'name')).str()
	}
	if rt.is_true(rt.call_function('is_a', [this.enumClass, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_BackedEnum.class(), rt.new_bool(true)])) {
		mut var_instance := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_{"nodeType":"Expr_PropertyFetch","line":70,"var":{"nodeType":"Expr_Variable","line":70,"name":"this"},"name":"enumClass"}{}; return temp.from(arg_0) }(var_value.dup())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ValueError') || rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_TypeError') {
			mut var_error := var_e_1.dup()
			mut var_notEnumInstanceOrValue := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_value.dup())
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError', []string{}, create_automattic_woocommerce_vendor_graphql_error_serializationerror(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Cannot serialize value as enum: '), var_notEnumInstanceOrValue), rt.new_string(', expected instance or valid value of ')), this.enumClass), rt.new_string('.')), rt.call_method(var_error, 'getCode', []rt.PhpVal{}), var_error.dup())))
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
		return (rt.get_property(var_instance, 'name')).str()
	}
	mut var_notEnum := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_value.dup())
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError', []string{}, create_automattic_woocommerce_vendor_graphql_error_serializationerror(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Cannot serialize value as enum: '), var_notEnum), rt.new_string(', expected instance of ')), this.enumClass), rt.new_string('.')))))
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType) parsevalue(var_value rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(var_value, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_{"nodeType":"Expr_PropertyFetch","line":86,"var":{"nodeType":"Expr_Variable","line":86,"name":"this"},"name":"enumClass"}'))) {
		return var_value.dup()
	}
	return this.Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType.parsevalue(var_value.dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType) basename(class string) string {
	mut var_parts := rt.call_function('explode', [rt.new_string('\\'), rt.new_string(class)])
	return (rt.call_function('end', [var_parts.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType) extractdescription(mut var_reflection Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_{"nodeType":"UnionType","line":106,"types":["ReflectionClassConstant","ReflectionClass"]}) string {
	mut var_reflection_mutated := var_reflection
	mut var_attributes := var_reflection_mutated.getattributes(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Description.class())
	if var_attributes.dup().array_count() == 1 {
		return (rt.get_property(rt.call_method(var_attributes.array_get(0), 'newInstance', []rt.PhpVal{}), 'description')).str()
	}
	if var_attributes.dup().array_count() > 1 {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Exception', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_exception(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType.multiple_descriptions_disallowed())))
	}
	mut var_comment := var_reflection_mutated.getdoccomment()
	mut var_unpadded := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc{}; return temp.unpad(arg_0) }(var_comment.dup())
	return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc{}; return temp.unwrap(arg_0) }(var_unpadded.dup())).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType) deprecationreason(mut var_reflection Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ReflectionClassConstant) string {
	mut var_reflection_mutated := var_reflection
	mut var_attributes := var_reflection_mutated.getattributes(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Deprecated.class())
	if var_attributes.dup().array_count() == 1 {
		return (rt.get_property(rt.call_method(var_attributes.array_get(0), 'newInstance', []rt.PhpVal{}), 'reason')).str()
	}
	if var_attributes.dup().array_count() > 1 {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Exception', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_exception(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType.multiple_deprecations_disallowed())))
	}
	return (rt.new_null()).str()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ReflectionEnum {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_{"nodeType":"Expr_PropertyFetch","line":70,"var":{"nodeType":"Expr_Variable","line":70,"name":"this"},"name":"enumClass"} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_phpenumtype(enumClass string, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType{
		PhpObjectBase: rt.PhpObjectBase{}
		enumClass: ''
	}
	obj.construct(enumClass, arg_1, arg_2, arg_3, arg_4)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_enumtype() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_reflectionenum() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ReflectionEnum {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ReflectionEnum{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_{"nodetype":"expr_propertyfetch","line":70,"var":{"nodetype":"expr_variable","line":70,"name":"this"},"name":"enumclass"}() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_{"nodeType":"Expr_PropertyFetch","line":70,"var":{"nodeType":"Expr_Variable","line":70,"name":"this"},"name":"enumClass"} {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_{"nodeType":"Expr_PropertyFetch","line":70,"var":{"nodeType":"Expr_Variable","line":70,"name":"this"},"name":"enumClass"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_utils() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_serializationerror() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_exception() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Exception {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_phpdoc() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?EnumTypeDefinitionNode](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?array](if args.len > 4 { args[4] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'serialize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.serialize(dispatch_arg_0))
		}
		'parseValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parsevalue(dispatch_arg_0)
		}
		'baseName' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.basename(dispatch_arg_0))
		}
		'extractDescription' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_{"nodeType":"UnionType","line":106,"types":["ReflectionClassConstant","ReflectionClass"]}](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.extractdescription(mut dispatch_arg_0))
		}
		'deprecationReason' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ReflectionClassConstant](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.deprecationreason(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'enumClass' { return rt.new_string(this.enumClass) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_PhpEnumType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'enumClass' { this.enumClass = (val).str(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ReflectionEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ReflectionEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ReflectionEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_{"nodeType":"Expr_PropertyFetch","line":70,"var":{"nodeType":"Expr_Variable","line":70,"name":"this"},"name":"enumClass"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_{"nodeType":"Expr_PropertyFetch","line":70,"var":{"nodeType":"Expr_Variable","line":70,"name":"this"},"name":"enumClass"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_{"nodeType":"Expr_PropertyFetch","line":70,"var":{"nodeType":"Expr_Variable","line":70,"name":"this"},"name":"enumClass"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_phpenumtype_php() {
	// unsupported statement: Stmt_Declare
}
