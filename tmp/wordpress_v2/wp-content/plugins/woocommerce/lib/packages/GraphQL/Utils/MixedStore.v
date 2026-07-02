import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore {
	rt.PhpObjectBase
pub mut:
	standardStore   rt.PhpVal = rt.new_array()
	floatStore      rt.PhpVal = rt.new_array()
	objectStore     rt.PhpVal = rt.new_null()
	arrayKeys       rt.PhpVal = rt.new_array()
	arrayValues     rt.PhpVal = rt.new_array()
	lastArrayKey    rt.PhpVal = rt.new_null()
	lastArrayValue  rt.PhpVal = rt.new_null()
	nullValue       rt.PhpVal = rt.new_null()
	nullValueIsSet  bool
	trueValue       rt.PhpVal = rt.new_null()
	trueValueIsSet  bool
	falseValue      rt.PhpVal = rt.new_null()
	falseValueIsSet bool
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore) construct() {
	this.objectStore = create_automattic_woocommerce_vendor_graphql_utils_splobjectstorage()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore) offsetexists(var_offset rt.PhpVal) bool {
	if rt.is_true(rt.identical(var_offset, rt.new_bool(false))) {
		return this.falseValueIsSet
	}
	if rt.is_true(rt.identical(var_offset, rt.new_bool(true))) {
		return this.trueValueIsSet
	}
	if var_offset.clone().is_long() || var_offset.clone().is_string() {
		return this.standardStore.array_isset(var_offset.clone())
	}
	if rt.is_true(rt.new_bool(var_offset.clone().is_double())) {
		return this.floatStore.array_isset(rt.new_string(var_offset.str()))
	}
	if rt.is_true(rt.new_bool(var_offset.clone().is_object())) {
		return (rt.call_method(this.objectStore, 'offsetExists', [
			var_offset.clone()])).to_bool()
	}
	if rt.is_true(rt.new_bool(var_offset.clone().is_array())) {
		mut iter_1 := this.arrayKeys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_entry := item_1.val
			mut var_index := item_1.key
			if rt.is_true(rt.identical(var_entry, var_offset)) {
				this.lastArrayKey = var_offset.clone()
				this.lastArrayValue = this.arrayValues.array_get(var_index)
				return true
			}
		}
	}
	if rt.is_true(rt.identical(var_offset, rt.new_null())) {
		return this.nullValueIsSet
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(var_offset, rt.new_bool(true))) {
		return this.trueValue
	}
	if rt.is_true(rt.identical(var_offset, rt.new_bool(false))) {
		return this.falseValue
	}
	if var_offset.clone().is_long() || var_offset.clone().is_string() {
		return this.standardStore.array_get(var_offset)
	}
	if rt.is_true(rt.new_bool(var_offset.clone().is_double())) {
		return this.floatStore.array_get(rt.new_string(var_offset.str()))
	}
	if rt.is_true(rt.new_bool(var_offset.clone().is_object())) {
		return rt.call_method(this.objectStore, 'offsetGet', [
			var_offset.clone()])
	}
	if rt.is_true(rt.new_bool(var_offset.clone().is_array())) {
		if rt.is_true(rt.identical(this.lastArrayKey, var_offset)) {
			return this.lastArrayValue
		}
		mut iter_2 := this.arrayKeys.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_entry := item_2.val
			mut var_index := item_2.key
			if rt.is_true(rt.identical(var_entry, var_offset)) {
				return this.arrayValues.array_get(var_index)
			}
		}
	}
	if rt.is_true(rt.identical(var_offset, rt.new_null())) {
		return this.nullValue
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.identical(var_offset, rt.new_bool(false))) {
		this.falseValue = var_value.clone()
		this.falseValueIsSet = true
	} else if rt.is_true(rt.identical(var_offset, rt.new_bool(true))) {
		this.trueValue = var_value.clone()
		this.trueValueIsSet = true
	} else if var_offset.clone().is_long() || var_offset.clone().is_string() {
		this.standardStore.array_set(var_offset, var_value.clone())
	} else if rt.is_true(rt.new_bool(var_offset.clone().is_double())) {
		this.floatStore.array_set(var_offset.str(), var_value.clone())
	} else if rt.is_true(rt.new_bool(var_offset.clone().is_object())) {
		this.objectStore.array_set(var_offset, var_value.clone())
	} else if rt.is_true(rt.new_bool(var_offset.clone().is_array())) {
		this.arrayKeys.array_push(var_offset.clone())
		this.arrayValues.array_push(var_value.clone())
	} else if rt.is_true(rt.identical(var_offset, rt.new_null())) {
		this.nullValue = var_value.clone()
		this.nullValueIsSet = true
	} else {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_0 := iife_temp_0.printsafe(var_offset.clone())
		mut var_unexpectedOffset := iife_result_0
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_InvalidArgumentException',
			[]string{},
			create_automattic_woocommerce_vendor_graphql_utils_invalidargumentexception(rt.new_string('Unexpected offset type: ${var_unexpectedOffset.to_string()}'))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore) offsetunset(var_offset rt.PhpVal) {
	if rt.is_true(rt.identical(var_offset, rt.new_bool(true))) {
		this.trueValue = rt.new_null()
		this.trueValueIsSet = false
	} else if rt.is_true(rt.identical(var_offset, rt.new_bool(false))) {
		this.falseValue = rt.new_null()
		this.falseValueIsSet = false
	} else if var_offset.clone().is_long() || var_offset.clone().is_string() {
		this.standardStore.array_unset(var_offset)
	} else if rt.is_true(rt.new_bool(var_offset.clone().is_double())) {
		this.floatStore.array_unset(var_offset.str())
	} else if rt.is_true(rt.new_bool(var_offset.clone().is_object())) {
		rt.call_method(this.objectStore, 'offsetUnset', [var_offset.clone()])
	} else if rt.is_true(rt.new_bool(var_offset.clone().is_array())) {
		mut var_index := rt.call_function('array_search', [var_offset.clone(), this.arrayKeys,
			rt.new_bool(true)])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_index, rt.new_bool(false))))) {
			rt.call_function('array_splice', [this.arrayKeys, var_index.clone(),
				rt.new_int(1)])
			rt.call_function('array_splice', [this.arrayValues, var_index.clone(),
				rt.new_int(1)])
		}
	} else if rt.is_true(rt.identical(var_offset, rt.new_null())) {
		this.nullValue = rt.new_null()
		this.nullValueIsSet = false
	}
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SplObjectStorage {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_utils_mixedstore() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore{
		PhpObjectBase:   rt.PhpObjectBase{}
		standardStore:   rt.new_array()
		floatStore:      rt.new_array()
		objectStore:     rt.new_null()
		arrayKeys:       rt.new_array()
		arrayValues:     rt.new_array()
		lastArrayKey:    rt.new_null()
		lastArrayValue:  rt.new_null()
		nullValue:       rt.new_null()
		nullValueIsSet:  false
		trueValue:       rt.new_null()
		trueValueIsSet:  false
		falseValue:      rt.new_null()
		falseValueIsSet: false
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_splobjectstorage(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SplObjectStorage {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SplObjectStorage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_invalidargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.offsetexists(dispatch_arg_0))
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'standardStore' { return this.standardStore }
		'floatStore' { return this.floatStore }
		'objectStore' { return this.objectStore }
		'arrayKeys' { return this.arrayKeys }
		'arrayValues' { return this.arrayValues }
		'lastArrayKey' { return this.lastArrayKey }
		'lastArrayValue' { return this.lastArrayValue }
		'nullValue' { return this.nullValue }
		'nullValueIsSet' { return rt.new_bool(this.nullValueIsSet) }
		'trueValue' { return this.trueValue }
		'trueValueIsSet' { return rt.new_bool(this.trueValueIsSet) }
		'falseValue' { return this.falseValue }
		'falseValueIsSet' { return rt.new_bool(this.falseValueIsSet) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'standardStore' {
			this.standardStore = val
			return true
		}
		'floatStore' {
			this.floatStore = val
			return true
		}
		'objectStore' {
			this.objectStore = val
			return true
		}
		'arrayKeys' {
			this.arrayKeys = val
			return true
		}
		'arrayValues' {
			this.arrayValues = val
			return true
		}
		'lastArrayKey' {
			this.lastArrayKey = val
			return true
		}
		'lastArrayValue' {
			this.lastArrayValue = val
			return true
		}
		'nullValue' {
			this.nullValue = val
			return true
		}
		'nullValueIsSet' {
			this.nullValueIsSet = val.to_bool()
			return true
		}
		'trueValue' {
			this.trueValue = val
			return true
		}
		'trueValueIsSet' {
			this.trueValueIsSet = val.to_bool()
			return true
		}
		'falseValue' {
			this.falseValue = val
			return true
		}
		'falseValueIsSet' {
			this.falseValueIsSet = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SplObjectStorage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SplObjectStorage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_SplObjectStorage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
