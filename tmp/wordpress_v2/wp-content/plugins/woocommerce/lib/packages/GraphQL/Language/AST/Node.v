import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	rt.PhpObjectBase
pub mut:
	loc  rt.PhpVal = rt.new_null()
	kind rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) construct(mut var_vars Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_array) {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_0 := iife_temp_0.assign(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node',
		[]string{}, this), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_array',
		[]string{}, var_vars))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) clonedeep() rt.PhpVal {
	return Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node.clonevalue(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node',
		[]string{}, this))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node.clonevalue(var_value rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(var_value,
		'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_self')))
	{
		mut var_cloned := var_value.dup()
		mut iter_1 := rt.call_function('get_object_vars', [var_cloned.clone()]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_propValue := item_1.val
			mut var_prop := item_1.key
			rt.set_property(var_cloned, '{"nodeType":"Expr_Variable","line":75,"name":"prop"}',
				Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node.clonevalue(var_propValue.clone()))
		}
		return var_cloned.clone()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_value,
		'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList')))
	{
		return rt.call_method(var_value, 'cloneDeep', []rt.PhpVal{})
	}
	return var_value.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) magic_tostring() string {
	return rt.json_encode(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', [
		'JsonSerializable',
	], &this))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) jsonserialize() rt.PhpVal {
	return this.toarray()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) toarray() rt.PhpVal {
	return Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node.recursivetoarray(mut this)
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node.recursivetoarray(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) rt.PhpVal {
	mut var_result := rt.new_array()
	mut iter_2 := rt.call_function('get_object_vars', [var_node]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_propValue := item_2.val
		mut var_prop := item_2.key
		if rt.is_true(rt.identical(var_propValue, rt.new_null())) {
			continue
		}
		if rt.is_true(rt.new_bool(rt.instance_of(var_propValue,
			'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList')))
		{
			mut var_converted := rt.new_array()
			mut iter_3 := var_propValue.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_item := item_3.val
				var_converted.array_push(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node.recursivetoarray(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](var_item)))
			}
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_propValue,
			'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node')))
		{
			var_converted =
				Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node.recursivetoarray(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](var_propValue))
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_propValue,
			'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location')))
		{
			var_converted = rt.call_method(var_propValue, 'toArray', []rt.PhpVal{})
		} else {
			var_converted = var_propValue
		}
		var_result.array_set(var_prop, var_converted.clone())
	}
	return var_result.clone()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_node(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node{
		PhpObjectBase: rt.PhpObjectBase{}
		loc:           rt.new_null()
		kind:          rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'cloneDeep' {
			return this.clonedeep()
		}
		'cloneValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node.clonevalue(dispatch_arg_0)
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'jsonSerialize' {
			return this.jsonserialize()
		}
		'toArray' {
			return this.toarray()
		}
		'recursiveToArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node.recursivetoarray(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'loc' { return this.loc }
		'kind' { return this.kind }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'loc' {
			this.loc = val
			return true
		}
		'kind' {
			this.kind = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
