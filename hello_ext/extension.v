module main

import vphp

const ext_config = vphp.ExtensionConfig{
	name: 'hello_ext'
	version: '0.1.0'
	description: 'PHP extension built with VPHP'
}

@[vphp.PhpExportFunction(name: 'hello_ext_hello')]
fn hello(name string) string {
	return 'Hello, ${name}!'
}
