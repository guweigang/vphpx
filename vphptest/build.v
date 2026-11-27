import os
import v.cmdexec
import vphp.compiler

fn detect_v_root_include_flags() []string {
	v_root := os.dir(os.real_path(@VEXE))
	if v_root == '' {
		return []
	}
	mut flags := []string{}
	// Generated C can pull V's compress module, which includes miniz.h from V's tree.
	zip_include := os.join_path(v_root, 'thirdparty', 'zip')
	if os.exists(zip_include) {
		flags << '-I${zip_include}'
	}
	return flags
}

fn detect_v_gc_mode() string {
	gc_mode := os.getenv_opt('VPHP_V_GC') or { '' }
	mode := gc_mode.trim_space()
	if mode == '' || mode == 'auto' {
		res := os.exec(['pkg-config', '--exists', 'bdw-gc'])
		if res.exit_code == 0 {
			return 'boehm'
		}
		return 'none'
	}
	return mode
}

fn pkg_config_flags(option string) ![]string {
	args := ['pkg-config', option, 'bdw-gc']
	res := os.exec(args)
	if res.exit_code != 0 {
		return error('pkg-config ${option} bdw-gc failed: ${res.output.trim_space()}')
	}
	return os.split_args(res.output)
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
			if f.ends_with('.v') && f != 'build.v' && f != 'vphp_bridge.v' && f != 'mod.v'
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
	flags_path := transpiled_c + '.flags'
	legacy_transpiled_c := os.join_path(project_root, 'vphp_ext_${ext_name}.c')
	output_so := os.join_path(project_root, 'vphptest.so')
	gc_mode := detect_v_gc_mode()
	println('🛠️  2. 转译 V 逻辑为 C -> ${transpiled_c}')
	println('   使用 V GC 模式: ${gc_mode}')
	os.rm(output_so) or {}
	os.rm(legacy_transpiled_c) or {}

	v_res := os.exec([@VEXE, '-nocache', '-enable-globals', '-gc', gc_mode, '-path', '.:..:@vlib',
		'-exclude', os.join_path(project_root, 'build.v'), '-shared', '-dump-c-flags', flags_path,
		'-o', transpiled_c, project_root])
	if v_res.exit_code != 0 {
		println('❌ V 编译失败: ${v_res.output}')
		exit(1)
	}
	native_inputs := compiler.native_link_inputs(flags_path) or {
		eprintln('❌ 无法读取 V 的链接输入: ${err}')
		exit(1)
	}
	objects_path := transpiled_c + '.objects'
	os.write_file(objects_path, native_inputs.map(os.quoted_path(it)).join('\n') + '\n') or {
		eprintln('❌ 无法保存 V 的链接输入: ${err}')
		exit(1)
	}

	// Step 3: GCC final link
	println('🛠️  3. GCC 最终链接...')
	link_extension(ext_name, transpiled_c, output_so, native_inputs, gc_mode) or {
		eprintln('❌ GCC 编译失败: ${err.msg()}')
		exit(1)
	}

	if !os.exists(output_so) {
		eprintln('❌ 错误：vphptest.so 未生成！')
		exit(1)
	}

	println('✅ 构建成功！vphptest.so 已就绪。')
}

fn link_extension(ext_name string, transpiled_c string, output_so string, native_inputs []string, gc_mode string) ! {
	is_macos := os.user_os() == 'macos'
	brew_path := '/opt/homebrew'
	os.setenv('C_INCLUDE_PATH', '${brew_path}/include/cjson', true)
	php := compiler.php_link_flags('php-config')!

	mut args := ['gcc', '-shared', '-fPIC', '-Wno-pointer-to-int-cast',
		'-Wno-incompatible-pointer-types']
	args << if is_macos { '-Wno-initializer-overrides' } else { '-Wno-override-init' }
	args << ['-D_GNU_SOURCE', '-DCOMPILE_DL_${ext_name.to_upper()}=1']
	args << detect_v_root_include_flags()
	if gc_mode == 'boehm' {
		args << pkg_config_flags('--cflags')!
		args << ['-DGC_THREADS=1', '-include', 'gc/gc.h']
	}
	args << ['-I${brew_path}/include', '-L${brew_path}/lib', '-lcjson',
		'-DcJSON_GetErrorPos=cJSON_GetErrorPtr']
	args << php.includes
	args << [transpiled_c, 'php_bridge.c', '../vphp/v_bridge.c']
	args << native_inputs
	args << ['-o', output_so, '-I../vphp']
	args << php.ldflags
	args << php.libs
	if gc_mode == 'boehm' {
		args << pkg_config_flags('--libs')!
	}
	if is_macos {
		args << ['-undefined', 'dynamic_lookup']
	} else if os.user_os() == 'linux' {
		args << '-Wl,-z,nodelete'
	}
	args << '-fvisibility=default'
	println('执行命令: ${cmdexec.display(args[0], args[1..])}')
	code := os.system_args(args)
	if code != 0 {
		return error('gcc exited with code ${code}')
	}
}
