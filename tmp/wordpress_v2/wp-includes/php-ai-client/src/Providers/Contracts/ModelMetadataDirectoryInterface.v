import rt

interface ModelMetadataDirectoryInterface {
	listmodelmetadata() rt.PhpVal
	hasmodelmetadata(rt.PhpVal) rt.PhpVal
	getmodelmetadata(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_modelId := rt.new_null()
}
