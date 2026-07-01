import rt

fn get_block_theme_folders(var_theme_stylesheet rt.PhpVal) rt.PhpVal {
	mut var_theme := rt.call_function('wp_get_theme', [// unsupported expression: Expr_Cast_String])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{}))))) {
		return rt.create_array([rt.ArrayItem{ key: 'wp_template', val: 'templates' }, rt.ArrayItem{ key: 'wp_template_part', val: 'parts' }])
	}
	return rt.call_method(var_theme, 'get_block_template_folders', []rt.PhpVal{})
}

fn get_allowed_block_template_part_areas() rt.PhpVal {
	mut var_default_area_definitions := [[rt.get_constant('WP_TEMPLATE_PART_AREA_UNCATEGORIZED'), rt.call_function('_x', [rt.new_string('General'), rt.new_string('template part area')]), rt.call_function('__', [rt.new_string('General templates often perform a specific role like displaying post content, and are not tied to any particular area.')]), rt.new_string('layout'), rt.new_string('div')], [rt.get_constant('WP_TEMPLATE_PART_AREA_HEADER'), rt.call_function('_x', [rt.new_string('Header'), rt.new_string('template part area')]), rt.call_function('__', [rt.new_string('The Header template defines a page area that typically contains a title, logo, and main navigation.')]), rt.new_string('header'), rt.new_string('header')], [rt.get_constant('WP_TEMPLATE_PART_AREA_FOOTER'), rt.call_function('_x', [rt.new_string('Footer'), rt.new_string('template part area')]), rt.call_function('__', [rt.new_string('The Footer template defines a page area that typically contains site credits, social links, or any other combination of blocks.')]), rt.new_string('footer'), rt.new_string('footer')], [rt.get_constant('WP_TEMPLATE_PART_AREA_NAVIGATION_OVERLAY'), rt.call_function('_x', [rt.new_string('Navigation Overlay'), rt.new_string('template part area')]), rt.call_function('__', [rt.new_string('The Navigation Overlay template defines an overlay area that typically contains navigation links and can be toggled open and closed.')]), rt.new_string('navigation-overlay'), rt.new_string('div')]]
	return rt.call_function('apply_filters', [rt.new_string('default_wp_template_part_areas'), var_default_area_definitions.dup()])
}

fn get_default_block_template_types() rt.PhpVal {
	mut var_default_template_types := rt.create_array([rt.ArrayItem{ key: 'index', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Index'), rt.new_string('Template name')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Used as a fallback template for all pages when a more specific template is not defined.')]) }]) }, rt.ArrayItem{ key: 'home', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Blog Home'), rt.new_string('Template name')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays the latest posts as either the site homepage or as the "Posts page" as defined under reading settings. If it exists, the Front Page template overrides this template when posts are shown on the homepage.')]) }]) }, rt.ArrayItem{ key: 'front-page', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Front Page'), rt.new_string('Template name')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays your site\'s homepage, whether it is set to display latest posts or a static page. The Front Page template takes precedence over all templates.')]) }]) }, rt.ArrayItem{ key: 'singular', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Single Entries'), rt.new_string('Template name')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays any single entry, such as a post or a page. This template will serve as a fallback when a more specific template (e.g. Single Post, Page, or Attachment) cannot be found.')]) }]) }, rt.ArrayItem{ key: 'single', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Single Posts'), rt.new_string('Template name')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays a single post on your website unless a custom template has been applied to that post or a dedicated template exists.')]) }]) }, rt.ArrayItem{ key: 'page', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Pages'), rt.new_string('Template name')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays a static page unless a custom template has been applied to that page or a dedicated template exists.')]) }]) }, rt.ArrayItem{ key: 'archive', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('All Archives'), rt.new_string('Template name')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays any archive, including posts by a single author, category, tag, taxonomy, custom post type, and date. This template will serve as a fallback when more specific templates (e.g. Category or Tag) cannot be found.')]) }]) }, rt.ArrayItem{ key: 'author', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Author Archives'), rt.new_string('Template name')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays a single author\'s post archive. This template will serve as a fallback when a more specific template (e.g. Author: Admin) cannot be found.')]) }]) }, rt.ArrayItem{ key: 'category', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Category Archives'), rt.new_string('Template name')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays a post category archive. This template will serve as a fallback when a more specific template (e.g. Category: Recipes) cannot be found.')]) }]) }, rt.ArrayItem{ key: 'taxonomy', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Taxonomy'), rt.new_string('Template name')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays a custom taxonomy archive. Like categories and tags, taxonomies have terms which you use to classify things. For example: a taxonomy named "Art" can have multiple terms, such as "Modern" and "18th Century." This template will serve as a fallback when a more specific template (e.g. Taxonomy: Art) cannot be found.')]) }]) }, rt.ArrayItem{ key: 'date', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Date Archives'), rt.new_string('Template name')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays a post archive when a specific date is visited (e.g., example.com/2023/).')]) }]) }, rt.ArrayItem{ key: 'tag', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Tag Archives'), rt.new_string('Template name')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays a post tag archive. This template will serve as a fallback when a more specific template (e.g. Tag: Pizza) cannot be found.')]) }]) }, rt.ArrayItem{ key: 'attachment', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Attachment Pages')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays when a visitor views the dedicated page that exists for any media attachment.')]) }]) }, rt.ArrayItem{ key: 'search', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Search Results'), rt.new_string('Template name')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays when a visitor performs a search on your website.')]) }]) }, rt.ArrayItem{ key: 'privacy-policy', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Privacy Policy')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays your site\'s Privacy Policy page.')]) }]) }, rt.ArrayItem{ key: '404', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Page: 404'), rt.new_string('Template name')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Displays when a visitor views a non-existent page, such as a dead link or a mistyped URL.')]) }]) }])
	mut var_post_formats := rt.call_function('get_post_format_strings', []rt.PhpVal{})
	{
		mut iter_1 := var_post_formats.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post_format_name := item_1.val
			mut var_post_format_slug := item_1.key
			var_default_template_types.array_set('taxonomy-post_format-post-format-' + (var_post_format_slug).str(), rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('Post Format: %s'), rt.new_string('Template name')]), var_post_format_name.dup()]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Displays the %s post format archive.')]), var_post_format_name.dup()]) }]))
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('default_template_types'), var_default_template_types.dup()])
}

