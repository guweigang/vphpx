import os
import strings
import json2
import v.cmdexec
import vphp.compiler

struct FixedArrayConstPatch {
	declaration string
	init_block  string
}

fn query_tool(args []string) string {
	res := os.exec(args)
	if res.exit_code != 0 {
		return ''
	}
	return res.output.trim_space()
}

fn detect_cjson_flags() !([]string, []string) {
	pkg_cflags := query_tool(['pkg-config', '--cflags', 'libcjson'])
	pkg_libs := query_tool(['pkg-config', '--libs', 'libcjson'])
	if pkg_libs != '' {
		return os.split_args(pkg_cflags)!, os.split_args(pkg_libs)!
	}

	brew_prefix := query_tool(['brew', '--prefix', 'cjson'])
	if brew_prefix != '' {
		return ['-I${brew_prefix}/include'], ['-L${brew_prefix}/lib', '-lcjson']
	}

	if os.exists('/opt/homebrew/include') && os.exists('/opt/homebrew/lib') {
		return ['-I/opt/homebrew/include'], ['-L/opt/homebrew/lib', '-lcjson']
	}

	return []string{}, ['-lcjson']
}

fn detect_openssl_cflags() ![]string {
	pkg_cflags := query_tool(['pkg-config', '--cflags', 'openssl'])
	if pkg_cflags != '' {
		return os.split_args(pkg_cflags)
	}

	brew_prefix := query_tool(['brew', '--prefix', 'openssl@3'])
	if brew_prefix != '' {
		return ['-I${brew_prefix}/include']
	}

	if os.exists('/opt/homebrew/opt/openssl@3/include') {
		return ['-I/opt/homebrew/opt/openssl@3/include']
	}

	return []
}

fn detect_mysql_flags() !([]string, []string) {
	for pkg in ['mysqlclient', 'mariadb', 'libmariadb'] {
		pkg_cflags := query_tool(['pkg-config', '--cflags', pkg])
		pkg_libs := query_tool(['pkg-config', '--libs', pkg])
		if pkg_cflags != '' || pkg_libs != '' {
			return os.split_args(pkg_cflags)!, os.split_args(pkg_libs)!
		}
	}
	brew_prefix := query_tool(['brew', '--prefix', 'mysql'])
	if brew_prefix != '' {
		return ['-I${brew_prefix}/include/mysql'], ['-L${brew_prefix}/lib', '-lmysqlclient']
	}
	return []string{}, []string{}
}

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

