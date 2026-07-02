import rt

fn register_block_pattern(var_pattern_name rt.PhpVal, var_pattern_properties rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_WP_Block_Patterns_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	return rt.call_method(iife_result_0, 'register', [var_pattern_name.clone(),
		var_pattern_properties.clone()])
}

fn unregister_block_pattern(var_pattern_name rt.PhpVal) rt.PhpVal {
	mut iife_temp_1 := Class_WP_Block_Patterns_Registry{}
	mut iife_result_1 := iife_temp_1.get_instance()
	return rt.call_method(iife_result_1, 'unregister', [var_pattern_name.clone()])
}

fn register_block_pattern_category(category_name string, var_category_properties rt.PhpVal) rt.PhpVal {
	mut var_category_name := category_name
	mut iife_temp_2 := Class_WP_Block_Pattern_Categories_Registry{}
	mut iife_result_2 := iife_temp_2.get_instance()
	return rt.call_method(iife_result_2, 'register', [rt.new_string(category_name),
		var_category_properties.clone()])
}

fn unregister_block_pattern_category(var_category_name rt.PhpVal) rt.PhpVal {
	mut iife_temp_3 := Class_WP_Block_Pattern_Categories_Registry{}
	mut iife_result_3 := iife_temp_3.get_instance()
	return rt.call_method(iife_result_3, 'unregister', [var_category_name.clone()])
}

fn _register_core_block_patterns_and_categories() {
	mut var_should_register_core_patterns := rt.new_null()
	mut var_core_block_patterns := []rt.PhpVal{}
	mut var_core_block_pattern := rt.new_null()
	mut var_pattern := rt.new_null()
	var_should_register_core_patterns = rt.call_function('get_theme_support', [
		rt.new_string('core-block-patterns'),
	])
	if rt.is_true(var_should_register_core_patterns) {
		var_core_block_patterns = ['query-standard-posts', 'query-medium-posts', 'query-small-posts',
			'query-grid-posts', 'query-large-title-posts', 'query-offset-posts', 'navigation-overlay',
			'navigation-overlay-black-bg', 'navigation-overlay-accent-bg',
			'navigation-overlay-centered', 'navigation-overlay-centered-with-extras']
		for var_core_block_pattern_shadow in var_core_block_patterns {
			var_pattern = rt.include_file(@DIR + '/block-patterns/' +
				(rt.new_string(var_core_block_pattern_shadow.str())).str() + '.php', '3')
			var_pattern.array_set('source', 'core')
			register_block_pattern(rt.new_string('core/' +
				(rt.new_string(var_core_block_pattern_shadow.str())).str()), var_pattern.clone())
		}
	}
	register_block_pattern_category('banner', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Banners'),
			rt.new_string('Block pattern category'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Bold sections designed to showcase key content.'),
		]) },
	]))
	register_block_pattern_category('buttons', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Buttons'),
			rt.new_string('Block pattern category'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Patterns that contain buttons and call to actions.'),
		]) },
	]))
	register_block_pattern_category('columns', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Columns'),
			rt.new_string('Block pattern category'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Multi-column patterns with more complex layouts.'),
		]) },
	]))
	register_block_pattern_category('text', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Text'), rt.new_string('Block pattern category')]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Patterns containing mostly text.')]) },
	]))
	register_block_pattern_category('query', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Posts'), rt.new_string('Block pattern category')]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Display your latest posts in lists, grids or other layouts.')]) },
	]))
	register_block_pattern_category('featured', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Featured'),
			rt.new_string('Block pattern category'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('A set of high quality curated patterns.'),
		]) },
	]))
	register_block_pattern_category('call-to-action', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Call to action'),
			rt.new_string('Block pattern category'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Sections whose purpose is to trigger a specific action.'),
		]) },
	]))
	register_block_pattern_category('team', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Team'), rt.new_string('Block pattern category')]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('A variety of designs to display your team members.')]) },
	]))
	register_block_pattern_category('testimonials', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Testimonials'),
			rt.new_string('Block pattern category'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Share reviews and feedback about your brand/business.'),
		]) },
	]))
	register_block_pattern_category('services', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Services'),
			rt.new_string('Block pattern category'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Briefly describe what your business does and how you can help.'),
		]) },
	]))
	register_block_pattern_category('contact', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Contact'),
			rt.new_string('Block pattern category'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Display your contact information.'),
		]) },
	]))
	register_block_pattern_category('about', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('About'), rt.new_string('Block pattern category')]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Introduce yourself.')]) },
	]))
	register_block_pattern_category('portfolio', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Portfolio'),
			rt.new_string('Block pattern category'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Showcase your latest work.'),
		]) },
	]))
	register_block_pattern_category('gallery', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Gallery'),
			rt.new_string('Block pattern category'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Different layouts for displaying images.'),
		]) },
	]))
	register_block_pattern_category('media', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Media'), rt.new_string('Block pattern category')]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Different layouts containing video or audio.')]) },
	]))
	register_block_pattern_category('videos', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Videos'), rt.new_string('Block pattern category')]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Different layouts containing videos.')]) },
	]))
	register_block_pattern_category('audio', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Audio'), rt.new_string('Block pattern category')]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Different layouts containing audio.')]) },
	]))
	register_block_pattern_category('posts', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Posts'), rt.new_string('Block pattern category')]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Display your latest posts in lists, grids or other layouts.')]) },
	]))
	register_block_pattern_category('footer', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Footers'),
			rt.new_string('Block pattern category'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('A variety of footer designs displaying information and site navigation.'),
		]) },
	]))
	register_block_pattern_category('header', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Headers'),
			rt.new_string('Block pattern category'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('A variety of header designs displaying your site title and navigation.'),
		]) },
	]))
	register_block_pattern_category('navigation', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Navigation'),
			rt.new_string('Block pattern category'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('A variety of designs displaying site navigation.'),
		]) },
	]))
}

