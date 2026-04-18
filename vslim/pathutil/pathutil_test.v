module pathutil

fn test_normalize_bootstrap_dir_path_windows_drive_path() {
	assert normalize_bootstrap_dir_path(r'D:\a\vphpx\vphpx\vslim\templates\app') == 'D:/a/vphpx/vphpx/vslim/templates/app'
}

fn test_normalize_bootstrap_dir_path_windows_preserves_parent_segments() {
	assert normalize_bootstrap_dir_path(r'D:\a\vphpx\vphpx\vslim\tests\..\templates\app') == 'D:/a/vphpx/vphpx/vslim/tests/../templates/app'
}

fn test_normalize_bootstrap_dir_path_windows_trims_trailing_slash() {
	assert normalize_bootstrap_dir_path(r'D:\a\vphpx\vphpx\vslim\templates\app\\') == 'D:/a/vphpx/vphpx/vslim/templates/app'
}

fn test_path_join_windows_drive_path() {
	assert path_join(r'D:\a\vphpx\vphpx\vslim\templates\app', 'bootstrap/app.php') == 'D:/a/vphpx/vphpx/vslim/templates/app/bootstrap/app.php'
}

fn test_path_join_windows_parent_segment_path() {
	assert path_join(r'D:\a\vphpx\vphpx\vslim\tests\..\templates\app', 'bootstrap/app.php') == 'D:/a/vphpx/vphpx/vslim/tests/../templates/app/bootstrap/app.php'
}

fn test_path_join_empty_base_returns_child() {
	assert path_join('', 'bootstrap/app.php') == 'bootstrap/app.php'
}
