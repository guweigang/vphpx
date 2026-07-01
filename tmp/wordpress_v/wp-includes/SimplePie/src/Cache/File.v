import rt

struct Class_SimplePie_Cache_File {
	rt.PhpObjectBase
pub mut:
		location string
		filename string
		extension rt.PhpVal = rt.new_null()
		name string
}

fn (mut this Class_SimplePie_Cache_File) construct(location string, name string, var_type rt.PhpVal)  {
	this.location = location
	this.filename = name
	this.extension = var_type.dup()
	this.name = rt.concat(rt.concat(rt.concat(rt.concat(this.location, rt.new_string('/')), this.filename), rt.new_string('.')), this.extension)
}

fn (mut this Class_SimplePie_Cache_File) save(var_data rt.PhpVal) bool {
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('file_exists', [this.name])) && rt.is_true(rt.call_function('is_writable', [this.name])))) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('file_exists', [this.location])) && rt.is_true(rt.call_function('is_writable', [this.location])))))) {
		if rt.is_true(rt.new_bool(rt.instance_of(var_data_mutated, 'SimplePie_Cache_SimplePie_SimplePie'))) {
			var_data_mutated = rt.get_property(var_data_mutated, 'data')
		}
		var_data_mutated = rt.call_function('serialize', [var_data_mutated.dup()])
		return (// unsupported expression: Expr_Cast_Bool).to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Cache_File) load() bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('file_exists', [this.name])) && rt.is_true(rt.call_function('is_readable', [this.name])))) {
		return (rt.call_function('unserialize', [// unsupported expression: Expr_Cast_String])).to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Cache_File) mtime() rt.PhpVal {
	return rt.call_function('filemtime', [this.name])
}

fn (mut this Class_SimplePie_Cache_File) touch() rt.PhpVal {
	return rt.call_function('touch', [this.name])
}

fn (mut this Class_SimplePie_Cache_File) unlink() bool {
	if rt.is_true(rt.call_function('file_exists', [this.name])) {
		return (rt.call_function('unlink', [this.name])).to_bool()
	}
	return false
}

fn create_simplepie_cache_file(location string, name string, arg_2 rt.PhpVal) &Class_SimplePie_Cache_File {
	mut obj := &Class_SimplePie_Cache_File{
		PhpObjectBase: rt.PhpObjectBase{}
		location: ''
		filename: ''
		extension: rt.new_null()
		name: ''
	}
	obj.construct(location, name, arg_2)
	return obj
}

fn (mut this Class_SimplePie_Cache_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.save(dispatch_arg_0))
		}
		'load' {
			return rt.new_bool(this.load())
		}
		'mtime' {
			return this.mtime()
		}
		'touch' {
			return this.touch()
		}
		'unlink' {
			return rt.new_bool(this.unlink())
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Cache_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'location' { return rt.new_string(this.location) }
		'filename' { return rt.new_string(this.filename) }
		'extension' { return this.extension }
		'name' { return rt.new_string(this.name) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Cache_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'location' { this.location = (val).str(); return true }
		'filename' { this.filename = (val).str(); return true }
		'extension' { this.extension = val; return true }
		'name' { this.name = (val).str(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_simplepie_src_cache_file_php() {
	// unsupported statement: Stmt_Declare
	rt.call_function('class_alias', [rt.new_string('SimplePie\\Cache\\File'), rt.new_string('SimplePie_Cache_File')])
}
