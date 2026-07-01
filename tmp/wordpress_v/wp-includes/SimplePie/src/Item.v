import rt
import crypto.md5

struct Class_SimplePie_Item {
	rt.PhpObjectBase
pub mut:
		feed rt.PhpVal = rt.new_null()
		data rt.PhpVal = rt.new_array()
		registry rt.PhpVal = rt.new_null()
		sanitize rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Item) construct(mut var_feed Class_SimplePie_SimplePie_SimplePie, mut var_data Class_SimplePie_array)  {
	this.feed = var_feed.dup()
	this.data = var_data.dup()
}

fn (mut this Class_SimplePie_Item) set_registry(mut var_registry Class_SimplePie_SimplePie_Registry)  {
	this.registry = var_registry.dup()
}

fn (mut this Class_SimplePie_Item) magic_tostring() string {
	return md5.hexhash(rt.call_function('serialize', [this.data]).to_string())
}

fn (mut this Class_SimplePie_Item) magic_destruct()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('gc_enabled', []rt.PhpVal{}))))) {
		this.feed = rt.new_null()
	}
}

fn (mut this Class_SimplePie_Item) get_item_tags(namespace string, tag string) rt.PhpVal {
	if this.data.array_get('child').array_get(namespace).array_isset(rt.new_string(tag)) {
		return this.data.array_get('child').array_get(namespace).array_get(tag)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_own_base(mut var_element Class_SimplePie_array) string {
	if !(!rt.is_true(var_element.array_get('xml_base_explicit'))) && var_element.array_isset(rt.new_string('xml_base')) {
		return (var_element.array_get('xml_base')).str()
	}
	return (rt.call_method(this.feed, 'get_base', []rt.PhpVal{})).str()
}

fn (mut this Class_SimplePie_Item) get_base(mut var_element Class_SimplePie_array) rt.PhpVal {
	if !(!rt.is_true(var_element.array_get('xml_base_explicit'))) && var_element.array_isset(rt.new_string('xml_base')) {
		return var_element.array_get('xml_base')
	}
	mut var_link := this.get_permalink()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		return var_link.dup()
	}
	return rt.call_method(this.feed, 'get_base', [var_element])
}

fn (mut this Class_SimplePie_Item) sanitize(data string, type i64, base string) rt.PhpVal {
	mut type_mutated := type
	return rt.call_method(this.feed, 'sanitize', [rt.new_string(data), rt.new_int(type_mutated).dup(), rt.new_string(base)])
}

fn (mut this Class_SimplePie_Item) get_feed() rt.PhpVal {
	return this.feed
}

fn (mut this Class_SimplePie_Item) get_id(hash bool, fn string) rt.PhpVal {
	mut fn_mutated := fn
	if !(var_hash) {
		if rt.is_true(mut var_return := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'id')) {
			return this.sanitize((var_return.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		} else if rt.is_true(var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'id')) {
			return this.sanitize((var_return.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		} else if rt.is_true(var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'guid')) {
			return this.sanitize((var_return.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		} else if rt.is_true(var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'identifier')) {
			return this.sanitize((var_return.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		} else if rt.is_true(var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'identifier')) {
			return this.sanitize((var_return.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		} else if this.data.array_get('attribs').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_isset(rt.new_string('about')) {
			return this.sanitize((this.data.array_get('attribs').array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_get('about')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		}
	}
	if rt.is_true(rt.identical(rt.new_string(fn_mutated), rt.new_bool(false))) {
		return rt.new_null()
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string(fn_mutated).dup()]))))) {
		rt.call_function('trigger_error', [rt.new_string('User-supplied function $fn must be callable'), rt.get_constant('E_USER_WARNING')])
		fn_mutated = 'md5'
	}
	return rt.call_function('call_user_func', [rt.new_string(fn_mutated).dup(), (this.get_permalink()).str() + (this.get_title()).str() + (this.get_content(false)).str()])
}

fn (mut this Class_SimplePie_Item) get_title() rt.PhpVal {
	if !(this.data.array_isset(rt.new_string('title'))) {
		if rt.is_true(mut var_return := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'title')) {
			this.data.array_set('title', this.sanitize((var_return.array_get(0).array_get('data')).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_10_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_return.array_get(0).array_get('attribs') }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(0)))).str()))
		} else if rt.is_true(var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'title')) {
			this.data.array_set('title', this.sanitize((var_return.array_get(0).array_get('data')).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_03_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_return.array_get(0).array_get('attribs') }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(0)))).str()))
		} else if rt.is_true(var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(), 'title')) {
			this.data.array_set('title', this.sanitize((var_return.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_maybe_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(0)))).str()))
		} else if rt.is_true(var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(), 'title')) {
			this.data.array_set('title', this.sanitize((var_return.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_maybe_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(0)))).str()))
		} else if rt.is_true(var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'title')) {
			this.data.array_set('title', this.sanitize((var_return.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_maybe_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(0)))).str()))
		} else if rt.is_true(var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'title')) {
			this.data.array_set('title', this.sanitize((var_return.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		} else if rt.is_true(var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'title')) {
			this.data.array_set('title', this.sanitize((var_return.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		} else {
			this.data.array_set('title', rt.new_null())
		}
	}
	return this.data.array_get('title')
}

fn (mut this Class_SimplePie_Item) get_description(description_only bool) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(mut var_tags := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'summary')) && rt.is_true(mut var_return := this.sanitize((var_tags.array_get(0).array_get('data')).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_10_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_tags.array_get(0).array_get('attribs') }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(0)))).str())))) {
		return var_return.dup()
	} else if rt.is_true(rt.new_bool(rt.is_true(var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'summary')) && rt.is_true(var_return = this.sanitize((var_tags.array_get(0).array_get('data')).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_03_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_tags.array_get(0).array_get('attribs') }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(0)))).str())))) {
		return var_return.dup()
	} else if rt.is_true(rt.new_bool(rt.is_true(var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(), 'description')) && rt.is_true(var_return = this.sanitize((var_tags.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_maybe_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(0)))).str())))) {
		return var_return.dup()
	} else if rt.is_true(rt.new_bool(rt.is_true(var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'description')) && rt.is_true(var_return = this.sanitize((var_tags.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(0)))).str())))) {
		return var_return.dup()
	} else if rt.is_true(rt.new_bool(rt.is_true(var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'description')) && rt.is_true(var_return = this.sanitize((var_tags.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')))) {
		return var_return.dup()
	} else if rt.is_true(rt.new_bool(rt.is_true(var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'description')) && rt.is_true(var_return = this.sanitize((var_tags.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')))) {
		return var_return.dup()
	} else if rt.is_true(rt.new_bool(rt.is_true(var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(), 'summary')) && rt.is_true(var_return = this.sanitize((var_tags.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(0)))).str())))) {
		return var_return.dup()
	} else if rt.is_true(rt.new_bool(rt.is_true(var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(), 'subtitle')) && rt.is_true(var_return = this.sanitize((var_tags.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')))) {
		return var_return.dup()
	} else if rt.is_true(rt.new_bool(rt.is_true(var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(), 'description')) && rt.is_true(var_return = this.sanitize((var_tags.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_html()).to_i64(), '')))) {
		return var_return.dup()
	} else if !(var_description_only) {
		return this.get_content(true)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_content(content_only bool) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(mut var_tags := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'content')) && rt.is_true(mut var_return := this.sanitize((var_tags.array_get(0).array_get('data')).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_10_content_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_tags.array_get(0).array_get('attribs') }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(0)))).str())))) {
		return var_return.dup()
	} else if rt.is_true(rt.new_bool(rt.is_true(var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'content')) && rt.is_true(var_return = this.sanitize((var_tags.array_get(0).array_get('data')).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_03_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_tags.array_get(0).array_get('attribs') }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(0)))).str())))) {
		return var_return.dup()
	} else if rt.is_true(rt.new_bool(rt.is_true(var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10_modules_content()).str(), 'encoded')) && rt.is_true(var_return = this.sanitize((var_tags.array_get(0).array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(0)))).str())))) {
		return var_return.dup()
	} else if !(var_content_only) {
		return this.get_description(true)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_thumbnail() rt.PhpVal {
	if !(this.data.array_isset(rt.new_string('thumbnail'))) {
		if rt.is_true(mut var_return := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).str(), 'thumbnail')) {
			mut var_thumbnail := var_return.array_get(0).array_get('attribs').array_get('')
			if !rt.is_true(var_thumbnail.array_get('url')) {
				this.data.array_set('thumbnail', rt.new_null())
			} else {
				var_thumbnail.array_set('url', this.sanitize((var_thumbnail.array_get('url')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(0)))).str()))
				this.data.array_set('thumbnail', var_thumbnail.dup())
			}
		} else {
			this.data.array_set('thumbnail', rt.new_null())
		}
	}
	return this.data.array_get('thumbnail')
}

