import rt

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Request {
	rt.PhpObjectBase
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Request) construct(method string, var_uri rt.PhpVal, mut var_headers Class_WordPress_AiClientDependencies_Nyholm_Psr7_array, var_body rt.PhpVal, version string) {
	mut var_uri_mutated := var_uri
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_Uri',
		[]string{}, var_uri_mutated),
		'WordPress_AiClientDependencies_Psr_Http_Message_UriInterface'))))))
	{
		var_uri_mutated =
			create_wordpress_aiclientdependencies_nyholm_psr7_uri(var_uri_mutated.clone())
	}
	this.dispatch_set_prop('method', rt.new_string(method))
	this.dispatch_set_prop('uri', var_uri_mutated.clone())
	this.setheaders(rt.new_object('WordPress_AiClientDependencies_Nyholm_Psr7_array', []string{},
		var_headers))
	this.dispatch_set_prop('protocol', rt.new_string(version))
	if rt.is_true(rt.new_bool(!(rt.is_true(this.hasheader(rt.new_string('Host')))))) {
		this.updatehostfromuri()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_body))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_body)))) {
		mut iife_temp_0 := Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{}
		mut iife_result_0 := iife_temp_0.create(var_body.clone())
		this.dispatch_set_prop('stream', iife_result_0)
	}
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_request(method string, arg_1 rt.PhpVal, arg_2 rt.PhpVal, version string, arg_4 rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Request {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(method, arg_1, arg_2, version, arg_4)
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_uri(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_stream(_args ...rt.PhpVal) &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WordPress_AiClientDependencies_Nyholm_Psr7_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Uri) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_Stream) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
