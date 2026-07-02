import rt

struct Class_WP_MatchesMapRegex {
	rt.PhpObjectBase
pub mut:
	_matches rt.PhpVal = rt.new_null()
	output   rt.PhpVal = rt.new_null()
	_subject rt.PhpVal = rt.new_null()
	_pattern rt.PhpVal = rt.new_string('(\\$matches\\[[1-9]+[0-9]*\\])')
}

fn (mut this Class_WP_MatchesMapRegex) construct(var_subject rt.PhpVal, var_matches rt.PhpVal) {
	this._subject = var_subject.clone()
	this._matches = var_matches.clone()
	this.output = this._map()
}

fn Class_WP_MatchesMapRegex.apply(var_subject rt.PhpVal, var_matches rt.PhpVal) rt.PhpVal {
	mut var_result := create_wp_matchesmapregex(var_subject.clone(), var_matches.clone())
	return var_result.output
}

fn (mut this Class_WP_MatchesMapRegex) _map() rt.PhpVal {
	mut var_callback := [rt.new_object('WP_MatchesMapRegex', []string{}, &this),
		rt.new_string('callback')]
	return rt.call_function('preg_replace_callback', [this._pattern,
		rt.create_array_from_list(var_callback), this._subject])
}

fn (mut this Class_WP_MatchesMapRegex) callback(var_matches rt.PhpVal) rt.PhpVal {
	mut var_index := rt.new_int((rt.call_function('substr', [
		var_matches.array_get(rt.new_int(0)), rt.new_int(9), rt.new_int(-1)])).to_i64())
	return if this._matches.array_isset(var_index) { rt.call_function('urlencode', [
			this._matches.array_get(var_index),
		]) } else { rt.new_string('') }
}

fn create_wp_matchesmapregex(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WP_MatchesMapRegex {
	mut obj := &Class_WP_MatchesMapRegex{
		PhpObjectBase: rt.PhpObjectBase{}
		_matches:      rt.new_null()
		output:        rt.new_null()
		_subject:      rt.new_null()
		_pattern:      rt.new_string('(\\$matches\\[[1-9]+[0-9]*\\])')
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_WP_MatchesMapRegex) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'apply' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_MatchesMapRegex.apply(dispatch_arg_0, dispatch_arg_1)
		}
		'_map' {
			return this._map()
		}
		'callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.callback(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_MatchesMapRegex) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'_matches' { return this._matches }
		'output' { return this.output }
		'_subject' { return this._subject }
		'_pattern' { return this._pattern }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_MatchesMapRegex) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'_matches' {
			this._matches = val
			return true
		}
		'output' {
			this.output = val
			return true
		}
		'_subject' {
			this._subject = val
			return true
		}
		'_pattern' {
			this._pattern = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
