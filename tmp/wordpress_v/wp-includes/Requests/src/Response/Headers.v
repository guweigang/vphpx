import rt

struct Class_WpOrg_Requests_Response_Headers {
	rt.PhpObjectBase
}

fn (mut this Class_WpOrg_Requests_Response_Headers) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	mut var_offset_mutated := var_offset
	if rt.is_true(rt.new_bool(var_offset_mutated.dup().is_string())) {
		var_offset_mutated =
			rt.new_string(rt.new_string(var_offset_mutated.dup().to_string().to_lower()))
	}
	if !(!var_offset_mutated.is_null()
		&& rt.get_property(rt.new_object('WpOrg_Requests_Response_Headers', ['WpOrg_Requests_Utility_CaseInsensitiveDictionary'], &this), 'data').array_isset(var_offset_mutated)) {
		return rt.new_null()
	}
	return this.flatten(rt.get_property(rt.new_object('WpOrg_Requests_Response_Headers', [
		'WpOrg_Requests_Utility_CaseInsensitiveDictionary',
	], &this), 'data').array_get(var_offset_mutated))
}

fn (mut this Class_WpOrg_Requests_Response_Headers) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	mut var_offset_mutated := var_offset
	if rt.is_true(rt.identical(var_offset_mutated, rt.new_null())) {
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('Object is a dictionary, not a list'),
			rt.new_string('invalidset'))))
	}
	if rt.is_true(rt.new_bool(var_offset_mutated.dup().is_string())) {
		var_offset_mutated =
			rt.new_string(rt.new_string(var_offset_mutated.dup().to_string().to_lower()))
	}
	if !(rt.get_property(rt.new_object('WpOrg_Requests_Response_Headers', [
		'WpOrg_Requests_Utility_CaseInsensitiveDictionary',
	], &this), 'data').array_isset(var_offset_mutated)) {
		rt.get_property(rt.new_object('WpOrg_Requests_Response_Headers', [
			'WpOrg_Requests_Utility_CaseInsensitiveDictionary',
		], &this), 'data').array_set(var_offset_mutated, rt.new_array())
	}
	rt.get_property(rt.new_object('WpOrg_Requests_Response_Headers', [
		'WpOrg_Requests_Utility_CaseInsensitiveDictionary',
	], &this), 'data').array_get_mut(var_offset_mutated).array_push(var_value.dup())
}

fn (mut this Class_WpOrg_Requests_Response_Headers) getvalues(var_offset rt.PhpVal) rt.PhpVal {
	mut var_offset_mutated := var_offset
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_offset_mutated.dup().is_string())))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_offset_mutated.dup().is_long())))))))
	{
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
			mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}
			return temp.create(arg_0, arg_1, arg_2, arg_3)
		}(rt.new_int(1), rt.new_string('$offset'), rt.new_string('string|int'), rt.call_function('gettype', [
			var_offset_mutated.dup(),
		])))
	}
	if rt.is_true(rt.new_bool(var_offset_mutated.dup().is_string())) {
		var_offset_mutated =
			rt.new_string(rt.new_string(var_offset_mutated.dup().to_string().to_lower()))
	}
	if !(rt.get_property(rt.new_object('WpOrg_Requests_Response_Headers', [
		'WpOrg_Requests_Utility_CaseInsensitiveDictionary',
	], &this), 'data').array_isset(var_offset_mutated)) {
		return rt.new_null()
	}
	return rt.get_property(rt.new_object('WpOrg_Requests_Response_Headers', [
		'WpOrg_Requests_Utility_CaseInsensitiveDictionary',
	], &this), 'data').array_get(var_offset_mutated)
}

fn (mut this Class_WpOrg_Requests_Response_Headers) flatten(var_value rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_value.dup().is_string())) {
		return var_value.dup()
	}
	if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
		return rt.call_function('implode', [rt.new_string(','),
			var_value.dup()])
	}
	rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WpOrg_Requests_Exception_InvalidArgument{}
		return temp.create(arg_0, arg_1, arg_2, arg_3)
	}(rt.new_int(1), rt.new_string('$value'), rt.new_string('string|array'), rt.call_function('gettype', [
		var_value.dup(),
	])))
	return rt.new_null()
}

fn (mut this Class_WpOrg_Requests_Response_Headers) getiterator() rt.PhpVal {
	return create_wporg_requests_utility_filterediterator(rt.get_property(rt.new_object('WpOrg_Requests_Response_Headers', [
		'WpOrg_Requests_Utility_CaseInsensitiveDictionary',
	], &this), 'data'), rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_object('WpOrg_Requests_Response_Headers', [
			'WpOrg_Requests_Utility_CaseInsensitiveDictionary',
		], &this) },
		rt.ArrayItem{ key: none, val: 'flatten' },
	]))
}

struct Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception_InvalidArgument {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Utility_FilteredIterator {
	rt.PhpObjectBase
}

fn create_wporg_requests_response_headers() &Class_WpOrg_Requests_Response_Headers {
	mut obj := &Class_WpOrg_Requests_Response_Headers{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_utility_caseinsensitivedictionary() &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary {
	mut obj := &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception() &Class_WpOrg_Requests_Exception {
	mut obj := &Class_WpOrg_Requests_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception_invalidargument() &Class_WpOrg_Requests_Exception_InvalidArgument {
	mut obj := &Class_WpOrg_Requests_Exception_InvalidArgument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_utility_filterediterator() &Class_WpOrg_Requests_Utility_FilteredIterator {
	mut obj := &Class_WpOrg_Requests_Utility_FilteredIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Response_Headers) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetget(dispatch_arg_0)
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'getValues' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.getvalues(dispatch_arg_0)
		}
		'flatten' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.flatten(dispatch_arg_0)
		}
		'getIterator' {
			return this.getiterator()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WpOrg_Requests_Response_Headers) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Response_Headers) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Utility_FilteredIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Utility_FilteredIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Utility_FilteredIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_requests_src_response_headers_php() {
}
