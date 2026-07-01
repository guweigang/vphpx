import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/wp-load.php',
		'4')
	rt.call_function('wp_redirect', [
		rt.call_function('admin_url', [
			rt.new_string('edit-comments.php?comment_status=moderated'),
		]),
	])
	// unsupported expression: Expr_Exit
}
