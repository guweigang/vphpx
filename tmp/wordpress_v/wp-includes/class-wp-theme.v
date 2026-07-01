import rt
import crypto.md5

struct Class_WP_Theme {
	rt.PhpObjectBase
pub mut:
		update rt.PhpVal = rt.new_bool(false)
		file_headers rt.PhpVal = rt.new_array()
		default_themes rt.PhpVal = rt.new_array()
		tag_map rt.PhpVal = rt.new_array()
		theme_root rt.PhpVal = rt.new_null()
		headers rt.PhpVal = rt.new_array()
		headers_sanitized rt.PhpVal = rt.new_null()
		block_theme rt.PhpVal = rt.new_null()
		name_translated rt.PhpVal = rt.new_null()
		errors rt.PhpVal = rt.new_null()
		stylesheet rt.PhpVal = rt.new_null()
		template rt.PhpVal = rt.new_null()
		parent rt.PhpVal = rt.new_null()
		theme_root_uri rt.PhpVal = rt.new_null()
		textdomain_loaded rt.PhpVal = rt.new_null()
		cache_hash string
		block_template_folders rt.PhpVal = rt.new_null()
		default_template_folders rt.PhpVal = rt.new_array()
		persistently_cache rt.PhpVal = rt.new_null()
		cache_expiration rt.PhpVal = rt.new_int(1800)
}

