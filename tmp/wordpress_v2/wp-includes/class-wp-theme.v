import rt
import crypto.md5

struct Class_WP_Theme {
	rt.PhpObjectBase
pub mut:
	update                   rt.PhpVal = rt.new_bool(false)
	theme_root               rt.PhpVal = rt.new_null()
	headers                  rt.PhpVal = rt.new_array()
	headers_sanitized        rt.PhpVal = rt.new_null()
	block_theme              rt.PhpVal = rt.new_null()
	name_translated          rt.PhpVal = rt.new_null()
	errors                   rt.PhpVal = rt.new_null()
	stylesheet               rt.PhpVal = rt.new_null()
	template                 rt.PhpVal = rt.new_null()
	parent                   rt.PhpVal = rt.new_null()
	theme_root_uri           rt.PhpVal = rt.new_null()
	textdomain_loaded        rt.PhpVal = rt.new_null()
	cache_hash               string
	block_template_folders   rt.PhpVal = rt.new_null()
	default_template_folders rt.PhpVal = rt.new_array()
}

fn init_static_wp_theme() {
	rt.init_static_prop('WP_Theme', 'file_headers', rt.create_array([
		rt.ArrayItem{ key: 'Name', val: 'Theme Name' },
		rt.ArrayItem{ key: 'ThemeURI', val: 'Theme URI' },
		rt.ArrayItem{ key: 'Description', val: 'Description' },
		rt.ArrayItem{ key: 'Author', val: 'Author' },
		rt.ArrayItem{ key: 'AuthorURI', val: 'Author URI' },
		rt.ArrayItem{ key: 'Version', val: 'Version' },
		rt.ArrayItem{ key: 'Template', val: 'Template' },
		rt.ArrayItem{ key: 'Status', val: 'Status' },
		rt.ArrayItem{ key: 'Tags', val: 'Tags' },
		rt.ArrayItem{ key: 'TextDomain', val: 'Text Domain' },
		rt.ArrayItem{ key: 'DomainPath', val: 'Domain Path' },
		rt.ArrayItem{ key: 'RequiresWP', val: 'Requires at least' },
		rt.ArrayItem{ key: 'RequiresPHP', val: 'Requires PHP' },
		rt.ArrayItem{ key: 'UpdateURI', val: 'Update URI' },
	]))
	rt.init_static_prop('WP_Theme', 'default_themes', rt.create_array([
		rt.ArrayItem{ key: 'classic', val: 'WordPress Classic' },
		rt.ArrayItem{ key: 'default', val: 'WordPress Default' },
		rt.ArrayItem{ key: 'twentyten', val: 'Twenty Ten' },
		rt.ArrayItem{ key: 'twentyeleven', val: 'Twenty Eleven' },
		rt.ArrayItem{ key: 'twentytwelve', val: 'Twenty Twelve' },
		rt.ArrayItem{ key: 'twentythirteen', val: 'Twenty Thirteen' },
		rt.ArrayItem{ key: 'twentyfourteen', val: 'Twenty Fourteen' },
		rt.ArrayItem{ key: 'twentyfifteen', val: 'Twenty Fifteen' },
		rt.ArrayItem{ key: 'twentysixteen', val: 'Twenty Sixteen' },
		rt.ArrayItem{ key: 'twentyseventeen', val: 'Twenty Seventeen' },
		rt.ArrayItem{ key: 'twentynineteen', val: 'Twenty Nineteen' },
		rt.ArrayItem{ key: 'twentytwenty', val: 'Twenty Twenty' },
		rt.ArrayItem{ key: 'twentytwentyone', val: 'Twenty Twenty-One' },
		rt.ArrayItem{ key: 'twentytwentytwo', val: 'Twenty Twenty-Two' },
		rt.ArrayItem{ key: 'twentytwentythree', val: 'Twenty Twenty-Three' },
		rt.ArrayItem{ key: 'twentytwentyfour', val: 'Twenty Twenty-Four' },
		rt.ArrayItem{ key: 'twentytwentyfive', val: 'Twenty Twenty-Five' },
	]))
	rt.init_static_prop('WP_Theme', 'tag_map', rt.create_array([
		rt.ArrayItem{ key: 'fixed-width', val: 'fixed-layout' },
		rt.ArrayItem{ key: 'flexible-width', val: 'fluid-layout' },
	]))
	rt.init_static_prop('WP_Theme', 'persistently_cache', rt.new_null())
	rt.init_static_prop('WP_Theme', 'cache_expiration', rt.new_int(1800))
}

