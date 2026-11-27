module vphp

fn (v DynValue) is_persistent_safe() bool {
	return match v.type {
		.null_, .bool_, .int_, .float_, .string_ {
			true
		}
		.array_ {
			if v.array == unsafe { nil } {
				return true
			}
			mut iter := v.array.iter()
			for {
				item := iter.next() or { break }
				if !item.val.is_persistent_safe() {
					return false
				}
			}
			true
		}
		.list_ {
			for item in v.list {
				if !item.is_persistent_safe() {
					return false
				}
			}
			true
		}
		.map_ {
			for _, item in v.map {
				if !item.is_persistent_safe() {
					return false
				}
			}
			true
		}
		.object_ref, .callable_ref {
			v.runtime_lifecycle == .persistent
		}
		.resource_ref {
			false
		}
	}
}

fn (v DynValue) request_owned() RequestOwnedZBox {
	mut out := ZVal.new_request()
	v.to_zval(mut out) or {
		out.release()
		return RequestOwnedZBox.new_null()
	}
	return request_owned_zbox_from_adopted_zval(out)
}

fn (v DynValue) to_string() string {
	return match v.type {
		.null_ {
			''
		}
		.bool_ {
			if v.bool_value() {
				'1'
			} else {
				''
			}
		}
		.int_ {
			v.int_value().str()
		}
		.float_ {
			v.float_value().str()
		}
		.string_ {
			v.string_value().clone()
		}
		else {
			mut temp := v.request_owned()
			defer {
				temp.release()
			}
			temp.to_string()
		}
	}
}

fn (v DynValue) to_string_list() []string {
	return match v.type {
		.array_ {
			if v.array == unsafe { nil } {
				return []string{}
			}
			mut out := []string{}
			mut iter := v.array.iter()
			for {
				item := iter.next() or { break }
				out << item.val.to_string()
			}
			out
		}
		.list_ {
			mut out := []string{}
			for item in v.list {
				out << item.to_string()
			}
			out
		}
		.string_ {
			[v.to_string()]
		}
		else {
			mut temp := v.request_owned()
			defer {
				temp.release()
			}
			temp.to_string_list()
		}
	}
}

fn (v DynValue) to_string_map() map[string]string {
	return match v.type {
		.array_ {
			if v.array == unsafe { nil } {
				return map[string]string{}
			}
			mut out := map[string]string{}
			mut iter := v.array.iter()
			for {
				item := iter.next() or { break }
				out[item.key.to_string()] = item.val.to_string()
			}
			out
		}
		.map_ {
			mut out := map[string]string{}
			for key, item in v.map {
				out[key] = item.to_string()
			}
			out
		}
		else {
			mut temp := v.request_owned()
			defer {
				temp.release()
			}
			temp.to_string_map()
		}
	}
}

fn (v DynValue) to_bool() bool {
	return match v.type {
		.null_ {
			false
		}
		.bool_ {
			v.bool_value()
		}
		.int_ {
			v.int_value() != 0
		}
		.float_ {
			v.float_value() != 0.0
		}
		.string_ {
			v.string_value().len > 0
		}
		.array_ {
			if v.array == unsafe { nil } {
				false
			} else {
				v.array.count() > 0
			}
		}
		.list_ {
			v.list.len > 0
		}
		.map_ {
			v.map.len > 0
		}
		else {
			false
		}
	}
}

fn (v DynValue) to_int() int {
	return match v.type {
		.int_ {
			int(v.int_value())
		}
		.bool_ {
			if v.bool_value() {
				1
			} else {
				0
			}
		}
		.float_ {
			int(v.float_value())
		}
		.string_ {
			v.to_string().int()
		}
		else {
			0
		}
	}
}

fn (v DynValue) to_i64() i64 {
	return match v.type {
		.int_ {
			v.int_value()
		}
		.bool_ {
			if v.bool_value() {
				i64(1)
			} else {
				i64(0)
			}
		}
		.float_ {
			i64(v.float_value())
		}
		.string_ {
			v.to_string().i64()
		}
		else {
			i64(0)
		}
	}
}

fn (v DynValue) to_f64() f64 {
	return match v.type {
		.float_ {
			v.float_value()
		}
		.int_ {
			f64(v.int_value())
		}
		.bool_ {
			if v.bool_value() {
				1.0
			} else {
				0.0
			}
		}
		.string_ {
			v.to_string().f64()
		}
		else {
			0.0
		}
	}
}