fn (mut this Class_WP_Theme) construct(var_theme_dir rt.PhpVal, var_theme_root rt.PhpVal, var__child rt.PhpVal)  {
	mut var_wp_theme_directories := rt.new_null()
	mut var_theme_dir_mutated := var_theme_dir
	mut var_theme_root_mutated := var_theme_root
	mut var__child_mutated := var__child
	// unsupported statement: Stmt_Global
	if !(!(// unsupported expression: Expr_StaticPropertyFetch).is_null()) {
		// unsupported assign target: Expr_StaticPropertyFetch
		if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
			rt.call_function('wp_cache_add_global_groups', [rt.new_string('themes')])
			if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_long())) {
				// unsupported assign target: Expr_StaticPropertyFetch
			}
		} else {
			rt.call_function('wp_cache_add_non_persistent_groups', [rt.new_string('themes')])
		}
	}
	var_theme_dir_mutated = // unsupported expression: Expr_Cast_String
	this.theme_root = var_theme_root_mutated.dup()
	this.stylesheet = var_theme_dir_mutated.dup()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_theme_root_mutated.dup(), rt.cast_array(var_wp_theme_directories), rt.new_bool(true)]))))) && rt.is_true(rt.call_function('in_array', [rt.call_function('dirname', [var_theme_root_mutated.dup()]), rt.cast_array(var_wp_theme_directories), rt.new_bool(true)])))) {
		this.stylesheet = (rt.call_function('basename', [this.theme_root])).str() + '/' + (this.stylesheet).str()
		this.theme_root = rt.call_function('dirname', [var_theme_root_mutated.dup()])
	}
	this.cache_hash = md5.hexhash((this.theme_root).str() + '/' + (this.stylesheet).str())
	mut var_theme_file := rt.new_string((this.stylesheet).str() + '/style.css')
	mut var_cache := this.cache_get(rt.new_string('theme'))
	if rt.is_true(rt.new_bool(var_cache.dup().is_array())) {
		{
			mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'block_template_folders' }, rt.ArrayItem{ key: none, val: 'block_theme' }, rt.ArrayItem{ key: none, val: 'errors' }, rt.ArrayItem{ key: none, val: 'headers' }, rt.ArrayItem{ key: none, val: 'template' }]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_key := item_1.val
				if var_cache.array_isset(var_key) {
					this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":290,"name":"key"}', var_cache.array_get(var_key))
				}
			}
		}
		if rt.is_true(this.errors) {
			return
		}
		if var_cache.array_isset(rt.new_string('theme_root_template')) {
			mut var_theme_root_template := var_cache.array_get('theme_root_template')
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [(this.theme_root).str() + '/' + (var_theme_file).str()]))))) {
		this.headers.array_set('Name', this.stylesheet)
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [(this.theme_root).str() + '/' + (this.stylesheet).str()]))))) {
			this.errors = create_wp_error(rt.new_string('theme_not_found'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The theme directory "%s" does not exist.')]), rt.call_function('esc_html', [this.stylesheet])]))
		} else {
			this.errors = create_wp_error(rt.new_string('theme_no_stylesheet'), rt.call_function('__', [rt.new_string('Stylesheet is missing.')]))
		}
		this.template = this.stylesheet
		this.block_theme = rt.new_bool(false)
		this.block_template_folders = this.default_template_folders
		this.cache_add(rt.new_string('theme'), rt.create_array([rt.ArrayItem{ key: 'block_template_folders', val: this.block_template_folders }, rt.ArrayItem{ key: 'block_theme', val: this.block_theme }, rt.ArrayItem{ key: 'headers', val: this.headers }, rt.ArrayItem{ key: 'errors', val: this.errors }, rt.ArrayItem{ key: 'stylesheet', val: this.stylesheet }, rt.ArrayItem{ key: 'template', val: this.template }]))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [this.theme_root]))))) {
			rt.call_method(this.errors, 'add', [rt.new_string('theme_root_missing'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> The themes directory is either empty or does not exist. Please check your installation.')])])
		}
		return
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [(this.theme_root).str() + '/' + (var_theme_file).str()]))))) {
		this.headers.array_set('Name', this.stylesheet)
		this.errors = create_wp_error(rt.new_string('theme_stylesheet_not_readable'), rt.call_function('__', [rt.new_string('Stylesheet is not readable.')]))
		this.template = this.stylesheet
		this.block_theme = rt.new_bool(false)
		this.block_template_folders = this.default_template_folders
		this.cache_add(rt.new_string('theme'), rt.create_array([rt.ArrayItem{ key: 'block_template_folders', val: this.block_template_folders }, rt.ArrayItem{ key: 'block_theme', val: this.block_theme }, rt.ArrayItem{ key: 'headers', val: this.headers }, rt.ArrayItem{ key: 'errors', val: this.errors }, rt.ArrayItem{ key: 'stylesheet', val: this.stylesheet }, rt.ArrayItem{ key: 'template', val: this.template }]))
		return
	} else {
		this.headers = rt.call_function('get_file_data', [(this.theme_root).str() + '/' + (var_theme_file).str(), // unsupported expression: Expr_StaticPropertyFetch, rt.new_string('theme')])
		mut var_default_theme_slug := rt.call_function('array_search', [this.headers.array_get('Name'), // unsupported expression: Expr_StaticPropertyFetch, rt.new_bool(true)])
		if rt.is_true(var_default_theme_slug) {
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.template)))) && rt.is_true(rt.identical(this.stylesheet, this.headers.array_get('Template'))))) {
		this.errors = create_wp_error(rt.new_string('theme_child_invalid'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The theme defines itself as its parent theme. Please check the %s header.')]), rt.new_string('<code>Template</code>')]))
		this.cache_add(rt.new_string('theme'), rt.create_array([rt.ArrayItem{ key: 'block_template_folders', val: this.get_block_template_folders() }, rt.ArrayItem{ key: 'block_theme', val: this.is_block_theme() }, rt.ArrayItem{ key: 'headers', val: this.headers }, rt.ArrayItem{ key: 'errors', val: this.errors }, rt.ArrayItem{ key: 'stylesheet', val: this.stylesheet }]))
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.template)))) {
		this.template = this.headers.array_get('Template')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.template)))) {
		this.template = this.stylesheet
		mut var_theme_path := rt.new_string((this.theme_root).str() + '/' + (this.stylesheet).str())
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.is_block_theme())))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [(var_theme_path).str() + '/index.php']))))))) {
			mut var_error_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Template is missing. Standalone themes need to have a %1$s or %2$s template file. <a href="%3$s">Child themes</a> need to have a %4$s header in the %5$s stylesheet.')]), rt.new_string('<code>templates/index.html</code>'), rt.new_string('<code>index.php</code>'), rt.call_function('__', [rt.new_string('https://developer.wordpress.org/themes/advanced-topics/child-themes/')]), rt.new_string('<code>Template</code>'), rt.new_string('<code>style.css</code>')])
			this.errors = create_wp_error(rt.new_string('theme_no_index'), var_error_message.dup())
			this.cache_add(rt.new_string('theme'), rt.create_array([rt.ArrayItem{ key: 'block_template_folders', val: this.get_block_template_folders() }, rt.ArrayItem{ key: 'block_theme', val: this.block_theme }, rt.ArrayItem{ key: 'headers', val: this.headers }, rt.ArrayItem{ key: 'errors', val: this.errors }, rt.ArrayItem{ key: 'stylesheet', val: this.stylesheet }, rt.ArrayItem{ key: 'template', val: this.template }]))
			return
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cache.dup().is_array()))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [(this.theme_root).str() + '/' + (this.template).str() + '/index.php']))))))) {
		mut var_parent_dir := rt.call_function('dirname', [this.stylesheet])
		mut var_directories := rt.call_function('search_theme_directories', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('file_exists', [(this.theme_root).str() + '/' + (var_parent_dir).str() + '/' + (this.template).str() + '/index.php'])))) {
			this.template = (var_parent_dir).str() + '/' + (this.template).str()
		} else if rt.is_true(rt.new_bool(rt.is_true(var_directories) && var_directories.array_isset(this.template))) {
			var_theme_root_template = var_directories.array_get(this.template).array_get('theme_root')
		} else {
			this.errors = create_wp_error(rt.new_string('theme_no_parent'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The parent theme is missing. Please install the "%s" parent theme.')]), rt.call_function('esc_html', [this.template])]))
			this.cache_add(rt.new_string('theme'), rt.create_array([rt.ArrayItem{ key: 'block_template_folders', val: this.get_block_template_folders() }, rt.ArrayItem{ key: 'block_theme', val: this.is_block_theme() }, rt.ArrayItem{ key: 'headers', val: this.headers }, rt.ArrayItem{ key: 'errors', val: this.errors }, rt.ArrayItem{ key: 'stylesheet', val: this.stylesheet }, rt.ArrayItem{ key: 'template', val: this.template }]))
			this.parent = create_wp_theme(this.template, this.theme_root, rt.new_object('WP_Theme', ['ArrayAccess'], &this).dup())
			return
		}
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var__child_mutated, 'WP_Theme'))) && rt.is_true(rt.identical(rt.get_property(var__child_mutated, 'template'), this.stylesheet)))) {
			rt.set_property(var__child_mutated, 'parent', rt.new_null())
			rt.set_property(var__child_mutated, 'errors', create_wp_error(rt.new_string('theme_parent_invalid'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The "%s" theme is not a valid parent theme.')]), rt.call_function('esc_html', [rt.get_property(var__child_mutated, 'template')])])))
			rt.call_method(var__child_mutated, 'cache_add', [rt.new_string('theme'), rt.create_array([rt.ArrayItem{ key: 'block_template_folders', val: rt.call_method(var__child_mutated, 'get_block_template_folders', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'block_theme', val: rt.call_method(var__child_mutated, 'is_block_theme', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'headers', val: rt.get_property(var__child_mutated, 'headers') }, rt.ArrayItem{ key: 'errors', val: rt.get_property(var__child_mutated, 'errors') }, rt.ArrayItem{ key: 'stylesheet', val: rt.get_property(var__child_mutated, 'stylesheet') }, rt.ArrayItem{ key: 'template', val: rt.get_property(var__child_mutated, 'template') }])])
			if rt.is_true(rt.identical(rt.get_property(var__child_mutated, 'stylesheet'), this.template)) {
				this.errors = create_wp_error(rt.new_string('theme_parent_invalid'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The "%s" theme is not a valid parent theme.')]), rt.call_function('esc_html', [this.template])]))
				this.cache_add(rt.new_string('theme'), rt.create_array([rt.ArrayItem{ key: 'block_template_folders', val: this.get_block_template_folders() }, rt.ArrayItem{ key: 'block_theme', val: this.is_block_theme() }, rt.ArrayItem{ key: 'headers', val: this.headers }, rt.ArrayItem{ key: 'errors', val: this.errors }, rt.ArrayItem{ key: 'stylesheet', val: this.stylesheet }, rt.ArrayItem{ key: 'template', val: this.template }]))
			}
			return
		}
		this.parent = create_wp_theme(this.template, if !(var_theme_root_template).is_null() { var_theme_root_template } else { this.theme_root }, rt.new_object('WP_Theme', ['ArrayAccess'], &this).dup())
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.call_function('wp_paused_themes', []rt.PhpVal{}), 'get', [this.stylesheet])) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [this.errors]))))) || !(rt.get_property(this.errors, 'errors').array_isset(rt.new_string('theme_paused'))))))) {
		this.errors = create_wp_error(rt.new_string('theme_paused'), rt.call_function('__', [rt.new_string('This theme failed to load properly and was paused within the admin backend.')]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cache.dup().is_array()))))) {
		var_cache = rt.create_array([rt.ArrayItem{ key: 'block_theme', val: this.is_block_theme() }, rt.ArrayItem{ key: 'block_template_folders', val: this.get_block_template_folders() }, rt.ArrayItem{ key: 'headers', val: this.headers }, rt.ArrayItem{ key: 'errors', val: this.errors }, rt.ArrayItem{ key: 'stylesheet', val: this.stylesheet }, rt.ArrayItem{ key: 'template', val: this.template }])
		if !(var_theme_root_template).is_null() {
			var_cache.array_set('theme_root_template', var_theme_root_template.dup())
		}
		this.cache_add(rt.new_string('theme'), var_cache.dup())
	}
}

