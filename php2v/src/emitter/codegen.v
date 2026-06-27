module emitter

// wrap_as_main 将转译生成的自定义函数和语句主体包装为可执行的 V main 程序
pub fn wrap_as_main(funcs string, body string, extra_imports map[string]bool) string {
	mut imports := 'import php2v.rt\n'
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