fn detect_v_module_path() string {
	override := (os.getenv_opt('VPHP_V_MODULE_PATH') or { '' }).trim_space()
	if override != '' {
		return override
	}
	sep := if os.user_os() == 'windows' { ';' } else { ':' }
	return ['.', '..', '@vlib'].join(sep)
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

fn detect_v_c_compiler() string {
	override := (os.getenv_opt('VPHP_V_CC') or { '' }).trim_space()
	if override != '' {
		return override
	}
	if os.user_os() == 'windows' {
		return 'msvc'
	}
	return ''
}

fn pkg_config_flags(option string) ![]string {
	args := ['pkg-config', option, 'bdw-gc']
	res := os.exec(args)
	if res.exit_code != 0 {
		return error('pkg-config ${option} bdw-gc failed: ${res.output.trim_space()}')
	}
	return os.split_args(res.output)
}

fn run_v_transpile(prod_mode bool, gc_mode string, module_path string, output_path string, source_dir string) ! {
	use_openssl := should_use_openssl()
	disable_vschannel := should_disable_vschannel()
	v_cc := detect_v_c_compiler()
	prod_arg := if prod_mode { '-prod' } else { '' }
	mut args := [@VEXE]
	if prod_arg != '' {
		args << prod_arg
	}
	args << '-nocache'
	args << '-enable-globals'
	args << '-gc'
	args << gc_mode
	if use_openssl {
		args << '-d'
		args << 'use_openssl'
	}
	if disable_vschannel {
		args << '-d'
		args << 'no_vschannel'
	}
	if v_cc != '' {
		args << '-cc'
		args << v_cc
	}
	args << '-path'
	args << module_path
	args << '-shared'
	args << '-dump-c-flags'
	args << output_path + '.flags'
	args << '-o'
	args << output_path
	args << source_dir

	result := os.exec(args)
	if result.exit_code != 0 {
		return error(result.output.trim_space())
	}
}

fn should_use_openssl() bool {
	raw := os.getenv_opt('VPHP_V_USE_OPENSSL') or { '' }
	flag := raw.trim_space().to_lower()
	if flag == '' {
		return true
	}
	return flag !in ['0', 'false', 'no', 'off']
}

fn should_disable_vschannel() bool {
	raw := os.getenv_opt('VPHP_V_NO_VSCHANNEL') or { '' }
	flag := raw.trim_space().to_lower()
	if flag == '' {
		return false
	}
	return flag !in ['0', 'false', 'no', 'off']
}

fn should_force_windows_patch() bool {
	raw := os.getenv_opt('VPHP_V_FORCE_WINDOWS_PATCH') or { '' }
	flag := raw.trim_space().to_lower()
	if flag == '' {
		return false
	}
	return flag !in ['0', 'false', 'no', 'off']
}

fn should_patch_windows_generated_c() bool {
	return os.user_os() == 'windows' || should_force_windows_patch()
}

fn is_decimal_literal(value string) bool {
	if value.len == 0 {
		return false
	}
	for ch in value {
		if ch < `0` || ch > `9` {
			return false
		}
	}
	return true
}

fn normalize_unsigned_literal_suffix(value string, width int) string {
	literal := value.trim_space()
	if literal == '' {
		return value
	}
	if width == 32 {
		if is_decimal_literal(literal) {
			return literal + 'U'
		}
		return literal
	}
	if width == 64 {
		if literal.ends_with('ULL') {
			return literal
		}
		if literal.ends_with('UL') {
			return literal[..literal.len - 2] + 'ULL'
		}
		if literal.ends_with('U') {
			return literal[..literal.len - 1] + 'ULL'
		}
		if is_decimal_literal(literal) {
			return literal + 'ULL'
		}
	}
	return literal
}

fn patch_windows_generated_const_suffixes(path string) ! {
	if !should_patch_windows_generated_c() {
		return
	}
	content := os.read_file(path)!
	mut builder := strings.new_builder(content.len + 256)
	mut changed := false
	for line in content.split_into_lines() {
		mut patched := line
		if line.contains('// precomputed2') && line.contains(' = ') {
			eq := line.index('=') or { -1 }
			semi := line.index(';') or { -1 }
			if eq > 0 && semi > eq {
				lhs := line[..eq]
				rhs := line[eq + 1..semi].trim_space()
				mut next_rhs := rhs
				if lhs.contains('const u32 ') {
					next_rhs = normalize_unsigned_literal_suffix(rhs, 32)
				} else if lhs.contains('const u64 ') {
					next_rhs = normalize_unsigned_literal_suffix(rhs, 64)
				}
				if next_rhs != rhs {
					patched = '${line[..eq + 1]} ${next_rhs}${line[semi..]}'
					changed = true
				}
			}
		}
		builder.writeln(patched)
	}
	if changed {
		os.write_file(path, builder.str())!
	}
}

fn build_fixed_array_const_patch(original string, index int) !FixedArrayConstPatch {
	comment_marker := '// fixed array const'
	comment_pos := original.index(comment_marker) or {
		return error('missing fixed array const marker')
	}
	eq := original.index('=') or {
		return error('missing assignment operator in fixed array const')
	}
	semi := original[..comment_pos].last_index(';') or {
		return error('missing semicolon in fixed array const')
	}
	prefix := original[..eq].trim_space()
	last_space := prefix.last_index(' ') or {
		return error('missing array name in fixed array const')
	}
	typ := prefix[..last_space].trim_space()
	name := prefix[last_space + 1..].trim_space()
	initializer := original[eq + 1..semi].trim_space()
	return FixedArrayConstPatch{
		declaration: '${prefix}; // fixed array const, inited later'
		init_block:  '\t{\n\t{\n\t\t${typ} _v_fixed_array_init_${index} = ${initializer};\n\t\tmemcpy(&${name}, &_v_fixed_array_init_${index}, sizeof(${typ}));\n\t}\n\t}\n'
	}
}

fn patch_windows_generated_fixed_array_consts(path string) ! {
	if !should_patch_windows_generated_c() {
		return
	}
	content := os.read_file(path)!
	marker := '// fixed array const'
	mut cursor := 0
	mut changed := false
	mut patches := []FixedArrayConstPatch{}
	mut rewritten := strings.new_builder(content.len + 4096)
	for cursor < content.len {
		relative := content[cursor..].index(marker) or { break }
		marker_pos := cursor + relative
		eq_pos := content[..marker_pos].last_index('=') or {
			cursor = marker_pos + marker.len
			continue
		}
		line_start := content[..eq_pos].last_index('\n') or { -1 }
		mut decl_start := if line_start >= 0 { line_start + 1 } else { 0 }
		for decl_start < content.len && (content[decl_start] == `\n` || content[decl_start] == `\r`) {
			decl_start++
		}
		line_end := content[marker_pos..].index('\n') or { content.len - marker_pos }
		decl_end := marker_pos + line_end
		original := content[decl_start..decl_end]
		rewritten.write_string(content[cursor..decl_start])
		patch := build_fixed_array_const_patch(original, patches.len + 1) or {
			rewritten.write_string(original)
			cursor = decl_end
			continue
		}
		rewritten.write_string(patch.declaration)
		patches << patch
		changed = true
		cursor = decl_end
	}
	rewritten.write_string(content[cursor..])
	if !changed {
		return
	}
	mut patched_content := rewritten.str()
	vinit_marker := 'void _vinit(int ___argc, voidptr ___argv) {\n'
	insert_at := patched_content.index(vinit_marker) or {
		return error('unable to locate _vinit for fixed array initialization patch')
	}
	mut init_builder := strings.new_builder(256 * patches.len)
	init_builder.writeln('\t// Windows/MSVC workaround: initialize fixed array consts at runtime.')
	for patch in patches {
		init_builder.write_string(patch.init_block)
	}
	patched_content = patched_content[..insert_at + vinit_marker.len] + init_builder.str() +
		patched_content[insert_at + vinit_marker.len..]
	os.write_file(path, patched_content)!
	println('🩹 Windows fixed array workaround patched ${patches.len} const definitions.')
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
		files := os.walk_ext(source_dir, '.v')
		for file in files {
			base := os.base(file)
			if base != 'build.v' && base != 'bridge.v' && base != 'vphp_bridge.v' && base != 'mod.v'
				&& !base.ends_with('_test.v') {
				target_files << os.real_path(file)
			}
		}
	}

	if target_files.len == 0 {
		eprintln('❌ 未找到任何 V 源文件进行编译！')
		return
	}

	println('🛠️  1. 启动 VPHP Compiler 流程...')
	mut vphp_c := compiler.new(target_files)
	vphp_c.config_path = os.join_path(source_dir, 'config.toml')

	ext_name := vphp_c.compile() or {
		eprintln('❌ 编译阶段失败: ${err}')
		exit(1)
	}

	vphp_c.generate_all() or {
		eprintln('❌ 代码生成失败: ${err}')
		exit(1)
	}

	transpiled_c := os.join_path(project_root, '${ext_name}_generated.c')
	legacy_transpiled_c := os.join_path(project_root, 'vphp_ext_${ext_name}.c')
	configured_output := (os.getenv_opt('VSLIM_OUTPUT') or { '' }).trim_space()
	output_so := if configured_output != '' {
		if os.is_abs_path(configured_output) {
			os.norm_path(configured_output)
		} else {
			os.norm_path(os.join_path(project_root, configured_output))
		}
	} else {
		filename := if os.user_os() == 'windows' && emit_only {
			'php_${ext_name}.dll'
		} else {
			'${ext_name}.so'
		}
		os.join_path(project_root, filename)
	}
	gc_mode := detect_v_gc_mode()
	println('🛠️  2. 转译 V 逻辑为 C -> ${transpiled_c}')
	println('   使用 V GC 模式: ${gc_mode}')
	expressions_sidecar := '${output_so}.stub-expressions.json'
	os.rm(output_so) or {}
	os.rm(expressions_sidecar) or {}
	os.rm(legacy_transpiled_c) or {}

	v_module_path := detect_v_module_path()
	run_v_transpile(prod_mode, gc_mode, v_module_path, transpiled_c, source_dir) or {
		println('❌ V 编译失败: ${err.msg()}')
		exit(1)
	}
	patch_windows_generated_const_suffixes(transpiled_c) or {
		println('❌ Windows 生成源码修补失败: ${err.msg()}')
		exit(1)
	}
	patch_windows_generated_fixed_array_consts(transpiled_c) or {
		println('❌ Windows fixed array 常量修补失败: ${err.msg()}')
		exit(1)
	}

	if !emit_only {
		println('🛠️  3. GCC 最终链接...')
		link_extension(ext_name, transpiled_c, output_so, gc_mode) or {
			eprintln('❌ GCC 编译失败: ${err.msg()}')
			exit(1)
		}

		if !os.exists(output_so) {
			eprintln('❌ 错误：${output_so} 未生成！')
			exit(1)
		}
	}

	os.write_file(expressions_sidecar, json2.encode(vphp_c.stub_expressions())) or {
		eprintln('❌ 无法写入 stub 表达式元数据: ${err.msg()}')
		exit(1)
	}
	declarations := vphp_c.userland_class_declarations()
	classes_sidecar := '${output_so}.classes.php'
	if declarations != '' {
		os.write_file(classes_sidecar, '${compiler.userland_classes_header}\n${declarations}\n') or {
			eprintln('❌ 无法写入 PHP 用户态类: ${err.msg()}')
			exit(1)
		}
	} else {
		compiler.remove_stale_userland_classes(classes_sidecar) or {
			eprintln('❌ 无法清理 PHP 用户态类: ${err.msg()}')
			exit(1)
		}
	}
	if emit_only {
		println('✅ 已生成扩展桥接源码（emit-only 模式），跳过最终本地链接。')
	} else {
		println('✅ 构建成功！${output_so} 已就绪。')
	}
}

