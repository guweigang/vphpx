import rt

const global_const_wp_use_themes = true

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/wp-blog-header.php', '3')
}
