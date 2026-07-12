module tests

import os

fn test_transpiler_end_to_end() {
	pwd := os.getwd()
	// 动态适配 tests 目录的重定位，既支持根目录下运行，也支持在 php2v/ 目录下运行
	mut fixtures_dir := os.join_path(pwd, 'php2v/tests/fixtures')
	if !os.exists(fixtures_dir) {
		fixtures_dir = os.join_path(pwd, 'tests/fixtures')
	}
	files := os.ls(fixtures_dir) or { panic(err) }

	// 预期生成的 V 代码特征片段，用于进行高精度源码结构比对测试
	expected_snippets := {
		'01_echo.php': [
			'rt.print_str(\'Hello World\\n\')',
		]
		'02_variables.php': [
			"mut var_a := ''",
			"var_a = 'hello'",
			"var_b = 'world\\n'",
			'rt.print_str(var_a)',
			'rt.print_str(var_b)',
		]
		'03_arithmetic.php': [
			'mut var_a := i64(0)',
			'var_a = 10 + 20',
			'var_b = var_a - 5',
			'var_c = var_b * 2',
			'var_d = var_c / 5',
			'rt.print_str(var_d.str())',
		]
		'04_string_concat.php': [
			"mut var_name := ''",
			"var_name = 'PHP'",
			"rt.print_str('Hello ' + var_name",
		]
		'05_if_else.php': [
			'mut var_a := i64(0)',
			'var_a = 15',
			'if var_a > 20 {',
			'} else if var_a > 10 {',
			'} else {',
		]
		'06_truthy.php': [
			"mut var_a := ''",
			'if var_a.len > 0 && var_a != \'0\' {',
			"var_b = '0'",
			"var_c = 123",
			'if var_c != 0 {',
		]
		'07_functions.php': [
			'fn add_five(val i64) i64 {',
			'return val + 5',
			'mut var_res := i64(0)',
			'var_res = add_five(10)',
			'rt.print_str(var_res.str())',
		]
		'08_arrays.php': [
			'mut var_arr := rt.new_null()',
			'var_arr = rt.create_array([rt.ArrayItem{ key: none, val: 10 },',
			'var_arr.array_push(30)',
			'var_arr.array_set(\'key\', \'hello\')',
			'rt.echo_val(var_arr.array_get(rt.new_int(0)))',
			'rt.print_str(var_arr.clone().array_count().str())',
		]
		'09_foreach.php': [
			"mut var_arr := map[string]i64{}",
			"var_arr = {",
			"for _, var_val_shadow in var_arr {",
			"for var_key_shadow, var_val_shadow in var_arr {",
		]
		'10_loops.php': [
			'for var_i < 3 {',
			'mut var_j := i64(0)',
			'var_j = 0',
			'if !(var_j < 5) { break',
			'if var_j == 2 {',
			'continue',
			'if var_j == 4 {',
			'break',
		]
		'11_oop.php': [
			'struct Class_User {',
			'name string',
			'fn (mut this Class_User) construct(name string) ',
			'fn (mut this Class_User) getname() string {',
			'fn create_user(name string) &Class_User {',
			"mut var_user := &Class_User(unsafe { nil })",
			"var_user = create_user('Alice')",
			'rt.print_str(var_user.getname())',
			"var_user.name = 'Bob'",
		]
		'12_dynamic.php': [
			"rt.call_function('eval', [rt.new_string(\"echo 'eval works\\n';\")])",
			"mut var_md5_res := ''",
			"var_md5_res = md5.hexhash('hello')",
			'rt.print_str(var_md5_res)',
			'var_json_res = rt.json_encode(',
			'rt.print_str(var_json_res)',
		]
		'13_closure.php': [
			'closure_1_fn := fn [var_x] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {',
			'mut var_y := if args.len > 0 { args[0].clone() } else { rt.new_null() }',
			'return rt.add(rt.new_int(var_x), var_y)',
			'var_cb = rt.new_closure(closure_1_fn)',
			'rt.echo_val(rt.call_callable(var_cb, [rt.new_int(5)]))',
			'closure_2_fn := fn [var_x] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {',
			'mut var_z := if args.len > 0 { args[0].clone() } else { rt.new_null() }',
			'return rt.mul(var_z, rt.new_int(var_x))',
			'var_fn = rt.new_closure(closure_2_fn)',
			'rt.echo_val(rt.call_callable(var_fn, [rt.new_int(3)]))',
		]
		'14_include.php': [
			"mut var_path := ''",
			"var_path = 'tests/fixtures/14_included.inc'",
			"var_ret = rt.include_file(var_path, '1')",
			"rt.echo_val(var_ret)",
			"var_ret2 = rt.include_file(var_path, '2')",
			"rt.print_str('once_done\\n')",
		]
		'15_constants.php': [
			"const global_const_app_env = 'production'",
			"const global_const_db_port = 3306",
			"rt.print_str('ENV: ' + global_const_app_env + '\\n')",
			"rt.print_str('PORT: ' + global_const_db_port.str() + '\\n')",
			"' + @DIR + '",
			"' + @FILE + '",
			"' + @LINE.int().str() + '",
		]
		'16_oop_inheritance.php': [
			'struct Class_Animal {',
			'name rt.PhpVal',
			'fn (mut this Class_Animal) construct(var_name rt.PhpVal) ',
			'fn (mut this Class_Animal) greet() {',
			'struct Class_Dog {',
			'breed string',
			'fn (mut this Class_Dog) construct(name string, breed string) ',
			'fn (mut this Class_Dog) greet() {',
			'this.Class_Animal.greet()',
			'fn create_dog(name string, breed string) &Class_Dog {',
			"mut var_dog := &Class_Dog(unsafe { nil })",
			"var_dog = create_dog('Rex', 'Labrador')",
		]
		'17_boolean_logical.php': [
			'if !(log_true(',
			'log_false(\'left_false\') && log_true(\'right_true\')',
			'log_true(\'left_true\') || log_true(\'right_true\')',
		]
		'18_ternary_coalesce.php': [
			'if var_a > 5',
			'if var_a != 0 { var_a } else {',
			'if !var_b.is_null() { var_b } else { rt.new_int(100) }',
		]
		'19_exceptions.php': [
			'struct Class_Exception {',
			'message string',
			'code    i64',
			'fn (mut this Class_Exception) getmessage() string {',
			'struct Class_MyException {',
			'message string',
			'fn (mut this Class_MyException) getmessage() string {',
			'rt.throw_exception(',
			'catch_label_1:',
			'finally_label_1:',
			'rt.instance_of(var_e_1, \'MyException\')',
			'rt.instance_of(var_e_1, \'Exception\')',
		]
		'20_web_superglobals.php': [
			'rt.get_superglobal(\'_GET\')',
			'rt.get_superglobal(\'_SERVER\')',
			'.array_isset(',
		]
		'21_namespaces.php': [
			'Class_App_Utils_Helper',
			'Class_App_Core_Application',
			'create_app_utils_helper()',
			'create_app_core_application()',
			'Class_App_Utils_Helper.info(',
			'Class_App_Core_Application.init(',
		]
		'22_string_interpolation.php': [
			'var_name = \'Alice\'',
			'var_age = 20',
			'\'Hello \${var_name}, next year you will be \${var_age.str()} years old.\'',
			'rt.print_str(var_msg',
		]
		'23_unset_empty.php': [
			"var_a == ''",
			"var_b == 0",
			"!rt.is_true(var_c)",
			"var_d == ''",
			"!rt.is_true(var_not_exist)",
			"var_arr.delete('key')",
		]
		'24_switch_case.php': [
			'match var_x {',
			'1 {',
			'2, 3 {',
			'rt.print_str(\'default case\\n\')',
		]
		'25_match_expr.php': [
			"var_y = match var_x {",
			"1 { rt.new_string('one') }",
			"2, 3 { rt.new_string('two or three') }",
			"else { rt.new_string('other') }",
		]
		'26_do_while.php': [
			'var_i = 0',
			'for {',
			"rt.print_str(var_i.str() + '\\n')",
			'var_i += 1',
			'if !(var_i < 3) {',
			'break',
		]
		'27_increment_decrement.php': [
			'var_a = 5',
			'var_a += 1',
			'var_b = rt.new_int(tmp_inc_1)',
			'var_c = rt.new_int(tmp_inc_2)',
			'var_d = rt.new_int(var_a)',
			'var_e = rt.new_int(var_a)',
		]
		'28_bitwise_ops.php': [
			'var_c = var_a & var_b',
			'var_d = var_a | var_b',
			'var_e = var_a ^ var_b',
			'var_f = var_a << 1',
			'var_g = var_a >> 1',
			'var_h = ~var_a',
			'var_i = rt.new_int(var_a)',
			"rt.print_str('bitwise and: ' + var_c.str() + '\\n')",
			"rt.print_str('error suppress: ' + var_i.str() + '\\n')",
		]
		'29_class_constants.php': [
			'pub fn Class_User.role_admin() string {',
			'pub fn Class_User.role_user() string {',
			'return Class_User.role_admin()',
			"rt.print_str(Class_User.role_admin() + '\\n')",
			'var_u = create_user()',
		]
		'30_oop_interfaces.php': [
			'interface Logger {',
			'struct Class_FileLogger {',
			'fn (mut this Class_FileLogger) log(msg string) {',
			'if true {',
			'rt.print_str(\'fl is Logger\\n\')',
			'var_fl.log(\'hello\')',
		]
		'31_oop_traits.php': [
			'struct Class_User {',
			'fn (mut this Class_User) sayhello(name string) {',
			"var_u.sayhello('Alice')",
		]
		'32_builtin_inference.php': [
			'var_len = var_str.len',
			'var_cnt = var_arr.len',
			'var_upper = var_str.to_upper()',
		]
		'33_pure_arrays.php': [
			'mut var_list := rt.new_null()',
			'var_list = rt.create_array([rt.ArrayItem{ key: none, val: 10 },',
			'var_list.array_push(30)',
			'rt.print_str(var_list.clone().array_count().str())',
			'mut iter_1 := var_list.iterator()',
			'mut var_item_shadow := item_1.val',
			"mut var_map := map[string]string{}",
			"var_map = {",
			"rt.print_str(var_map['a'])",
			"rt.print_str(var_map.len.str())",
			"for var_k_shadow, var_v_shadow in var_map {",
		]
		'34_wp_error.php': [
			'struct Class_WP_Error',
			'fn (mut this Class_WP_Error) add(code string, message string, data string)',
			'do_action',
		]
		'35_dynamic_all.php': [
			'rt.register_func',
			'rt.register_class_factory',
			'rt.create_object_dynamically',
			'rt.call_callable',
			'fn init_registry() {',
			'rt.call_method',
			'rt.get_property',
			'dispatch_set_prop',
		]
		// 36: 闭包内联赋值不泄漏到外层作用域 (WordPress wp_extract_urls 修复)
		'36_closure_inline_assign.php': [
			// 闭包内 $item = trim($item) 应在闭包体内
			'mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }',
			'var_item = rt.new_string(var_item.clone().to_string().trim_space())',
			// 闭包内 $link = html_entity_decode($link) 应在闭包体内
			'mut var_link := if args.len > 0 { args[0].clone() } else { rt.new_null() }',
			'var_link = rt.call_function(\'html_entity_decode\'',
			// 外层函数不应有 var_link 声明（关键：不泄漏）
		]
		// 37: IIFE 模式 — 静态方法链式调用 (WordPress register_block_type 修复)
		'37_iife_new_method.php': [
			'struct Class_Registry',
			// 静态调用直接生成，不创建 IIFE 闭包
			'fn Class_Registry.get_instance() rt.PhpVal {',
			// 链式调用通过 rt.call_method 实现
			'rt.call_method(Class_Registry.get_instance(), \'register\'',
			'rt.call_method(Class_Registry.get_instance(), \'unregister\'',
		]
		// 38: 长条件表达式 (WordPress 多文件 if 条件修复)
		'38_long_conditions.php': [
			'fn validate_and_process(var_block_type rt.PhpVal) rt.PhpVal {',
			// && 条件正确生成
			'&& rt.is_true(rt.call_function(\'file_exists\'',
			// || 条件正确生成（由于 `!(rt.is_true(...))` 化简）
			'|| !(rt.is_true(rt.call_function(\'file_exists\'',
			// elseif 正确生成
			'} else if rt.is_true',
			'fn complex_condition(var_a rt.PhpVal, var_b rt.PhpVal, var_c rt.PhpVal) string {',
		]
		// 39: 静态属性访问 (通过 rt.get_static_prop / rt.set_static_prop / rt.init_static_prop)
		'39_static_property.php': [
			'struct Class_Database',
			// 静态属性通过 rt.get_static_prop / rt.set_static_prop 访问
			'fn get_connection() rt.PhpVal {',
			'rt.get_static_prop(',
			'fn get_config_value(var_key rt.PhpVal) rt.PhpVal {',
			'fn init_static_database()',
		]
		// 40: 无 MethodInfo 回退情况下原生标量实参自动装箱
		'40_mysql2date.php': [
			'fn test_mysql2date(format string, var_var_date rt.PhpVal) rt.PhpVal {',
			'return test_wp_date(rt.new_string(format), var_var_date.clone())',
		]
		// 41: 原生列表空字面量类型自适应及追加标量类型一致
		'41_array_append.php': [
			'mut var_arr := rt.new_null()',
			'var_arr = rt.new_array()',
			'var_arr.array_push(\'<option>\' + var_val.str() + \'</option>\')',
			'return var_arr.clone()',
		]
		// 42: 包装变量调用 strlen, trim 等内置函数的安全拆箱
		'42_strlen_safety.php': [
			'mut var_val := var_val_arg',
			'var_val = rt.new_string(\'hello\')',
			'if var_val.str().len > 0 {',
			'var_val = rt.new_string(var_val.str().trim_space())',
			'return var_val',
		]
		// 43: 自定义类实例做局部变量时的空指针声明与原生方法直接调用
		'43_object_predeclare.php': [
			'mut var_util := &Class_WP_List_Util(unsafe { nil })',
			'var_util = create_wp_list_util()',
			'return var_util.filter(var_args.clone())',
		]
		// 44: 返回 void 的自定义函数在动态注册适配器时的代码生成正确性
		'44_void_func_register.php': [
			'fn test_void_func(var_msg rt.PhpVal) {',
			'rt.register_func(\'test_void_func\', fn (args []rt.PhpVal) rt.PhpVal {',
			'test_void_func(arg_0)',
			'return rt.new_null()',
		]
		// 52: 静态 include 链全自动 AOT 原生转译与运行
		'52_include_native_transpiled.php': [
			'rt.register_include(',
			'run_transpiled_include_',
			'rt.include_file(',
		]
		// 53: ArrayAccess 接口原生转译与运行
		'53_oop_arrayaccess.php': [
			'.offsetset(',
			'.offsetget(',
			'.offsetexists(',
			'.offsetunset(',
		]
		// 54: Iterator 接口原生转译与运行
		'54_oop_iterator.php': [
			'.rewind()',
			'.valid()',
			'.current()',
			'.next()',
			'for {',
		]
		// 55: 魔术方法 __get 与 __set 原生转译与运行
		'55_oop_magic_properties.php': [
			'.magic_get(',
			'.magic_set(',
			'mut_this.magic_get(',
			'this.magic_set(',
		]
		// 56: 内置 call_user_func 与 call_user_func_array 动态调用
		'56_builtin_call_user_func.php': [
			"rt.call_function('call_user_func'",
			"rt.call_function('call_user_func_array'",
		]
		// 57: 面向对象核心内置函数原生与双轨支持
		'57_builtin_class_functions.php': [
			"rt.register_class_metadata('ChildClass'",
			"rt.call_function('get_class'",
			"rt.call_function('is_a'",
			"rt.call_function('method_exists'",
		]
	}

	// 获取 php-config includes 路径以支持编译时 C 头文件寻址
	mut php_inc := ''
	if os.exists('/usr/local/php-embed/include/php/sapi/embed/php_embed.h') {
		php_inc = '-I/usr/local/php-embed/include/php -I/usr/local/php-embed/include/php/main -I/usr/local/php-embed/include/php/TSRM -I/usr/local/php-embed/include/php/Zend'
	} else {
		php_inc_res := os.execute('php-config --includes')
		php_inc = if php_inc_res.exit_code == 0 { php_inc_res.output.trim_space() } else { '' }
	}

	for file in files {
		if !file.ends_with('.php') {
			continue
		}

		php_file := os.join_path(fixtures_dir, file)
		println('Testing: ${file}...')

		// 1. 运行 php2v 将 PHP 源码转译为 V 源码
		temp_v_file := os.join_path(fixtures_dir, file.all_before_last('.') + '.v')
		mut php2v_exe := './php2v/php2v'
		if !os.exists(php2v_exe) {
			php2v_exe = './php2v'
		}
		transpile_res := os.execute('${php2v_exe} compile "${php_file}" -o "${temp_v_file}"')
		if transpile_res.exit_code != 0 {
			assert false, 'php2v transpilation failed for ${file}: ${transpile_res.output}'
		}

		// 2. 读取并断言 V 源码特征片段
		v_content := os.read_file(temp_v_file) or {
			panic('Failed to read generated V file for ${file}: ${err}')
		}
		
		snippets := expected_snippets[file] or { []string{} }
		for snippet in snippets {
			if !v_content.contains(snippet) {
				println('=== Code mismatch for ${file} ===')
				println('Expected snippet not found: ${snippet}')
				println('--- Generated V Code ---')
				println(v_content)
				println('=========================')
				assert false, 'Generated V code lacks expected snippet for ${file}'
			}
		}

		// 3. 运行 V 共享库编译以验证在 C 级别是否语法正确且能正常链接
		temp_so_file := os.join_path(os.temp_dir(), file.all_before_last('.') + '_gen.so')
		mut rt_inc := os.join_path(pwd, 'php2v/src/rt')
		if !os.exists(rt_inc) {
			rt_inc = os.join_path(pwd, 'src/rt')
		}
		clean_v_file := os.join_path(os.temp_dir(), file.all_before_last('.') + '.v')
		os.cp(temp_v_file, clean_v_file) or { panic(err) }
		
		mut v_path := '${os.join_path(pwd, "php2v/src")}:@vlib'
		if !os.exists(os.join_path(pwd, 'php2v/src')) {
			v_path = '${os.join_path(pwd, "src")}:@vlib'
		}
		v_comp_cmd := 'v -path "${v_path}" -shared -cc clang -cflags "-DZTS -undefined dynamic_lookup -I${rt_inc} ${php_inc}" -o "${temp_so_file}" "${clean_v_file}"'
		comp_res := os.execute(v_comp_cmd)
		
		os.rm(clean_v_file) or {}
		
		// 清理临时 so 文件，保留 .v 源码文件供查看
		os.rm(temp_so_file) or {}

		if comp_res.exit_code != 0 {
			assert false, 'C compilation failed for ${file}: ${comp_res.output}'
		}

		println('Passed: ${file}')
	}
}
