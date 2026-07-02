import rt

interface Commentable {
	addcomments(rt.PhpVal) rt.PhpVal
	getcomments() rt.PhpVal
	setcomments(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_aComments := rt.new_null()
}
