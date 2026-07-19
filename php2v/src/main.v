module main

import os
import ast
import emitter

fn main() {
	if os.args.len < 3 {
		print_usage()
		return
	}

	cmd := os.args[1]
	if cmd != 'compile' {
		print_usage()
		return
	}

	input_file := os.args[2]
	if !os.exists(input_file) {
		eprintln('File not found: ${input_file}')
		return
	}

	mut output_file := ''
	mut run_after := false
	mut mode := 'exe'

	for i := 3; i < os.args.len; i++ {
		arg := os.args[i]
		if arg == '-o' && i + 1 < os.args.len {
			output_file = os.args[i + 1]
			i++
		} else if arg == '-mode' && i + 1 < os.args.len {
			mode = os.args[i + 1]
			i++
		} else if arg == '--run' {
			run_after = true
		}
	}

	if output_file == '' {
		output_file = input_file.all_before_last('.') + '.v'
	}

	parser_path := find_parser_path() or {
		eprintln('Error: ${err}')
		exit(1)
	}

	// 1. 获取/调用 php 生成 JSON AST 缓存
	safe_name := input_file.replace('/', '_').replace(':', '_').replace('\\', '_')
	cache_dir := os.join_path(os.dir(parser_path), 'tmp/ast_cache')
	cache_path := os.join_path(cache_dir, safe_name + '.json')
	mut json_ast := ''
	if os.exists(cache_path) {
		json_ast = os.read_file(cache_path) or { '' }
	}
	if json_ast == '' {
		res := os.execute('php "${parser_path}" "${input_file}"')
		if res.exit_code != 0 {
			eprintln('PHP parsing failed: ${res.output}')
			return
		}
		json_ast = res.output
		os.mkdir_all(cache_dir) or {}
		os.write_file(cache_path, json_ast) or {}
	}

	// 2. 解析 AST 并深度克隆以脱离 cJSON 内存生命周期
	parsed_stmts := ast.parse_ast_json(json_ast) or {
		eprintln('Failed to parse AST JSON: ${err}')
		return
	}
	mut stmts := []ast.AstNode{}
	for i in 0 .. parsed_stmts.len {
		stmts << *parsed_stmts[i].clone()
	}

	// 3. 转译为 V 代码
	mut transpiler := emitter.Transpiler.new()
	transpiler.current_file = input_file
	transpiler.parser_php_path = parser_path
	transpiler.mode = mode
	v_body := transpiler.transpile(stmts)

	all_funcs := transpiler.func_out.str() + transpiler.include_funcs_code.str()
	final_v_body := transpiler.include_register_code.str() + v_body

	v_code := if mode == 'web' {
		base_name := input_file.all_before_last('.').all_after_last('/')
		func_name := 'run_${base_name}'
		emitter.wrap_as_entry_script(all_funcs, final_v_body, func_name, 'main', transpiler.extra_imports)
	} else if mode == 'gateway' {
		emitter.wrap_as_gateway(all_funcs, final_v_body, transpiler.extra_imports)
	} else if mode == 'lib' {
		base_name := input_file.all_before_last('.').all_after_last('/')
		init_func_name := 'init_${base_name}'
		emitter.wrap_as_lib(all_funcs, final_v_body, init_func_name, 'main', transpiler.extra_imports)
	} else {
		emitter.wrap_as_main(all_funcs, final_v_body, transpiler.extra_imports)
	}

	// 4. 写入输出文件

	os.write_file(output_file, v_code) or {
		eprintln('Failed to write output file: ${err}')
		return
	}
	
	// 5. 格式化 V 源码
	fmt_res := os.execute('v fmt -w "${output_file}"')
	if fmt_res.exit_code != 0 {
		eprintln('Warning: v fmt failed: ${fmt_res.output}')
	}
	fix_multiline_if(output_file)
	
	println('Successfully transpiled ${input_file} -> ${output_file}')

	// 6. 如果需要，直接编译并运行
	if run_after {
		run_res := os.execute('v run "${output_file}"')
		print(run_res.output)
		if run_res.exit_code != 0 {
			exit(run_res.exit_code)
		}
	}
}

fn find_parser_path() !string {
	// 1. 检查环境变量
	env_path := os.getenv('PHP2V_SCRIPTS_PATH')
	if env_path != '' {
		p := os.join_path(env_path, 'parser.php')
		if os.exists(p) {
			return p
		}
	}
	// 2. 检查可执行程序所在目录
	exe_dir := os.dir(os.executable())
	p_exe := os.join_path(exe_dir, 'scripts/parser.php')
	if os.exists(p_exe) {
		return p_exe
	}
	// 3. 检查当前工作目录
	p_pwd := os.join_path(os.getwd(), 'php2v/scripts/parser.php')
	if os.exists(p_pwd) {
		return p_pwd
	}
	// 4. 检查开发环境预设绝对路径
	dev_path := '/Users/guweigang/Source/vphpx/php2v/scripts/parser.php'
	if os.exists(dev_path) {
		return dev_path
	}
	return error('parser.php not found! Please set PHP2V_SCRIPTS_PATH env variable.')
}

fn print_usage() {
	println('Usage: php2v compile <input.php> [-o output.v] [--run]')
	println('  compile  Transpiles a PHP file into V source code')
	println('  --run    Compiles and runs the generated V code immediately')
}

// fix_multiline_if fixes multi-line if conditions produced by v fmt
// where { ends up on a separate line, which V compiler rejects
fn fix_multiline_if(file_path string) {
	content := os.read_file(file_path) or { return }
	lb := '\n'
	if !content.contains('${lb}\t{') && !content.contains('${lb} {') {
		return
	}
	lines := content.split(lb)
	mut result := []string{}
	mut i := 0
	for i < lines.len {
		line := lines[i]
		if i + 1 < lines.len {
			next_line := lines[i + 1]
			trimmed := next_line.trim_space()
			if trimmed == '{' {
				stripped := line.trim_space()
				if stripped.starts_with('if ') || stripped.starts_with('} else if ') || stripped.starts_with('for ') {
					result << line + ' {'
					i += 2
					continue
				}
			}
		}
		result << line
		i++
	}
	os.write_file(file_path, result.join(lb)) or { return }
}
