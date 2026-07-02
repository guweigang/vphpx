import rt

struct Class_WP_Customize_Themes_Section {
	rt.PhpObjectBase
pub mut:
	prop_type   rt.PhpVal = rt.new_string('themes')
	action      rt.PhpVal = rt.new_string('')
	filter_type rt.PhpVal = rt.new_string('local')
}

fn (mut this Class_WP_Customize_Themes_Section) json() rt.PhpVal {
	mut var_exported := this.Class_WP_Customize_Section.json()
	var_exported.array_set('action', this.action)
	var_exported.array_set('filter_type', this.filter_type)
	return var_exported.clone()
}

fn (mut this Class_WP_Customize_Themes_Section) render_template() {
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')]))
		|| rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Theme Details')])
	// unsupported statement: Stmt_InlineHTML
	this.filter_bar_content_template()
	// unsupported statement: Stmt_InlineHTML
	this.filter_drawer_content_template()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.'),
		]),
		rt.call_function('__', [
			rt.new_string('https://wordpress.org/support/forums/'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('No themes found. Try a different search.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('No themes found. Try a different search, or %s.'),
		]),
		rt.call_function('sprintf', [
			rt.new_string('<button type="button" class="button-link search-dotorg-themes">%s</button>'),
			rt.call_function('__', [rt.new_string('Search WordPress.org themes')]),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Customize_Themes_Section) filter_bar_content_template() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Go to theme sources')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Search themes')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('The search results will be updated as you type.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Search themes')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('The search results will be updated as you type.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Filter themes')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Filter themes (%s)')]),
		rt.new_string('<span class="theme-filter-count">0</span>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('%s themes')]),
		rt.new_string('<span class="theme-count">0</span>')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Customize_Themes_Section) filter_drawer_content_template() {
	mut var_feature_list := rt.call_function('get_theme_feature_list', [
		rt.new_bool(false),
	])
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_feature_list.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_features := item_1.val
		mut var_feature_name := item_1.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_feature_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
		mut iter_2 := var_features.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_feature_name_shadow := item_2.val
			mut var_feature := item_2.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_feature.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_feature.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_feature.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_feature_name_shadow.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Customize_Section {
	rt.PhpObjectBase
}

fn create_wp_customize_themes_section(_args ...rt.PhpVal) &Class_WP_Customize_Themes_Section {
	mut obj := &Class_WP_Customize_Themes_Section{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('themes')
		action:        rt.new_string('')
		filter_type:   rt.new_string('local')
	}
	return obj
}

fn create_wp_customize_section(_args ...rt.PhpVal) &Class_WP_Customize_Section {
	mut obj := &Class_WP_Customize_Section{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Themes_Section) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'json' {
			return this.json()
		}
		'render_template' {
			this.render_template()
			return rt.new_null()
		}
		'filter_bar_content_template' {
			this.filter_bar_content_template()
			return rt.new_null()
		}
		'filter_drawer_content_template' {
			this.filter_drawer_content_template()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Themes_Section) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'action' { return this.action }
		'filter_type' { return this.filter_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Themes_Section) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'action' {
			this.action = val
			return true
		}
		'filter_type' {
			this.filter_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Customize_Section) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Section) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Section) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