fn _filter_block_template_part_area(var_type rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_item.array_get('area')
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_item.array_get('area')
	}
	mut var_allowed_areas := rt.call_function('array_map', [rt.new_closure(closure_1_fn), get_allowed_block_template_part_areas()])
	if rt.is_true(rt.call_function('in_array', [var_type.dup(), var_allowed_areas.dup(), rt.new_bool(true)])) {
		return var_type.dup()
	}
	mut var_warning_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('"%1$s" is not a supported wp_template_part area value and has been added as "%2$s".')]), var_type.dup(), rt.get_constant('WP_TEMPLATE_PART_AREA_UNCATEGORIZED')])
	rt.call_function('wp_trigger_error', [rt.new_string(@FN), var_warning_message.dup()])
	return rt.get_constant('WP_TEMPLATE_PART_AREA_UNCATEGORIZED')
}

fn _get_block_templates_paths(var_base_directory rt.PhpVal) rt.PhpVal {
	mut var_template_path_list := rt.new_null()
	// unsupported statement: Stmt_Static
	if var_template_path_list.array_isset(var_base_directory) {
		return var_template_path_list.array_get(var_base_directory)
	}
	mut var_path_list := []rt.PhpVal{}
	if rt.is_true(rt.call_function('is_dir', [var_base_directory.dup()])) {
		mut var_nested_files := create_recursiveiteratoriterator(create_recursivedirectoryiterator(var_base_directory.dup()))
		mut var_nested_html_files := create_regexiterator(var_nested_files.dup(), rt.new_string('/^.+\\.html$/i'), Class_RecursiveRegexIterator.get_match())
		{
			mut iter_1 := var_nested_html_files.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_file := item_1.val
				mut var_path := item_1.key
				var_path_list << var_path.dup()
			}
		}
	}
	var_template_path_list.array_set(var_base_directory, var_path_list.dup())
	return var_path_list.dup()
}