fn (mut this Class_WP_Theme) construct(var_theme_dir rt.PhpVal, var_theme_root rt.PhpVal, var__child rt.PhpVal) {
	mut var_wp_theme_directories := rt.new_null()
	mut var_theme_dir_mutated := var_theme_dir
	mut var_theme_root_mutated := var_theme_root
	mut var__child_mutated := var__child
	if !(!(rt.get_static_prop('WP_Theme', 'persistently_cache')).is_null()) {
		rt.set_static_prop('WP_Theme', 'persistently_cache', rt.call_function('apply_filters', [
			rt.new_string('wp_cache_themes_persistently'),
			rt.new_bool(false),
			rt.new_string('WP_Theme'),
		]))
		if rt.is_true(rt.get_static_prop('WP_Theme', 'persistently_cache')) {
			rt.call_function('wp_cache_add_global_groups', [rt.new_string('themes')])
			if rt.is_true(rt.new_bool(rt.get_static_prop('WP_Theme', 'persistently_cache').is_long())) {
				rt.set_static_prop('WP_Theme', 'cache_expiration', rt.get_static_prop('WP_Theme',
					'persistently_cache'))
			}
		} else {
			rt.call_function('wp_cache_add_non_persistent_groups', [
				rt.new_string('themes'),
			])
		}
	}
	var_theme_dir_mutated = rt.new_string(var_theme_dir_mutated.str())
	this.theme_root = var_theme_root_mutated.clone()
	this.stylesheet = var_theme_dir_mutated.clone()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_theme_root_mutated.clone(), rt.cast_array(var_wp_theme_directories), rt.new_bool(true)])))))
		&& rt.is_true(rt.call_function('in_array', [rt.call_function('dirname', [var_theme_root_mutated.clone()]), rt.cast_array(var_wp_theme_directories), rt.new_bool(true)])) {
		this.stylesheet = (rt.call_function('basename', [this.theme_root])).str() + '/' +
			(this.stylesheet).str()
		this.theme_root = rt.call_function('dirname', [var_theme_root_mutated.clone()])
	}
	this.cache_hash = md5.hexhash((this.theme_root).str() + '/' + (this.stylesheet).str())
	mut var_theme_file := rt.new_string((this.stylesheet).str() + '/style.css')
	mut var_cache := this.cache_get(rt.new_string('theme'))
	if rt.is_true(rt.new_bool(var_cache.clone().is_array())) {
		mut iter_1 := rt.create_array([
			rt.ArrayItem{ key: none, val: 'block_template_folders' },
			rt.ArrayItem{ key: none, val: 'block_theme' },
			rt.ArrayItem{ key: none, val: 'errors' },
			rt.ArrayItem{ key: none, val: 'headers' },
			rt.ArrayItem{ key: none, val: 'template' },
		]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if var_cache.array_isset(var_key) {
				this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":290,"name":"key"}',
					var_cache.array_get(var_key))
			}
		}
		if rt.is_true(this.errors) {
			return
		}
		if var_cache.array_isset(rt.new_string('theme_root_template')) {
			mut var_theme_root_template := var_cache.array_get(rt.new_string('theme_root_template'))
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		rt.new_string((this.theme_root).str() + '/' + var_theme_file.str()),
	])))))
	{
		this.headers.array_set('Name', this.stylesheet)
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
			rt.new_string((this.theme_root).str() + '/' + (this.stylesheet).str()),
		])))))
		{
			this.errors = create_wp_error(rt.new_string('theme_not_found'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The theme directory "%s" does not exist.'),
				]),
				rt.call_function('esc_html', [
					this.stylesheet,
				]),
			]))
		} else {
			this.errors = create_wp_error(rt.new_string('theme_no_stylesheet'), rt.call_function('__', [
				rt.new_string('Stylesheet is missing.'),
			]))
		}
		this.template = this.stylesheet
		this.block_theme = rt.new_bool(false)
		this.block_template_folders = this.default_template_folders
		this.cache_add(rt.new_string('theme'), rt.create_array([
			rt.ArrayItem{ key: 'block_template_folders', val: this.block_template_folders },
			rt.ArrayItem{ key: 'block_theme', val: this.block_theme },
			rt.ArrayItem{ key: 'headers', val: this.headers },
			rt.ArrayItem{ key: 'errors', val: this.errors },
			rt.ArrayItem{ key: 'stylesheet', val: this.stylesheet },
			rt.ArrayItem{ key: 'template', val: this.template },
		]))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
			this.theme_root,
		])))))
		{
			rt.call_method(this.errors, 'add', [rt.new_string('theme_root_missing'),
				rt.call_function('__', [
					rt.new_string('<strong>Error:</strong> The themes directory is either empty or does not exist. Please check your installation.'),
				])])
		}
		return
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [
		rt.new_string((this.theme_root).str() + '/' + var_theme_file.str()),
	])))))
	{
		this.headers.array_set('Name', this.stylesheet)
		this.errors = create_wp_error(rt.new_string('theme_stylesheet_not_readable'), rt.call_function('__', [
			rt.new_string('Stylesheet is not readable.'),
		]))
		this.template = this.stylesheet
		this.block_theme = rt.new_bool(false)
		this.block_template_folders = this.default_template_folders
		this.cache_add(rt.new_string('theme'), rt.create_array([
			rt.ArrayItem{ key: 'block_template_folders', val: this.block_template_folders },
			rt.ArrayItem{ key: 'block_theme', val: this.block_theme },
			rt.ArrayItem{ key: 'headers', val: this.headers },
			rt.ArrayItem{ key: 'errors', val: this.errors },
			rt.ArrayItem{ key: 'stylesheet', val: this.stylesheet },
			rt.ArrayItem{ key: 'template', val: this.template },
		]))
		return
	} else {
		this.headers = rt.call_function('get_file_data', [
			rt.new_string((this.theme_root).str() + '/' + var_theme_file.str()),
			rt.get_static_prop('WP_Theme', 'file_headers'),
			rt.new_string('theme'),
		])
		mut var_default_theme_slug := rt.call_function('array_search', [
			this.headers.array_get(rt.new_string('Name')),
			rt.get_static_prop('WP_Theme', 'default_themes'),
			rt.new_bool(true),
		])
		if rt.is_true(var_default_theme_slug) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('basename', [
				this.stylesheet,
			]), var_default_theme_slug))))
			{
				this.headers.array_get(rt.new_string('Name')) = rt.concat(this.headers.array_get(rt.new_string('Name')), rt.new_string(
					'/' + (this.stylesheet).str()))
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.template))))
		&& rt.is_true(rt.identical(this.stylesheet, this.headers.array_get(rt.new_string('Template')))) {
		this.errors = create_wp_error(rt.new_string('theme_child_invalid'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The theme defines itself as its parent theme. Please check the %s header.'),
			]),
			rt.new_string('<code>Template</code>'),
		]))
		this.cache_add(rt.new_string('theme'), rt.create_array([
			rt.ArrayItem{ key: 'block_template_folders', val: this.get_block_template_folders() },
			rt.ArrayItem{ key: 'block_theme', val: this.is_block_theme() },
			rt.ArrayItem{ key: 'headers', val: this.headers },
			rt.ArrayItem{ key: 'errors', val: this.errors },
			rt.ArrayItem{ key: 'stylesheet', val: this.stylesheet },
		]))
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.template)))) {
		this.template = this.headers.array_get(rt.new_string('Template'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.template)))) {
		this.template = this.stylesheet
		mut var_theme_path := rt.new_string((this.theme_root).str() + '/' + (this.stylesheet).str())
		if rt.is_true(rt.new_bool(!(rt.is_true(this.is_block_theme()))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string(var_theme_path.str() + '/index.php')]))))) {
			mut var_error_message := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Template is missing. Standalone themes need to have a %1$s or %2$s template file. <a href="%3$s">Child themes</a> need to have a %4$s header in the %5$s stylesheet.'),
				]),
				rt.new_string('<code>templates/index.html</code>'),
				rt.new_string('<code>index.php</code>'),
				rt.call_function('__', [
					rt.new_string('https://developer.wordpress.org/themes/advanced-topics/child-themes/'),
				]),
				rt.new_string('<code>Template</code>'),
				rt.new_string('<code>style.css</code>'),
			])
			this.errors = create_wp_error(rt.new_string('theme_no_index'),
				var_error_message.clone())
			this.cache_add(rt.new_string('theme'), rt.create_array([
				rt.ArrayItem{ key: 'block_template_folders', val: this.get_block_template_folders() },
				rt.ArrayItem{ key: 'block_theme', val: this.block_theme },
				rt.ArrayItem{ key: 'headers', val: this.headers },
				rt.ArrayItem{ key: 'errors', val: this.errors },
				rt.ArrayItem{ key: 'stylesheet', val: this.stylesheet },
				rt.ArrayItem{ key: 'template', val: this.template },
			]))
			return
		}
	}
	if !(var_cache.clone().is_array())
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.template, this.stylesheet))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((this.theme_root).str() + '/' + (this.template).str() + '/index.php')]))))) {
		mut var_parent_dir := rt.call_function('dirname', [this.stylesheet])
		mut var_directories := rt.call_function('search_theme_directories', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('.'), var_parent_dir))))
			&& rt.is_true(rt.call_function('file_exists', [rt.new_string((this.theme_root).str() + '/' + var_parent_dir.str() + '/' + (this.template).str() + '/index.php')])) {
			this.template = var_parent_dir.str() + '/' + (this.template).str()
		} else if rt.is_true(var_directories) && var_directories.array_isset(this.template) {
			var_theme_root_template =
				var_directories.array_get(this.template).array_get(rt.new_string('theme_root'))
		} else {
			this.errors = create_wp_error(rt.new_string('theme_no_parent'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The parent theme is missing. Please install the "%s" parent theme.'),
				]),
				rt.call_function('esc_html', [
					this.template,
				]),
			]))
			this.cache_add(rt.new_string('theme'), rt.create_array([
				rt.ArrayItem{ key: 'block_template_folders', val: this.get_block_template_folders() },
				rt.ArrayItem{ key: 'block_theme', val: this.is_block_theme() },
				rt.ArrayItem{ key: 'headers', val: this.headers },
				rt.ArrayItem{ key: 'errors', val: this.errors },
				rt.ArrayItem{ key: 'stylesheet', val: this.stylesheet },
				rt.ArrayItem{ key: 'template', val: this.template },
			]))
			this.parent = create_wp_theme(this.template, this.theme_root, rt.new_object('WP_Theme', [
				'ArrayAccess',
			], &this))
			return
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.template, this.stylesheet)))) {
		if rt.is_true(rt.new_bool(rt.instance_of(var__child_mutated, 'WP_Theme')))
			&& rt.is_true(rt.identical(rt.get_property(var__child_mutated, 'template'), this.stylesheet)) {
			rt.set_property(var__child_mutated, 'parent', rt.new_null())
			rt.set_property(var__child_mutated, 'errors', create_wp_error(rt.new_string('theme_parent_invalid'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The "%s" theme is not a valid parent theme.'),
				]),
				rt.call_function('esc_html', [
					rt.get_property(var__child_mutated, 'template'),
				]),
			])))
			rt.call_method(var__child_mutated, 'cache_add', [
				rt.new_string('theme'),
				rt.create_array([
					rt.ArrayItem{ key: 'block_template_folders', val: rt.call_method(var__child_mutated,
						'get_block_template_folders', []rt.PhpVal{}) },
					rt.ArrayItem{ key: 'block_theme', val: rt.call_method(var__child_mutated,
						'is_block_theme', []rt.PhpVal{}) },
					rt.ArrayItem{ key: 'headers', val: rt.get_property(var__child_mutated,
						'headers') },
					rt.ArrayItem{ key: 'errors', val: rt.get_property(var__child_mutated, 'errors') },
					rt.ArrayItem{ key: 'stylesheet', val: rt.get_property(var__child_mutated,
						'stylesheet') },
					rt.ArrayItem{ key: 'template', val: rt.get_property(var__child_mutated,
						'template') },
				])])
			if rt.is_true(rt.identical(rt.get_property(var__child_mutated, 'stylesheet'),
				this.template))
			{
				this.errors = create_wp_error(rt.new_string('theme_parent_invalid'), rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The "%s" theme is not a valid parent theme.'),
					]),
					rt.call_function('esc_html', [
						this.template,
					]),
				]))
				this.cache_add(rt.new_string('theme'), rt.create_array([
					rt.ArrayItem{
						key: 'block_template_folders'
						val: this.get_block_template_folders()
					},
					rt.ArrayItem{ key: 'block_theme', val: this.is_block_theme() },
					rt.ArrayItem{ key: 'headers', val: this.headers },
					rt.ArrayItem{ key: 'errors', val: this.errors },
					rt.ArrayItem{ key: 'stylesheet', val: this.stylesheet },
					rt.ArrayItem{ key: 'template', val: this.template },
				]))
			}
			return
		}
		this.parent = create_wp_theme(this.template, if !var_theme_root_template.is_null() {
			var_theme_root_template
		} else {
			this.theme_root
		}, rt.new_object('WP_Theme', ['ArrayAccess'], &this))
	}
	if rt.is_true(rt.call_method(rt.call_function('wp_paused_themes', []rt.PhpVal{}), 'get', [this.stylesheet]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [this.errors])))))
		|| !(rt.get_property(this.errors, 'errors').array_isset(rt.new_string('theme_paused'))) {
		this.errors = create_wp_error(rt.new_string('theme_paused'), rt.call_function('__', [
			rt.new_string('This theme failed to load properly and was paused within the admin backend.'),
		]))
	}
	if !(var_cache.clone().is_array()) {
		var_cache = rt.create_array([
			rt.ArrayItem{ key: 'block_theme', val: this.is_block_theme() },
			rt.ArrayItem{ key: 'block_template_folders', val: this.get_block_template_folders() },
			rt.ArrayItem{ key: 'headers', val: this.headers },
			rt.ArrayItem{ key: 'errors', val: this.errors },
			rt.ArrayItem{ key: 'stylesheet', val: this.stylesheet },
			rt.ArrayItem{ key: 'template', val: this.template },
		])
		if !var_theme_root_template.is_null() {
			var_cache.array_set('theme_root_template', var_theme_root_template.clone())
		}
		this.cache_add(rt.new_string('theme'), var_cache.clone())
	}
}