fn (mut this Class_SimplePie_Item) get_category(key i64) rt.PhpVal {
	mut var_categories := this.get_categories()
	if var_categories.array_isset(rt.new_int(key)) {
		return var_categories.array_get(key)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_categories() rt.PhpVal {
	mut var_categories := rt.new_array()
	mut var_type := rt.new_string(rt.new_string('category'))
	{
		mut iter_1 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), (var_type).str())).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			mut var_term := rt.new_null()
			mut var_scheme := rt.new_null()
			mut var_label := rt.new_null()
			if var_category.array_get('attribs').array_get('').array_isset(rt.new_string('term')) {
				var_term = this.sanitize((var_category.array_get('attribs').array_get('').array_get('term')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
			if var_category.array_get('attribs').array_get('').array_isset(rt.new_string('scheme')) {
				var_scheme = this.sanitize((var_category.array_get('attribs').array_get('').array_get('scheme')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
			if var_category.array_get('attribs').array_get('').array_isset(rt.new_string('label')) {
				var_label = this.sanitize((var_category.array_get('attribs').array_get('').array_get('label')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
			var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_term }, rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: var_label }, rt.ArrayItem{ key: none, val: var_type }])]))
		}
	}
	{
		mut iter_1 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), (var_type).str())).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			mut var_term := this.sanitize((var_category.array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			if var_category.array_get('attribs').array_get('').array_isset(rt.new_string('domain')) {
				mut var_scheme := this.sanitize((var_category.array_get('attribs').array_get('').array_get('domain')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			} else {
				var_scheme = rt.new_null()
			}
			var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_term }, rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_type }])]))
		}
	}
	var_type = rt.new_string(rt.new_string('subject'))
	{
		mut iter_1 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), (var_type).str())).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_category.array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_type }])]))
		}
	}
	{
		mut iter_1 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), (var_type).str())).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_category.array_get('data')).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_type }])]))
		}
	}
	if !(!rt.is_true(var_categories)) {
		return rt.call_function('array_unique', [var_categories.dup()])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_author(key i64) rt.PhpVal {
	mut var_authors := this.get_authors()
	if var_authors.array_isset(rt.new_int(key)) {
		return var_authors.array_get(key)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_contributor(key i64) rt.PhpVal {
	mut var_contributors := this.get_contributors()
	if var_contributors.array_isset(rt.new_int(key)) {
		return var_contributors.array_get(key)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_contributors() rt.PhpVal {
	mut var_contributors := rt.new_array()
	{
		mut iter_1 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'contributor')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_contributor := item_1.val
			mut var_name := rt.new_null()
			mut var_uri := rt.new_null()
			mut var_email := rt.new_null()
			if .array_get().array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get('name').array_get(0).array_isset(rt.new_string('data')) {
				var_name = this.sanitize((.array_get()).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
			if .array_get().array_get('uri').array_get(0).array_isset(rt.new_string('data')) {
				var_uri = .array_get()
				var_uri = 
			}
			if .array_get().array_isset(rt.new_string('data')) {
				
			}
			if rt.is_true() {
			}
		}
	}
	{
		mut iter_1 := .iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_contributor := item_1.val
		}
	}
}

fn (mut this Class_SimplePie_Item) get_authors() rt.PhpVal {
}

fn (mut this Class_SimplePie_Item) get_copyright() rt.PhpVal {
}

fn (mut this Class_SimplePie_Item) get_date(date_format string) rt.PhpVal {
}

fn (mut this Class_SimplePie_Item) get_updated_date(date_format string) rt.PhpVal {
}

fn (mut this Class_SimplePie_Item) get_local_date(date_format string) rt.PhpVal {
}

fn (mut this Class_SimplePie_Item) get_gmdate(date_format string) rt.PhpVal {
}

fn (mut this Class_SimplePie_Item) get_updated_gmdate(date_format string) rt.PhpVal {
}

fn (mut this Class_SimplePie_Item) get_permalink() rt.PhpVal {
}

fn (mut this Class_SimplePie_Item) get_link(key i64, rel string) rt.PhpVal {
}

fn (mut this Class_SimplePie_Item) get_links(rel string) rt.PhpVal {
}

fn (mut this Class_SimplePie_Item) get_enclosure(key i64) rt.PhpVal {
}

fn (mut this Class_SimplePie_Item) get_enclosures() rt.PhpVal {
}

fn (mut this Class_SimplePie_Item) get_latitude() rt.PhpVal {
	mut var_match := rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_longitude() rt.PhpVal {
	mut var_match := rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_source() rt.PhpVal {
}

fn (mut this Class_SimplePie_Item) set_sanitize(mut var_sanitize Class_SimplePie_Sanitize)  {
}

fn (mut this Class_SimplePie_Item) get_sanitize() rt.PhpVal {
}

fn create_simplepie_item(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_SimplePie_Item {
	mut obj := &Class_SimplePie_Item{
		PhpObjectBase: rt.PhpObjectBase{}
		feed: rt.new_null()
		data: rt.new_array()
		registry: rt.new_null()
		sanitize: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_SimplePie_Item) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_SimplePie_SimplePie](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'set_registry' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_SimplePie_Registry](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_registry(mut dispatch_arg_0)
			return rt.new_null()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'__destruct' {
			this.magic_destruct()
			return rt.new_null()
		}
		'get_item_tags' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_item_tags(dispatch_arg_0, dispatch_arg_1)
		}
		'get_own_base' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_own_base(mut dispatch_arg_0))
		}
		'get_base' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_base(mut dispatch_arg_0)
		}
		'sanitize' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.sanitize(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_feed' {
			return this.get_feed()
		}
		'get_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_id(dispatch_arg_0, dispatch_arg_1)
		}
		'get_title' {
			return this.get_title()
		}
		'get_description' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_description(dispatch_arg_0)
		}
		'get_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_content(dispatch_arg_0)
		}
		'get_thumbnail' {
			return this.get_thumbnail()
		}
		'get_category' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_category(dispatch_arg_0)
		}
		'get_categories' {
			return this.get_categories()
		}
		'get_author' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_author(dispatch_arg_0)
		}
		'get_contributor' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_contributor(dispatch_arg_0)
		}
		'get_contributors' {
			return this.get_contributors()
		}
		'get_authors' {
			return this.get_authors()
		}
		'get_copyright' {
			return this.get_copyright()
		}
		'get_date' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date(dispatch_arg_0)
		}
		'get_updated_date' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_updated_date(dispatch_arg_0)
		}
		'get_local_date' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_local_date(dispatch_arg_0)
		}
		'get_gmdate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_gmdate(dispatch_arg_0)
		}
		'get_updated_gmdate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_updated_gmdate(dispatch_arg_0)
		}
		'get_permalink' {
			return this.get_permalink()
		}
		'get_link' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_link(dispatch_arg_0, dispatch_arg_1)
		}
		'get_links' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_links(dispatch_arg_0)
		}
		'get_enclosure' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_enclosure(dispatch_arg_0)
		}
		'get_enclosures' {
			return this.get_enclosures()
		}
		'get_latitude' {
			return this.get_latitude()
		}
		'get_longitude' {
			return this.get_longitude()
		}
		'get_source' {
			return this.get_source()
		}
		'set_sanitize' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_Sanitize](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_sanitize(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_sanitize' {
			return this.get_sanitize()
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Item) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'feed' { return this.feed }
		'data' { return this.data }
		'registry' { return this.registry }
		'sanitize' { return this.sanitize }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Item) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'feed' { this.feed = val; return true }
		'data' { this.data = val; return true }
		'registry' { this.registry = val; return true }
		'sanitize' { this.sanitize = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_simplepie_src_item_php() {
	// unsupported statement: Stmt_Declare
}