fn (mut this Class_WP_Theme) magic_tostring() rt.PhpVal {
	return // unsupported expression: Expr_Cast_String
}

fn (mut this Class_WP_Theme) magic_isset(var_offset rt.PhpVal) rt.PhpVal {
	mut var_properties := rt.new_null()
	// unsupported statement: Stmt_Static
	return rt.call_function('in_array', [var_offset.dup(), var_properties.dup(), rt.new_bool(true)])
}

fn (mut this Class_WP_Theme) magic_get(var_offset rt.PhpVal)  {
	mut switch_val_1 := var_offset
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('name'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('title'))) {
		return rt.new_bool(this.get(rt.new_string('Name')))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('version'))) {
		return rt.new_bool(this.get(rt.new_string('Version')))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('parent_theme'))) {
		return if rt.is_true(this.parent()) { rt.call_method(this.parent(), 'get', [rt.new_string('Name')]) } else { rt.new_string('') }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('template_dir'))) {
		return rt.new_string(this.get_template_directory())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('stylesheet_dir'))) {
		return rt.new_string(this.get_stylesheet_directory())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('template'))) {
		return this.get_template()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('stylesheet'))) {
		return this.get_stylesheet()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('screenshot'))) {
		return this.get_screenshot('relative')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('description'))) {
		return rt.new_bool(this.display(rt.new_string('Description'), false, false))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('author'))) {
		return rt.new_bool(this.display(rt.new_string('Author'), false, false))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tags'))) {
		return rt.new_bool(this.get(rt.new_string('Tags')))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('theme_root'))) {
		return this.get_theme_root()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('theme_root_uri'))) {
		return this.get_theme_root_uri()
	} else {
		this.offsetget(var_offset.dup())
		return rt.new_null()
	}
}

