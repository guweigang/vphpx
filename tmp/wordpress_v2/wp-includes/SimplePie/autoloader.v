import rt

struct Class_SimplePie_Autoloader {
	rt.PhpObjectBase
pub mut:
	path rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Autoloader) construct() {
	this.path = (rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		(rt.get_constant('DIRECTORY_SEPARATOR')).str() + 'library'
}

fn (mut this Class_SimplePie_Autoloader) autoload(var_class rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		var_class.clone(),
		rt.new_string('SimplePie'),
	]), rt.new_int(0)))))
	{
		return
	}
	mut var_filename := rt.new_string(
		(this.path).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + (rt.call_function('str_replace', [rt.new_string('_'), rt.get_constant('DIRECTORY_SEPARATOR'), var_class.clone()])).str() +
		'.php')
	rt.include_file(var_filename.to_string(), '1')
}

fn create_simplepie_autoloader() &Class_SimplePie_Autoloader {
	mut obj := &Class_SimplePie_Autoloader{
		PhpObjectBase: rt.PhpObjectBase{}
		path:          rt.new_null()
	}
	obj.construct()
	return obj
}

fn (mut this Class_SimplePie_Autoloader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'autoload' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.autoload(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_SimplePie_Autoloader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'path' { return this.path }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Autoloader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'path' {
			this.path = val
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

	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_class := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_prefix := rt.new_string('SimplePie\\')
		mut var_base_dir := rt.new_string(@DIR + '/src/')
		mut var_len := rt.new_int(var_prefix.clone().to_string().len)
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strncmp', [
			var_prefix.clone(),
			var_class.clone(),
			var_len.clone(),
		]), rt.new_int(0)))))
		{
			return rt.new_null()
		}
		mut var_relative_class := rt.call_function('substr', [
			var_class.clone(), var_len.clone()])
		mut var_file := rt.new_string(var_base_dir.str() +
			(rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), var_relative_class.clone()])).str() +
			'.php')
		if rt.is_true(rt.call_function('file_exists', [var_file.clone()])) {
			rt.include_file(var_file.to_string(), '3')
		}
		return rt.new_null()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_class := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_prefix := rt.new_string('SimplePie\\')
		mut var_base_dir := rt.new_string(@DIR + '/src/')
		mut var_len := rt.new_int(var_prefix.clone().to_string().len)
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strncmp', [
			var_prefix.clone(),
			var_class.clone(),
			var_len.clone(),
		]), rt.new_int(0)))))
		{
			return rt.new_null()
		}
		mut var_relative_class := rt.call_function('substr', [
			var_class.clone(), var_len.clone()])
		mut var_file := rt.new_string(var_base_dir.str() +
			(rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), var_relative_class.clone()])).str() +
			'.php')
		if rt.is_true(rt.call_function('file_exists', [var_file.clone()])) {
			rt.include_file(var_file.to_string(), '3')
		}
		return rt.new_null()
	}
	rt.call_function('spl_autoload_register', [rt.new_closure(closure_1_fn)])
	rt.call_function('spl_autoload_register', [
		rt.create_array([rt.ArrayItem{ key: none, val: create_simplepie_autoloader() },
			rt.ArrayItem{ key: none, val: 'autoload' }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('SimplePie'),
	])))))
	{
		fn () {
			print((rt.new_string('Autoloader not registered properly')).str())
			exit(0)
		}()
	}
}
