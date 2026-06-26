module emitter

// wrap_as_main 将转译生成的自定义函数和语句主体包装为可执行的 V main 程序
pub fn wrap_as_main(funcs string, body string) string {
	return 'import php2v.rt

${funcs}
fn main() {
	defer {
		rt.shutdown()
	}

${body}}
'
}