fn (mut this Class_WP_Theme) magic_tostring() string {
	return this.display(rt.new_string('Name'), false, false).str()
}

fn (mut this Class_WP_Theme) magic_isset(var_offset rt.PhpVal) rt.PhpVal {
	mut var_properties := rt.new_null()
	return rt.call_function('in_array', [var_offset.clone(), var_properties.clone(),
		rt.new_bool(true)])
}

fn (mut this Class_WP_Theme) magic_get(var_offset rt.PhpVal) rt.PhpVal {
	mut switch_val_1 := var_offset
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('name')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('title'))) {
		return rt.new_bool(this.get(rt.new_string('Name')))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('version'))) {
		return rt.new_bool(this.get(rt.new_string('Version')))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('parent_theme'))) {
		return if rt.is_true(this.parent()) { rt.call_method(this.parent(), 'get', [
				rt.new_string('Name'),
			]) } else { rt.new_string('') }
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
		return this.offsetget(var_offset.clone())
	}
	return rt.new_null()
}

fn (mut this Class_WP_Theme) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_Theme) offsetunset(var_offset rt.PhpVal) {
}

fn (mut this Class_WP_Theme) offsetexists(var_offset rt.PhpVal) rt.PhpVal {
	mut var_keys := rt.new_null()
	return rt.call_function('in_array', [var_offset.clone(), var_keys.clone(),
		rt.new_bool(true)])
}

fn (mut this Class_WP_Theme) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	mut switch_val_2 := var_offset
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('Name')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('Title'))) {
		return rt.new_bool(this.get(rt.new_string('Name')))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Author'))) {
		return rt.new_bool(this.display(rt.new_string('Author'), false, false))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Author Name'))) {
		return rt.new_bool(this.display(rt.new_string('Author'), false, false))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Author URI'))) {
		return rt.new_bool(this.display(rt.new_string('AuthorURI'), false, false))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Description'))) {
		return rt.new_bool(this.display(rt.new_string('Description'), false, false))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Version')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('Status'))) {
		return rt.new_bool(this.get(var_offset.clone()))
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
		return this.get_screenshot('relative')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Tags'))) {
		return rt.new_bool(this.get(rt.new_string('Tags')))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Theme Root'))) {
		return this.get_theme_root()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Theme Root URI'))) {
		return this.get_theme_root_uri()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Parent Theme'))) {
		return if rt.is_true(this.parent()) { rt.call_method(this.parent(), 'get', [
				rt.new_string('Name'),
			]) } else { rt.new_string('') }
	} else {
		return rt.new_null()
	}
	return rt.new_null()
}

fn (mut this Class_WP_Theme) errors() rt.PhpVal {
	return if rt.is_true(rt.call_function('is_wp_error', [this.errors])) {
		this.errors
	} else {
		rt.new_bool(false)
	}
}

fn (mut this Class_WP_Theme) exists() bool {
	return !(rt.is_true(this.errors())
		&& rt.is_true(rt.call_function('in_array', [rt.new_string('theme_not_found'), rt.call_method(this.errors(), 'get_error_codes', []rt.PhpVal{}), rt.new_bool(true)])))
}

fn (mut this Class_WP_Theme) parent() rt.PhpVal {
	return if !(this.parent).is_null() { this.parent } else { rt.new_bool(false) }
}

fn (mut this Class_WP_Theme) magic_wakeup() {
	if rt.is_true(this.parent)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.parent, 'self')))))) {
		rt.throw_exception(rt.new_object('UnexpectedValueException', []string{},
			create_unexpectedvalueexception()))
	}
	if rt.is_true(this.headers) && !(this.headers.is_array()) {
		rt.throw_exception(rt.new_object('UnexpectedValueException', []string{},
			create_unexpectedvalueexception()))
	}
	mut iter_2 := this.headers.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		if !(var_value.clone().is_string()) {
			rt.throw_exception(rt.new_object('UnexpectedValueException', []string{},
				create_unexpectedvalueexception()))
		}
	}
	this.headers_sanitized = rt.new_array()
}

fn (mut this Class_WP_Theme) cache_add(var_key rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	return rt.call_function('wp_cache_add', [
		rt.new_string(var_key_mutated.str() + '-' + this.cache_hash),
		var_data.clone(),
		rt.new_string('themes'),
		rt.get_static_prop('WP_Theme', 'cache_expiration'),
	])
}

fn (mut this Class_WP_Theme) cache_get(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	return rt.call_function('wp_cache_get', [
		rt.new_string(var_key_mutated.str() + '-' + this.cache_hash),
		rt.new_string('themes'),
	])
}

fn (mut this Class_WP_Theme) cache_delete() {
	mut iter_3 := rt.create_array([rt.ArrayItem{ key: none, val: 'theme' },
		rt.ArrayItem{ key: none, val: 'screenshot' }, rt.ArrayItem{ key: none, val: 'headers' },
		rt.ArrayItem{ key: none, val: 'post_templates' }]).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_key := item_3.val
		rt.call_function('wp_cache_delete', [
			rt.new_string(var_key.str() + '-' + this.cache_hash),
			rt.new_string('themes'),
		])
	}
	this.template = rt.new_null()
	this.textdomain_loaded = rt.new_null()
	this.theme_root_uri = rt.new_null()
	this.parent = rt.new_null()
	this.errors = rt.new_null()
	this.headers_sanitized = rt.new_null()
	this.name_translated = rt.new_null()
	this.block_theme = rt.new_null()
	this.block_template_folders = rt.new_null()
	this.headers = rt.new_array()
	this.construct(this.stylesheet, this.theme_root, rt.new_null())
	this.delete_pattern_cache()
}

