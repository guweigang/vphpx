module rt

struct Registry {
mut:
	func_registry   map[string]fn ([]PhpVal) PhpVal
	class_factories map[string]fn ([]PhpVal) PhpVal
	// 静态属性表：class_name -> prop_name -> value
	static_props    map[string]map[string]PhpVal
}

fn C.php2v_get_registry() voidptr
fn C.php2v_set_registry(p voidptr)

fn get_registry() &Registry {
	mut p := C.php2v_get_registry()
	if p == unsafe { nil } {
		mut r := &Registry{
			func_registry:   map[string]fn ([]PhpVal) PhpVal{}
			class_factories: map[string]fn ([]PhpVal) PhpVal{}
			static_props:    map[string]map[string]PhpVal{}
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

// --- 静态属性支持 (ClassEntry 机制) ---

// init_static_prop 初始化一个静态属性（在模块初始化时调用）
pub fn init_static_prop(class_name string, prop_name string, default_val PhpVal) {
	mut r := get_registry()
	if class_name !in r.static_props {
		r.static_props[class_name] = map[string]PhpVal{}
	}
	// 只在未初始化时设置默认值（避免重复初始化覆盖已有值）
	if prop_name !in r.static_props[class_name] {
		r.static_props[class_name][prop_name] = default_val
	}
}

// get_static_prop 读取静态属性
// 对于 static:: 后期绑定，runtime_class 是实际调用的子类名
// 对于 self:: / ClassName::，runtime_class 等于 class_name
pub fn get_static_prop(class_name string, prop_name string) PhpVal {
	mut r := get_registry()
	if class_name in r.static_props {
		return r.static_props[class_name][prop_name] or { new_null() }
	}
	return new_null()
}

// set_static_prop 写入静态属性
pub fn set_static_prop(class_name string, prop_name string, val PhpVal) {
	mut r := get_registry()
	if class_name !in r.static_props {
		r.static_props[class_name] = map[string]PhpVal{}
	}
	r.static_props[class_name][prop_name] = val
}