fn link_extension(ext_name string, transpiled_c string, output_so string, gc_mode string) ! {
	is_macos := os.user_os() == 'macos' || os.user_os() == 'darwin'
	native_inputs := compiler.native_link_inputs(transpiled_c + '.flags')!
	php_config := (os.getenv_opt('VPHP_PHP_CONFIG') or { 'php-config' }).trim_space()
	php := compiler.php_link_flags(php_config)!
	cjson_cflags, cjson_libs := detect_cjson_flags()!
	mysql_cflags, mysql_libs := detect_mysql_flags()!
	extension_cc := (os.getenv_opt('VSLIM_EXTENSION_CC') or { 'gcc' }).trim_space()
	mut args := if os.is_file(extension_cc) { [extension_cc] } else { os.split_args(extension_cc)! }
	if args.len == 0 {
		return error('missing extension compiler command')
	}
	args << ['-shared', '-fPIC', '-Wno-pointer-to-int-cast', '-Wno-incompatible-pointer-types',
		'-Wno-unused-value', '-Wno-pointer-sign']
	args << if is_macos { '-Wno-initializer-overrides' } else { '-Wno-override-init' }
	args << ['-D_GNU_SOURCE', '-DCOMPILE_DL_${ext_name.to_upper()}=1']
	args << cjson_cflags
	args << detect_openssl_cflags()!
	args << mysql_cflags
	args << detect_v_root_include_flags()
	if gc_mode == 'boehm' {
		args << pkg_config_flags('--cflags')!
		args << ['-DGC_THREADS=1', '-include', 'gc/gc.h']
	}
	args << '-DcJSON_GetErrorPos=cJSON_GetErrorPtr'
	args << php.includes
	args << [transpiled_c, 'php_bridge.c', '../vphp/v_bridge.c']
	args << native_inputs
	args << ['-o', output_so, '-I../vphp']

	mut libs := php.ldflags.clone()
	libs << php.libs
	libs << cjson_libs
	libs << mysql_libs
	if is_macos {
		libs << ['-L/opt/homebrew/lib', '-L/usr/local/lib']
	}
	if gc_mode == 'boehm' {
		libs << pkg_config_flags('--libs')!
	}
	args << libs
	if is_macos {
		args << ['-undefined', 'dynamic_lookup']
	} else if os.user_os() == 'linux' {
		args << '-Wl,-z,nodelete'
	}
	args << '-fvisibility=default'
	println('执行命令: ${cmdexec.display(args[0], args[1..])}')
	code := os.system_args(args)
	if code != 0 {
		return error('${args[0]} exited with code ${code}')
	}
}
