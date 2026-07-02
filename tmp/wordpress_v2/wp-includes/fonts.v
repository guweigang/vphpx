import rt

fn wp_print_font_faces(var_fonts_arg rt.PhpVal) {
	mut var_fonts := var_fonts_arg
	mut var_wp_font_face := rt.new_null()
	if !rt.is_true(var_fonts) {
		mut iife_temp_0 := Class_WP_Font_Face_Resolver{}
		mut iife_result_0 := iife_temp_0.get_fonts_from_theme_json()
		var_fonts = iife_result_0
	}
	if !rt.is_true(var_fonts) {
		return
	}
	var_wp_font_face = create_wp_font_face()
	var_wp_font_face.generate_and_print(var_fonts.clone())
}

fn wp_print_font_faces_from_style_variations() {
	mut var_fonts := rt.new_null()
	mut iife_temp_1 := Class_WP_Font_Face_Resolver{}
	mut iife_result_1 := iife_temp_1.get_fonts_from_style_variations()
	var_fonts = iife_result_1
	if !rt.is_true(var_fonts) {
		return
	}
	wp_print_font_faces(var_fonts.clone())
}

fn wp_register_font_collection(slug string, var_args rt.PhpVal) rt.PhpVal {
	mut var_slug := slug
	mut iife_temp_2 := Class_WP_Font_Library{}
	mut iife_result_2 := iife_temp_2.get_instance()
	return rt.call_method(iife_result_2, 'register_font_collection', [
		rt.new_string(slug),
		var_args.clone(),
	])
}

fn wp_unregister_font_collection(slug string) rt.PhpVal {
	mut var_slug := slug
	mut iife_temp_3 := Class_WP_Font_Library{}
	mut iife_result_3 := iife_temp_3.get_instance()
	return rt.call_method(iife_result_3, 'unregister_font_collection', [
		rt.new_string(slug),
	])
}

fn wp_get_font_dir() rt.PhpVal {
	return wp_font_dir(false)
}

fn wp_font_dir(create_dir bool) rt.PhpVal {
	mut var_create_dir := create_dir
	mut var_font_dir := rt.new_null()
	rt.call_function('add_filter', [rt.new_string('upload_dir'),
		rt.new_string('_wp_filter_font_directory')])
	var_font_dir = rt.call_function('wp_upload_dir', [rt.new_null(),
		rt.new_bool(create_dir), rt.new_bool(false)])
	rt.call_function('remove_filter', [rt.new_string('upload_dir'),
		rt.new_string('_wp_filter_font_directory')])
	return var_font_dir.clone()
}

fn _wp_filter_font_directory(var_font_dir_arg rt.PhpVal) rt.PhpVal {
	mut var_font_dir := var_font_dir_arg
	if rt.is_true(rt.call_function('doing_filter', [rt.new_string('font_dir')])) {
		return var_font_dir.clone()
	}
	var_font_dir = rt.create_array([
		rt.ArrayItem{ key: 'path', val:
			(rt.call_function('untrailingslashit', [var_font_dir.array_get(rt.new_string('basedir'))])).str() +
			'/fonts' },
		rt.ArrayItem{ key: 'url', val:
			(rt.call_function('untrailingslashit', [var_font_dir.array_get(rt.new_string('baseurl'))])).str() +
			'/fonts' },
		rt.ArrayItem{ key: 'subdir', val: '' },
		rt.ArrayItem{ key: 'basedir', val:
			(rt.call_function('untrailingslashit', [var_font_dir.array_get(rt.new_string('basedir'))])).str() +
			'/fonts' },
		rt.ArrayItem{ key: 'baseurl', val:
			(rt.call_function('untrailingslashit', [var_font_dir.array_get(rt.new_string('baseurl'))])).str() +
			'/fonts' },
		rt.ArrayItem{ key: 'error', val: false },
	])
	return rt.call_function('apply_filters', [rt.new_string('font_dir'),
		var_font_dir.clone()])
}

