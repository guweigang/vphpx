import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source {
	rt.PhpObjectBase
pub mut:
		body string
		length rt.PhpVal = rt.new_null()
		name rt.PhpVal = rt.new_null()
		locationOffset rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source) construct(body string, mut var_name Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string, mut var_location Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?SourceLocation) {
	this.body = body
	this.length = rt.call_function('mb_strlen', [rt.new_string(body), rt.new_string('UTF-8')])
	this.name = if rt.is_true(rt.identical(var_name, rt.new_string(''))) || rt.is_true(rt.identical(var_name, rt.new_null())) { rt.new_string('Automattic\\WooCommerce\\Vendor\\GraphQL request') } else { var_name }
	this.locationOffset = if !(var_location).is_null() { var_location } else { create_automattic_woocommerce_vendor_graphql_language_sourcelocation(rt.new_int(1), rt.new_int(1)) }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source) getlocation(position i64) rt.PhpVal {
	mut var_line := rt.new_int(1)
	mut var_column := rt.new_int(position + 1)
	mut var_utfChars := rt.call_function('json_decode', [rt.new_string('"\\u2028\\u2029"')])
	mut var_lineRegexp := rt.new_string('/\\r\\n|[\\n\\r' + (var_utfChars).str() + ']/su')
	mut var_matches := rt.new_array()
	rt.call_function('preg_match_all', [var_lineRegexp.clone(), rt.call_function('mb_substr', [rt.new_string(this.body), rt.new_int(0), rt.new_int(position), rt.new_string('UTF-8')]), var_matches.clone(), rt.get_constant('PREG_OFFSET_CAPTURE')])
	mut iter_1 := var_matches.array_get(rt.new_int(0)).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_match := item_1.val
		rt.pre_inc(var_line)
	var_column = rt.sub(position + 1, rt.add(var_match.array_get(rt.new_int(1)), rt.call_function('mb_strlen', [var_match.array_get(rt.new_int(0)), rt.new_string('UTF-8')])))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation', []string{}, create_automattic_woocommerce_vendor_graphql_language_sourcelocation(var_line.clone(), var_column.clone()))
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_source(body string, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source{
		PhpObjectBase: rt.PhpObjectBase{}
		body: ''
		length: rt.new_null()
		name: rt.new_null()
		locationOffset: rt.new_null()
	}
	obj.construct(body, arg_1, arg_2)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_sourcelocation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?SourceLocation](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'getLocation' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.getlocation(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'body' { return rt.new_string(this.body) }
		'length' { return this.length }
		'name' { return this.name }
		'locationOffset' { return this.locationOffset }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'body' { this.body = (val).str(); return true }
		'length' { this.length = val; return true }
		'name' { this.name = val; return true }
		'locationOffset' { this.locationOffset = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_SourceLocation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
