import rt

struct Class_WP_Sitemaps {
	rt.PhpObjectBase
pub mut:
		index rt.PhpVal = rt.new_null()
		registry rt.PhpVal = rt.new_null()
		renderer rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Sitemaps) construct()  {
	this.registry = create_wp_sitemaps_registry()
	this.renderer = create_wp_sitemaps_renderer()
	this.index = create_wp_sitemaps_index(this.registry)
}

fn (mut this Class_WP_Sitemaps) init()  {
	this.register_rewrites()
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Sitemaps', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_sitemaps' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.sitemaps_enabled())))) {
		return rt.new_null()
	}
	this.register_sitemaps()
	rt.call_function('add_filter', [rt.new_string('robots_txt'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Sitemaps', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_robots' }]), rt.new_int(0), rt.new_int(2)])
}

fn (mut this Class_WP_Sitemaps) sitemaps_enabled() rt.PhpVal {
	mut var_is_enabled := // unsupported expression: Expr_Cast_Bool
	return // unsupported expression: Expr_Cast_Bool
}

fn (mut this Class_WP_Sitemaps) register_sitemaps()  {
	mut var_providers := { 'posts': create_wp_sitemaps_posts(), 'taxonomies': create_wp_sitemaps_taxonomies(), 'users': create_wp_sitemaps_users() }
	for var_name, var_provider in var_providers {
		rt.call_method(this.registry, 'add_provider', [rt.new_string(name), var_provider.dup()])
	}
}

fn (mut this Class_WP_Sitemaps) register_rewrites()  {
	rt.call_function('add_rewrite_tag', [rt.new_string('%sitemap%'), rt.new_string('([^?]+)')])
	rt.call_function('add_rewrite_tag', [rt.new_string('%sitemap-subtype%'), rt.new_string('([^?]+)')])
	rt.call_function('add_rewrite_rule', [rt.new_string('^wp-sitemap\\.xml$'), rt.new_string('index.php?sitemap=index'), rt.new_string('top')])
	rt.call_function('add_rewrite_tag', [rt.new_string('%sitemap-stylesheet%'), rt.new_string('([^?]+)')])
	rt.call_function('add_rewrite_rule', [rt.new_string('^wp-sitemap\\.xsl$'), rt.new_string('index.php?sitemap-stylesheet=sitemap'), rt.new_string('top')])
	rt.call_function('add_rewrite_rule', [rt.new_string('^wp-sitemap-index\\.xsl$'), rt.new_string('index.php?sitemap-stylesheet=index'), rt.new_string('top')])
	rt.call_function('add_rewrite_rule', [rt.new_string('^wp-sitemap-([a-z]+?)-([a-z\\d_-]+?)-(\\d+?)\\.xml$'), rt.new_string('index.php?sitemap=$matches[1]&sitemap-subtype=$matches[2]&paged=$matches[3]'), rt.new_string('top')])
	rt.call_function('add_rewrite_rule', [rt.new_string('^wp-sitemap-([a-z]+?)-(\\d+?)\\.xml$'), rt.new_string('index.php?sitemap=$matches[1]&paged=$matches[2]'), rt.new_string('top')])
}

fn (mut this Class_WP_Sitemaps) render_sitemaps()  {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_sitemap := rt.call_function('sanitize_text_field', [rt.call_function('get_query_var', [rt.new_string('sitemap')])])
	mut var_object_subtype := rt.call_function('sanitize_text_field', [rt.call_function('get_query_var', [rt.new_string('sitemap-subtype')])])
	mut var_stylesheet_type := rt.call_function('sanitize_text_field', [rt.call_function('get_query_var', [rt.new_string('sitemap-stylesheet')])])
	mut var_paged := rt.call_function('absint', [rt.call_function('get_query_var', [rt.new_string('paged')])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(var_sitemap) || rt.is_true(var_stylesheet_type)))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.sitemaps_enabled())))) {
		rt.call_method(var_wp_query, 'set_404', []rt.PhpVal{})
		rt.call_function('status_header', [rt.new_int(404)])
		return rt.new_null()
	}
	if rt.is_true(var_stylesheet_type) {
		mut var_stylesheet := create_wp_sitemaps_stylesheet()
		var_stylesheet.render_stylesheet(var_stylesheet_type.dup())
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.identical(rt.new_string('index'), var_sitemap)) {
		mut var_sitemap_list := rt.call_method(this.index, 'get_sitemap_list', []rt.PhpVal{})
		rt.call_method(this.renderer, 'render_index', [var_sitemap_list.dup()])
		// unsupported expression: Expr_Exit
	}
	mut var_provider := rt.call_method(this.registry, 'get_provider', [var_sitemap.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_provider)))) {
		return rt.new_null()
	}
	if !rt.is_true(var_paged) {
		var_paged = rt.new_int(rt.new_int(1))
	}
	mut var_url_list := rt.call_method(var_provider, 'get_url_list', [var_paged.dup(), var_object_subtype.dup()])
	if !rt.is_true(var_url_list) {
		rt.call_method(var_wp_query, 'set_404', []rt.PhpVal{})
		rt.call_function('status_header', [rt.new_int(404)])
		return rt.new_null()
	}
	rt.call_method(this.renderer, 'render_sitemap', [var_url_list.dup()])
	// unsupported expression: Expr_Exit
}