fn (mut this Class_WP_Theme) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_Theme) offsetunset(var_offset rt.PhpVal)  {
}

fn (mut this Class_WP_Theme) offsetexists(var_offset rt.PhpVal) rt.PhpVal {
	mut var_keys := rt.new_null()
	// unsupported statement: Stmt_Static
	return rt.call_function('in_array', [var_offset.dup(), var_keys.dup(), rt.new_bool(true)])
}

fn (mut this Class_WP_Theme) offsetget(var_offset rt.PhpVal)  {
	mut switch_val_2 := var_offset
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('Name'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('Title'))) {
		return rt.new_bool(this.get(rt.new_string('Name')))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Author'))) {
		return rt.new_bool(this.display(rt.new_string('Author'), false, false))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Author Name'))) {
		return rt.new_bool(this.display(rt.new_string('Author'), false, false))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Author URI'))) {
		return rt.new_bool(this.display(rt.new_string('AuthorURI'), false, false))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Description'))) {
		return rt.new_bool(this.display(rt.new_string('Description'), false, false))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Version'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('Status'))) {
		return rt.new_bool(this.get(var_offset.dup()))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Template'))) {
		return this.get_template()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Stylesheet'))) {
		return this.get_stylesheet()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Template Files'))) {
		return this.get_files(rt.new_string('php'), 1, true)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Stylesheet Files'))) {
		return this.get_files(rt.new_string('css'), 0, false)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Template Dir'))) {
		return rt.new_string(this.get_template_directory())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Stylesheet Dir'))) {
		return rt.new_string(this.get_stylesheet_directory())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Screenshot'))) {
		return 
	} else if rt.is_true(rt.equal(switch_val_2, )) {
	} else if rt.is_true(rt.equal(switch_val_2, )) {
	} else if rt.is_true(rt.equal(switch_val_2, )) {
	} else if rt.is_true(rt.equal(switch_val_2, )) {
	} else {
	}
}

