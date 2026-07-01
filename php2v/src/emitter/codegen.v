module emitter

// wrap_as_main 将转译生成的自定义函数和语句主体包装为可执行的 V main 程序
pub fn wrap_as_main(funcs string, body string, extra_imports map[string]bool) string {
	mut imports := 'import rt\n'
	for mod, _ in extra_imports {
		imports += 'import ${mod}\n'
	}
	return '${imports}
${funcs}
fn main() {
	defer {
		rt.shutdown()
	}

${body}}
'
}

// wrap_as_lib 将转译生成的自定义函数和语句主体包装为库模块（供项目级打包使用）
pub fn wrap_as_lib(funcs string, body string, init_func_name string, module_name string, extra_imports map[string]bool) string {
	mut imports := 'module ${module_name}\n\nimport rt\n'
	for mod, _ in extra_imports {
		imports += 'import ${mod}\n'
	}
	return '${imports}
${funcs}

pub fn ${init_func_name}() {
${body}}
'
}

// wrap_as_entry_script 将入口脚本包装为 run_{script}() 函数，返回 rt.PhpVal
// exit/die 已在 emit 阶段转换为 return
pub fn wrap_as_entry_script(funcs string, body string, func_name string, module_name string, extra_imports map[string]bool) string {
	mut imports := 'module ${module_name}\n\nimport rt\n'
	for mod, _ in extra_imports {
		imports += 'import ${mod}\n'
	}
	// 确保函数末尾有 return（如果 body 没有以 return 结尾）
	mut final_body := body
	if !body.trim_space().ends_with('return rt.new_null()') && !body.trim_space().ends_with('return rt.new_int(0)') {
		final_body += '\treturn rt.new_null()\n'
	}
	return '${imports}
${funcs}

pub fn ${func_name}() rt.PhpVal {
${final_body}}
'
}