fn wp_normalize_remote_block_pattern(var_pattern rt.PhpVal) rt.PhpVal {
	if var_pattern.array_isset(rt.new_string('block_types')) {
		var_pattern.array_set('blockTypes', var_pattern.array_get(rt.new_string('block_types')))
		var_pattern.array_unset(rt.new_string('block_types'))
	}
	if var_pattern.array_isset(rt.new_string('viewport_width')) {
		var_pattern.array_set('viewportWidth',
			var_pattern.array_get(rt.new_string('viewport_width')))
		var_pattern.array_unset(rt.new_string('viewport_width'))
	}
	return rt.cast_array(var_pattern)
}

fn _load_remote_block_patterns(var_deprecated rt.PhpVal) {
	mut var_current_screen := rt.new_null()
	mut var_supports_core_patterns := rt.new_null()
	mut var_should_load_remote := rt.new_null()
	mut var_request := rt.new_null()
	mut var_core_keyword_id := i64(0)
	mut var_response := rt.new_null()
	mut var_patterns := rt.new_null()
	mut var_pattern := rt.new_null()
	mut var_normalized_pattern := rt.new_null()
	mut var_pattern_name := rt.new_null()
	if !(!rt.is_true(var_deprecated)) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('5.9.0')])
		var_current_screen = var_deprecated
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_current_screen,
			'is_block_editor')))))
		{
			return
		}
	}
	var_supports_core_patterns = rt.call_function('get_theme_support', [
		rt.new_string('core-block-patterns'),
	])
	var_should_load_remote = rt.call_function('apply_filters', [
		rt.new_string('should_load_remote_block_patterns'),
		rt.new_bool(true),
	])
	if rt.is_true(var_supports_core_patterns) && rt.is_true(var_should_load_remote) {
		var_request = create_wp_rest_request(rt.new_string('GET'),
			rt.new_string('/wp/v2/pattern-directory/patterns'))
		var_core_keyword_id = 11
		rt.call_method(var_request, 'set_param', [rt.new_string('keyword'),
			rt.new_int(var_core_keyword_id).clone()])
		var_response = rt.call_function('rest_do_request', [var_request.clone()])
		if rt.is_true(rt.call_method(var_response, 'is_error', []rt.PhpVal{})) {
			return
		}
		var_patterns = rt.call_method(var_response, 'get_data', []rt.PhpVal{})
		mut iter_1 := var_patterns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_pattern_shadow := item_1.val
			var_pattern_shadow.array_set('source', 'pattern-directory/core')
			var_normalized_pattern = wp_normalize_remote_block_pattern(var_pattern_shadow.clone())
			var_pattern_name =
				rt.new_string('core/' +(rt.call_function('sanitize_title', [var_normalized_pattern.array_get(rt.new_string('title'))])).str())
			register_block_pattern(var_pattern_name.clone(), var_normalized_pattern.clone())
		}
	}
}

