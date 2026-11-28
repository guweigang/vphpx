module main

import vphp

@[vphp.PhpExportFunction(name: 'tomldemo_hello')]
fn hello() string {
	return 'from TOML'
}
