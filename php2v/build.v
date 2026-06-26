import os

fn main() {
	args := os.args[1..]
	if args.len == 0 {
		println('PHP to V Binary Compiler Script')
		println('Usage: v run build.v <input_file.php> [output_binary] [--keep-v]')
		println('Options:')
		println('  --keep-v     Keep the intermediate generated .v file')
		return
	}

	mut php_file := ''
	mut output_bin := ''
	mut keep_v := false

	for arg in args {
		if arg == '--keep-v' {
			keep_v = true
		} else if php_file == '' {
			php_file = arg
		} else if output_bin == '' {
			output_bin = arg
		}
	}

	if php_file == '' {
		eprintln('Error: No input PHP file specified.')
		return
	}

	if !os.exists(php_file) {
		eprintln('Error: Input file "${php_file}" does not exist.')
		return
	}

	// 1. 确定输出名称
	if output_bin == '' {
		base := os.file_name(php_file)
		name := base.all_before_last('.')
		output_bin = os.join_path(os.dir(php_file), name)
	}

	pwd := os.getwd()
	script_dir := os.dir(os.real_path(os.args[0]))

	// 2. 检查并编译 php2v (放在 php2v 目录下)
	php2v_bin := os.join_path(script_dir, 'php2v')
	if !os.exists(php2v_bin) {
		println('Compiling php2v compiler...')
		comp_php2v := os.execute('v -o "${php2v_bin}" "${os.join_path(script_dir, "src")}"')
		if comp_php2v.exit_code != 0 {
			eprintln('Error: Failed to compile php2v: ${comp_php2v.output}')
			return
		}
	}

	// 3. 转译 PHP 源码为 V 源码
	temp_v_file := php_file.all_before_last('.') + '.v'
	println('Transpiling ${php_file} -> ${temp_v_file}...')
	transpile_res := os.execute('"${php2v_bin}" compile "${php_file}" -o "${temp_v_file}"')
	if transpile_res.exit_code != 0 {
		eprintln('Error: Transpilation failed: ${transpile_res.output}')
		return
	}

	// 4. 自适应探测 PHP 头文件与链接库路径
	mut php_inc := ''
	mut php_libs := ''

	if os.exists('/usr/local/php-embed/include/php/sapi/embed/php_embed.h') {
		php_inc = '-I/usr/local/php-embed/include/php -I/usr/local/php-embed/include/php/main -I/usr/local/php-embed/include/php/TSRM -I/usr/local/php-embed/include/php/Zend'
		php_libs = '-L/usr/local/php-embed/lib -lphp -Wl,-rpath,/usr/local/php-embed/lib'
	} else {
		// 回落到系统的 php-config
		inc_res := os.execute('php-config --includes')
		php_inc = if inc_res.exit_code == 0 { inc_res.output.trim_space() } else { '' }
		
		ld_res := os.execute('php-config --ldflags')
		ld_flags := if ld_res.exit_code == 0 { ld_res.output.trim_space() } else { '' }
		
		php_libs = '${ld_flags} -lphp'
	}

	// 5. 编译为可执行二进制文件
	println('Compiling ${temp_v_file} -> ${output_bin}...')
	v_comp_cmd := 'v -nocache -path "${pwd}:@vlib" -cc clang -cflags "-DZTS -I${os.join_path(script_dir, "src", "rt")} ${php_inc} ${php_libs}" -o "${output_bin}" "${temp_v_file}"'
	comp_res := os.execute(v_comp_cmd)

	if comp_res.exit_code != 0 {
		eprintln('Error: Binary compilation failed:\n${comp_res.output}')
		// 编译失败时，保留临时 .v 文件供查错
		return
	}

	// 6. 清理临时 V 源码文件
	if !keep_v {
		os.rm(temp_v_file) or {
			eprintln('Warning: Failed to clean temporary V file: ${err}')
		}
	}

	println('----------------------------------------------------')
	println('🎉 Successfully built binary!')
	println('Output binary: ${output_bin}')
	println('To run: ./${output_bin}')
	println('----------------------------------------------------')
}