fn (mut this Class_WP_Theme) errors() rt.PhpVal {
}

fn (mut this Class_WP_Theme) exists() bool {
}

fn (mut this Class_WP_Theme) parent() rt.PhpVal {
}

fn (mut this Class_WP_Theme) magic_wakeup()  {
}

fn (mut this Class_WP_Theme) cache_add(var_key rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
}

fn (mut this Class_WP_Theme) cache_get(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
}

fn (mut this Class_WP_Theme) cache_delete()  {
}

fn (mut this Class_WP_Theme) get(var_header rt.PhpVal) bool {
}

fn (mut this Class_WP_Theme) display(var_header rt.PhpVal, markup bool, translate bool) bool {
	mut translate_mutated := translate
}

fn (mut this Class_WP_Theme) sanitize_header(var_header rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_header_tags := rt.new_null()
	mut var_header_tags_with_a := rt.new_null()
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_Theme) markup_header(var_header rt.PhpVal, var_value rt.PhpVal, var_translate rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_translate_mutated := var_translate
}

fn (mut this Class_WP_Theme) translate_header(var_header rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_Theme) get_stylesheet() rt.PhpVal {
}

fn (mut this Class_WP_Theme) get_template() rt.PhpVal {
}

fn (mut this Class_WP_Theme) get_stylesheet_directory() string {
}

fn (mut this Class_WP_Theme) get_template_directory() string {
}

fn (mut this Class_WP_Theme) get_stylesheet_directory_uri() string {
}

fn (mut this Class_WP_Theme) get_template_directory_uri() string {
}

fn (mut this Class_WP_Theme) get_theme_root() rt.PhpVal {
}

fn (mut this Class_WP_Theme) get_theme_root_uri() rt.PhpVal {
}

fn (mut this Class_WP_Theme) get_screenshot(uri string) rt.PhpVal {
}

fn (mut this Class_WP_Theme) get_files(var_type rt.PhpVal, depth i64, search_parent bool) rt.PhpVal {
	mut var_type_mutated := var_type
}

fn (mut this Class_WP_Theme) get_post_templates() rt.PhpVal {
	mut var_header := rt.new_null()
}

fn (mut this Class_WP_Theme) get_page_templates(var_post rt.PhpVal, post_type string) rt.PhpVal {
	mut post_type_mutated := post_type
}

fn Class_WP_Theme.scandir(var_path rt.PhpVal, var_extensions rt.PhpVal, depth i64, relative_path string) rt.PhpVal {
	mut var_path_mutated := var_path
	mut var_extensions_mutated := var_extensions
	mut relative_path_mutated := relative_path
}

fn (mut this Class_WP_Theme) load_textdomain() bool {
}

fn (mut this Class_WP_Theme) is_allowed(check string, var_blog_id rt.PhpVal) bool {
	mut var_blog_id_mutated := var_blog_id
}

fn (mut this Class_WP_Theme) is_block_theme() rt.PhpVal {
}

