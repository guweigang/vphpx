import rt

struct Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary {
	rt.PhpObjectBase
pub mut:
	data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) construct(mut var_data Class_WpOrg_Requests_Utility_array) {
	mut iter_1 := var_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_offset := item_1.key
		this.offsetset(var_offset.clone(), var_value.clone())
	}
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) offsetexists(var_offset rt.PhpVal) rt.PhpVal {
	mut var_offset_mutated := var_offset
	if rt.is_true(rt.new_bool(var_offset_mutated.clone().is_string())) {
		var_offset_mutated = rt.new_string(var_offset_mutated.clone().to_string().to_lower())
	}
	if rt.is_true(rt.identical(var_offset_mutated, rt.new_null())) {
		var_offset_mutated = rt.new_string('')
	}
	return rt.new_bool(this.data.array_isset(var_offset_mutated))
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	mut var_offset_mutated := var_offset
	if rt.is_true(rt.new_bool(var_offset_mutated.clone().is_string())) {
		var_offset_mutated = rt.new_string(var_offset_mutated.clone().to_string().to_lower())
	}
	if rt.is_true(rt.identical(var_offset_mutated, rt.new_null())) {
		var_offset_mutated = rt.new_string('')
	}
	if !(this.data.array_isset(var_offset_mutated)) {
		return rt.new_null()
	}
	return this.data.array_get(var_offset_mutated)
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	mut var_offset_mutated := var_offset
	if rt.is_true(rt.identical(var_offset_mutated, rt.new_null())) {
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('Object is a dictionary, not a list'),
			rt.new_string('invalidset'))))
	}
	if rt.is_true(rt.new_bool(var_offset_mutated.clone().is_string())) {
		var_offset_mutated = rt.new_string(var_offset_mutated.clone().to_string().to_lower())
	}
	this.data.array_set(var_offset_mutated, var_value.clone())
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) offsetunset(var_offset rt.PhpVal) {
	mut var_offset_mutated := var_offset
	if rt.is_true(rt.new_bool(var_offset_mutated.clone().is_string())) {
		var_offset_mutated = rt.new_string(var_offset_mutated.clone().to_string().to_lower())
	}
	if rt.is_true(rt.identical(var_offset_mutated, rt.new_null())) {
		var_offset_mutated = rt.new_string('')
	}
	this.data.array_unset(var_offset_mutated)
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) getiterator() rt.PhpVal {
	return rt.new_object('ArrayIterator', []string{}, create_arrayiterator(this.data))
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) getall() rt.PhpVal {
	return this.data
}

struct Class_WpOrg_Requests_Exception {
	rt.PhpObjectBase
}

struct Class_ArrayIterator {
	rt.PhpObjectBase
}

fn create_wporg_requests_utility_caseinsensitivedictionary(arg_0 rt.PhpVal) &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary {
	mut obj := &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary{
		PhpObjectBase: rt.PhpObjectBase{}
		data:          rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wporg_requests_exception(_args ...rt.PhpVal) &Class_WpOrg_Requests_Exception {
	mut obj := &Class_WpOrg_Requests_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_arrayiterator(_args ...rt.PhpVal) &Class_ArrayIterator {
	mut obj := &Class_ArrayIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WpOrg_Requests_Utility_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetexists(dispatch_arg_0)
		}
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
		'offsetUnset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetunset(dispatch_arg_0)
			return rt.new_null()
		}
		'getIterator' {
			return this.getiterator()
		}
		'getAll' {
			return this.getall()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WpOrg_Requests_Utility_CaseInsensitiveDictionary) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' {
			this.data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_ArrayIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ArrayIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ArrayIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