fn _load_remote_featured_patterns() {
	mut var_supports_core_patterns := rt.new_null()
	mut var_should_load_remote := rt.new_null()
	mut var_request := rt.new_null()
	mut var_featured_cat_id := i64(0)
	mut var_response := rt.new_null()
	mut var_patterns := rt.new_null()
	mut var_registry := rt.new_null()
	mut var_pattern := rt.new_null()
	mut var_normalized_pattern := rt.new_null()
	mut var_pattern_name := rt.new_null()
	mut var_is_registered := false
	var_supports_core_patterns = rt.call_function('get_theme_support', [
		rt.new_string('core-block-patterns'),
	])
	var_should_load_remote = rt.call_function('apply_filters', [
		rt.new_string('should_load_remote_block_patterns'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_should_load_remote))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_supports_core_patterns)))) {
		return
	}
	var_request = create_wp_rest_request(rt.new_string('GET'),
		rt.new_string('/wp/v2/pattern-directory/patterns'))
	var_featured_cat_id = 26
	rt.call_method(var_request, 'set_param', [rt.new_string('category'),
		rt.new_int(var_featured_cat_id).clone()])
	var_response = rt.call_function('rest_do_request', [var_request.clone()])
	if rt.is_true(rt.call_method(var_response, 'is_error', []rt.PhpVal{})) {
		return
	}
	var_patterns = rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	mut iife_temp_4 := Class_WP_Block_Patterns_Registry{}
	mut iife_result_4 := iife_temp_4.get_instance()
	var_registry = iife_result_4
	mut iter_2 := var_patterns.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_pattern_shadow := item_2.val
		var_pattern_shadow.array_set('source', 'pattern-directory/featured')
		var_normalized_pattern = wp_normalize_remote_block_pattern(var_pattern_shadow.clone())
		var_pattern_name = rt.call_function('sanitize_title', [
			var_normalized_pattern.array_get(rt.new_string('title')),
		])
		var_is_registered =
			rt.is_true(rt.call_method(var_registry, 'is_registered', [var_pattern_name.clone()]))
			|| rt.is_true(rt.call_method(var_registry, 'is_registered', [rt.new_string('core/${var_pattern_name.to_string()}')]))
		if !var_is_registered {
			register_block_pattern(var_pattern_name.clone(), var_normalized_pattern.clone())
		}
	}
}

fn _register_remote_theme_patterns() {
	mut var_pattern_settings := rt.new_null()
	mut var_request := rt.new_null()
	mut var_response := rt.new_null()
	mut var_patterns := rt.new_null()
	mut var_patterns_registry := rt.new_null()
	mut var_pattern := rt.new_null()
	mut var_normalized_pattern := rt.new_null()
	mut var_pattern_name := rt.new_null()
	mut var_is_registered := false
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('should_load_remote_block_patterns'),
		rt.new_bool(true),
	])))))
	{
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_theme_has_theme_json',
		[]rt.PhpVal{})))))
	{
		return
	}
	var_pattern_settings = rt.call_function('wp_get_theme_directory_pattern_slugs', []rt.PhpVal{})
	if !rt.is_true(var_pattern_settings) {
		return
	}
	var_request = create_wp_rest_request(rt.new_string('GET'),
		rt.new_string('/wp/v2/pattern-directory/patterns'))
	var_request.array_set('slug', var_pattern_settings.clone())
	var_response = rt.call_function('rest_do_request', [var_request.clone()])
	if rt.is_true(rt.call_method(var_response, 'is_error', []rt.PhpVal{})) {
		return
	}
	var_patterns = rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	mut iife_temp_5 := Class_WP_Block_Patterns_Registry{}
	mut iife_result_5 := iife_temp_5.get_instance()
	var_patterns_registry = iife_result_5
	mut iter_3 := var_patterns.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_pattern_shadow := item_3.val
		var_pattern_shadow.array_set('source', 'pattern-directory/theme')
		var_normalized_pattern = wp_normalize_remote_block_pattern(var_pattern_shadow.clone())
		var_pattern_name = rt.call_function('sanitize_title', [
			var_normalized_pattern.array_get(rt.new_string('title')),
		])
		var_is_registered =
			rt.is_true(rt.call_method(var_patterns_registry, 'is_registered', [var_pattern_name.clone()]))
			|| rt.is_true(rt.call_method(var_patterns_registry, 'is_registered', [rt.new_string('core/${var_pattern_name.to_string()}')]))
		if !var_is_registered {
			register_block_pattern(var_pattern_name.clone(), var_normalized_pattern.clone())
		}
	}
}

