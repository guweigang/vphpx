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

fn dedupe_link_flags(flags string) string {
	mut kept := []string{}
	mut seen := map[string]bool{}
	for token in flags.split(' ') {
		t := token.trim_space()
		if t == '' {
			continue
		}
		if t in seen {
			continue
		}
		seen[t] = true
		kept << t
	}
	return kept.join(' ')
}

fn shell_trim(cmd string) string {
	res := os.execute(cmd)
	if res.exit_code != 0 {
		return ''
	}
	return res.output.trim_space()
}

fn detect_cjson_flags() (string, string) {
	pkg_cflags := shell_trim('pkg-config --cflags libcjson')
	pkg_libs := shell_trim('pkg-config --libs libcjson')
	if pkg_libs != '' {
		return pkg_cflags, pkg_libs
	}

	brew_prefix := shell_trim('brew --prefix cjson')
	if brew_prefix != '' {
		return '-I${brew_prefix}/include', '-L${brew_prefix}/lib -lcjson'
	}

	if os.exists('/opt/homebrew/include') && os.exists('/opt/homebrew/lib') {
		return '-I/opt/homebrew/include', '-L/opt/homebrew/lib -lcjson'
	}

	return '', '-lcjson'
}

fn detect_openssl_cflags() string {
	pkg_cflags := shell_trim('pkg-config --cflags openssl')
	if pkg_cflags != '' {
		return pkg_cflags
	}

	brew_prefix := shell_trim('brew --prefix openssl@3')
	if brew_prefix != '' {
		return '-I${brew_prefix}/include'
	}

	if os.exists('/opt/homebrew/opt/openssl@3/include') {
		return '-I/opt/homebrew/opt/openssl@3/include'
	}

	return ''
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
	source_dir := os.join_path(project_root, 'src')
	mut target_files := []string{}
	mut prod_mode := false
	mut emit_only := false
	os.chdir(project_root) or {
		eprintln('❌ 无法切换到项目目录: ${project_root}')
		return
	}

	for arg in os.args[1..] {
		if arg == '-prod' {
			prod_mode = true
			continue
		}
		if arg == '-emit-only' {
			emit_only = true
			continue
		}
		if arg.ends_with('.v') {
			target_files << os.real_path(arg)
		}
	}

	if target_files.len == 0 {
		files := os.ls(source_dir) or { []string{} }
		for f in files {
			if f.ends_with('.v') && f != 'build.v' && f != 'bridge.v' && f != 'mod.v' && !f.ends_with('_test.v') {
				target_files << os.real_path(os.join_path(source_dir, f))
			}
		}
	}

	if target_files.len == 0 {
		eprintln('❌ 未找到任何 V 源文件进行编译！')
		return
	}

	println('🛠️  1. 启动 VPHP Compiler 流程...')
	mut vphp_c := compiler.new(target_files)

	ext_name := vphp_c.compile() or {
		eprintln('❌ 编译阶段失败: ${err}')
		return
	}

	vphp_c.generate_all() or {
		eprintln('❌ 代码生成失败: ${err}')
		return
	}

	is_macos := os.user_os() == 'macos'
	mut disabled_warnings := '-Wno-pointer-to-int-cast -Wno-incompatible-pointer-types -Wno-unused-value'
	if is_macos {
		disabled_warnings += ' -Wno-initializer-overrides'
	} else {
		disabled_warnings += ' -Wno-override-init'
	}
	cjson_cflags, cjson_libs := detect_cjson_flags()
	openssl_cflags := detect_openssl_cflags()
	v_root_cflags := detect_v_root_include_flags()

	transpiled_c := os.join_path(project_root, '${ext_name}_generated.c')
	legacy_transpiled_c := os.join_path(project_root, 'vphp_ext_${ext_name}.c')
	output_so := os.join_path(project_root, '${ext_name}.so')
	gc_mode := detect_v_gc_mode()
	gc_compile_flags := detect_gc_compile_flags(gc_mode)
	gc_link_flags := detect_gc_link_flags(gc_mode)
	println('🛠️  2. 转译 V 逻辑为 C -> ${transpiled_c}')
	println('   使用 V GC 模式: ${gc_mode}')
	os.rm(output_so) or {}
	os.rm(legacy_transpiled_c) or {}

	prod_flag := if prod_mode { '-prod ' } else { '' }
	v_res := os.execute('v ${prod_flag}-nocache -enable-globals -gc ${gc_mode} -d use_openssl -path ".:..:@vlib" -shared -o ${transpiled_c} ${source_dir}')
	if v_res.exit_code != 0 {
		println('❌ V 编译失败: ${v_res.output}')
		return
	}

	if emit_only {
		println('✅ 已生成扩展桥接源码（emit-only 模式），跳过最终本地链接。')
		return
	}

	println('🛠️  3. GCC 最终链接...')
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
		'${cjson_cflags} ${openssl_cflags} ${v_root_cflags} ${extra_compile_flags}-DcJSON_GetErrorPos=cJSON_GetErrorPtr ' +
		'${php_inc} ${transpiled_c} php_bridge.c ../vphp/v_bridge.c -o ${output_so} ' +
		'-I../vphp ' + dedupe_link_flags('${php_ldflags} ${php_libs} ${cjson_libs}${extra_link_flags} ${platform_link_flags}')

	println('执行命令: ${gcc_cmd}')
	if os.system(gcc_cmd) != 0 {
		eprintln('❌ GCC 编译失败')
		exit(1)
	}

	if !os.exists(output_so) {
		eprintln('❌ 错误：${output_so} 未生成！')
		exit(1)
	}

	println('✅ 构建成功！${output_so} 已就绪。')
}
