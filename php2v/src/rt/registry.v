module rt

struct Registry {
mut:
	func_registry   map[string]fn ([]PhpVal) PhpVal
	class_factories map[string]fn ([]PhpVal) PhpVal
}

fn C.php2v_get_registry() voidptr
fn C.php2v_set_registry(p voidptr)

fn get_registry() &Registry {
	mut p := C.php2v_get_registry()
	if p == unsafe { nil } {
		mut r := &Registry{
			func_registry: map[string]fn ([]PhpVal) PhpVal{}
			class_factories: map[string]fn ([]PhpVal) PhpVal{}
		}
		C.php2v_set_registry(voidptr(r))
		return r
	}
	return &Registry(p)
}

pub fn register_func(name string, f fn ([]PhpVal) PhpVal) {
	mut r := get_registry()
	r.func_registry[name] = f
}

pub fn register_class_factory(name string, f fn ([]PhpVal) PhpVal) {
	mut r := get_registry()
	r.class_factories[name] = f
}

pub fn create_object_dynamically(class_name string, args []PhpVal) PhpVal {
	mut r := get_registry()
	if class_name in r.class_factories {
		return r.class_factories[class_name](args)
	}
	eprintln('Class not found dynamically: ' + class_name)
	return new_null()
}

pub fn call_callable(cb PhpVal, args []PhpVal) PhpVal {
	if cb.is_closure() {
		return call_closure_val(cb, args)
	}
	if cb.is_string() {
		func_name := cb.to_string()
		mut r := get_registry()
		if func_name in r.func_registry {
			return r.func_registry[func_name](args)
		}
		return call_function(func_name, args)
	}
	return new_null()
}
