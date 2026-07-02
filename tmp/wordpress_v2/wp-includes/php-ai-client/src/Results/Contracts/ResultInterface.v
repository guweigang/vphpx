import rt

interface ResultInterface {
	getid() rt.PhpVal
	gettokenusage() rt.PhpVal
	getprovidermetadata() rt.PhpVal
	getmodelmetadata() rt.PhpVal
	getadditionaldata() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
