module rt

struct Registry {
mut:
	func_registry   map[string]fn ([]PhpVal) PhpVal
	class_factories map[string]fn ([]PhpVal) PhpVal
	// 静态属性表：class_name -> prop_name -> value
	static_props    map[string]map[string]PhpVal
	mysql_pool      voidptr
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
		C.php2v_set_v_callback(voidptr(my_v_callback_handler))
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

// ---------------- 沙箱互操作回调处理 ----------------
fn C.php2v_set_v_callback(cb voidptr)
fn C.php2v_extract_array_elements(z_arr voidptr, out_elements &voidptr) int
fn C.php2v_get_array_num_elements(z_arr voidptr) int

// my_v_callback_handler V 语言中转路由回调，接收来自 PHP 虚拟机的请求并派发执行
fn my_v_callback_handler(name &char, name_len int, z_args_array voidptr) voidptr {
	func_name_str := unsafe { tos(&u8(name), name_len) }
	
	mut v_args := []PhpVal{}
	if z_args_array != unsafe { nil } {
		count := C.php2v_get_array_num_elements(z_args_array)
		if count > 0 {
			mut z_elements := []voidptr{len: count, init: unsafe { nil }}
			num := C.php2v_extract_array_elements(z_args_array, z_elements.data)
			for i in 0 .. num {
				v_args << PhpVal{ raw: &C.zval(z_elements[i]) }
			}
		}
	}
	
	mut r := get_registry()
	mut ret_val := new_null()
	if func_name_str in r.func_registry {
		ret_val = r.func_registry[func_name_str](v_args)
	} else {
		ret_val = call_function(func_name_str, v_args)
	}
	return ret_val.raw
}

// register_v_helpers_to_php_interpreter 动态提取注册函数向嵌入式 PHP 中注入桩代码
pub fn register_v_helpers_to_php_interpreter() {
	mut r := get_registry()
	mut names := []string{}
	for name, _ in r.func_registry {
		names << name
	}
	builtins := [
		'strlen', 'strtoupper', 'strtolower', 'count',
		'mysqli_connect', 'mysqli_real_connect', 'mysqli_query',
		'mysqli_fetch_assoc', 'mysqli_fetch_row', 'mysqli_fetch_array',
		'mysqli_num_rows', 'mysqli_free_result', 'mysqli_close',
		'mysqli_real_escape_string', 'mysqli_error', 'mysqli_errno',
		'mysqli_select_db', 'mysqli_set_charset', 'mysqli_report', 'mysqli_init', 'mysqli_get_server_info'
	]
	for b in builtins {
		if b !in names {
			names << b
		}
	}

	if names.len == 0 { return }
	
	mut php_code := "
	\$funcs_str = '" + names.join(',') + "';
	\$v_funcs = explode(',', \$funcs_str);
	foreach (\$v_funcs as \$f) {
		if (!function_exists(\$f)) {
			eval(\"function \$f(...\\\$args) { return vphp_call_v_native('\$f', \\\$args); }\");
		}
	}
	"
	z_ret := new_zval()
	unsafe {
		C.php2v_eval_string(php_code.str, usize(php_code.len), z_ret)
		free(z_ret)
	}
}
