import rt

struct Class_WP_Sitemaps_Renderer {
	rt.PhpObjectBase
pub mut:
	stylesheet       rt.PhpVal = rt.new_string('')
	stylesheet_index rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WP_Sitemaps_Renderer) construct() {
	mut var_stylesheet_url := this.get_sitemap_stylesheet_url()
	if rt.is_true(var_stylesheet_url) {
		this.stylesheet = '<?xml-stylesheet type="text/xsl" href="' +
			(rt.call_function('esc_url', [var_stylesheet_url.clone()])).str() + '" ?>'
	}
	mut var_stylesheet_index_url := this.get_sitemap_index_stylesheet_url()
	if rt.is_true(var_stylesheet_index_url) {
		this.stylesheet_index = '<?xml-stylesheet type="text/xsl" href="' +
			(rt.call_function('esc_url', [var_stylesheet_index_url.clone()])).str() + '" ?>'
	}
}

fn (mut this Class_WP_Sitemaps_Renderer) get_sitemap_stylesheet_url() rt.PhpVal {
	mut var_wp_rewrite := rt.new_null()
	mut var_sitemap_url := rt.call_function('home_url', [
		rt.new_string('/wp-sitemap.xsl'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks',
		[]rt.PhpVal{})))))
	{
		var_sitemap_url = rt.call_function('home_url', [
			rt.new_string('/?sitemap-stylesheet=sitemap'),
		])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('wp_sitemaps_stylesheet_url'),
		var_sitemap_url.clone(),
	])
}

fn (mut this Class_WP_Sitemaps_Renderer) get_sitemap_index_stylesheet_url() rt.PhpVal {
	mut var_wp_rewrite := rt.new_null()
	mut var_sitemap_url := rt.call_function('home_url', [
		rt.new_string('/wp-sitemap-index.xsl'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks',
		[]rt.PhpVal{})))))
	{
		var_sitemap_url = rt.call_function('home_url', [
			rt.new_string('/?sitemap-stylesheet=index'),
		])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('wp_sitemaps_stylesheet_index_url'),
		var_sitemap_url.clone(),
	])
}

fn (mut this Class_WP_Sitemaps_Renderer) render_index(var_sitemaps rt.PhpVal) {
	rt.call_function('header', [
		rt.new_string('Content-Type: application/xml; charset=UTF-8'),
	])
	this.check_for_simple_xml_availability()
	mut var_index_xml := this.get_sitemap_index_xml(var_sitemaps.clone())
	if !(!rt.is_true(var_index_xml)) {
		rt.echo_val(var_index_xml)
	}
}

fn (mut this Class_WP_Sitemaps_Renderer) get_sitemap_index_xml(var_sitemaps rt.PhpVal) rt.PhpVal {
	mut var_sitemap_index := create_simplexmlelement(rt.call_function('sprintf', [
		rt.new_string('%1$s%2$s%3$s'),
		rt.new_string('<?xml version="1.0" encoding="UTF-8" ?>'),
		this.stylesheet_index,
		rt.new_string('<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" />'),
	]))
	mut iter_1 := var_sitemaps.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_entry := item_1.val
		mut var_sitemap := var_sitemap_index.addchild(rt.new_string('sitemap'))
		mut iter_2 := var_entry.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_value := item_2.val
			mut var_name := item_2.key
			if rt.is_true(rt.identical(rt.new_string('loc'), var_name)) {
				rt.call_method(var_sitemap, 'addChild', [var_name.clone(),
					rt.call_function('esc_url', [var_value.clone()])])
			} else if rt.is_true(rt.identical(rt.new_string('lastmod'), var_name)) {
				rt.call_method(var_sitemap, 'addChild', [var_name.clone(),
					rt.call_function('esc_xml', [var_value.clone()])])
			} else {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Fields other than %s are not currently supported for the sitemap index.'),
						]),
						rt.call_function('implode', [
							rt.new_string(','),
							rt.create_array([rt.ArrayItem{ key: none, val: 'loc' },
								rt.ArrayItem{ key: none, val: 'lastmod' }]),
						]),
					]),
					rt.new_string('5.5.0')])
			}
		}
	}
	return var_sitemap_index.asxml()
}

fn (mut this Class_WP_Sitemaps_Renderer) render_sitemap(var_url_list rt.PhpVal) {
	rt.call_function('header', [
		rt.new_string('Content-Type: application/xml; charset=UTF-8'),
	])
	this.check_for_simple_xml_availability()
	mut var_sitemap_xml := this.get_sitemap_xml(var_url_list.clone())
	if !(!rt.is_true(var_sitemap_xml)) {
		rt.echo_val(var_sitemap_xml)
	}
}

