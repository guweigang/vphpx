import rt

struct Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection {
	rt.PhpObjectBase
pub mut:
		headers rt.PhpVal = rt.new_array()
		headersMap rt.PhpVal = rt.new_array()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection) construct(mut var_headers Class_WordPress_AiClient_Providers_Http_Collections_array)  {
	{
		mut iter_1 := var_headers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_name := item_1.key
			this.set((var_name).str(), var_value.dup())
		}
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection) get(name string) rt.PhpVal {
	mut var_lowerName := rt.new_string(rt.new_string(name.to_lower()))
	if !(this.headersMap.array_isset(var_lowerName)) {
		return rt.new_null()
	}
	mut var_actualName := this.headersMap.array_get(var_lowerName)
	return this.headers.array_get(var_actualName)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection) getall() rt.PhpVal {
	return this.headers
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection) getasstring(name string) string {
	mut var_values := this.get(name)
	return (if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_function('implode', [rt.new_string(', '), var_values.dup()]) } else { rt.new_null() }).str()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection) has(name string) bool {
	return (rt.new_bool(this.headersMap.array_isset(rt.new_string(name.to_lower())))).to_bool()
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection) set(name string, var_value rt.PhpVal)  {
	if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
		mut var_normalizedValues := rt.call_function('array_values', [var_value.dup()])
	} else {
		var_normalizedValues = rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), var_value.dup()])])
	}
	mut var_lowerName := rt.new_string(rt.new_string(name.to_lower()))
	if this.headersMap.array_isset(var_lowerName) {
		mut var_oldName := this.headersMap.array_get(var_lowerName)
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			this.headers.array_unset(var_oldName)
		}
	}
	this.headers.array_set(name, var_normalizedValues.dup())
	this.headersMap.array_set(var_lowerName, name)
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection) withheader(name string, var_value rt.PhpVal) rt.PhpVal {
	mut var_new := // unsupported expression: Expr_Clone
	rt.call_method(var_new, 'set', [rt.new_string(name), var_value.dup()])
	return var_new.dup()
}

fn create_wordpress_aiclient_providers_http_collections_headerscollection(arg_0 rt.PhpVal) &Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection {
	mut obj := &Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection{
		PhpObjectBase: rt.PhpObjectBase{}
		headers: rt.new_array()
		headersMap: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Providers_Http_Collections_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get(dispatch_arg_0)
		}
		'getAll' {
			return this.getall()
		}
		'getAsString' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.getasstring(dispatch_arg_0))
		}
		'has' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has(dispatch_arg_0))
		}
		'set' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'withHeader' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.withheader(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'headers' { return this.headers }
		'headersMap' { return this.headersMap }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Providers_Http_Collections_HeadersCollection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'headers' { this.headers = val; return true }
		'headersMap' { this.headersMap = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_php_ai_client_src_providers_http_collections_headerscollection_php() {
	// unsupported statement: Stmt_Declare
}
