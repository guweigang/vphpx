import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location {
	rt.PhpObjectBase
pub mut:
		start rt.PhpVal = rt.new_null()
		end rt.PhpVal = rt.new_null()
		startToken rt.PhpVal = rt.new_null()
		endToken rt.PhpVal = rt.new_null()
		source rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location.create(start i64, end i64) rt.PhpVal {
	mut var_tmp := create_automattic_woocommerce_vendor_graphql_language_ast_static()
	rt.set_property(var_tmp, 'start', rt.new_int(start))
	rt.set_property(var_tmp, 'end', rt.new_int(end))
	return mut var_tmp
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location) construct(mut var_startToken Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_?Token, mut var_endToken Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_?Token, mut var_source Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_?Source) {
	this.startToken = var_startToken
	this.endToken = var_endToken
	this.source = var_source
	if rt.is_true(rt.identical(var_startToken, rt.new_null())) || rt.is_true(rt.identical(var_endToken, rt.new_null())) {
		return
	}
	this.start = rt.get_property(var_startToken, 'start')
	this.end = rt.get_property(var_endToken, 'end')
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location) toarray() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'start', val: this.start }, rt.ArrayItem{ key: 'end', val: this.end }])
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_static {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_location(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location{
		PhpObjectBase: rt.PhpObjectBase{}
		start: rt.new_null()
		end: rt.new_null()
		startToken: rt.new_null()
		endToken: rt.new_null()
		source: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_static {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'create' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location.create(dispatch_arg_0, dispatch_arg_1)
		}
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_?Token](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_?Token](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_?Source](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'toArray' {
			return this.toarray()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'start' { return this.start }
		'end' { return this.end }
		'startToken' { return this.startToken }
		'endToken' { return this.endToken }
		'source' { return this.source }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'start' { this.start = val; return true }
		'end' { this.end = val; return true }
		'startToken' { this.startToken = val; return true }
		'endToken' { this.endToken = val; return true }
		'source' { this.source = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