fn (mut this Class_WP_Sitemaps_Renderer) get_sitemap_xml(var_url_list rt.PhpVal) rt.PhpVal {
	mut var_urlset := create_simplexmlelement(rt.call_function('sprintf', [
		rt.new_string('%1$s%2$s%3$s'),
		rt.new_string('<?xml version="1.0" encoding="UTF-8" ?>'),
		this.stylesheet,
		rt.new_string('<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" />'),
	]))
	mut iter_3 := var_url_list.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_url_item := item_3.val
		mut var_url := var_urlset.addchild(rt.new_string('url'))
		mut iter_4 := var_url_item.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_value := item_4.val
			mut var_name := item_4.key
			if rt.is_true(rt.identical(rt.new_string('loc'), var_name)) {
				rt.call_method(var_url, 'addChild', [var_name.clone(),
					rt.call_function('esc_url', [var_value.clone()])])
			} else if rt.is_true(rt.call_function('in_array', [
				var_name.clone(),
				rt.create_array([
					rt.ArrayItem{ key: none, val: 'lastmod' },
					rt.ArrayItem{ key: none, val: 'changefreq' },
					rt.ArrayItem{ key: none, val: 'priority' },
				]),
				rt.new_bool(true)]))
			{
				rt.call_method(var_url, 'addChild', [var_name.clone(),
					rt.call_function('esc_xml', [var_value.clone()])])
			} else {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Fields other than %s are not currently supported for sitemaps.'),
						]),
						rt.call_function('implode', [
							rt.new_string(','),
							rt.create_array([rt.ArrayItem{ key: none, val: 'loc' },
								rt.ArrayItem{ key: none, val: 'lastmod' },
								rt.ArrayItem{ key: none, val: 'changefreq' },
								rt.ArrayItem{ key: none, val: 'priority' }]),
						]),
					]),
					rt.new_string('5.5.0')])
			}
		}
	}
	return var_urlset.asxml()
}

fn (mut this Class_WP_Sitemaps_Renderer) check_for_simple_xml_availability() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('SimpleXMLElement'),
	])))))
	{
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			return
		}
		rt.call_function('add_filter', [rt.new_string('wp_die_handler'),
			rt.new_closure(closure_1_fn)])
		rt.call_function('wp_die', [
			rt.call_function('sprintf', [
				rt.call_function('esc_xml', [
					rt.call_function('__', [
						rt.new_string('Could not generate XML sitemap due to missing %s extension'),
					]),
				]),
				rt.new_string('SimpleXML'),
			]),
			rt.call_function('esc_xml', [
				rt.call_function('__', [
					rt.new_string('WordPress &rsaquo; Error'),
				]),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'response', val: 501 },
			]),
		])
	}
}

struct Class_SimpleXMLElement {
	rt.PhpObjectBase
}

fn create_wp_sitemaps_renderer() &Class_WP_Sitemaps_Renderer {
	mut obj := &Class_WP_Sitemaps_Renderer{
		PhpObjectBase:    rt.PhpObjectBase{}
		stylesheet:       rt.new_string('')
		stylesheet_index: rt.new_string('')
	}
	obj.construct()
	return obj
}

fn create_simplexmlelement(_args ...rt.PhpVal) &Class_SimpleXMLElement {
	mut obj := &Class_SimpleXMLElement{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Sitemaps_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_sitemap_stylesheet_url' {
			return this.get_sitemap_stylesheet_url()
		}
		'get_sitemap_index_stylesheet_url' {
			return this.get_sitemap_index_stylesheet_url()
		}
		'render_index' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.render_index(dispatch_arg_0)
			return rt.new_null()
		}
		'get_sitemap_index_xml' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_sitemap_index_xml(dispatch_arg_0)
		}
		'render_sitemap' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.render_sitemap(dispatch_arg_0)
			return rt.new_null()
		}
		'get_sitemap_xml' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_sitemap_xml(dispatch_arg_0)
		}
		'check_for_simple_xml_availability' {
			this.check_for_simple_xml_availability()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Sitemaps_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'stylesheet' { return this.stylesheet }
		'stylesheet_index' { return this.stylesheet_index }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Sitemaps_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'stylesheet' {
			this.stylesheet = val
			return true
		}
		'stylesheet_index' {
			this.stylesheet_index = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_SimpleXMLElement) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimpleXMLElement) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimpleXMLElement) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
