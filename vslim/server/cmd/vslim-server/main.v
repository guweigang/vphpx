module main

import os
import serverx

fn main() {
	config_path := if os.args.len > 1 { os.args[1] } else { 'vslim.yaml' }
	serverx.start(config_path) or {
		eprintln('vslim serve failed: ${err}')
		exit(1)
	}
}