fn (mut this Class_WP_Theme) get_file_path(file string) rt.PhpVal {
	mut file_mutated := file
}

fn Class_WP_Theme.get_core_default_theme() bool {
}

fn Class_WP_Theme.get_allowed(var_blog_id rt.PhpVal) rt.PhpVal {
	mut var_blog_id_mutated := var_blog_id
}

fn Class_WP_Theme.get_allowed_on_network() rt.PhpVal {
}

fn Class_WP_Theme.get_allowed_on_site(var_blog_id rt.PhpVal) rt.PhpVal {
	mut var_allowed_themes := rt.new_null()
	mut var_blog_id_mutated := var_blog_id
}

fn (mut this Class_WP_Theme) get_block_template_folders() rt.PhpVal {
}

fn (mut this Class_WP_Theme) get_block_patterns() rt.PhpVal {
}

fn (mut this Class_WP_Theme) get_pattern_cache() bool {
}

fn (mut this Class_WP_Theme) set_pattern_cache(mut var_patterns Class_array)  {
}

fn (mut this Class_WP_Theme) delete_pattern_cache()  {
}

fn Class_WP_Theme.network_enable_theme(var_stylesheets rt.PhpVal)  {
	mut var_stylesheets_mutated := var_stylesheets
}

fn Class_WP_Theme.network_disable_theme(var_stylesheets rt.PhpVal)  {
	mut var_stylesheets_mutated := var_stylesheets
}

fn Class_WP_Theme.sort_by_name(var_themes rt.PhpVal)  {
	mut var_themes_mutated := var_themes
}

fn Class_WP_Theme._name_sort(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
}