fn (mut this Class_WP_Theme) get(var_header rt.PhpVal) bool {
	if !(this.headers.array_isset(var_header)) {
		return false
	}
	if !(!(this.headers_sanitized).is_null()) {
		this.headers_sanitized = this.cache_get(rt.new_string('headers'))
		if !(this.headers_sanitized.is_array()) {
			this.headers_sanitized = rt.new_array()
		}
	}
	if this.headers_sanitized.array_isset(var_header) {
		return (this.headers_sanitized.array_get(var_header)).to_bool()
	}
	if rt.is_true(rt.get_static_prop('WP_Theme', 'persistently_cache')) {
		mut iter_4 := rt.func_array_keys(this.headers).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var__header := item_4.val
			this.headers_sanitized.array_set(var__header, this.sanitize_header(var__header.clone(),
				this.headers.array_get(var__header)))
		}
		this.cache_add(rt.new_string('headers'), this.headers_sanitized)
	} else {
		this.headers_sanitized.array_set(var_header, this.sanitize_header(var_header.clone(),
			this.headers.array_get(var_header)))
	}
	return (this.headers_sanitized.array_get(var_header)).to_bool()
}

fn (mut this Class_WP_Theme) display(var_header rt.PhpVal, markup bool, translate bool) bool {
	mut translate_mutated := translate
	mut var_value := rt.new_bool(this.get(var_header.clone()))
	if rt.is_true(rt.identical(rt.new_bool(false), var_value)) {
		return false
	}
	if rt.is_true(rt.new_bool(translate_mutated)) && !rt.is_true(var_value)
		|| !(this.load_textdomain()) {
		translate_mutated = false
	}
	if rt.is_true(rt.new_bool(translate_mutated)) {
		var_value = this.translate_header(var_header.clone(), var_value.clone())
	}
	if var_markup {
		var_value = this.markup_header(var_header.clone(), var_value.clone(),
			rt.new_bool(translate_mutated))
	}
	return var_value.to_bool()
}

fn (mut this Class_WP_Theme) sanitize_header(var_header rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_header_tags := rt.new_null()
	mut var_header_tags_with_a := rt.new_null()
	mut var_value_mutated := var_value
	mut switch_val_3 := var_header
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('Status'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_value_mutated)))) {
			var_value_mutated = rt.new_string('publish')
		}
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('Name'))) {
		var_value_mutated = rt.call_function('wp_kses', [var_value_mutated.clone(),
			var_header_tags.clone()])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('Author')))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_string('Description'))) {
		var_value_mutated = rt.call_function('wp_kses', [var_value_mutated.clone(),
			var_header_tags_with_a.clone()])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('ThemeURI')))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_string('AuthorURI'))) {
		var_value_mutated = rt.call_function('sanitize_url', [
			var_value_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('Tags'))) {
		var_value_mutated = rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('trim'),
				rt.call_function('explode', [rt.new_string(','),
					rt.call_function('strip_tags', [var_value_mutated.clone()])])]),
		])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('Version')))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_string('RequiresWP')))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_string('RequiresPHP')))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_string('UpdateURI'))) {
		var_value_mutated = rt.call_function('strip_tags', [var_value_mutated.clone()])
	}
	return var_value_mutated.clone()
}

fn (mut this Class_WP_Theme) markup_header(var_header rt.PhpVal, var_value rt.PhpVal, var_translate rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_translate_mutated := var_translate
	mut switch_val_4 := var_header
	if rt.is_true(rt.equal(switch_val_4, rt.new_string('Name'))) {
		if !rt.is_true(var_value_mutated) {
			var_value_mutated = rt.call_function('esc_html', [
				this.get_stylesheet()])
		}
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('Description'))) {
		var_value_mutated = rt.call_function('wptexturize', [
			var_value_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('Author'))) {
		if this.get(rt.new_string('AuthorURI')) {
			var_value_mutated = rt.call_function('sprintf', [
				rt.new_string('<a href="%1$s">%2$s</a>'),
				rt.new_bool(this.display(rt.new_string('AuthorURI'), true,
					var_translate_mutated.to_bool())),
				var_value_mutated.clone(),
			])
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_value_mutated)))) {
			var_value_mutated = rt.call_function('__', [rt.new_string('Anonymous')])
		}
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('Tags'))) {
		mut var_comma := rt.new_null()
		if !(!var_comma.is_null()) {
			var_comma = rt.call_function('wp_get_list_item_separator', []rt.PhpVal{})
		}
		var_value_mutated = rt.call_function('implode', [var_comma.clone(),
			var_value_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('ThemeURI')))
		|| rt.is_true(rt.equal(switch_val_4, rt.new_string('AuthorURI'))) {
		var_value_mutated = rt.call_function('esc_url', [var_value_mutated.clone()])
	}
	return var_value_mutated.clone()
}

fn (mut this Class_WP_Theme) translate_header(var_header rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut switch_val_5 := var_header
	if rt.is_true(rt.equal(switch_val_5, rt.new_string('Name'))) {
		if !(this.name_translated).is_null() {
			return this.name_translated
		}
		this.name_translated = rt.call_function('translate', [
			var_value_mutated.clone(), rt.new_bool(this.get(rt.new_string('TextDomain')))])
		return this.name_translated
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('Tags'))) {
		if !rt.is_true(var_value_mutated)
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_theme_feature_list')]))))) {
			return var_value_mutated.clone()
		}
		mut var_tags_list := rt.new_null()
		if !(!var_tags_list.is_null()) {
			var_tags_list = rt.create_array([
				rt.ArrayItem{ key: 'black', val: rt.call_function('__', [
					rt.new_string('Black'),
				]) },
				rt.ArrayItem{ key: 'blue', val: rt.call_function('__', [
					rt.new_string('Blue'),
				]) },
				rt.ArrayItem{ key: 'brown', val: rt.call_function('__', [
					rt.new_string('Brown'),
				]) },
				rt.ArrayItem{ key: 'gray', val: rt.call_function('__', [
					rt.new_string('Gray'),
				]) },
				rt.ArrayItem{ key: 'green', val: rt.call_function('__', [
					rt.new_string('Green'),
				]) },
				rt.ArrayItem{ key: 'orange', val: rt.call_function('__', [
					rt.new_string('Orange'),
				]) },
				rt.ArrayItem{ key: 'pink', val: rt.call_function('__', [
					rt.new_string('Pink'),
				]) },
				rt.ArrayItem{ key: 'purple', val: rt.call_function('__', [
					rt.new_string('Purple'),
				]) },
				rt.ArrayItem{ key: 'red', val: rt.call_function('__', [
					rt.new_string('Red'),
				]) },
				rt.ArrayItem{ key: 'silver', val: rt.call_function('__', [
					rt.new_string('Silver'),
				]) },
				rt.ArrayItem{ key: 'tan', val: rt.call_function('__', [
					rt.new_string('Tan'),
				]) },
				rt.ArrayItem{ key: 'white', val: rt.call_function('__', [
					rt.new_string('White'),
				]) },
				rt.ArrayItem{ key: 'yellow', val: rt.call_function('__', [
					rt.new_string('Yellow'),
				]) },
				rt.ArrayItem{ key: 'dark', val: rt.call_function('_x', [
					rt.new_string('Dark'),
					rt.new_string('color scheme'),
				]) },
				rt.ArrayItem{ key: 'light', val: rt.call_function('_x', [
					rt.new_string('Light'),
					rt.new_string('color scheme'),
				]) },
				rt.ArrayItem{ key: 'fixed-layout', val: rt.call_function('__', [
					rt.new_string('Fixed Layout'),
				]) },
				rt.ArrayItem{ key: 'fluid-layout', val: rt.call_function('__', [
					rt.new_string('Fluid Layout'),
				]) },
				rt.ArrayItem{ key: 'responsive-layout', val: rt.call_function('__', [
					rt.new_string('Responsive Layout'),
				]) },
				rt.ArrayItem{ key: 'blavatar', val: rt.call_function('__', [
					rt.new_string('Blavatar'),
				]) },
				rt.ArrayItem{ key: 'photoblogging', val: rt.call_function('__', [
					rt.new_string('Photoblogging'),
				]) },
				rt.ArrayItem{ key: 'seasonal', val: rt.call_function('__', [
					rt.new_string('Seasonal'),
				]) },
			])
			mut var_feature_list := rt.call_function('get_theme_feature_list', [
				rt.new_bool(false),
			])
			mut iter_5 := var_feature_list.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_tags := item_5.val
				var_tags_list = rt.add(var_tags_list, var_tags)
			}
		}
		mut iter_6 := var_value_mutated.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_tag := item_6.val
			if var_tags_list.array_isset(var_tag) {
				var_tag = var_tags_list.array_get(var_tag)
			} else if rt.get_static_prop('WP_Theme', 'tag_map').array_isset(var_tag) {
				var_tag =
					var_tags_list.array_get(rt.get_static_prop('WP_Theme', 'tag_map').array_get(var_tag))
			}
		}
		return var_value_mutated.clone()
	} else {
		var_value_mutated = rt.call_function('translate', [var_value_mutated.clone(),
			rt.new_bool(this.get(rt.new_string('TextDomain')))])
	}
	return var_value_mutated.clone()
}