fn _wp_after_delete_font_family(var_post_id rt.PhpVal, var_post rt.PhpVal) {
	mut var_font_faces_ids := rt.new_null()
	mut var_font_faces_id := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wp_font_family'), rt.get_property(var_post,
		'post_type')))))
	{
		return
	}
	var_font_faces_ids = rt.call_function('get_children', [
		rt.create_array([rt.ArrayItem{ key: 'post_parent', val: var_post_id },
			rt.ArrayItem{ key: 'post_type', val: 'wp_font_face' },
			rt.ArrayItem{ key: 'fields', val: 'ids' }]),
	])
	mut iter_1 := var_font_faces_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_font_faces_id_shadow := item_1.val
		rt.call_function('wp_delete_post', [var_font_faces_id_shadow.clone(),
			rt.new_bool(true)])
	}
}

fn _wp_before_delete_font_face(var_post_id rt.PhpVal, var_post rt.PhpVal) {
	mut var_font_files := rt.new_null()
	mut var_font_dir := rt.new_null()
	mut var_font_file := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wp_font_face'), rt.get_property(var_post,
		'post_type')))))
	{
		return
	}
	var_font_files = rt.call_function('get_post_meta', [var_post_id.clone(),
		rt.new_string('_wp_font_face_file'), rt.new_bool(false)])
	var_font_dir = rt.call_function('untrailingslashit', [
		wp_get_font_dir().array_get(rt.new_string('basedir')),
	])
	mut iter_2 := var_font_files.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_font_file_shadow := item_2.val
		rt.call_function('wp_delete_file', [
			rt.new_string(var_font_dir.str() + '/' + var_font_file_shadow.str()),
		])
	}
}

fn _wp_register_default_font_collections() {
	wp_register_font_collection('google-fonts', rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [
			rt.new_string('Google Fonts'),
			rt.new_string('font collection name'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Install from Google Fonts. Fonts are copied to and served from your site.'),
		]) },
		rt.ArrayItem{
			key: 'font_families'
			val: 'https://s.w.org/images/fonts/wp-7.0/collections/google-fonts-with-preview.json'
		},
		rt.ArrayItem{ key: 'categories', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [
					rt.new_string('Sans Serif'),
					rt.new_string('font category'),
				]) },
				rt.ArrayItem{ key: 'slug', val: 'sans-serif' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [
					rt.new_string('Display'),
					rt.new_string('font category'),
				]) },
				rt.ArrayItem{ key: 'slug', val: 'display' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [
					rt.new_string('Serif'),
					rt.new_string('font category'),
				]) },
				rt.ArrayItem{ key: 'slug', val: 'serif' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [
					rt.new_string('Handwriting'),
					rt.new_string('font category'),
				]) },
				rt.ArrayItem{ key: 'slug', val: 'handwriting' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [
					rt.new_string('Monospace'),
					rt.new_string('font category'),
				]) },
				rt.ArrayItem{ key: 'slug', val: 'monospace' },
			]) },
		]) },
	]))
}

struct Class_WP_Font_Face_Resolver {
	rt.PhpObjectBase
}

struct Class_WP_Font_Face {
	rt.PhpObjectBase
}

struct Class_WP_Font_Library {
	rt.PhpObjectBase
}

fn create_wp_font_face_resolver(_args ...rt.PhpVal) &Class_WP_Font_Face_Resolver {
	mut obj := &Class_WP_Font_Face_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_font_face(_args ...rt.PhpVal) &Class_WP_Font_Face {
	mut obj := &Class_WP_Font_Face{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_font_library(_args ...rt.PhpVal) &Class_WP_Font_Library {
	mut obj := &Class_WP_Font_Library{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Font_Face_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Font_Face_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Font_Face_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Font_Face) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Font_Face) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Font_Face) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Font_Library) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Font_Library) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Font_Library) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