fn (mut this Class_WP_Sitemaps) redirect_sitemapxml(var_bypass rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('6.7.0')])
	if rt.is_true(var_bypass) {
		return var_bypass.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('sitemap-xml'), rt.call_method(var_query, 'get', [rt.new_string('pagename')]))) || rt.is_true(rt.identical(rt.new_string('sitemap-xml'), rt.call_method(var_query, 'get', [rt.new_string('name')]))))) {
		rt.call_function('wp_safe_redirect', [rt.call_method(this.index, 'get_index_url', []rt.PhpVal{})])
		// unsupported expression: Expr_Exit
	}
	return var_bypass.dup()
}

fn (mut this Class_WP_Sitemaps) add_robots(var_output rt.PhpVal, var_is_public rt.PhpVal) rt.PhpVal {
	if rt.is_true(var_is_public) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_output.dup()
}

struct Class_WP_Sitemaps_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Sitemaps_Renderer {
	rt.PhpObjectBase
}

struct Class_WP_Sitemaps_Index {
	rt.PhpObjectBase
}

struct Class_WP_Sitemaps_Posts {
	rt.PhpObjectBase
}

struct Class_WP_Sitemaps_Taxonomies {
	rt.PhpObjectBase
}

struct Class_WP_Sitemaps_Users {
	rt.PhpObjectBase
}

struct Class_WP_Sitemaps_Stylesheet {
	rt.PhpObjectBase
}

fn create_wp_sitemaps() &Class_WP_Sitemaps {
	mut obj := &Class_WP_Sitemaps{
		PhpObjectBase: rt.PhpObjectBase{}
		index: rt.new_null()
		registry: rt.new_null()
		renderer: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_sitemaps_registry() &Class_WP_Sitemaps_Registry {
	mut obj := &Class_WP_Sitemaps_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_sitemaps_renderer() &Class_WP_Sitemaps_Renderer {
	mut obj := &Class_WP_Sitemaps_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_sitemaps_index() &Class_WP_Sitemaps_Index {
	mut obj := &Class_WP_Sitemaps_Index{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_sitemaps_posts() &Class_WP_Sitemaps_Posts {
	mut obj := &Class_WP_Sitemaps_Posts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_sitemaps_taxonomies() &Class_WP_Sitemaps_Taxonomies {
	mut obj := &Class_WP_Sitemaps_Taxonomies{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_sitemaps_users() &Class_WP_Sitemaps_Users {
	mut obj := &Class_WP_Sitemaps_Users{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_sitemaps_stylesheet() &Class_WP_Sitemaps_Stylesheet {
	mut obj := &Class_WP_Sitemaps_Stylesheet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Sitemaps) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'sitemaps_enabled' {
			return this.sitemaps_enabled()
		}
		'register_sitemaps' {
			this.register_sitemaps()
			return rt.new_null()
		}
		'register_rewrites' {
			this.register_rewrites()
			return rt.new_null()
		}
		'render_sitemaps' {
			this.render_sitemaps()
			return rt.new_null()
		}
		'redirect_sitemapxml' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.redirect_sitemapxml(dispatch_arg_0, dispatch_arg_1)
		}
		'add_robots' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_robots(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WP_Sitemaps) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'index' { return this.index }
		'registry' { return this.registry }
		'renderer' { return this.renderer }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Sitemaps) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'index' { this.index = val; return true }
		'registry' { this.registry = val; return true }
		'renderer' { this.renderer = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Sitemaps_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Sitemaps_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Sitemaps_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Sitemaps_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Sitemaps_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Sitemaps_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Sitemaps_Index) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Sitemaps_Index) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Sitemaps_Index) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Sitemaps_Posts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Sitemaps_Posts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Sitemaps_Posts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Sitemaps_Taxonomies) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Sitemaps_Taxonomies) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Sitemaps_Taxonomies) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Sitemaps_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Sitemaps_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Sitemaps_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Sitemaps_Stylesheet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Sitemaps_Stylesheet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Sitemaps_Stylesheet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sitemaps_class_wp_sitemaps_php() {
}