fn (mut this Class_WP_Theme) get_stylesheet() rt.PhpVal {
	return this.stylesheet
}

fn (mut this Class_WP_Theme) get_template() rt.PhpVal {
	return this.template
}

fn (mut this Class_WP_Theme) get_stylesheet_directory() string {
	if rt.is_true(this.errors())
		&& rt.is_true(rt.call_function('in_array', [rt.new_string('theme_root_missing'), rt.call_method(this.errors(), 'get_error_codes', []rt.PhpVal{}), rt.new_bool(true)])) {
		return ''
	}
	return (this.theme_root).str() + '/' + (this.stylesheet).str()
}

fn (mut this Class_WP_Theme) get_template_directory() string {
	if rt.is_true(this.parent()) {
		mut var_theme_root := rt.get_property(this.parent(), 'theme_root')
	} else {
		var_theme_root = this.theme_root
	}
	return var_theme_root.str() + '/' + (this.template).str()
}

fn (mut this Class_WP_Theme) get_stylesheet_directory_uri() string {
	return (this.get_theme_root_uri()).str() + '/' +(rt.call_function('str_replace', [rt.new_string('%2F'), rt.new_string('/'), rt.call_function('rawurlencode', [this.stylesheet])])).str()
}

fn (mut this Class_WP_Theme) get_template_directory_uri() string {
	if rt.is_true(this.parent()) {
		mut var_theme_root_uri := rt.call_method(this.parent(), 'get_theme_root_uri', []rt.PhpVal{})
	} else {
		var_theme_root_uri = this.get_theme_root_uri()
	}
	return var_theme_root_uri.str() + '/' +(rt.call_function('str_replace', [rt.new_string('%2F'), rt.new_string('/'), rt.call_function('rawurlencode', [this.template])])).str()
}

fn (mut this Class_WP_Theme) get_theme_root() rt.PhpVal {
	return this.theme_root
}

fn (mut this Class_WP_Theme) get_theme_root_uri() rt.PhpVal {
	if !(!(this.theme_root_uri).is_null()) {
		this.theme_root_uri = rt.call_function('get_theme_root_uri',
			[this.stylesheet, this.theme_root])
	}
	return this.theme_root_uri
}

fn (mut this Class_WP_Theme) get_screenshot(uri string) rt.PhpVal {
	mut var_screenshot := this.cache_get(rt.new_string('screenshot'))
	if rt.is_true(var_screenshot) {
		if rt.is_true(rt.identical(rt.new_string('relative'), rt.new_string(uri))) {
			return var_screenshot.clone()
		}
		return rt.new_string(this.get_stylesheet_directory_uri() + '/' + var_screenshot.str())
	} else if rt.is_true(rt.identical(rt.new_int(0), var_screenshot)) {
		return rt.new_bool(false)
	}
	mut iter_7 := rt.create_array([rt.ArrayItem{ key: none, val: 'png' },
		rt.ArrayItem{ key: none, val: 'gif' }, rt.ArrayItem{ key: none, val: 'jpg' },
		rt.ArrayItem{ key: none, val: 'jpeg' }, rt.ArrayItem{ key: none, val: 'webp' },
		rt.ArrayItem{ key: none, val: 'avif' }]).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_ext := item_7.val
		if rt.is_true(rt.call_function('file_exists', [
			rt.new_string(this.get_stylesheet_directory() + '/screenshot.${var_ext.to_string()}'),
		]))
		{
			this.cache_add(rt.new_string('screenshot'),
				rt.new_string('screenshot.' + var_ext.str()))
			if rt.is_true(rt.identical(rt.new_string('relative'), rt.new_string(uri))) {
				return rt.new_string('screenshot.' + var_ext.str())
			}
			return rt.new_string(this.get_stylesheet_directory_uri() + '/' + 'screenshot.' +
				var_ext.str())
		}
	}
	this.cache_add(rt.new_string('screenshot'), rt.new_int(0))
	return rt.new_bool(false)
}

fn (mut this Class_WP_Theme) get_files(var_type rt.PhpVal, depth i64, search_parent bool) rt.PhpVal {
	mut var_type_mutated := var_type
	mut var_files := rt.cast_array(Class_WP_Theme.scandir(rt.new_string(this.get_stylesheet_directory()),
		var_type_mutated.to_i64(), depth))
	if var_search_parent && rt.is_true(this.parent()) {
		var_files = rt.add(var_files, rt.cast_array(Class_WP_Theme.scandir(rt.new_string(this.get_template_directory()),
			var_type_mutated.to_i64(), depth)))
	}
	return rt.call_function('array_filter', [var_files.clone()])
}

fn (mut this Class_WP_Theme) get_post_templates() rt.PhpVal {
	mut var_header := rt.new_null()
	if rt.is_true(this.errors()) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(this.errors(), 'get_error_codes', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{
		key: none
		val: 'theme_parent_invalid'
	}]))))) {
		return rt.new_array()
	}
	mut var_post_templates := this.cache_get(rt.new_string('post_templates'))
	if !(var_post_templates.clone().is_array()) {
		var_post_templates = rt.new_array()
		mut var_files := rt.cast_array(this.get_files(rt.new_string('php'), 1, true))
		mut iter_8 := var_files.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_full_path := item_8.val
			mut var_file := item_8.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
				rt.new_string('|Template Name:(.*)$|mi'),
				rt.call_function('file_get_contents', [var_full_path.clone()]),
				var_header.clone(),
			])))))
			{
				continue
			}
			mut var_types := rt.create_array([rt.ArrayItem{ key: none, val: 'page' }])
			if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('|Template Post Type:(.*)$|mi'),
				rt.call_function('file_get_contents', [var_full_path.clone()]),
				var_type.clone(),
			]))
			{
				var_types = rt.call_function('explode', [rt.new_string(','),
					rt.call_function('_cleanup_header_comment', [
						var_type.array_get(rt.new_int(1)),
					])])
			}
			mut iter_9 := var_types.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_type := item_9.val
				var_type = rt.call_function('sanitize_key', [
					var_type.clone()])
				if !(var_post_templates.array_isset(var_type)) {
					var_post_templates.array_set(var_type, rt.new_array())
				}
				var_post_templates.array_get_mut(var_type).array_set(var_file, rt.call_function('_cleanup_header_comment', [
					var_header.array_get(rt.new_int(1)),
				]))
			}
		}
		this.cache_add(rt.new_string('post_templates'), var_post_templates.clone())
	}
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('block-templates'),
	]))
	{
		mut var_block_templates := rt.call_function('get_block_templates', [
			rt.new_array(),
			rt.new_string('wp_template'),
		])
		mut iter_10 := rt.call_function('get_post_types', [
			rt.create_array([rt.ArrayItem{ key: 'public', val: true }]),
		]).iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_type := item_10.val
			mut iter_11 := var_block_templates.iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_block_template := item_11.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_template,
					'is_custom')))))
				{
					continue
				}
				if !(rt.get_property(var_block_template, 'post_types')).is_null()
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_type.clone(), rt.get_property(var_block_template, 'post_types'), rt.new_bool(true)]))))) {
					continue
				}
				var_post_templates.array_get_mut(var_type).array_set(rt.get_property(var_block_template,
					'slug'), rt.get_property(var_block_template, 'title'))
			}
		}
	}
	if this.load_textdomain() {
		mut iter_12 := var_post_templates.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_post_type := item_12.val
			mut iter_13 := var_post_type.iterator()
			for {
				item_13 := iter_13.next() or { break }
				mut var_post_template := item_13.val
				var_post_template = this.translate_header(rt.new_string('Template Name'),
					var_post_template.clone())
			}
		}
	}
	return var_post_templates.clone()
}

