import rt

interface Commentable {
	addcomments(rt.PhpVal) rt.PhpVal
	getcomments() rt.PhpVal
	setcomments(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_sabberworm_css_comment_commentable_php() {
	mut var_aComments := rt.new_null()
}
