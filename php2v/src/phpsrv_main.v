module main

import src.rt
import os

fn main() {
	defer {
		rt.shutdown()
	}
	mut config_file := 'gateway.yaml'
	if os.args.len > 1 {
		config_file = os.args[1]
	}
	println('Starting PHP Embedded Server (veb HTTP Gateway) with config [${config_file}]...')
	rt.start_gateway(8086, unsafe { nil })
}
