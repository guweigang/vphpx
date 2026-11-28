module main

import vphp

@[vphp.PhpGlobals]
pub struct ExtGlobals {
pub mut:
	request_count int
}