fn _register_theme_block_patterns() {
	mut var_themes := []rt.PhpVal{}
	mut var_theme := rt.new_null()
	mut var_registry := rt.new_null()
	mut var_patterns := rt.new_null()
	mut var_dirpath := rt.new_null()
	mut var_text_domain := rt.new_null()
	mut var_pattern_data := map[string]rt.PhpVal{}
	mut var_file := rt.new_null()
	mut var_file_path := rt.new_null()
	if !rt.is_true(rt.call_function('wp_get_active_and_valid_themes', []rt.PhpVal{})) {
		return
	}
	var_themes = []rt.PhpVal{}
	var_theme = rt.call_function('wp_get_theme', []rt.PhpVal{})
	var_themes << var_theme.clone()
	if rt.is_true(rt.call_method(var_theme, 'parent', []rt.PhpVal{})) {
		var_themes << rt.call_method(var_theme, 'parent', []rt.PhpVal{})
	}
	mut iife_temp_6 := Class_WP_Block_Patterns_Registry{}
	mut iife_result_6 := iife_temp_6.get_instance()
	var_registry = iife_result_6
	for var_theme_shadow in var_themes {
		var_patterns = rt.call_method(var_theme_shadow, 'get_block_patterns', []rt.PhpVal{})
		var_dirpath = rt.new_string(
			(rt.call_method(var_theme_shadow, 'get_stylesheet_directory', []rt.PhpVal{})).str() +
			'/patterns/')
		var_text_domain = rt.call_method(var_theme_shadow, 'get', [
			rt.new_string('TextDomain'),
		])
		mut iter_4 := var_patterns.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_pattern_data_shadow := item_4.val
			mut var_file_shadow := item_4.key
			if rt.is_true(rt.call_method(var_registry, 'is_registered',
				[var_pattern_data_shadow['slug']]))
			{
				continue
			}
			var_file_path = rt.new_string(var_dirpath.str() + var_file_shadow.str())
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
				var_file_path.clone(),
			])))))
			{
				rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Could not register file "%s" as a block pattern as the file does not exist.'),
						]),
						var_file_shadow.clone(),
					]),
					rt.new_string('6.4.0')])
				rt.call_method(var_theme_shadow, 'delete_pattern_cache', []rt.PhpVal{})
				continue
			}
			var_pattern_data_shadow['filePath'] = var_file_path.clone()
			var_pattern_data_shadow['title'] = rt.call_function('translate_with_gettext_context', [
				var_pattern_data_shadow['title'],
				rt.new_string('Pattern title'),
				var_text_domain.clone(),
			])
			if !(!rt.is_true(var_pattern_data_shadow['description'])) {
				var_pattern_data_shadow['description'] = rt.call_function('translate_with_gettext_context', [
					var_pattern_data_shadow['description'],
					rt.new_string('Pattern description'),
					var_text_domain.clone(),
				])
			}
			register_block_pattern(var_pattern_data_shadow['slug'], var_pattern_data_shadow.clone())
		}
	}
}

struct Class_WP_Block_Patterns_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Block_Pattern_Categories_Registry {
	rt.PhpObjectBase
}

struct Class_WP_REST_Request {
	rt.PhpObjectBase
}

fn create_wp_block_patterns_registry(_args ...rt.PhpVal) &Class_WP_Block_Patterns_Registry {
	mut obj := &Class_WP_Block_Patterns_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_pattern_categories_registry(_args ...rt.PhpVal) &Class_WP_Block_Pattern_Categories_Registry {
	mut obj := &Class_WP_Block_Pattern_Categories_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_request(_args ...rt.PhpVal) &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Patterns_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Patterns_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Patterns_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block_Pattern_Categories_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Pattern_Categories_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Pattern_Categories_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_theme_support', [rt.new_string('core-block-patterns')])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('_register_theme_block_patterns')])
}
