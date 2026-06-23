module main

import os
import php2v.src.ast
import php2v.src.emitter

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

	for i := 3; i < os.args.len; i++ {
		arg := os.args[i]
		if arg == '-o' && i + 1 < os.args.len {
			output_file = os.args[i + 1]
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

	// 1. 调用 php 生成 JSON AST
	res := os.execute('php "${parser_path}" "${input_file}"')
	if res.exit_code != 0 {
		eprintln('PHP parsing failed: ${res.output}')
		return
	}

	// 2. 解析 AST
	stmts := ast.parse_ast_json(res.output) or {
		eprintln('Failed to parse AST JSON: ${err}')
		return
	}

	// 3. 转译为 V 代码
	mut transpiler := emitter.Transpiler.new()
	v_body := transpiler.transpile(stmts)
	v_code := emitter.wrap_as_main(transpiler.func_out.str(), v_body)

	// 4. 写入输出文件
	os.write_file(output_file, v_code) or {
		eprintln('Failed to write output file: ${err}')
		return
	}
	println('Successfully transpiled ${input_file} -> ${output_file}')

	// 5. 如果需要，直接编译并运行
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