fn (mut this Class_WP_Theme) get_page_templates(var_post rt.PhpVal, post_type string) rt.PhpVal {
	mut post_type_mutated := post_type
	if rt.is_true(var_post) {
		post_type_mutated = (rt.call_function('get_post_type', [
			var_post.clone()])).str()
	}
	mut var_post_templates := this.get_post_templates()
	var_post_templates = if !(var_post_templates.array_get(rt.new_string(post_type_mutated))).is_null() {
		var_post_templates.array_get(rt.new_string(post_type_mutated))
	} else {
		rt.new_array()
	}
	var_post_templates = rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('theme_templates'),
		var_post_templates.clone(),
		rt.new_object('WP_Theme', ['ArrayAccess'], &this),
		var_post.clone(),
		rt.new_string(post_type_mutated).clone(),
	]))
	var_post_templates = rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('theme_${var_post_type.to_string()}_templates'),
		var_post_templates.clone(),
		rt.new_object('WP_Theme', ['ArrayAccess'], &this),
		var_post.clone(),
		rt.new_string(post_type_mutated).clone(),
	]))
	return var_post_templates.clone()
}

fn Class_WP_Theme.scandir(var_path rt.PhpVal, var_extensions rt.PhpVal, depth i64, relative_path string) rt.PhpVal {
	mut var_path_mutated := var_path
	mut var_extensions_mutated := var_extensions
	mut relative_path_mutated := relative_path
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [
		var_path_mutated.clone()])))))
	{
		return rt.new_bool(false)
	}
	if rt.is_true(var_extensions_mutated) {
		var_extensions_mutated = rt.cast_array(var_extensions_mutated)
		mut var__extensions := rt.call_function('implode', [rt.new_string('|'),
			var_extensions_mutated.clone()])
	}
	relative_path_mutated = (rt.call_function('trailingslashit', [
		rt.new_string(relative_path_mutated).clone()])).str()
	if rt.is_true(rt.identical(rt.new_string('/'), rt.new_string(relative_path_mutated))) {
		relative_path_mutated = ''
	}
	mut var_results := rt.call_function('scandir', [var_path_mutated.clone()])
	mut var_files := rt.new_array()
	mut var_exclusions := rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('theme_scandir_exclusions'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'CVS' },
			rt.ArrayItem{ key: none, val: 'node_modules' }, rt.ArrayItem{ key: none, val: 'vendor' },
			rt.ArrayItem{ key: none, val: 'bower_components' }]),
	]))
	mut iter_14 := var_results.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_result := item_14.val
		if rt.is_true(rt.identical(rt.new_string('.'), var_result.array_get(rt.new_int(0))))
			|| rt.is_true(rt.call_function('in_array', [var_result.clone(), var_exclusions.clone(), rt.new_bool(true)])) {
			continue
		}
		if rt.is_true(rt.call_function('is_dir', [
			rt.new_string(var_path_mutated.str() + '/' + var_result.str()),
		]))
		{
			if !(var_depth != 0) {
				continue
			}
			mut var_found := Class_WP_Theme.scandir(rt.new_string(var_path_mutated.str() + '/' +
				var_result.str()), var_extensions_mutated.to_i64(), depth - 1, rt.new_string(
				relative_path_mutated + var_result.str()))
			var_files = rt.call_function('array_merge_recursive', [
				var_files.clone(), var_found.clone()])
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_extensions_mutated))))
			|| rt.is_true(rt.call_function('preg_match', [rt.new_string('~\\.(' + var__extensions.str() + ')$~'), var_result.clone()])) {
			var_files.array_set(relative_path_mutated + var_result.str(), var_path_mutated.str() +
				'/' + var_result.str())
		}
	}
	return var_files.clone()
}

fn (mut this Class_WP_Theme) load_textdomain() bool {
	if !(this.textdomain_loaded).is_null() {
		return (this.textdomain_loaded).to_bool()
	}
	mut var_textdomain := rt.new_bool(this.get(rt.new_string('TextDomain')))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_textdomain)))) {
		this.textdomain_loaded = rt.new_bool(false)
		return false
	}
	if rt.is_true(rt.call_function('is_textdomain_loaded', [var_textdomain.clone()])) {
		this.textdomain_loaded = rt.new_bool(true)
		return true
	}
	mut var_path := rt.new_string(this.get_stylesheet_directory())
	mut var_domainpath := rt.new_bool(this.get(rt.new_string('DomainPath')))
	if rt.is_true(var_domainpath) {
		var_path = rt.concat(var_path, var_domainpath)
	} else {
		var_path = rt.concat(var_path, rt.new_string('/languages'))
	}
	this.textdomain_loaded = rt.call_function('load_theme_textdomain', [
		var_textdomain.clone(), var_path.clone()])
	return (this.textdomain_loaded).to_bool()
}

fn (mut this Class_WP_Theme) is_allowed(check string, var_blog_id rt.PhpVal) bool {
	mut var_blog_id_mutated := var_blog_id
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return true
	}
	if rt.is_true(rt.identical(rt.new_string('both'), rt.new_string(check)))
		|| rt.is_true(rt.identical(rt.new_string('network'), rt.new_string(check))) {
		mut var_allowed := Class_WP_Theme.get_allowed_on_network()
		if !(!rt.is_true(var_allowed.array_get(this.get_stylesheet()))) {
			return true
		}
	}
	if rt.is_true(rt.identical(rt.new_string('both'), rt.new_string(check)))
		|| rt.is_true(rt.identical(rt.new_string('site'), rt.new_string(check))) {
		var_allowed = Class_WP_Theme.get_allowed_on_site(var_blog_id_mutated.clone())
		if !(!rt.is_true(var_allowed.array_get(this.get_stylesheet()))) {
			return true
		}
	}
	return false
}

fn (mut this Class_WP_Theme) is_block_theme() rt.PhpVal {
	if !(this.block_theme).is_null() {
		return this.block_theme
	}
	mut var_paths_to_index_block_template := [this.get_file_path('/templates/index.html'),
		this.get_file_path('/block-templates/index.html')]
	this.block_theme = rt.new_bool(false)
	for var_path_to_index_block_template in var_paths_to_index_block_template {
		if rt.is_true(rt.call_function('is_file', [var_path_to_index_block_template.clone()]))
			&& rt.is_true(rt.call_function('is_readable', [var_path_to_index_block_template.clone()])) {
			this.block_theme = rt.new_bool(true)
			break
		}
	}
	return this.block_theme
}

fn (mut this Class_WP_Theme) get_file_path(file string) rt.PhpVal {
	mut file_mutated := file
	file_mutated = file_mutated.trim_left(' \t\n\r')
	mut var_stylesheet_directory := rt.new_string(this.get_stylesheet_directory())
	mut var_template_directory := rt.new_string(this.get_template_directory())
	if file_mutated == '' {
		mut var_path := var_stylesheet_directory.clone()
	} else if
		rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_stylesheet_directory, var_template_directory))))
		&& rt.is_true(rt.call_function('file_exists', [rt.new_string(var_stylesheet_directory.str() + '/' + file_mutated)])) {
		var_path = rt.new_string(var_stylesheet_directory.str() + '/' + file_mutated)
	} else {
		var_path = rt.new_string(var_template_directory.str() + '/' + file_mutated)
	}
	return rt.call_function('apply_filters', [rt.new_string('theme_file_path'),
		var_path.clone(), rt.new_string(file_mutated).clone()])
}

fn Class_WP_Theme.get_core_default_theme() bool {
	mut iter_15 := rt.call_function('array_reverse', [
		rt.get_static_prop('WP_Theme', 'default_themes'),
	]).iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_name := item_15.val
		mut var_slug := item_15.key
		mut var_theme := rt.call_function('wp_get_theme', [var_slug.clone()])
		if rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{})) {
			return var_theme.to_bool()
		}
	}
	return false
}

fn Class_WP_Theme.get_allowed(var_blog_id rt.PhpVal) rt.PhpVal {
	mut var_blog_id_mutated := var_blog_id
	mut var_network := rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('network_allowed_themes'),
		Class_WP_Theme.get_allowed_on_network(),
		var_blog_id_mutated.clone(),
	]))
	return rt.add(var_network, Class_WP_Theme.get_allowed_on_site(var_blog_id_mutated.clone()))
}

