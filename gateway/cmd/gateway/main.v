module main

import gateway
import os

fn main() {
	config_path := if os.args.len > 1 { os.args[1] } else { 'gateway.yaml' }
	gateway.start(config_path) or {
		eprintln('gateway failed: ${err}')
		exit(1)
	}
}
