module tests

import os

fn test_transpiler_end_to_end() {
	pwd := os.getwd()
	fixtures_dir := os.join_path(pwd, 'tests/fixtures')
	files := os.ls(fixtures_dir) or { panic(err) }

	// 预期生成的 V 代码特征片段，用于进行高精度源码结构比对测试
	expected_snippets := {
		'01_echo.php': [
			'rt.echo_val(rt.new_string(\'Hello World',
		]
		'02_variables.php': [
			'mut var_a := rt.new_string(\'hello\')',
			'mut var_b := rt.new_string(\'world',
			'rt.echo_val(var_a)',
			'rt.echo_val(var_b)',
		]
		'03_arithmetic.php': [
			'mut var_a := rt.add(rt.new_int(10), rt.new_int(20))',
			'mut var_b := rt.sub(var_a, rt.new_int(5))',
			'mut var_c := rt.mul(var_b, rt.new_int(2))',
			'mut var_d := rt.div(var_c, rt.new_int(5))',
			'rt.echo_val(var_d)',
		]
		'04_string_concat.php': [
			'mut var_name := rt.new_string(\'PHP\')',
			'rt.concat(rt.new_string(\'Hello \'), var_name)',
		]
		'05_if_else.php': [
			'mut var_a := rt.new_int(15)',
			'if rt.is_true(rt.greater(var_a, rt.new_int(20))) {',
			'} else if rt.is_true(rt.greater(var_a, rt.new_int(10))) {',
			'} else {',
		]
		'06_truthy.php': [
			'mut var_a := rt.new_string(\'\')',
			'if rt.is_true(var_a) {',
			'mut var_b := rt.new_string(\'0\')',
			'if rt.is_true(var_b) {',
			'mut var_c := rt.new_int(123)',
			'if rt.is_true(var_c) {',
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
			'rt.echo_val(rt.call_function(\'count\', [var_arr.dup()]))',
		]
		'09_foreach.php': [
			'mut iter := var_arr.iterator()',
			'item := iter.next() or { break }',
			'mut var_val := item.val',
			'mut var_key := item.key',
		]
		'10_loops.php': [
			'for rt.is_true(rt.less(var_i, rt.new_int(3))) {',
			'mut var_j := rt.new_int(0)',
			'if !rt.is_true(rt.less(var_j, rt.new_int(5))) { break }',
			'if rt.is_true(rt.equal(var_j, rt.new_int(2))) {',
			'continue',
			'if rt.is_true(rt.equal(var_j, rt.new_int(4))) {',
			'break',
		]
	}

	// 获取 php-config includes 路径以支持编译时 C 头文件寻址
	php_inc_res := os.execute('php-config --includes')
	php_inc := if php_inc_res.exit_code == 0 { php_inc_res.output.trim_space() } else { '' }

	for file in files {
		if !file.ends_with('.php') {
			continue
		}

		php_file := os.join_path(fixtures_dir, file)
		println('Testing: ${file}...')

		// 1. 运行 php2v 将 PHP 源码转译为 V 源码
		temp_v_file := os.join_path(os.temp_dir(), file.all_before_last('.') + '_gen.v')
		transpile_res := os.execute('./php2v_bin compile "${php_file}" -o "${temp_v_file}"')
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
		v_comp_cmd := 'v -path "${pwd}:@vlib" -shared -cc clang -cflags "-undefined dynamic_lookup -I${pwd}/php2v/rt ${php_inc}" -o "${temp_so_file}" "${temp_v_file}"'
		comp_res := os.execute(v_comp_cmd)
		
		// 清理所有临时文件
		os.rm(temp_v_file) or {}
		os.rm(temp_so_file) or {}

		if comp_res.exit_code != 0 {
			assert false, 'C compilation failed for ${file}: ${comp_res.output}'
		}

		println('Passed: ${file}')
	}
}
