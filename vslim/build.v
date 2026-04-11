import os
import strings
import vphp.compiler

struct FixedArrayConstPatch {
	declaration string
	init_block  string
}

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

fn detect_mysql_flags() (string, string) {
	for pkg in ['mysqlclient', 'mariadb', 'libmariadb'] {
		pkg_cflags := shell_trim('pkg-config --cflags ${pkg}')
		pkg_libs := shell_trim('pkg-config --libs ${pkg}')
		if pkg_cflags != '' || pkg_libs != '' {
			return pkg_cflags, pkg_libs
		}
	}
	brew_prefix := shell_trim('brew --prefix mysql')
	if brew_prefix != '' {
		return '-I${brew_prefix}/include/mysql', '-L${brew_prefix}/lib -lmysqlclient'
	}
	return '', ''
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

fn detect_v_module_path() string {
	sep := if os.user_os() == 'windows' { ';' } else { ':' }
	return ['.', '..', '@vlib'].join(sep)
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

fn pkg_config_flags(args string) string {
	cmd := 'pkg-config ${args}'
	res := os.execute(cmd)
	if res.exit_code != 0 {
		eprintln('❌ 执行 `${cmd}` 失败: ${res.output.trim_space()}')
		exit(1)
	}
	return res.output.trim_space()
}

fn run_v_transpile(project_root string, prod_mode bool, gc_mode string, module_path string, output_path string, source_dir string) ! {
	v_exe := os.find_abs_path_of_executable('v') or {
		return error('unable to resolve V executable from PATH')
	}
	use_openssl := should_use_openssl()
	disable_vschannel := should_disable_vschannel()
	v_cc := detect_v_c_compiler()
	prod_arg := if prod_mode { '-prod' } else { '' }
	mut args := []string{}
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
	args << '-o'
	args << output_path
	args << source_dir

	mut proc := os.new_process(v_exe)
	proc.set_work_folder(project_root)
	proc.set_args(args)
	proc.set_redirect_stdio()
	proc.run()
	proc.wait()
	stdout := proc.stdout_slurp()
	stderr := proc.stderr_slurp()
	output := (stdout + stderr).trim_space()
	if proc.code != 0 {
		return error(output)
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
			if f.ends_with('.v') && f != 'build.v' && f != 'bridge.v' && f != 'mod.v'
				&& !f.ends_with('_test.v') {
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
		exit(1)
	}

	vphp_c.generate_all() or {
		eprintln('❌ 代码生成失败: ${err}')
		exit(1)
	}

	is_macos := os.user_os() == 'macos' || os.user_os() == 'darwin'
	mut disabled_warnings := '-Wno-pointer-to-int-cast -Wno-incompatible-pointer-types -Wno-unused-value -Wno-pointer-sign'
	if is_macos {
		disabled_warnings += ' -Wno-initializer-overrides'
	} else {
		disabled_warnings += ' -Wno-override-init'
	}
	cjson_cflags, cjson_libs := detect_cjson_flags()
	openssl_cflags := detect_openssl_cflags()
	mysql_cflags, mysql_libs := detect_mysql_flags()
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

	v_module_path := detect_v_module_path()
	run_v_transpile(project_root, prod_mode, gc_mode, v_module_path, transpiled_c, source_dir) or {
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

	if emit_only {
		println('✅ 已生成扩展桥接源码（emit-only 模式），跳过最终本地链接。')
		return
	}

	println('🛠️  3. GCC 最终链接...')
	php_inc := os.execute('php-config --includes').output.trim_space()
	php_ldflags := sanitize_ldflags(os.execute('php-config --ldflags').output.trim_space())
	php_libs := os.execute('php-config --libs').output.replace('-lzip', '').trim_space()

	mut platform_link_flags := '-fvisibility=default'
	mut extra_link_flags := ''
	if is_macos {
		platform_link_flags = '-undefined dynamic_lookup -fvisibility=default'
		extra_link_flags += ' -L/opt/homebrew/lib -L/usr/local/lib'
	}
	mut extra_compile_flags := ''
	if gc_compile_flags != '' {
		extra_compile_flags = '${gc_compile_flags} '
	}
	if gc_link_flags != '' {
		extra_link_flags += ' ${gc_link_flags}'
	}

	gcc_cmd := 'gcc -shared -fPIC ${disabled_warnings} -DCOMPILE_DL_${ext_name.to_upper()}=1 ' +
		'${cjson_cflags} ${openssl_cflags} ${mysql_cflags} ${v_root_cflags} ${extra_compile_flags}-DcJSON_GetErrorPos=cJSON_GetErrorPtr ' +
		'${php_inc} ${transpiled_c} php_bridge.c ../vphp/v_bridge.c -o ${output_so} ' +
		'-I../vphp ' +
		dedupe_link_flags('${php_ldflags} ${php_libs} ${cjson_libs} ${mysql_libs}${extra_link_flags} ${platform_link_flags}')

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
