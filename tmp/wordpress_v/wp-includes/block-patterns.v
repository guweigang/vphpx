import rt

fn register_block_pattern(var_pattern_name rt.PhpVal, var_pattern_properties rt.PhpVal) rt.PhpVal {
	return rt.call_method(fn () rt.PhpVal { mut temp := Class_WP_Block_Patterns_Registry{}; return temp.get_instance() }(), 'register', [var_pattern_name.dup(), var_pattern_properties.dup()])
}

fn unregister_block_pattern(var_pattern_name rt.PhpVal) rt.PhpVal {
	return rt.call_method(fn () rt.PhpVal { mut temp := Class_WP_Block_Patterns_Registry{}; return temp.get_instance() }(), 'unregister', [var_pattern_name.dup()])
}

fn register_block_pattern_category(category_name string, var_category_properties rt.PhpVal) rt.PhpVal {
	return rt.call_method(fn () rt.PhpVal { mut temp := Class_WP_Block_Pattern_Categories_Registry{}; return temp.get_instance() }(), 'register', [rt.new_string(category_name), var_category_properties.dup()])
}

fn unregister_block_pattern_category(var_category_name rt.PhpVal) rt.PhpVal {
	return rt.call_method(fn () rt.PhpVal { mut temp := Class_WP_Block_Pattern_Categories_Registry{}; return temp.get_instance() }(), 'unregister', [var_category_name.dup()])
}

fn _register_core_block_patterns_and_categories() {
	mut var_should_register_core_patterns := rt.call_function('get_theme_support', [rt.new_string('core-block-patterns')])
	if rt.is_true(var_should_register_core_patterns) {
		mut var_core_block_patterns := ['query-standard-posts', 'query-medium-posts', 'query-small-posts', 'query-grid-posts', 'query-large-title-posts', 'query-offset-posts', 'navigation-overlay', 'navigation-overlay-black-bg', 'navigation-overlay-accent-bg', 'navigation-overlay-centered', 'navigation-overlay-centered-with-extras']
		for var_core_block_pattern in var_core_block_patterns {
			mut var_pattern := rt.include_file(@DIR + '/block-patterns/' + core_block_pattern + '.php', '3')
			var_pattern.array_set('source', 'core')
			register_block_pattern('core/' + core_block_pattern, var_pattern.dup())
		}
	}
	register_block_pattern_category('banner', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Banners'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Bold sections designed to showcase key content.')]) }]))
	register_block_pattern_category('buttons', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Buttons'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Patterns that contain buttons and call to actions.')]) }]))
	register_block_pattern_category('columns', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Columns'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Multi-column patterns with more complex layouts.')]) }]))
	register_block_pattern_category('text', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Text'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Patterns containing mostly text.')]) }]))
	register_block_pattern_category('query', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Posts'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Display your latest posts in lists, grids or other layouts.')]) }]))
	register_block_pattern_category('featured', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Featured'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A set of high quality curated patterns.')]) }]))
	register_block_pattern_category('call-to-action', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Call to action'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Sections whose purpose is to trigger a specific action.')]) }]))
	register_block_pattern_category('team', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Team'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A variety of designs to display your team members.')]) }]))
	register_block_pattern_category('testimonials', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Testimonials'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Share reviews and feedback about your brand/business.')]) }]))
	register_block_pattern_category('services', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Services'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Briefly describe what your business does and how you can help.')]) }]))
	register_block_pattern_category('contact', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Contact'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Display your contact information.')]) }]))
	register_block_pattern_category('about', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('About'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Introduce yourself.')]) }]))
	register_block_pattern_category('portfolio', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Portfolio'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Showcase your latest work.')]) }]))
	register_block_pattern_category('gallery', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Gallery'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Different layouts for displaying images.')]) }]))
	register_block_pattern_category('media', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Media'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Different layouts containing video or audio.')]) }]))
	register_block_pattern_category('videos', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Videos'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Different layouts containing videos.')]) }]))
	register_block_pattern_category('audio', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Audio'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Different layouts containing audio.')]) }]))
	register_block_pattern_category('posts', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Posts'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Display your latest posts in lists, grids or other layouts.')]) }]))
	register_block_pattern_category('footer', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Footers'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A variety of footer designs displaying information and site navigation.')]) }]))
	register_block_pattern_category('header', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Headers'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A variety of header designs displaying your site title and navigation.')]) }]))
	register_block_pattern_category('navigation', rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Navigation'), rt.new_string('Block pattern category')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A variety of designs displaying site navigation.')]) }]))
}

fn wp_normalize_remote_block_pattern(var_pattern rt.PhpVal) rt.PhpVal {
	if var_pattern.array_isset(rt.new_string('block_types')) {
		var_pattern.array_set('blockTypes', var_pattern.array_get('block_types'))
		var_pattern.array_unset(rt.new_string('block_types'))
	}
	if var_pattern.array_isset(rt.new_string('viewport_width')) {
		var_pattern.array_set('viewportWidth', var_pattern.array_get('viewport_width'))
		var_pattern.array_unset(rt.new_string('viewport_width'))
	}
	return rt.cast_array(var_pattern)
}