fn Class_WP_Theme.get_allowed_on_network() rt.PhpVal {
	mut var_allowed_themes := rt.new_null()
	if !(!var_allowed_themes.is_null()) {
		var_allowed_themes = rt.cast_array(rt.call_function('get_site_option', [
			rt.new_string('allowedthemes'),
		]))
	}
	var_allowed_themes = rt.call_function('apply_filters', [
		rt.new_string('allowed_themes'),
		var_allowed_themes.clone(),
	])
	return var_allowed_themes.clone()
}

fn Class_WP_Theme.get_allowed_on_site(var_blog_id rt.PhpVal) rt.PhpVal {
	mut var_allowed_themes := rt.new_null()
	mut var_blog_id_mutated := var_blog_id
	if rt.is_true(rt.new_bool(!(rt.is_true(var_blog_id_mutated))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_blog_id_mutated = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	if var_allowed_themes.array_isset(var_blog_id_mutated) {
		return rt.cast_array(rt.call_function('apply_filters', [
			rt.new_string('site_allowed_themes'),
			var_allowed_themes.array_get(var_blog_id_mutated),
			var_blog_id_mutated.clone(),
		]))
	}
	mut var_current := rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}),
		var_blog_id_mutated)
	if rt.is_true(var_current) {
		var_allowed_themes.array_set(var_blog_id_mutated, rt.call_function('get_option', [
			rt.new_string('allowedthemes'),
		]))
	} else {
		rt.call_function('switch_to_blog', [var_blog_id_mutated.clone()])
		var_allowed_themes.array_set(var_blog_id_mutated, rt.call_function('get_option', [
			rt.new_string('allowedthemes'),
		]))
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(rt.new_bool(false),
		var_allowed_themes.array_get(var_blog_id_mutated)))
	{
		if rt.is_true(var_current) {
			var_allowed_themes.array_set(var_blog_id_mutated, rt.call_function('get_option', [
				rt.new_string('allowed_themes'),
			]))
		} else {
			rt.call_function('switch_to_blog', [var_blog_id_mutated.clone()])
			var_allowed_themes.array_set(var_blog_id_mutated, rt.call_function('get_option', [
				rt.new_string('allowed_themes'),
			]))
			rt.call_function('restore_current_blog', []rt.PhpVal{})
		}
		if !(var_allowed_themes.array_get(var_blog_id_mutated).is_array())
			|| !rt.is_true(var_allowed_themes.array_get(var_blog_id_mutated)) {
			var_allowed_themes.array_set(var_blog_id_mutated, rt.new_array())
		} else {
			mut var_converted := rt.new_array()
			mut var_themes := rt.call_function('wp_get_themes', []rt.PhpVal{})
			mut iter_16 := var_themes.iterator()
			for {
				item_16 := iter_16.next() or { break }
				mut var_theme_data := item_16.val
				mut var_stylesheet := item_16.key
				if var_allowed_themes.array_get(var_blog_id_mutated).array_isset(rt.call_method(var_theme_data,
					'get', [rt.new_string('Name')]))
				{
					var_converted.array_set(var_stylesheet, true)
				}
			}
			var_allowed_themes.array_set(var_blog_id_mutated, var_converted.clone())
		}
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
			&& rt.is_true(var_allowed_themes.array_get(var_blog_id_mutated)) {
			if rt.is_true(var_current) {
				rt.call_function('update_option', [rt.new_string('allowedthemes'),
					var_allowed_themes.array_get(var_blog_id_mutated),
					rt.new_bool(false)])
				rt.call_function('delete_option', [rt.new_string('allowed_themes')])
			} else {
				rt.call_function('switch_to_blog', [var_blog_id_mutated.clone()])
				rt.call_function('update_option', [rt.new_string('allowedthemes'),
					var_allowed_themes.array_get(var_blog_id_mutated),
					rt.new_bool(false)])
				rt.call_function('delete_option', [rt.new_string('allowed_themes')])
				rt.call_function('restore_current_blog', []rt.PhpVal{})
			}
		}
	}
	return rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('site_allowed_themes'),
		var_allowed_themes.array_get(var_blog_id_mutated),
		var_blog_id_mutated.clone(),
	]))
}

fn (mut this Class_WP_Theme) get_block_template_folders() rt.PhpVal {
	if !(this.block_template_folders).is_null() {
		return this.block_template_folders
	}
	this.block_template_folders = this.default_template_folders
	mut var_stylesheet_directory := rt.new_string(this.get_stylesheet_directory())
	if rt.is_true(rt.call_function('file_exists', [rt.new_string(var_stylesheet_directory.str() + '/block-templates')]))
		|| rt.is_true(rt.call_function('file_exists', [rt.new_string(var_stylesheet_directory.str() + '/block-template-parts')])) {
		this.block_template_folders = rt.create_array([
			rt.ArrayItem{ key: 'wp_template', val: 'block-templates' },
			rt.ArrayItem{ key: 'wp_template_part', val: 'block-template-parts' },
		])
	}
	return this.block_template_folders
}

fn (mut this Class_WP_Theme) get_block_patterns() rt.PhpVal {
	mut var_can_use_cached := rt.new_bool(!(rt.is_true(rt.call_function('wp_is_development_mode', [
		rt.new_string('theme'),
	]))))
	mut var_pattern_data := rt.new_bool(this.get_pattern_cache())
	if rt.is_true(rt.new_bool(var_pattern_data.clone().is_array())) {
		if rt.is_true(var_can_use_cached) {
			return var_pattern_data.clone()
		}
		this.delete_pattern_cache()
	}
	mut var_dirpath := rt.new_string(this.get_stylesheet_directory() + '/patterns')
	var_pattern_data = rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_dirpath.clone()])))))
	{
		if rt.is_true(var_can_use_cached) {
			this.set_pattern_cache(mut rt.cast_object_ptr[Class_array](var_pattern_data))
		}
		return var_pattern_data.clone()
	}
	mut var_files := rt.cast_array(Class_WP_Theme.scandir(var_dirpath.clone(), 'php', -1))
	var_files = rt.call_function('apply_filters', [
		rt.new_string('theme_block_pattern_files'),
		var_files.clone(),
		var_dirpath.clone(),
	])
	var_dirpath = rt.call_function('trailingslashit', [var_dirpath.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_files)))) {
		if rt.is_true(var_can_use_cached) {
			this.set_pattern_cache(mut rt.cast_object_ptr[Class_array](var_pattern_data))
		}
		return var_pattern_data.clone()
	}
	mut var_default_headers := {
		'title':         'Title'
		'slug':          'Slug'
		'description':   'Description'
		'viewportWidth': 'Viewport Width'
		'inserter':      'Inserter'
		'categories':    'Categories'
		'keywords':      'Keywords'
		'blockTypes':    'Block Types'
		'postTypes':     'Post Types'
		'templateTypes': 'Template Types'
	}
	mut var_properties_to_parse := ['categories', 'keywords', 'blockTypes', 'postTypes',
		'templateTypes']
	mut iter_17 := var_files.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_file := item_17.val
		mut var_pattern := rt.call_function('get_file_data', [
			var_file.clone(), rt.create_array_from_native_map(var_default_headers)])
		if !rt.is_true(var_pattern.array_get(rt.new_string('slug'))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Could not register file "%s" as a block pattern ("Slug" field missing)'),
					]),
					var_file.clone(),
				]),
				rt.new_string('6.0.0')])
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^[A-z0-9\\/_-]+$/'),
			var_pattern.array_get(rt.new_string('slug')),
		])))))
		{
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Could not register file "%1$s" as a block pattern (invalid slug "%2$s")'),
					]),
					var_file.clone(),
					var_pattern.array_get(rt.new_string('slug')),
				]),
				rt.new_string('6.0.0')])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_pattern.array_get(rt.new_string('title')))))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Could not register file "%s" as a block pattern ("Title" field missing)'),
					]),
					var_file.clone(),
				]),
				rt.new_string('6.0.0')])
			continue
		}
		for var_property in var_properties_to_parse {
			if !(!rt.is_true(var_pattern.array_get(rt.new_string(property)))) {
				var_pattern.array_set(property, rt.call_function('array_filter', [
					rt.call_function('wp_parse_list', [
						rt.new_string((var_pattern.array_get(rt.new_string(property))).str()),
					]),
				]))
			} else {
				var_pattern.array_unset(rt.new_string(property))
			}
		}
		mut var_property := rt.new_string('viewportWidth')
		if !(!rt.is_true(var_pattern.array_get(var_property))) {
			var_pattern.array_set(var_property,
				rt.new_int((var_pattern.array_get(var_property)).to_i64()))
		} else {
			var_pattern.array_unset(var_property)
		}
		var_property = rt.new_string('inserter')
		if !(!rt.is_true(var_pattern.array_get(var_property))) {
			var_pattern.array_set(var_property, rt.call_function('in_array', [
				rt.new_string(var_pattern.array_get(var_property).to_string().to_lower()),
				rt.create_array([rt.ArrayItem{ key: none, val: 'yes' },
					rt.ArrayItem{ key: none, val: 'true' }]),
				rt.new_bool(true),
			]))
		} else {
			var_pattern.array_unset(var_property)
		}
		mut var_key := rt.call_function('str_replace', [var_dirpath.clone(),
			rt.new_string(''), var_file.clone()])
		var_pattern_data.array_set(var_key, var_pattern.clone())
	}
	if rt.is_true(var_can_use_cached) {
		this.set_pattern_cache(mut rt.cast_object_ptr[Class_array](var_pattern_data))
	}
	return var_pattern_data.clone()
}