fn _get_block_template_file(var_template_type rt.PhpVal, var_slug rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_themes := rt.create_array([rt.ArrayItem{ key: rt.call_function('get_stylesheet', []rt.PhpVal{}), val: rt.call_function('get_stylesheet_directory', []rt.PhpVal{}) }, rt.ArrayItem{ key: rt.call_function('get_template', []rt.PhpVal{}), val: rt.call_function('get_template_directory', []rt.PhpVal{}) }])
	{
		mut iter_1 := var_themes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_theme_dir := item_1.val
			mut var_theme_slug := item_1.key
			mut var_template_base_paths := get_block_theme_folders(var_theme_slug.dup())
			mut var_file_path := rt.new_string((var_theme_dir).str() + '/' + (var_template_base_paths.array_get(var_template_type)).str() + '/' + (var_slug).str() + '.html')
			if rt.is_true(rt.call_function('file_exists', [var_file_path.dup()])) {
				mut var_new_template_item := { 'slug': var_slug, 'path': var_file_path, 'theme': var_theme_slug, 'type': var_template_type }
				if rt.is_true(rt.identical(rt.new_string('wp_template_part'), var_template_type)) {
					return _add_block_template_part_area_info(var_new_template_item.dup())
				}
				return _add_block_template_info(var_new_template_item.dup())
			}
		}
	}
	return rt.new_null()
}

fn _get_block_templates_files(var_template_type rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_default_template_types := []rt.PhpVal{}
	if rt.is_true(rt.identical(rt.new_string('wp_template'), var_template_type)) {
		var_default_template_types = get_default_block_template_types()
	}
	mut var_slugs_to_include := if !(var_query.array_get('slug__in')).is_null() { var_query.array_get('slug__in') } else { []rt.PhpVal{} }
	mut var_slugs_to_skip := if !(var_query.array_get('slug__not_in')).is_null() { var_query.array_get('slug__not_in') } else { []rt.PhpVal{} }
	mut var_area := if !(var_query.array_get('area')).is_null() { var_query.array_get('area') } else { rt.new_null() }
	mut var_post_type := if !(var_query.array_get('post_type')).is_null() { var_query.array_get('post_type') } else { rt.new_string('') }
	mut var_stylesheet := rt.call_function('get_stylesheet', []rt.PhpVal{})
	mut var_template := rt.call_function('get_template', []rt.PhpVal{})
	mut var_themes := rt.create_array([rt.ArrayItem{ key: var_stylesheet, val: rt.call_function('get_stylesheet_directory', []rt.PhpVal{}) }])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_themes.array_set(var_template, rt.call_function('get_template_directory', []rt.PhpVal{}))
	}
	mut var_template_files := []rt.PhpVal{}
	{
		mut iter_1 := var_themes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_theme_dir := item_1.val
			mut var_theme_slug := item_1.key
			mut var_template_base_paths := get_block_theme_folders(var_theme_slug.dup())
			mut var_theme_template_files := _get_block_templates_paths((var_theme_dir).str() + '/' + (var_template_base_paths.array_get(var_template_type)).str())
			{
				mut iter_2 := var_theme_template_files.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_template_file := item_2.val
					mut var_template_base_path := var_template_base_paths.array_get(var_template_type)
					mut var_template_slug := rt.call_function('substr', [var_template_file.dup(), rt.add(rt.add(rt.call_function('strpos', [var_template_file.dup(), rt.concat(var_template_base_path, rt.get_constant('DIRECTORY_SEPARATOR'))]), rt.new_int(1)), rt.new_int(var_template_base_path.dup().to_string().len)), // unsupported expression: Expr_UnaryMinus])
					if rt.is_true(rt.new_bool(!(!rt.is_true(var_slugs_to_include)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_template_slug.dup(), var_slugs_to_include.dup(), rt.new_bool(true)]))))))) {
						continue
					}
					if rt.is_true(rt.new_bool(!(!rt.is_true(var_slugs_to_skip)) && rt.is_true(rt.call_function('in_array', [var_template_slug.dup(), var_slugs_to_skip.dup(), rt.new_bool(true)])))) {
						continue
					}
					if var_template_files.array_isset(var_template_slug) {
						continue
					}
					mut var_new_template_item := { 'slug': var_template_slug, 'path': var_template_file, 'theme': var_theme_slug, 'type': var_template_type }
					if rt.is_true(rt.identical(rt.new_string('wp_template_part'), var_template_type)) {
						mut var_candidate := _add_block_template_part_area_info(var_new_template_item.dup())
						if rt.is_true(rt.new_bool(!(!(var_area).is_null()) || rt.is_true(rt.identical(var_area, var_candidate.array_get('area'))))) {
							var_template_files.array_set(var_template_slug, var_candidate.dup())
						}
					}
					if rt.is_true(rt.identical(rt.new_string('wp_template'), var_template_type)) {
						var_candidate = _add_block_template_info(var_new_template_item.dup())
						mut var_is_custom := !(var_default_template_types.array_isset(var_candidate.array_get('slug')))
						if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_post_type) && var_candidate.array_isset(rt.new_string('postTypes')))) && rt.is_true(rt.call_function('in_array', [var_post_type.dup(), var_candidate.array_get('postTypes'), rt.new_bool(true)])))))) {
							var_template_files.array_set(var_template_slug, var_candidate.dup())
						}
						if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_post_type) && !(var_candidate.array_isset(rt.new_string('postTypes'))))) && var_is_custom)) {
							var_template_files.array_set(var_template_slug, var_candidate.dup())
						}
					}
				}
			}
		}
	}
	return rt.call_function('array_values', [var_template_files.dup()])
}

