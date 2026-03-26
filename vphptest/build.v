import os
import vphp.compiler

fn sanitize_ldflags(ldflags string) string {
	mut kept := []string{}
	for token in ldflags.split(' ') {
		t := token.trim_space()
		if t == '' {
			continue
		}
		if t.starts_with('-L') && t.len > 2 {
			path := t[2..]
			if !os.exists(path) {
				continue
			}
		}
		kept << t
	}
	return kept.join(' ')
}

fn detect_v_root_include_flags() string {
	v_exe := os.find_abs_path_of_executable('v') or { '' }
	if v_exe == '' {
		return ''
	}
	v_root := os.dir(os.real_path(v_exe))
	if v_root == '' {
		return ''
	}
	mut flags := []string{}
	// Generated C can pull V's compress module, which includes miniz.h from V's tree.
	zip_include := os.join_path(v_root, 'thirdparty', 'zip')
	if os.exists(zip_include) {
		flags << '-I${zip_include}'
	}
	return flags.join(' ')
}

fn detect_v_gc_mode() string {
	gc_mode := os.getenv_opt('VPHP_V_GC') or { '' }
	mode := gc_mode.trim_space()
	if mode == '' || mode == 'auto' {
		res := os.execute('pkg-config --exists bdw-gc')
		if res.exit_code == 0 {
			return 'boehm'
		}
		return 'none'
	}
	return mode
}

fn pkg_config_flags(args string) string {
	cmd := "pkg-config ${args}"
	res := os.execute(cmd)
	if res.exit_code != 0 {
		eprintln('❌ 执行 `${cmd}` 失败: ${res.output.trim_space()}')
		exit(1)
	}
	return res.output.trim_space()
}

fn detect_gc_compile_flags(gc_mode string) string {
	return match gc_mode {
		'boehm' { pkg_config_flags('--cflags bdw-gc') }
		else { '' }
	}
}

fn detect_gc_link_flags(gc_mode string) string {
	return match gc_mode {
		'boehm' { pkg_config_flags('--libs bdw-gc') }
		else { '' }
	}
}

fn main() {
	project_root := os.dir(os.real_path(@FILE))
	os.chdir(project_root) or {
		eprintln('❌ 无法切换到项目目录: ${project_root}')
		exit(1)
	}

	mut target_files := []string{}

	if os.args.len > 1 && os.args[1].ends_with('.v') {
		for arg in os.args[1..] {
			target_files << os.real_path(arg)
		}
	} else {
		files := os.ls('.') or { []string{} }
		for f in files {
			if f.ends_with('.v') && f != 'build.v' && f != 'bridge.v' && f != 'mod.v'
				&& !f.ends_with('_test.v') {
				target_files << os.real_path(os.join_path(project_root, f))
			}
		}
	}
	if target_files.len == 0 {
		eprintln('❌ 未找到任何 V 源文件进行编译！')
		exit(1)
	}

	// Step 1: Run vphp compiler to generate bridge files
	println('🛠️  1. 启动 VPHP Compiler 流程...')
	mut vphp_c := compiler.new(target_files)

	ext_name := vphp_c.compile() or {
		eprintln('❌ 编译阶段失败: ${err}')
		exit(1)
	}

	vphp_c.generate_all() or {
		eprintln('❌ 代码生成失败: ${err}')
		exit(1)
	}

	// Step 2: V -> C transpilation
	transpiled_c := os.join_path(project_root, '${ext_name}_generated.c')
	legacy_transpiled_c := os.join_path(project_root, 'vphp_ext_${ext_name}.c')
	output_so := os.join_path(project_root, 'vphptest.so')
	gc_mode := detect_v_gc_mode()
	gc_compile_flags := detect_gc_compile_flags(gc_mode)
	gc_link_flags := detect_gc_link_flags(gc_mode)
	println('🛠️  2. 转译 V 逻辑为 C -> ${transpiled_c}')
	println('   使用 V GC 模式: ${gc_mode}')
	os.rm(output_so) or {}
	os.rm(legacy_transpiled_c) or {}

	v_res := os.execute('v -nocache -enable-globals -gc ${gc_mode} -path ".:..:@vlib" -shared -o ${transpiled_c} ${project_root}')
	if v_res.exit_code != 0 {
		println('❌ V 编译失败: ${v_res.output}')
		exit(1)
	}

	// Step 3: GCC final link
	println('🛠️  3. GCC 最终链接...')
	is_macos := os.user_os() == 'macos'
	mut disabled_warnings := '-Wno-pointer-to-int-cast -Wno-incompatible-pointer-types'
	if is_macos {
		disabled_warnings += ' -Wno-initializer-overrides'
	} else {
		disabled_warnings += ' -Wno-override-init'
	}
	brew_path := '/opt/homebrew'
	v_root_cflags := detect_v_root_include_flags()
	os.setenv('C_INCLUDE_PATH', '${brew_path}/include/cjson', true)

	php_inc := os.execute('php-config --includes').output.trim_space()
	php_ldflags := sanitize_ldflags(os.execute('php-config --ldflags').output.trim_space())
	php_libs := os.execute('php-config --libs').output.replace('-lzip', '').trim_space()
	mut platform_link_flags := '-fvisibility=default'
	if is_macos {
		platform_link_flags = '-undefined dynamic_lookup -fvisibility=default'
	}
	mut extra_compile_flags := ''
	mut extra_link_flags := ''
	if gc_compile_flags != '' {
		extra_compile_flags = '${gc_compile_flags} '
	}
	if gc_link_flags != '' {
		extra_link_flags = ' ${gc_link_flags}'
	}

	gcc_cmd := 'gcc -shared -fPIC ${disabled_warnings} -DCOMPILE_DL_${ext_name.to_upper()}=1 ' +
		'${v_root_cflags} ${extra_compile_flags}-I${brew_path}/include -L${brew_path}/lib -lcjson ' +
		'-DcJSON_GetErrorPos=cJSON_GetErrorPtr ' +
		'${php_inc} ${transpiled_c} php_bridge.c ../vphp/v_bridge.c -o ${output_so} ' +
		'-I../vphp ' + '${php_ldflags} ${php_libs}${extra_link_flags} ${platform_link_flags}'

	println('执行命令: ${gcc_cmd}')
	if os.system(gcc_cmd) != 0 {
		eprintln('❌ GCC 编译失败')
		exit(1)
	}

	if !os.exists(output_so) {
		eprintln('❌ 错误：vphptest.so 未生成！')
		exit(1)
	}

	println('✅ 构建成功！vphptest.so 已就绪。')
}