fn (mut this Class_WP_Theme) get_pattern_cache() bool {
	if !(this.exists()) {
		return false
	}
	mut var_pattern_data := rt.call_function('get_site_transient', [
		rt.new_string('wp_theme_files_patterns-' + this.cache_hash),
	])
	if var_pattern_data.clone().is_array()
		&& rt.is_true(rt.identical(var_pattern_data.array_get(rt.new_string('version')), this.get(rt.new_string('Version')))) {
		return (var_pattern_data.array_get(rt.new_string('patterns'))).to_bool()
	}
	return false
}

fn (mut this Class_WP_Theme) set_pattern_cache(mut var_patterns Class_array) {
	mut var_pattern_data := rt.create_array([
		rt.ArrayItem{ key: 'version', val: this.get(rt.new_string('Version')) },
		rt.ArrayItem{ key: 'patterns', val: var_patterns },
	])
	mut var_cache_expiration := rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('wp_theme_files_cache_ttl'),
		rt.get_static_prop('WP_Theme', 'cache_expiration'),
		rt.new_string('theme_block_patterns'),
	])).to_i64())
	if rt.is_true(rt.less_equal(var_cache_expiration, rt.new_int(0))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The %1$s filter must return an integer value greater than 0.'),
				]),
				rt.new_string('<code>wp_theme_files_cache_ttl</code>'),
			]),
			rt.new_string('6.6.0')])
		var_cache_expiration = rt.get_static_prop('WP_Theme', 'cache_expiration')
	}
	rt.call_function('set_site_transient', [
		rt.new_string('wp_theme_files_patterns-' + this.cache_hash),
		var_pattern_data.clone(),
		var_cache_expiration.clone(),
	])
}

fn (mut this Class_WP_Theme) delete_pattern_cache() {
	rt.call_function('delete_site_transient', [
		rt.new_string('wp_theme_files_patterns-' + this.cache_hash),
	])
}

fn Class_WP_Theme.network_enable_theme(var_stylesheets rt.PhpVal) {
	mut var_stylesheets_mutated := var_stylesheets
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return
	}
	if !(var_stylesheets_mutated.clone().is_array()) {
		var_stylesheets_mutated = rt.create_array([
			rt.ArrayItem{ key: none, val: var_stylesheets_mutated },
		])
	}
	mut var_allowed_themes := rt.call_function('get_site_option', [
		rt.new_string('allowedthemes'),
	])
	mut iter_18 := var_stylesheets_mutated.iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_stylesheet := item_18.val
		var_allowed_themes.array_set(var_stylesheet, true)
	}
	rt.call_function('update_site_option', [rt.new_string('allowedthemes'),
		var_allowed_themes.clone()])
}

fn Class_WP_Theme.network_disable_theme(var_stylesheets rt.PhpVal) {
	mut var_stylesheets_mutated := var_stylesheets
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return
	}
	if !(var_stylesheets_mutated.clone().is_array()) {
		var_stylesheets_mutated = rt.create_array([
			rt.ArrayItem{ key: none, val: var_stylesheets_mutated },
		])
	}
	mut var_allowed_themes := rt.call_function('get_site_option', [
		rt.new_string('allowedthemes'),
	])
	mut iter_19 := var_stylesheets_mutated.iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_stylesheet := item_19.val
		if var_allowed_themes.array_isset(var_stylesheet) {
			var_allowed_themes.array_unset(var_stylesheet)
		}
	}
	rt.call_function('update_site_option', [rt.new_string('allowedthemes'),
		var_allowed_themes.clone()])
}

fn Class_WP_Theme.sort_by_name(var_themes rt.PhpVal) {
	mut var_themes_mutated := var_themes
	if rt.is_true(rt.call_function('str_starts_with', [
		rt.call_function('get_user_locale', []rt.PhpVal{}),
		rt.new_string('en_'),
	]))
	{
		rt.call_function('uasort', [var_themes_mutated.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Theme' },
				rt.ArrayItem{ key: none, val: '_name_sort' }])])
	} else {
		mut iter_20 := var_themes_mutated.iterator()
		for {
			item_20 := iter_20.next() or { break }
			mut var_theme := item_20.val
			mut var_key := item_20.key
			rt.call_method(var_theme, 'translate_header', [rt.new_string('Name'),
				rt.get_property(var_theme, 'headers').array_get(rt.new_string('Name'))])
		}
		rt.call_function('uasort', [var_themes_mutated.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Theme' },
				rt.ArrayItem{ key: none, val: '_name_sort_i18n' }])])
	}
}

fn Class_WP_Theme._name_sort(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return rt.call_function('strnatcasecmp', [rt.get_property(var_a, 'headers').array_get(rt.new_string('Name')),
		rt.get_property(var_b, 'headers').array_get(rt.new_string('Name'))])
}

fn Class_WP_Theme._name_sort_i18n(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return rt.call_function('strnatcasecmp', [rt.get_property(var_a, 'name_translated'),
		rt.get_property(var_b, 'name_translated')])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_UnexpectedValueException {
	rt.PhpObjectBase
}

fn create_wp_theme(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Theme {
	mut obj := &Class_WP_Theme{
		PhpObjectBase:            rt.PhpObjectBase{}
		update:                   rt.new_bool(false)
		theme_root:               rt.new_null()
		headers:                  rt.new_array()
		headers_sanitized:        rt.new_null()
		block_theme:              rt.new_null()
		name_translated:          rt.new_null()
		errors:                   rt.new_null()
		stylesheet:               rt.new_null()
		template:                 rt.new_null()
		parent:                   rt.new_null()
		theme_root_uri:           rt.new_null()
		textdomain_loaded:        rt.new_null()
		cache_hash:               ''
		block_template_folders:   rt.new_null()
		default_template_folders: rt.new_array()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_unexpectedvalueexception(_args ...rt.PhpVal) &Class_UnexpectedValueException {
	mut obj := &Class_UnexpectedValueException{
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
			return rt.new_string(this.magic_tostring())
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_isset(dispatch_arg_0)
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
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
			return this.offsetget(dispatch_arg_0)
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
			return Class_WP_Theme.scandir(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
		else {
			return none
		}
	}
}

fn (this &Class_WP_Theme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'update' { return this.update }
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
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Theme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'update' {
			this.update = val
			return true
		}
		'theme_root' {
			this.theme_root = val
			return true
		}
		'headers' {
			this.headers = val
			return true
		}
		'headers_sanitized' {
			this.headers_sanitized = val
			return true
		}
		'block_theme' {
			this.block_theme = val
			return true
		}
		'name_translated' {
			this.name_translated = val
			return true
		}
		'errors' {
			this.errors = val
			return true
		}
		'stylesheet' {
			this.stylesheet = val
			return true
		}
		'template' {
			this.template = val
			return true
		}
		'parent' {
			this.parent = val
			return true
		}
		'theme_root_uri' {
			this.theme_root_uri = val
			return true
		}
		'textdomain_loaded' {
			this.textdomain_loaded = val
			return true
		}
		'cache_hash' {
			this.cache_hash = val.str()
			return true
		}
		'block_template_folders' {
			this.block_template_folders = val
			return true
		}
		'default_template_folders' {
			this.default_template_folders = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_UnexpectedValueException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_UnexpectedValueException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_UnexpectedValueException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