fn _add_block_template_info(var_template_item rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{}))))) {
		return var_template_item.dup()
	}
	mut var_theme_data := rt.call_function('wp_get_theme_data_custom_templates', []rt.PhpVal{})
	if var_theme_data.array_isset(var_template_item.array_get('slug')) {
		var_template_item['title'] = var_theme_data.array_get(var_template_item.array_get('slug')).array_get('title')
		var_template_item['postTypes'] = var_theme_data.array_get(var_template_item.array_get('slug')).array_get('postTypes')
	}
	return var_template_item.dup()
}

fn _add_block_template_part_area_info(var_template_info rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{})) {
		mut var_theme_data := rt.call_function('wp_get_theme_data_template_parts', []rt.PhpVal{})
	}
	if var_theme_data.array_get(var_template_info.array_get('slug')).array_isset(rt.new_string('area')) {
		var_template_info['title'] = var_theme_data.array_get(var_template_info.array_get('slug')).array_get('title')
		var_template_info['area'] = _filter_block_template_part_area(var_theme_data.array_get(var_template_info.array_get('slug')).array_get('area'))
	} else {
		var_template_info['area'] = rt.get_constant('WP_TEMPLATE_PART_AREA_UNCATEGORIZED')
	}
	return var_template_info.dup()
}

fn _flatten_blocks(var_blocks rt.PhpVal) rt.PhpVal {
	mut var_all_blocks := []rt.PhpVal{}
	mut var_queue := []rt.PhpVal{}
	{
		mut iter_1 := var_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			// unsupported expression: Expr_AssignRef
		}
	}
	for var_queue.len > 0 {
		// unsupported expression: Expr_AssignRef
		rt.call_function('array_shift', [var_queue.dup()])
		// unsupported expression: Expr_AssignRef
		if !(!rt.is_true(var_block.array_get('innerBlocks'))) {
			{
				mut iter_1 := .array_get().iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_inner_block := item_1.val
					
				}
			}
		}
	}
	return .dup()
}

struct Class_RecursiveIteratorIterator {
	rt.PhpObjectBase
}

struct Class_RecursiveDirectoryIterator {
	rt.PhpObjectBase
}

struct Class_RegexIterator {
	rt.PhpObjectBase
}

fn create_recursiveiteratoriterator() &Class_RecursiveIteratorIterator {
	mut obj := &Class_RecursiveIteratorIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_recursivedirectoryiterator() &Class_RecursiveDirectoryIterator {
	mut obj := &Class_RecursiveDirectoryIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_regexiterator() &Class_RegexIterator {
	mut obj := &Class_RegexIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_RecursiveIteratorIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RecursiveIteratorIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RecursiveIteratorIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_RecursiveDirectoryIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RecursiveDirectoryIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RecursiveDirectoryIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_RegexIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RegexIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RegexIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_block_template_utils_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_TEMPLATE_PART_AREA_HEADER')]))))) {
		rt.call_function('define', [rt.new_string('WP_TEMPLATE_PART_AREA_HEADER'), rt.new_string('header')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_TEMPLATE_PART_AREA_FOOTER')]))))) {
		rt.call_function('define', [rt.new_string('WP_TEMPLATE_PART_AREA_FOOTER'), rt.new_string('footer')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_TEMPLATE_PART_AREA_SIDEBAR')]))))) {
		rt.call_function('define', [rt.new_string('WP_TEMPLATE_PART_AREA_SIDEBAR'), rt.new_string('sidebar')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_TEMPLATE_PART_AREA_UNCATEGORIZED')]))))) {
		rt.call_function('define', [rt.new_string('WP_TEMPLATE_PART_AREA_UNCATEGORIZED'), rt.new_string('uncategorized')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_TEMPLATE_PART_AREA_NAVIGATION_OVERLAY')]))))) {
		rt.call_function('define', [rt.new_string('WP_TEMPLATE_PART_AREA_NAVIGATION_OVERLAY'), rt.new_string('navigation-overlay')])
	}
}