fn _load_remote_block_patterns(var_deprecated rt.PhpVal) {
	if !(!rt.is_true(var_deprecated)) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('5.9.0')])
		mut var_current_screen := var_deprecated
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_current_screen, 'is_block_editor'))))) {
			return rt.new_null()
		}
	}
	mut var_supports_core_patterns := rt.call_function('get_theme_support', [rt.new_string('core-block-patterns')])
	mut var_should_load_remote := rt.call_function('apply_filters', [rt.new_string('should_load_remote_block_patterns'), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(var_supports_core_patterns) && rt.is_true(var_should_load_remote))) {
		mut var_request := create_wp_rest_request(rt.new_string('GET'), rt.new_string('/wp/v2/pattern-directory/patterns'))
		mut var_core_keyword_id := 11
		rt.call_method(var_request, 'set_param', [rt.new_string('keyword'), rt.new_int(var_core_keyword_id).dup()])
		mut var_response := rt.call_function('rest_do_request', [var_request.dup()])
		if rt.is_true(rt.call_method(var_response, 'is_error', []rt.PhpVal{})) {
			return rt.new_null()
		}
		mut var_patterns := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
		{
			mut iter_1 := var_patterns.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_pattern := item_1.val
				var_pattern.array_set('source', 'pattern-directory/core')
				mut var_normalized_pattern := wp_normalize_remote_block_pattern(var_pattern.dup())
				mut var_pattern_name := rt.new_string('core/' + (rt.call_function('sanitize_title', [var_normalized_pattern.array_get('title')])).str())
				register_block_pattern(var_pattern_name.dup(), var_normalized_pattern.dup())
			}
		}
	}
}

fn _load_remote_featured_patterns() {
	mut var_supports_core_patterns := rt.call_function('get_theme_support', [rt.new_string('core-block-patterns')])
	mut var_should_load_remote := rt.call_function('apply_filters', [rt.new_string('should_load_remote_block_patterns'), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_should_load_remote)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_supports_core_patterns)))))) {
		return rt.new_null()
	}
	mut var_request := create_wp_rest_request(rt.new_string('GET'), rt.new_string('/wp/v2/pattern-directory/patterns'))
	mut var_featured_cat_id := 26
	rt.call_method(var_request, 'set_param', [rt.new_string('category'), rt.new_int(var_featured_cat_id).dup()])
	mut var_response := rt.call_function('rest_do_request', [var_request.dup()])
	if rt.is_true(rt.call_method(var_response, 'is_error', []rt.PhpVal{})) {
		return rt.new_null()
	}
	mut var_patterns := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	mut var_registry := fn () rt.PhpVal { mut temp := Class_WP_Block_Patterns_Registry{}; return temp.get_instance() }()
	{
		mut iter_1 := var_patterns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_pattern := item_1.val
			var_pattern.array_set('source', 'pattern-directory/featured')
			mut var_normalized_pattern := wp_normalize_remote_block_pattern(var_pattern.dup())
			mut var_pattern_name := rt.call_function('sanitize_title', [var_normalized_pattern.array_get('title')])
			mut var_is_registered := rt.is_true(rt.call_method(var_registry, 'is_registered', [var_pattern_name.dup()])) || rt.is_true(rt.call_method(var_registry, 'is_registered', [rt.new_string("core/${var_pattern_name.to_string()}")]))
			if !(var_is_registered) {
				register_block_pattern(var_pattern_name.dup(), var_normalized_pattern.dup())
			}
		}
	}
}

fn _register_remote_theme_patterns() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('should_load_remote_block_patterns'), rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	mut var_pattern_settings := rt.call_function('wp_get_theme_directory_pattern_slugs', []rt.PhpVal{})
	if !rt.is_true(var_pattern_settings) {
		return rt.new_null()
	}
	mut var_request := create_wp_rest_request(rt.new_string('GET'), rt.new_string('/wp/v2/pattern-directory/patterns'))
	var_request.array_set('slug', var_pattern_settings.dup())
	mut var_response := rt.call_function('rest_do_request', [var_request.dup()])
	if rt.is_true(rt.call_method(var_response, 'is_error', []rt.PhpVal{})) {
		return rt.new_null()
	}
	mut var_patterns := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	mut var_patterns_registry := fn () rt.PhpVal { mut temp := Class_WP_Block_Patterns_Registry{}; return temp.get_instance() }()
	{
		mut iter_1 := var_patterns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_pattern := item_1.val
			var_pattern.array_set('source', 'pattern-directory/theme')
			mut var_normalized_pattern := wp_normalize_remote_block_pattern(var_pattern.dup())
			mut var_pattern_name := rt.call_function('sanitize_title', [var_normalized_pattern.array_get('title')])
			mut var_is_registered := rt.is_true(rt.call_method(var_patterns_registry, 'is_registered', [var_pattern_name.dup()])) || rt.is_true(rt.call_method(var_patterns_registry, 'is_registered', [rt.new_string("core/${var_pattern_name.to_string()}")]))
			if !(var_is_registered) {
				register_block_pattern(var_pattern_name.dup(), var_normalized_pattern.dup())
			}
		}
	}
}

fn _register_theme_block_patterns() {
	if !rt.is_true(rt.call_function('wp_get_active_and_valid_themes', []rt.PhpVal{})) {
		return rt.new_null()
	}
	mut var_themes := []rt.PhpVal{}
	mut var_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
	 << .dup()
	if rt.is_true() {
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

fn create_wp_block_patterns_registry() &Class_WP_Block_Patterns_Registry {
	mut obj := &Class_WP_Block_Patterns_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_pattern_categories_registry() &Class_WP_Block_Pattern_Categories_Registry {
	mut obj := &Class_WP_Block_Pattern_Categories_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_request() &Class_WP_REST_Request {
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




pub fn init_wp_includes_block_patterns_php() {
	rt.call_function('add_theme_support', [rt.new_string('core-block-patterns')])
}
