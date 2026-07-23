import rt

fn main() {
	defer {
		rt.shutdown()
	}
	println('Starting PHP Embedded Server (veb HTTP Gateway) on http://localhost:8086 ...')
	rt.start_gateway(8086, unsafe { nil })
}