fn Class_WP_Theme._name_sort_i18n(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_theme(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Theme {
	mut obj := &Class_WP_Theme{
		PhpObjectBase: rt.PhpObjectBase{}
		update: rt.new_bool(false)
		file_headers: rt.new_array()
		default_themes: rt.new_array()
		tag_map: rt.new_array()
		theme_root: rt.new_null()
		headers: rt.new_array()
		headers_sanitized: rt.new_null()
		block_theme: rt.new_null()
		name_translated: rt.new_null()
		errors: rt.new_null()
		stylesheet: rt.new_null()
		template: rt.new_null()
		parent: rt.new_null()
		theme_root_uri: rt.new_null()
		textdomain_loaded: rt.new_null()
		cache_hash: ''
		block_template_folders: rt.new_null()
		default_template_folders: rt.new_array()
		persistently_cache: rt.new_null()
		cache_expiration: rt.new_int(1800)
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Theme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_isset(dispatch_arg_0)
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.magic_get(dispatch_arg_0)
			return rt.new_null()
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetUnset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetunset(dispatch_arg_0)
			return rt.new_null()
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetexists(dispatch_arg_0)
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetget(dispatch_arg_0)
			return rt.new_null()
		}
		'errors' {
			return this.errors()
		}
		'exists' {
			return rt.new_bool(this.exists())
		}
		'parent' {
			return this.parent()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'cache_add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.cache_add(dispatch_arg_0, dispatch_arg_1)
		}
		'cache_get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.cache_get(dispatch_arg_0)
		}
		'cache_delete' {
			this.cache_delete()
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get(dispatch_arg_0))
		}
		'display' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.display(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'sanitize_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.sanitize_header(dispatch_arg_0, dispatch_arg_1)
		}
		'markup_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.markup_header(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'translate_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.translate_header(dispatch_arg_0, dispatch_arg_1)
		}
		'get_stylesheet' {
			return this.get_stylesheet()
		}
		'get_template' {
			return this.get_template()
		}
		'get_stylesheet_directory' {
			return rt.new_string(this.get_stylesheet_directory())
		}
		'get_template_directory' {
			return rt.new_string(this.get_template_directory())
		}
		'get_stylesheet_directory_uri' {
			return rt.new_string(this.get_stylesheet_directory_uri())
		}
		'get_template_directory_uri' {
			return rt.new_string(this.get_template_directory_uri())
		}
		'get_theme_root' {
			return this.get_theme_root()
		}
		'get_theme_root_uri' {
			return this.get_theme_root_uri()
		}
		'get_screenshot' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_screenshot(dispatch_arg_0)
		}
		'get_files' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_files(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_post_templates' {
			return this.get_post_templates()
		}
		'get_page_templates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_page_templates(dispatch_arg_0, dispatch_arg_1)
		}
		'scandir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_WP_Theme.scandir(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'load_textdomain' {
			return rt.new_bool(this.load_textdomain())
		}
		'is_allowed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.is_allowed(dispatch_arg_0, dispatch_arg_1))
		}
		'is_block_theme' {
			return this.is_block_theme()
		}
		'get_file_path' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_file_path(dispatch_arg_0)
		}
		'get_core_default_theme' {
			return rt.new_bool(Class_WP_Theme.get_core_default_theme())
		}
		'get_allowed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme.get_allowed(dispatch_arg_0)
		}
		'get_allowed_on_network' {
			return Class_WP_Theme.get_allowed_on_network()
		}
		'get_allowed_on_site' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme.get_allowed_on_site(dispatch_arg_0)
		}
		'get_block_template_folders' {
			return this.get_block_template_folders()
		}
		'get_block_patterns' {
			return this.get_block_patterns()
		}
		'get_pattern_cache' {
			return rt.new_bool(this.get_pattern_cache())
		}
		'set_pattern_cache' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_pattern_cache(mut dispatch_arg_0)
			return rt.new_null()
		}
		'delete_pattern_cache' {
			this.delete_pattern_cache()
			return rt.new_null()
		}
		'network_enable_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WP_Theme.network_enable_theme(dispatch_arg_0)
			return rt.new_null()
		}
		'network_disable_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WP_Theme.network_disable_theme(dispatch_arg_0)
			return rt.new_null()
		}
		'sort_by_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WP_Theme.sort_by_name(dispatch_arg_0)
			return rt.new_null()
		}
		'_name_sort' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme._name_sort(dispatch_arg_0, dispatch_arg_1)
		}
		'_name_sort_i18n' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme._name_sort_i18n(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WP_Theme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'update' { return this.update }
		'file_headers' { return this.file_headers }
		'default_themes' { return this.default_themes }
		'tag_map' { return this.tag_map }
		'theme_root' { return this.theme_root }
		'headers' { return this.headers }
		'headers_sanitized' { return this.headers_sanitized }
		'block_theme' { return this.block_theme }
		'name_translated' { return this.name_translated }
		'errors' { return this.errors }
		'stylesheet' { return this.stylesheet }
		'template' { return this.template }
		'parent' { return this.parent }
		'theme_root_uri' { return this.theme_root_uri }
		'textdomain_loaded' { return this.textdomain_loaded }
		'cache_hash' { return rt.new_string(this.cache_hash) }
		'block_template_folders' { return this.block_template_folders }
		'default_template_folders' { return this.default_template_folders }
		'persistently_cache' { return this.persistently_cache }
		'cache_expiration' { return this.cache_expiration }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Theme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'update' { this.update = val; return true }
		'file_headers' { this.file_headers = val; return true }
		'default_themes' { this.default_themes = val; return true }
		'tag_map' { this.tag_map = val; return true }
		'theme_root' { this.theme_root = val; return true }
		'headers' { this.headers = val; return true }
		'headers_sanitized' { this.headers_sanitized = val; return true }
		'block_theme' { this.block_theme = val; return true }
		'name_translated' { this.name_translated = val; return true }
		'errors' { this.errors = val; return true }
		'stylesheet' { this.stylesheet = val; return true }
		'template' { this.template = val; return true }
		'parent' { this.parent = val; return true }
		'theme_root_uri' { this.theme_root_uri = val; return true }
		'textdomain_loaded' { this.textdomain_loaded = val; return true }
		'cache_hash' { this.cache_hash = (val).str(); return true }
		'block_template_folders' { this.block_template_folders = val; return true }
		'default_template_folders' { this.default_template_folders = val; return true }
		'persistently_cache' { this.persistently_cache = val; return true }
		'cache_expiration' { this.cache_expiration = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_theme_php() {
}
