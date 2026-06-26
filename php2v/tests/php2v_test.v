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
			'print(\'Hello World\\n\')',
		]
		'02_variables.php': [
			"mut var_a := 'hello'",
			"mut var_b := 'world\\n'",
			'print(var_a)',
			'print(var_b)',
		]
		'03_arithmetic.php': [
			'mut var_a := 10 + 20',
			'mut var_b := var_a - 5',
			'mut var_c := var_b * 2',
			'mut var_d := var_c / 5',
			'print(var_d.str())',
		]
		'04_string_concat.php': [
			"mut var_name := 'PHP'",
			"print('Hello ' + var_name",
		]
		'05_if_else.php': [
			'mut var_a := 15',
			'if var_a > 20 {',
			'} else if var_a > 10 {',
			'} else {',
		]
		'06_truthy.php': [
			"mut var_a := ''",
			'if var_a.len > 0 && var_a != \'0\' {',
			"mut var_b := '0'",
			'mut var_c := 123',
			'if var_c != 0 {',
		]
		'07_functions.php': [
			'fn func_add_five(var_val rt.PhpVal) rt.PhpVal {',
			'return rt.add(var_val, rt.new_int(5))',
			'mut var_res := func_add_five(rt.new_int(10))',
			'rt.echo_val(var_res)',
		]
		'08_arrays.php': [
			'mut var_arr := rt.create_array([rt.ArrayItem{ key: none, val: rt.new_int(10) }, rt.ArrayItem{ key: none, val: rt.new_int(20) }])',
			'var_arr.array_push(rt.new_int(30))',
			'var_arr.array_set(rt.new_string(\'key\'), rt.new_string(\'hello\'))',
			'rt.echo_val(var_arr.array_get(rt.new_int(0)))',
			'rt.echo_val(rt.new_int(var_arr.dup().array_count()))',
		]
		'09_foreach.php': [
			'mut iter := var_arr.iterator()',
			'item := iter.next() or { break }',
			'mut var_val := item.val',
			'mut var_key := item.key',
		]
		'10_loops.php': [
			'for var_i < 3 {',
			'mut var_j := 0',
			'if !(var_j < 5) { break }',
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
			"mut var_user := create_user('Alice')",
			'print(var_user.getname())',
			"var_user.name = 'Bob'",
		]
		'12_dynamic.php': [
			"rt.call_function('eval', [rt.new_string('echo \\'eval works\\n\\';')])",
			"mut var_md5_res := rt.call_function('md5', [rt.new_string('hello')])",
			"rt.echo_val(var_md5_res)",
			"mut var_json_res := rt.call_function('json_encode', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_int(1) }, rt.ArrayItem{ key: none, val: rt.new_int(2) }, rt.ArrayItem{ key: none, val: rt.new_int(3) }])])",
			"rt.echo_val(var_json_res)",
		]
		'13_closure.php': [
			'struct Closure_1 {',
			'prop_x rt.PhpVal',
			'fn (mut this Closure_1) invoke(args []rt.PhpVal) rt.PhpVal {',
			'mut var_y := if args.len > 0 { args[0].dup() } else { rt.new_null() }',
			'mut var_x := this.prop_x.dup()',
			'return rt.add(var_x, var_y)',
			'struct Closure_2 {',
			'fn (mut this Closure_2) invoke(args []rt.PhpVal) rt.PhpVal {',
			'mut var_z := if args.len > 0 { args[0].dup() } else { rt.new_null() }',
			'return rt.mul(var_z, var_x)',
			'fn call_closure(cb rt.PhpVal, args []rt.PhpVal) rt.PhpVal {',
			'mut var_cb := rt.new_object(\'Closure_1\', [\'Closure\'], \u0026Closure_1{ prop_x: rt.new_int(var_x) })',
			'rt.echo_val(call_closure(var_cb, [rt.new_int(5)]))',
			'mut var_fn := rt.new_object(\'Closure_2\', [\'Closure\'], \u0026Closure_2{ prop_x: rt.new_int(var_x) })',
			'rt.echo_val(call_closure(var_fn, [rt.new_int(3)]))',
		]
		'14_include.php': [
			"mut var_path := 'tests/fixtures/14_included.inc'",
			"mut var_ret := rt.include_file(rt.new_string(var_path), '1')",
			"rt.echo_val(var_ret)",
			"mut var_ret2 := rt.include_file(rt.new_string(var_path), '2')",
			"print('once_done\\n')",
		]
		'15_constants.php': [
			"rt.define_constant('APP_ENV'",
			"rt.get_constant('APP_ENV')",
			"rt.get_constant('DB_PORT')",
			"rt.new_int(5)",
		]
		'16_oop_inheritance.php': [
			'struct Class_Animal {',
			'prop_name rt.PhpVal',
			'fn (mut this Class_Animal) construct(var_name rt.PhpVal) ',
			'fn (mut this Class_Animal) greet() rt.PhpVal {',
			'struct Class_Dog {',
			'breed string',
			'fn (mut this Class_Dog) construct(name string, breed string) ',
			'fn (mut this Class_Dog) greet() rt.PhpVal {',
			'this.Class_Animal.greet()',
			'fn create_dog(name string, breed string) &Class_Dog {',
			"mut var_dog := create_dog('Rex', 'Labrador')",
		]
		'17_boolean_logical.php': [
			'rt.new_bool(!rt.is_true(',
			'&& rt.is_true(func_log_true(rt.new_string(\'right_true\'))',
			'|| rt.is_true(func_log_true(rt.new_string(\'right_true\'))',
		]
		'18_ternary_coalesce.php': [
			'if rt.is_true(rt.greater(',
			'if rt.is_true(rt.new_int(var_a)) { rt.new_int(var_a) } else {',
			'if !(var_b).is_null() { var_b } else {',
		]
		'19_exceptions.php': [
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
			'temp.info(',
			'temp.init(',
		]
		'22_string_interpolation.php': [
			'mut var_name := \'Alice\'',
			'mut var_age := 20',
			'"Hello \${var_name}',
			'\${var_age.str()}',
			'print(var_msg',
		]
		'23_unset_empty.php': [
			'rt.new_bool(!rt.is_true(',
			'var_not_exist',
			"var_d = ''",
			'var_arr.array_unset(',
		]
		'24_switch_case.php': [
			'match var_x {',
			'1 {',
			'2, 3 {',
			'print(\'default case\\n\')',
		]
		'25_match_expr.php': [
			"mut var_y := match var_x {",
			"1 { rt.new_string('one') }",
			"2, 3 { rt.new_string('two or three') }",
			"else { rt.new_string('other') }",
		]
		'26_do_while.php': [
			'mut var_i := 0',
			'for {',
			'rt.echo_val(rt.concat(rt.new_int(var_i), rt.new_string(\'\\n\')))',
			'var_i += 1',
			'if !(var_i < 3) {',
			'break',
		]
		'27_increment_decrement.php': [
			'mut var_a := 5',
			'mut var_b := rt.post_inc(rt.new_int(var_a))',
			'mut var_c := rt.post_dec(rt.new_int(var_a))',
			'mut var_d := rt.pre_inc(rt.new_int(var_a))',
			'mut var_e := rt.pre_dec(rt.new_int(var_a))',
		]
		'28_bitwise_ops.php': [
			'mut var_c := rt.bitwise_and(rt.new_int(var_a), rt.new_int(var_b))',
			'mut var_d := rt.bitwise_or(rt.new_int(var_a), rt.new_int(var_b))',
			'mut var_e := rt.bitwise_xor(rt.new_int(var_a), rt.new_int(var_b))',
			'mut var_f := rt.shift_left(rt.new_int(var_a), rt.new_int(1))',
			'mut var_g := rt.shift_right(rt.new_int(var_a), rt.new_int(1))',
			'mut var_h := rt.bitwise_not(rt.new_int(var_a))',
			'mut var_i := rt.new_int(var_a)',
			'rt.echo_val(rt.concat(rt.concat(rt.new_string(\'error suppress: \'), var_i), rt.new_string(\'\\n\')))',
		]
		'29_class_constants.php': [
			'const class_user_role_admin = rt.new_string(\'admin\')',
			'const class_user_role_user = rt.new_string(\'user\')',
			'return class_user_role_admin',
			'rt.echo_val(rt.concat(class_user_role_admin, rt.new_string(\'\\n\')))',
			'mut var_u := create_user()',
		]
		'30_oop_interfaces.php': [
			'struct Class_FileLogger {',
			'fn (mut this Class_FileLogger) log(msg string) rt.PhpVal {',
			"rt.instance_of(rt.new_object('FileLogger', ['Logger'], var_fl), 'Logger')",
			"print('fl is Logger\\n')",
			"var_fl.log('hello')",
		]
		'31_oop_traits.php': [
			'struct Class_User {',
			'fn (mut this Class_User) sayhello(name string) rt.PhpVal {',
			"var_u.sayhello('Alice')",
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
		mut v_path := '${pwd}:${os.dir(pwd)}:@vlib'
		v_comp_cmd := 'v -path "${v_path}" -shared -cc clang -cflags "-DZTS -undefined dynamic_lookup -I${rt_inc} ${php_inc}" -o "${temp_so_file}" "${temp_v_file}"'
		comp_res := os.execute(v_comp_cmd)
		
		// 清理临时 so 文件，保留 .v 源码文件供查看
		os.rm(temp_so_file) or {}

		if comp_res.exit_code != 0 {
			assert false, 'C compilation failed for ${file}: ${comp_res.output}'
		}

		println('Passed: ${file}')
	}
}
