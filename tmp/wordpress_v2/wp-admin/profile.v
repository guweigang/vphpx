import rt

const global_const_is_profile_page = true

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/user-edit.php', '4')
}
