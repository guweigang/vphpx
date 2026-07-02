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

fn (mut this Class_SimplePie_Item) construct(mut var_feed Class_SimplePie_SimplePie_SimplePie, mut var_data Class_SimplePie_array) {
	this.feed = var_feed
	this.data = var_data
}

fn (mut this Class_SimplePie_Item) set_registry(mut var_registry Class_SimplePie_SimplePie_Registry) {
	this.registry = var_registry
}

fn (mut this Class_SimplePie_Item) magic_tostring() string {
	return md5.hexhash(rt.call_function('serialize', [this.data]).to_string())
}

fn (mut this Class_SimplePie_Item) magic_destruct() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('gc_enabled', []rt.PhpVal{}))))) {
		this.feed = rt.new_null()
	}
}

fn (mut this Class_SimplePie_Item) get_item_tags(namespace string, tag string) rt.PhpVal {
	if this.data.array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_isset(rt.new_string(tag)) {
		return this.data.array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_get(rt.new_string(tag))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_own_base(mut var_element Class_SimplePie_array) string {
	if !(!rt.is_true(var_element.array_get(rt.new_string('xml_base_explicit')))) && var_element.array_isset(rt.new_string('xml_base')) {
		return (var_element.array_get(rt.new_string('xml_base'))).str()
	}
	return (rt.call_method(this.feed, 'get_base', []rt.PhpVal{})).str()
}

fn (mut this Class_SimplePie_Item) get_base(mut var_element Class_SimplePie_array) rt.PhpVal {
	if !(!rt.is_true(var_element.array_get(rt.new_string('xml_base_explicit')))) && var_element.array_isset(rt.new_string('xml_base')) {
		return var_element.array_get(rt.new_string('xml_base'))
	}
	mut var_link := this.get_permalink()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_link, rt.new_null())))) {
		return var_link.clone()
	}
	return rt.call_method(this.feed, 'get_base', [var_element])
}

fn (mut this Class_SimplePie_Item) sanitize(data string, type i64, base string) rt.PhpVal {
	mut type_mutated := type
	return rt.call_method(this.feed, 'sanitize', [rt.new_string(data), rt.new_int(type_mutated).clone(), rt.new_string(base)])
}

fn (mut this Class_SimplePie_Item) get_feed() rt.PhpVal {
	return this.feed
}

fn (mut this Class_SimplePie_Item) get_id(hash bool, fn string) rt.PhpVal {
	mut fn_mutated := fn
	if !(var_hash) {
		mut var_return := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'id')
		if rt.is_true(var_return) {
			return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'id')
		} else if rt.is_true(var_return) {
			return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'guid')
		} else if rt.is_true(var_return) {
			return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'identifier')
		} else if rt.is_true(var_return) {
			return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'identifier')
		} else if rt.is_true(var_return) {
			return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		} else if this.data.array_get(rt.new_string('attribs')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_isset(rt.new_string('about')) {
			return this.sanitize((this.data.array_get(rt.new_string('attribs')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('about'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		}
	}
	if rt.is_true(rt.identical(rt.new_string(fn_mutated), rt.new_bool(false))) {
		return rt.new_null()
	} else if !(rt.call_function('is_callable', [rt.new_string(fn_mutated).clone()])) {
		rt.call_function('trigger_error', [rt.new_string('User-supplied function $fn must be callable'), rt.get_constant('E_USER_WARNING')])
	fn_mutated = 'md5'
	}
	return rt.call_function('call_user_func', [rt.new_string(fn_mutated).clone(), rt.new_string((this.get_permalink()).str() + (this.get_title()).str() + (this.get_content(false)).str())])
}

fn (mut this Class_SimplePie_Item) get_title() rt.PhpVal {
	if !(this.data.array_isset(rt.new_string('title'))) {
		mut var_return := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'title')
		if rt.is_true(var_return) {
			this.data.array_set('title', this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_10_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')) }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'title')
		} else if rt.is_true(var_return) {
			this.data.array_set('title', this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_03_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')) }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(), 'title')
		} else if rt.is_true(var_return) {
			this.data.array_set('title', this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_maybe_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(), 'title')
		} else if rt.is_true(var_return) {
			this.data.array_set('title', this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_maybe_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'title')
		} else if rt.is_true(var_return) {
			this.data.array_set('title', this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_maybe_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'title')
		} else if rt.is_true(var_return) {
			this.data.array_set('title', this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'title')
		} else if rt.is_true(var_return) {
			this.data.array_set('title', this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		} else {
			this.data.array_set('title', rt.new_null())
		}
	}
	return this.data.array_get(rt.new_string('title'))
}

fn (mut this Class_SimplePie_Item) get_description(description_only bool) rt.PhpVal {
	mut var_tags := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'summary')
	mut var_return := this.sanitize((var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_10_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')) }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(rt.new_int(0))))).str())
	if rt.is_true(var_tags) && rt.is_true(var_return) {
		return var_return.clone()
	var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'summary')
	var_return = this.sanitize((var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_03_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')) }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(rt.new_int(0))))).str())
	} else if rt.is_true(var_tags) && rt.is_true(var_return) {
		return var_return.clone()
	var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(), 'description')
	var_return = this.sanitize((var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_maybe_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(rt.new_int(0))))).str())
	} else if rt.is_true(var_tags) && rt.is_true(var_return) {
		return var_return.clone()
	var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'description')
	var_return = this.sanitize((var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(rt.new_int(0))))).str())
	} else if rt.is_true(var_tags) && rt.is_true(var_return) {
		return var_return.clone()
	var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'description')
	var_return = this.sanitize((var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
	} else if rt.is_true(var_tags) && rt.is_true(var_return) {
		return var_return.clone()
	var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'description')
	var_return = this.sanitize((var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
	} else if rt.is_true(var_tags) && rt.is_true(var_return) {
		return var_return.clone()
	var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(), 'summary')
	var_return = this.sanitize((var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(rt.new_int(0))))).str())
	} else if rt.is_true(var_tags) && rt.is_true(var_return) {
		return var_return.clone()
	var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(), 'subtitle')
	var_return = this.sanitize((var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
	} else if rt.is_true(var_tags) && rt.is_true(var_return) {
		return var_return.clone()
	var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(), 'description')
	var_return = this.sanitize((var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_html()).to_i64(), '')
	} else if rt.is_true(var_tags) && rt.is_true(var_return) {
		return var_return.clone()
	} else if !(var_description_only) {
		return this.get_content(true)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_content(content_only bool) rt.PhpVal {
	mut var_tags := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'content')
	mut var_return := this.sanitize((var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_10_content_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')) }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(rt.new_int(0))))).str())
	if rt.is_true(var_tags) && rt.is_true(var_return) {
		return var_return.clone()
	var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'content')
	var_return = this.sanitize((var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_03_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')) }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(rt.new_int(0))))).str())
	} else if rt.is_true(var_tags) && rt.is_true(var_return) {
		return var_return.clone()
	var_tags = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10_modules_content()).str(), 'encoded')
	var_return = this.sanitize((var_tags.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_tags.array_get(rt.new_int(0))))).str())
	} else if rt.is_true(var_tags) && rt.is_true(var_return) {
		return var_return.clone()
	} else if !(var_content_only) {
		return this.get_description(true)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_thumbnail() rt.PhpVal {
	if !(this.data.array_isset(rt.new_string('thumbnail'))) {
		mut var_return := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).str(), 'thumbnail')
		if rt.is_true(var_return) {
			mut var_thumbnail := var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string(''))
			if !rt.is_true(var_thumbnail.array_get(rt.new_string('url'))) {
				this.data.array_set('thumbnail', rt.new_null())
			} else {
				var_thumbnail.array_set('url', this.sanitize((var_thumbnail.array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
				this.data.array_set('thumbnail', var_thumbnail.clone())
			}
		} else {
			this.data.array_set('thumbnail', rt.new_null())
		}
	}
	return this.data.array_get(rt.new_string('thumbnail'))
}

fn (mut this Class_SimplePie_Item) get_category(key i64) rt.PhpVal {
	mut var_categories := this.get_categories()
	if var_categories.array_isset(rt.new_int(key)) {
		return var_categories.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_categories() rt.PhpVal {
	mut var_categories := rt.new_array()
	mut var_type := rt.new_string('category')
	mut iter_1 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), (var_type).str())).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_category := item_1.val
		mut var_term := rt.new_null()
		mut var_scheme := rt.new_null()
		mut var_label := rt.new_null()
		if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('term')) {
		var_term = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('term'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		}
		if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
		var_scheme = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		}
		if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('label')) {
		var_label = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('label'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		}
		var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_term }, rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: var_label }, rt.ArrayItem{ key: none, val: var_type }])]))
	}
	mut iter_2 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), (var_type).str())).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_category := item_2.val
		mut var_term := this.sanitize((var_category.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('domain')) {
		mut var_scheme := this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('domain'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		} else {
		var_scheme = rt.new_null()
		}
		var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_term }, rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_type }])]))
	}
	var_type = rt.new_string('subject')
	mut iter_3 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), (var_type).str())).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_category := item_3.val
		var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_category.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_type }])]))
	}
	mut iter_4 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), (var_type).str())).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_category := item_4.val
		var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_category.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_type }])]))
	}
	if !(!rt.is_true(var_categories)) {
		return rt.call_function('array_unique', [var_categories.clone()])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_author(key i64) rt.PhpVal {
	mut var_authors := this.get_authors()
	if var_authors.array_isset(rt.new_int(key)) {
		return var_authors.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_contributor(key i64) rt.PhpVal {
	mut var_contributors := this.get_contributors()
	if var_contributors.array_isset(rt.new_int(key)) {
		return var_contributors.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_contributors() rt.PhpVal {
	mut var_contributors := rt.new_array()
	mut iter_5 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'contributor')).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_contributor := item_5.val
		mut var_name := rt.new_null()
		mut var_uri := rt.new_null()
		mut var_email := rt.new_null()
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_name = this.sanitize((var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		}
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('uri')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_uri = var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('uri')).array_get(rt.new_int(0))
		var_uri = this.sanitize((var_uri.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_uri))).str())
		}
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_email = this.sanitize((var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_email, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_uri, rt.new_null())))) {
			var_contributors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_uri }, rt.ArrayItem{ key: none, val: var_email }])]))
		}
	}
	mut iter_6 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'contributor')).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_contributor := item_6.val
		mut var_name := rt.new_null()
		mut var_url := rt.new_null()
		mut var_email := rt.new_null()
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_name = this.sanitize((var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		}
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('url')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_url = var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('url')).array_get(rt.new_int(0))
		var_url = this.sanitize((var_url.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_url))).str())
		}
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_email = this.sanitize((var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_email, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_url, rt.new_null())))) {
			var_contributors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_url }, rt.ArrayItem{ key: none, val: var_email }])]))
		}
	}
	if !(!rt.is_true(var_contributors)) {
		return rt.call_function('array_unique', [var_contributors.clone()])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_authors() rt.PhpVal {
	mut var_authors := rt.new_array()
	mut iter_7 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'author')).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_author := item_7.val
		mut var_name := rt.new_null()
		mut var_uri := rt.new_null()
		mut var_email := rt.new_null()
		if var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_name = this.sanitize((var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		}
		if var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('uri')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_uri = var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('uri')).array_get(rt.new_int(0))
		var_uri = this.sanitize((var_uri.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_uri))).str())
		}
		if var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_email = this.sanitize((var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_email, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_uri, rt.new_null())))) {
			var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_uri }, rt.ArrayItem{ key: none, val: var_email }])]))
		}
	}
	mut var_author := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'author')
	if rt.is_true(var_author) {
		mut var_name := rt.new_null()
		mut var_url := rt.new_null()
		mut var_email := rt.new_null()
		if var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_name = this.sanitize((var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		}
		if var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('url')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_url = var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('url')).array_get(rt.new_int(0))
		var_url = this.sanitize((var_url.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_url))).str())
		}
		if var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_email = this.sanitize((var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_email, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_url, rt.new_null())))) {
			var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_url }, rt.ArrayItem{ key: none, val: var_email }])]))
		}
	}
	var_author = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'author')
	if rt.is_true(var_author) {
		var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: this.sanitize((var_author.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '') }])]))
	}
	mut iter_8 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'creator')).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_author_shadow := item_8.val
		var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_author_shadow.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }])]))
	}
	mut iter_9 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'creator')).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_author_shadow := item_9.val
		var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_author_shadow.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }])]))
	}
	mut iter_10 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(), 'author')).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_author_shadow := item_10.val
		var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_author_shadow.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }])]))
	}
	if !(!rt.is_true(var_authors)) {
		return rt.call_function('array_unique', [var_authors.clone()])
	mut var_source := this.get_source()
	var_authors = rt.call_method(var_source, 'get_authors', []rt.PhpVal{})
	} else if rt.is_true(var_source) && rt.is_true(var_authors) {
		return var_authors.clone()
	var_authors = rt.call_method(this.feed, 'get_authors', []rt.PhpVal{})
	} else if rt.is_true(var_authors) {
		return var_authors.clone()
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_copyright() rt.PhpVal {
	mut var_return := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'rights')
	if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_10_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')) }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str())
	var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'rights')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
	var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'rights')
	} else if rt.is_true(var_return) {
		return this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_date(date_format string) rt.PhpVal {
	if !(this.data.array_isset(rt.new_string('date'))) {
		mut var_return := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'published')
		if rt.is_true(var_return) {
			this.data.array_get_mut('date').array_set('raw', var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')))
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'pubDate')
		} else if rt.is_true(var_return) {
			this.data.array_get_mut('date').array_set('raw', var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')))
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'date')
		} else if rt.is_true(var_return) {
			this.data.array_get_mut('date').array_set('raw', var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')))
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'date')
		} else if rt.is_true(var_return) {
			this.data.array_get_mut('date').array_set('raw', var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')))
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'updated')
		} else if rt.is_true(var_return) {
			this.data.array_get_mut('date').array_set('raw', var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')))
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'issued')
		} else if rt.is_true(var_return) {
			this.data.array_get_mut('date').array_set('raw', var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')))
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'created')
		} else if rt.is_true(var_return) {
			this.data.array_get_mut('date').array_set('raw', var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')))
		var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'modified')
		} else if rt.is_true(var_return) {
			this.data.array_get_mut('date').array_set('raw', var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')))
		}
		if !(!rt.is_true(this.data.array_get(rt.new_string('date')).array_get(rt.new_string('raw')))) {
			mut var_parser := rt.call_method(this.registry, 'call', [Class_SimplePie_Parse_Date.class(), rt.new_string('get')])
			this.data.array_get_mut('date').array_set('parsed', if rt.is_true(rt.call_method(var_parser, 'parse', [this.data.array_get(rt.new_string('date')).array_get(rt.new_string('raw'))])) { rt.call_method(var_parser, 'parse', [this.data.array_get(rt.new_string('date')).array_get(rt.new_string('raw'))]) } else { rt.new_null() })
		} else {
			this.data.array_set('date', rt.new_null())
		}
	}
	if rt.is_true(this.data.array_get(rt.new_string('date'))) {
		mut switch_val_1 := rt.new_string(date_format)
		if rt.is_true(rt.equal(switch_val_1, rt.new_string(''))) {
			return this.sanitize((this.data.array_get(rt.new_string('date')).array_get(rt.new_string('raw'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('U'))) {
			return this.data.array_get(rt.new_string('date')).array_get(rt.new_string('parsed'))
		} else {
			return rt.call_function('date', [rt.new_string(date_format), this.data.array_get(rt.new_string('date')).array_get(rt.new_string('parsed'))])
		}
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_updated_date(date_format string) rt.PhpVal {
	if !(this.data.array_isset(rt.new_string('updated'))) {
		mut var_return := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'updated')
		if rt.is_true(var_return) {
			this.data.array_get_mut('updated').array_set('raw', var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')))
		}
		if !(!rt.is_true(this.data.array_get(rt.new_string('updated')).array_get(rt.new_string('raw')))) {
			mut var_parser := rt.call_method(this.registry, 'call', [Class_SimplePie_Parse_Date.class(), rt.new_string('get')])
			this.data.array_get_mut('updated').array_set('parsed', if rt.is_true(rt.call_method(var_parser, 'parse', [this.data.array_get(rt.new_string('updated')).array_get(rt.new_string('raw'))])) { rt.call_method(var_parser, 'parse', [this.data.array_get(rt.new_string('updated')).array_get(rt.new_string('raw'))]) } else { rt.new_null() })
		} else {
			this.data.array_set('updated', rt.new_null())
		}
	}
	if rt.is_true(this.data.array_get(rt.new_string('updated'))) {
		mut switch_val_2 := rt.new_string(date_format)
		if rt.is_true(rt.equal(switch_val_2, rt.new_string(''))) {
			return this.sanitize((this.data.array_get(rt.new_string('updated')).array_get(rt.new_string('raw'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('U'))) {
			return this.data.array_get(rt.new_string('updated')).array_get(rt.new_string('parsed'))
		} else {
			return rt.call_function('date', [rt.new_string(date_format), this.data.array_get(rt.new_string('updated')).array_get(rt.new_string('parsed'))])
		}
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_local_date(date_format string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string(date_format), rt.new_string(''))) {
		mut var_raw_date := this.get_date('')
		if rt.is_true(rt.identical(var_raw_date, rt.new_null())) {
			return rt.new_null()
		}
		return this.sanitize((var_raw_date).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
	mut var_date := this.get_date('U')
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_date, rt.new_null())))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_date, rt.new_bool(false))))) {
		return rt.call_function('strftime', [rt.new_string(date_format), var_date.clone()])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_gmdate(date_format string) rt.PhpVal {
	mut var_date := this.get_date('U')
	if rt.is_true(rt.identical(var_date, rt.new_null())) {
		return rt.new_null()
	}
	return rt.call_function('gmdate', [rt.new_string(date_format), var_date.clone()])
}

fn (mut this Class_SimplePie_Item) get_updated_gmdate(date_format string) rt.PhpVal {
	mut var_date := this.get_updated_date('U')
	if rt.is_true(rt.identical(var_date, rt.new_null())) {
		return rt.new_null()
	}
	return rt.call_function('gmdate', [rt.new_string(date_format), var_date.clone()])
}

fn (mut this Class_SimplePie_Item) get_permalink() rt.PhpVal {
	mut var_link := this.get_link(0, '')
	mut var_enclosure := this.get_enclosure(0)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_link, rt.new_null())))) {
		return var_link.clone()
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_enclosure, rt.new_null())))) {
		return rt.call_method(var_enclosure, 'get_link', []rt.PhpVal{})
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_link(key i64, rel string) rt.PhpVal {
	mut var_links := this.get_links(rel)
	if rt.is_true(var_links) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_links.array_get(rt.new_int(key)), rt.new_null())))) {
		return var_links.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_links(rel string) rt.PhpVal {
	if !(this.data.array_isset(rt.new_string('links'))) {
		this.data.array_set('links', rt.new_array())
		mut iter_11 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'link')).iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_link := item_11.val
			if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('href')) {
				mut var_link_rel := if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('rel')) { var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('rel')) } else { rt.new_string('alternate') }
				this.data.array_get_mut('links').array_get_mut(var_link_rel).array_push(this.sanitize((var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('href'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_link))))
			}
		}
		mut iter_12 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'link')).iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_link := item_12.val
			if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('href')) {
				mut var_link_rel := if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('rel')) { var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('rel')) } else { rt.new_string('alternate') }
				this.data.array_get_mut('links').array_get_mut(var_link_rel).array_push(this.sanitize((var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('href'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_link))))
			}
		}
		mut var_links := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(), 'link')
		if rt.is_true(var_links) {
			this.data.array_get_mut('links').array_get_mut('alternate').array_push(this.sanitize((var_links.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_links.array_get(rt.new_int(0))))))
		}
		var_links = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(), 'link')
		if rt.is_true(var_links) {
			this.data.array_get_mut('links').array_get_mut('alternate').array_push(this.sanitize((var_links.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_links.array_get(rt.new_int(0))))))
		}
		var_links = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'link')
		if rt.is_true(var_links) {
			this.data.array_get_mut('links').array_get_mut('alternate').array_push(this.sanitize((var_links.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_links.array_get(rt.new_int(0))))))
		}
		var_links = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'guid')
		if rt.is_true(var_links) {
			if !(var_links.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('isPermaLink'))) || rt.is_true(rt.identical(rt.new_string(var_links.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('isPermaLink')).to_string().trim_space().to_lower()), rt.new_string('true'))) {
				this.data.array_get_mut('links').array_get_mut('alternate').array_push(this.sanitize((var_links.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_links.array_get(rt.new_int(0))))))
			}
		}
		mut var_keys := rt.func_array_keys(this.data.array_get(rt.new_string('links')))
		mut iter_13 := var_keys.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_key := item_13.val
			if rt.is_true(rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('is_isegment_nz_nc'), rt.create_array([rt.ArrayItem{ key: none, val: var_key }])])) {
				if this.data.array_get(rt.new_string('links')).array_isset((Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()).str() + (var_key).str()) {
					this.data.array_get_mut('links').array_set((Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()).str() + (var_key).str(), rt.call_function('array_merge', [this.data.array_get(rt.new_string('links')).array_get(var_key), this.data.array_get(rt.new_string('links')).array_get(rt.new_string((Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()).str() + (var_key).str()))]))
					this.data.array_get(rt.new_string('links')).array_get(var_key) = this.data.array_get(rt.new_string('links')).array_get(rt.new_string((Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()).str() + (var_key).str()))
				} else {
					this.data.array_get(rt.new_string('links')).array_get(rt.new_string((Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()).str() + (var_key).str())) = this.data.array_get(rt.new_string('links')).array_get(var_key)
				}
			} else if rt.is_true(rt.identical(rt.call_function('substr', [rt.new_string((var_key).str()), rt.new_int(0), rt.new_int(41)]), Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry())) {
				this.data.array_get(rt.new_string('links')).array_get(rt.call_function('substr', [rt.new_string((var_key).str()), rt.new_int(41)])) = this.data.array_get(rt.new_string('links')).array_get(var_key)
			}
			this.data.array_get_mut('links').array_set(var_key, rt.call_function('array_unique', [this.data.array_get(rt.new_string('links')).array_get(var_key)]))
		}
	}
	if this.data.array_get(rt.new_string('links')).array_isset(rt.new_string(rel)) {
		return this.data.array_get(rt.new_string('links')).array_get(rt.new_string(rel))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_enclosure(key i64) rt.PhpVal {
	mut var_enclosures := this.get_enclosures()
	if var_enclosures.array_isset(rt.new_int(key)) {
		return var_enclosures.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_enclosures() rt.PhpVal {
	if !(this.data.array_isset(rt.new_string('enclosures'))) {
		this.data.array_set('enclosures', rt.new_array())
		mut var_captions_parent := rt.new_null()
		mut var_categories_parent := rt.new_null()
		mut var_copyrights_parent := rt.new_null()
		mut var_credits_parent := rt.new_null()
		mut var_description_parent := rt.new_null()
		mut var_duration_parent := rt.new_null()
		mut var_hashes_parent := rt.new_null()
		mut var_keywords_parent := rt.new_null()
		mut var_player_parent := rt.new_null()
		mut var_ratings_parent := rt.new_null()
		mut var_restrictions_parent := rt.new_array()
		mut var_thumbnails_parent := rt.new_null()
		mut var_title_parent := rt.new_null()
		mut var_parent := this.get_feed()
		mut var_captions := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).str(), 'text')
		if rt.is_true(var_captions) {
			mut iter_14 := var_captions.iterator()
			for {
				item_14 := iter_14.next() or { break }
				mut var_caption := item_14.val
				mut var_caption_type := rt.new_null()
				mut var_caption_lang := rt.new_null()
				mut var_caption_startTime := rt.new_null()
				mut var_caption_endTime := rt.new_null()
				mut var_caption_text := rt.new_null()
				if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('type')) {
				var_caption_type = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('type'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('lang')) {
				var_caption_lang = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('lang'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('start')) {
				var_caption_startTime = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('start'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('end')) {
				var_caption_endTime = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('end'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_caption.array_isset(rt.new_string('data')) {
				var_caption_text = this.sanitize((var_caption.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				var_captions_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Caption.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_caption_type }, rt.ArrayItem{ key: none, val: var_caption_lang }, rt.ArrayItem{ key: none, val: var_caption_startTime }, rt.ArrayItem{ key: none, val: var_caption_endTime }, rt.ArrayItem{ key: none, val: var_caption_text }])]))
			}
		var_captions = rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_mediarss(), rt.new_string('text')])
		} else if rt.is_true(var_captions) {
			mut iter_15 := var_captions.iterator()
			for {
				item_15 := iter_15.next() or { break }
				mut var_caption := item_15.val
				mut var_caption_type := rt.new_null()
				mut var_caption_lang := rt.new_null()
				mut var_caption_startTime := rt.new_null()
				mut var_caption_endTime := rt.new_null()
				mut var_caption_text := rt.new_null()
				if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('type')) {
				var_caption_type = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('type'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('lang')) {
				var_caption_lang = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('lang'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('start')) {
				var_caption_startTime = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('start'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('end')) {
				var_caption_endTime = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('end'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_caption.array_isset(rt.new_string('data')) {
				var_caption_text = this.sanitize((var_caption.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				var_captions_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Caption.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_caption_type }, rt.ArrayItem{ key: none, val: var_caption_lang }, rt.ArrayItem{ key: none, val: var_caption_startTime }, rt.ArrayItem{ key: none, val: var_caption_endTime }, rt.ArrayItem{ key: none, val: var_caption_text }])]))
			}
		}
		if rt.is_true(rt.new_bool(var_captions_parent.clone().is_array())) {
		var_captions_parent = rt.call_function('array_values', [rt.call_function('array_unique', [var_captions_parent.clone()])])
		}
		mut iter_16 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).str(), 'category')).iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_category := item_16.val
			mut var_term := rt.new_null()
			mut var_scheme := rt.new_null()
			mut var_label := rt.new_null()
			if var_category.array_isset(rt.new_string('data')) {
			var_term = this.sanitize((var_category.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
			if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
			var_scheme = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			} else {
			var_scheme = rt.new_string('http://search.yahoo.com/mrss/category_schema')
			}
			if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('label')) {
			var_label = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('label'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
			var_categories_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_term }, rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: var_label }])]))
		}
		mut iter_17 := rt.cast_array(rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_mediarss(), rt.new_string('category')])).iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_category := item_17.val
			mut var_term := rt.new_null()
			mut var_scheme := rt.new_null()
			mut var_label := rt.new_null()
			if var_category.array_isset(rt.new_string('data')) {
			var_term = this.sanitize((var_category.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
			if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
			var_scheme = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			} else {
			var_scheme = rt.new_string('http://search.yahoo.com/mrss/category_schema')
			}
			if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('label')) {
			var_label = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('label'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
			var_categories_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_term }, rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: var_label }])]))
		}
		mut iter_18 := rt.cast_array(rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_itunes(), rt.new_string('category')])).iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_category := item_18.val
			mut var_term := rt.new_null()
			mut var_scheme := rt.new_string('http://www.itunes.com/dtds/podcast-1.0.dtd')
			mut var_label := rt.new_null()
			if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('text')) {
			var_label = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('text'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
			var_categories_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_term }, rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: var_label }])]))
			if var_category.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).array_isset(rt.new_string('category')) {
				mut iter_19 := rt.cast_array(var_category.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).array_get(rt.new_string('category'))).iterator()
				for {
					item_19 := iter_19.next() or { break }
					mut var_subcategory := item_19.val
					if var_subcategory.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('text')) {
					var_label = this.sanitize((var_subcategory.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('text'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
					}
					var_categories_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_term }, rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: var_label }])]))
				}
			}
		}
		if rt.is_true(rt.new_bool(var_categories_parent.clone().is_array())) {
		var_categories_parent = rt.call_function('array_values', [rt.call_function('array_unique', [var_categories_parent.clone()])])
		}
		mut var_copyright := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).str(), 'copyright')
		if rt.is_true(var_copyright) {
			mut var_copyright_url := rt.new_null()
			mut var_copyright_label := rt.new_null()
			if var_copyright.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('url')) {
			var_copyright_url = this.sanitize((var_copyright.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
			if var_copyright.array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_copyright_label = this.sanitize((var_copyright.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
		var_copyrights_parent = rt.call_method(this.registry, 'create', [Class_SimplePie_Copyright.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_copyright_url }, rt.ArrayItem{ key: none, val: var_copyright_label }])])
		var_copyright = rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_mediarss(), rt.new_string('copyright')])
		} else if rt.is_true(var_copyright) {
			var_copyright_url = rt.new_null()
			var_copyright_label = rt.new_null()
			if var_copyright.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('url')) {
			var_copyright_url = this.sanitize((var_copyright.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
			if var_copyright.array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_copyright_label = this.sanitize((var_copyright.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
		var_copyrights_parent = rt.call_method(this.registry, 'create', [Class_SimplePie_Copyright.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_copyright_url }, rt.ArrayItem{ key: none, val: var_copyright_label }])])
		}
		mut var_credits := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).str(), 'credit')
		if rt.is_true(var_credits) {
			mut iter_20 := var_credits.iterator()
			for {
				item_20 := iter_20.next() or { break }
				mut var_credit := item_20.val
				mut var_credit_role := rt.new_null()
				mut var_credit_scheme := rt.new_null()
				mut var_credit_name := rt.new_null()
				if var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('role')) {
				var_credit_role = this.sanitize((var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('role'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
				var_credit_scheme = this.sanitize((var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				} else {
				var_credit_scheme = rt.new_string('urn:ebu')
				}
				if var_credit.array_isset(rt.new_string('data')) {
				var_credit_name = this.sanitize((var_credit.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				var_credits_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Credit.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_credit_role }, rt.ArrayItem{ key: none, val: var_credit_scheme }, rt.ArrayItem{ key: none, val: var_credit_name }])]))
			}
		var_credits = rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_mediarss(), rt.new_string('credit')])
		} else if rt.is_true(var_credits) {
			mut iter_21 := var_credits.iterator()
			for {
				item_21 := iter_21.next() or { break }
				mut var_credit := item_21.val
				mut var_credit_role := rt.new_null()
				mut var_credit_scheme := rt.new_null()
				mut var_credit_name := rt.new_null()
				if var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('role')) {
				var_credit_role = this.sanitize((var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('role'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
				var_credit_scheme = this.sanitize((var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				} else {
				var_credit_scheme = rt.new_string('urn:ebu')
				}
				if var_credit.array_isset(rt.new_string('data')) {
				var_credit_name = this.sanitize((var_credit.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				var_credits_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Credit.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_credit_role }, rt.ArrayItem{ key: none, val: var_credit_scheme }, rt.ArrayItem{ key: none, val: var_credit_name }])]))
			}
		}
		if rt.is_true(rt.new_bool(var_credits_parent.clone().is_array())) {
		var_credits_parent = rt.call_function('array_values', [rt.call_function('array_unique', [var_credits_parent.clone()])])
		}
		var_description_parent = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).str(), 'description')
		if rt.is_true(var_description_parent) {
			if var_description_parent.array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_description_parent = this.sanitize((var_description_parent.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
		var_description_parent = rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_mediarss(), rt.new_string('description')])
		} else if rt.is_true(var_description_parent) {
			if var_description_parent.array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_description_parent = this.sanitize((var_description_parent.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
		}
		mut var_duration_tags := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(), 'duration')
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_duration_tags, rt.new_null())))) {
			mut var_seconds := rt.new_null()
			mut var_minutes := rt.new_null()
			mut var_hours := rt.new_null()
			if var_duration_tags.array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
				mut var_temp := rt.call_function('explode', [rt.new_string(':'), this.sanitize((var_duration_tags.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')])
				var_seconds = rt.new_int((rt.call_function('array_pop', [var_temp.clone()])).to_i64())
				if var_temp.clone().array_count() > 0 {
					var_minutes = rt.new_int((rt.call_function('array_pop', [var_temp.clone()])).to_i64())
					var_seconds = rt.add(var_seconds, rt.mul(var_minutes, rt.new_int(60)))
				}
				if var_temp.clone().array_count() > 0 {
					var_hours = rt.new_int((rt.call_function('array_pop', [var_temp.clone()])).to_i64())
					var_seconds = rt.add(var_seconds, rt.mul(var_hours, rt.new_int(3600)))
				}
				var_temp = rt.new_null()
			var_duration_parent = var_seconds.clone()
			}
		}
		mut var_hashes_iterator := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).str(), 'hash')
		if rt.is_true(var_hashes_iterator) {
			mut iter_22 := var_hashes_iterator.iterator()
			for {
				item_22 := iter_22.next() or { break }
				mut var_hash := item_22.val
				mut var_value := rt.new_null()
				mut var_algo := rt.new_null()
				if var_hash.array_isset(rt.new_string('data')) {
				var_value = this.sanitize((var_hash.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_hash.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('algo')) {
				var_algo = this.sanitize((var_hash.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('algo'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				} else {
				var_algo = rt.new_string('md5')
				}
				var_hashes_parent.array_push((var_algo).str() + ':' + (var_value).str())
			}
		var_hashes_iterator = rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_mediarss(), rt.new_string('hash')])
		} else if rt.is_true(var_hashes_iterator) {
			mut iter_23 := var_hashes_iterator.iterator()
			for {
				item_23 := iter_23.next() or { break }
				mut var_hash := item_23.val
				mut var_value := rt.new_null()
				mut var_algo := rt.new_null()
				if var_hash.array_isset(rt.new_string('data')) {
				var_value = this.sanitize((var_hash.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_hash.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('algo')) {
				var_algo = this.sanitize((var_hash.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('algo'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				} else {
				var_algo = rt.new_string('md5')
				}
				var_hashes_parent.array_push((var_algo).str() + ':' + (var_value).str())
			}
		}
		if rt.is_true(rt.new_bool(var_hashes_parent.clone().is_array())) {
		var_hashes_parent = rt.call_function('array_values', [rt.call_function('array_unique', [var_hashes_parent.clone()])])
		}
		mut var_keywords := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).str(), 'keywords')
		if rt.is_true(var_keywords) {
			if var_keywords.array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
				var_temp = rt.call_function('explode', [rt.new_string(','), this.sanitize((var_keywords.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')])
				mut iter_24 := var_temp.iterator()
				for {
					item_24 := iter_24.next() or { break }
					mut var_word := item_24.val
					var_keywords_parent.array_push(var_word.clone().to_string().trim_space())
				}
			}
			var_temp = rt.new_null()
		var_keywords = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(), 'keywords')
		} else if rt.is_true(var_keywords) {
			if var_keywords.array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
				var_temp = rt.call_function('explode', [rt.new_string(','), this.sanitize((var_keywords.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')])
				mut iter_25 := var_temp.iterator()
				for {
					item_25 := iter_25.next() or { break }
					mut var_word := item_25.val
					var_keywords_parent.array_push(var_word.clone().to_string().trim_space())
				}
			}
			var_temp = rt.new_null()
		var_keywords = rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_mediarss(), rt.new_string('keywords')])
		} else if rt.is_true(var_keywords) {
			if var_keywords.array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
				var_temp = rt.call_function('explode', [rt.new_string(','), this.sanitize((var_keywords.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')])
				mut iter_26 := var_temp.iterator()
				for {
					item_26 := iter_26.next() or { break }
					mut var_word := item_26.val
					var_keywords_parent.array_push(var_word.clone().to_string().trim_space())
				}
			}
			var_temp = rt.new_null()
		var_keywords = rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_itunes(), rt.new_string('keywords')])
		} else if rt.is_true(var_keywords) {
			if var_keywords.array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
				var_temp = rt.call_function('explode', [rt.new_string(','), this.sanitize((var_keywords.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')])
				mut iter_27 := var_temp.iterator()
				for {
					item_27 := iter_27.next() or { break }
					mut var_word := item_27.val
					var_keywords_parent.array_push(var_word.clone().to_string().trim_space())
				}
			}
			var_temp = rt.new_null()
		}
		if rt.is_true(rt.new_bool(var_keywords_parent.clone().is_array())) {
		var_keywords_parent = rt.call_function('array_values', [rt.call_function('array_unique', [var_keywords_parent.clone()])])
		}
		var_player_parent = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).str(), 'player')
		if rt.is_true(var_player_parent) {
			if var_player_parent.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('url')) {
			var_player_parent = this.sanitize((var_player_parent.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_player_parent.array_get(rt.new_int(0)))))
			}
		var_player_parent = rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_mediarss(), rt.new_string('player')])
		} else if rt.is_true(var_player_parent) {
			if var_player_parent.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('url')) {
			var_player_parent = this.sanitize((var_player_parent.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_player_parent.array_get(rt.new_int(0)))))
			}
		}
		mut var_ratings := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).str(), 'rating')
		if rt.is_true(var_ratings) {
			mut iter_28 := var_ratings.iterator()
			for {
				item_28 := iter_28.next() or { break }
				mut var_rating := item_28.val
				mut var_rating_scheme := rt.new_null()
				mut var_rating_value := rt.new_null()
				if var_rating.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
				var_rating_scheme = this.sanitize((var_rating.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				} else {
				var_rating_scheme = rt.new_string('urn:simple')
				}
				if var_rating.array_isset(rt.new_string('data')) {
				var_rating_value = this.sanitize((var_rating.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				var_ratings_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Rating.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_rating_scheme }, rt.ArrayItem{ key: none, val: var_rating_value }])]))
			}
		var_ratings = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(), 'explicit')
		} else if rt.is_true(var_ratings) {
			mut iter_29 := var_ratings.iterator()
			for {
				item_29 := iter_29.next() or { break }
				mut var_rating := item_29.val
				mut var_rating_scheme := rt.new_string('urn:itunes')
				mut var_rating_value := rt.new_null()
				if var_rating.array_isset(rt.new_string('data')) {
				var_rating_value = this.sanitize((var_rating.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				var_ratings_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Rating.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_rating_scheme }, rt.ArrayItem{ key: none, val: var_rating_value }])]))
			}
		var_ratings = rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_mediarss(), rt.new_string('rating')])
		} else if rt.is_true(var_ratings) {
			mut iter_30 := var_ratings.iterator()
			for {
				item_30 := iter_30.next() or { break }
				mut var_rating := item_30.val
				mut var_rating_scheme := rt.new_null()
				mut var_rating_value := rt.new_null()
				if var_rating.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
				var_rating_scheme = this.sanitize((var_rating.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				} else {
				var_rating_scheme = rt.new_string('urn:simple')
				}
				if var_rating.array_isset(rt.new_string('data')) {
				var_rating_value = this.sanitize((var_rating.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				var_ratings_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Rating.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_rating_scheme }, rt.ArrayItem{ key: none, val: var_rating_value }])]))
			}
		var_ratings = rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_itunes(), rt.new_string('explicit')])
		} else if rt.is_true(var_ratings) {
			mut iter_31 := var_ratings.iterator()
			for {
				item_31 := iter_31.next() or { break }
				mut var_rating := item_31.val
				mut var_rating_scheme := rt.new_string('urn:itunes')
				mut var_rating_value := rt.new_null()
				if var_rating.array_isset(rt.new_string('data')) {
				var_rating_value = this.sanitize((var_rating.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				var_ratings_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Rating.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_rating_scheme }, rt.ArrayItem{ key: none, val: var_rating_value }])]))
			}
		}
		if rt.is_true(rt.new_bool(var_ratings_parent.clone().is_array())) {
		var_ratings_parent = rt.call_function('array_values', [rt.call_function('array_unique', [var_ratings_parent.clone()])])
		}
		mut var_restrictions := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).str(), 'restriction')
		if rt.is_true(var_restrictions) {
			mut iter_32 := var_restrictions.iterator()
			for {
				item_32 := iter_32.next() or { break }
				mut var_restriction := item_32.val
				mut var_restriction_relationship := rt.new_null()
				mut var_restriction_type := rt.new_null()
				mut var_restriction_value := rt.new_null()
				if var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('relationship')) {
				var_restriction_relationship = this.sanitize((var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('relationship'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('type')) {
				var_restriction_type = this.sanitize((var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('type'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_restriction.array_isset(rt.new_string('data')) {
				var_restriction_value = this.sanitize((var_restriction.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				var_restrictions_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Restriction.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_restriction_relationship }, rt.ArrayItem{ key: none, val: var_restriction_type }, rt.ArrayItem{ key: none, val: var_restriction_value }])]))
			}
		var_restrictions = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(), 'block')
		} else if rt.is_true(var_restrictions) {
			mut iter_33 := var_restrictions.iterator()
			for {
				item_33 := iter_33.next() or { break }
				mut var_restriction := item_33.val
				mut var_restriction_relationship := Class_SimplePie_Restriction.relationship_allow()
				mut var_restriction_type := rt.new_null()
				mut var_restriction_value := rt.new_string('itunes')
				if var_restriction.array_isset(rt.new_string('data')) && rt.is_true(rt.identical(rt.new_string(var_restriction.array_get(rt.new_string('data')).to_string().to_lower()), rt.new_string('yes'))) {
				var_restriction_relationship = Class_SimplePie_Restriction.relationship_deny()
				}
				var_restrictions_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Restriction.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_restriction_relationship }, rt.ArrayItem{ key: none, val: var_restriction_type }, rt.ArrayItem{ key: none, val: var_restriction_value }])]))
			}
		var_restrictions = rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_mediarss(), rt.new_string('restriction')])
		} else if rt.is_true(var_restrictions) {
			mut iter_34 := var_restrictions.iterator()
			for {
				item_34 := iter_34.next() or { break }
				mut var_restriction := item_34.val
				mut var_restriction_relationship := rt.new_null()
				mut var_restriction_type := rt.new_null()
				mut var_restriction_value := rt.new_null()
				if var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('relationship')) {
				var_restriction_relationship = this.sanitize((var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('relationship'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('type')) {
				var_restriction_type = this.sanitize((var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('type'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_restriction.array_isset(rt.new_string('data')) {
				var_restriction_value = this.sanitize((var_restriction.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				var_restrictions_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Restriction.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_restriction_relationship }, rt.ArrayItem{ key: none, val: var_restriction_type }, rt.ArrayItem{ key: none, val: var_restriction_value }])]))
			}
		var_restrictions = rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_itunes(), rt.new_string('block')])
		} else if rt.is_true(var_restrictions) {
			mut iter_35 := var_restrictions.iterator()
			for {
				item_35 := iter_35.next() or { break }
				mut var_restriction := item_35.val
				mut var_restriction_relationship := Class_SimplePie_Restriction.relationship_allow()
				mut var_restriction_type := rt.new_null()
				mut var_restriction_value := rt.new_string('itunes')
				if var_restriction.array_isset(rt.new_string('data')) && rt.is_true(rt.identical(rt.new_string(var_restriction.array_get(rt.new_string('data')).to_string().to_lower()), rt.new_string('yes'))) {
				var_restriction_relationship = Class_SimplePie_Restriction.relationship_deny()
				}
				var_restrictions_parent.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Restriction.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_restriction_relationship }, rt.ArrayItem{ key: none, val: var_restriction_type }, rt.ArrayItem{ key: none, val: var_restriction_value }])]))
			}
		}
		if var_restrictions_parent.clone().array_count() > 0 {
		var_restrictions_parent = rt.call_function('array_values', [rt.call_function('array_unique', [var_restrictions_parent.clone()])])
		} else {
		var_restrictions_parent = rt.create_array([rt.ArrayItem{ key: none, val: create_simplepie_simplepie_restriction(Class_SimplePie_Restriction.relationship_allow(), rt.new_null(), rt.new_string('default')) }])
		}
		mut var_thumbnails := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).str(), 'thumbnail')
		if rt.is_true(var_thumbnails) {
			mut iter_36 := var_thumbnails.iterator()
			for {
				item_36 := iter_36.next() or { break }
				mut var_thumbnail := item_36.val
				if var_thumbnail.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('url')) {
					var_thumbnails_parent.array_push(this.sanitize((var_thumbnail.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_thumbnail))))
				}
			}
		var_thumbnails = rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_mediarss(), rt.new_string('thumbnail')])
		} else if rt.is_true(var_thumbnails) {
			mut iter_37 := var_thumbnails.iterator()
			for {
				item_37 := iter_37.next() or { break }
				mut var_thumbnail := item_37.val
				if var_thumbnail.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('url')) {
					var_thumbnails_parent.array_push(this.sanitize((var_thumbnail.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_thumbnail))))
				}
			}
		}
		var_title_parent = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).str(), 'title')
		if rt.is_true(var_title_parent) {
			if var_title_parent.array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_title_parent = this.sanitize((var_title_parent.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
		var_title_parent = rt.call_method(var_parent, 'get_channel_tags', [Class_SimplePie_SimplePie_SimplePie.namespace_mediarss(), rt.new_string('title')])
		} else if rt.is_true(var_title_parent) {
			if var_title_parent.array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
			var_title_parent = this.sanitize((var_title_parent.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
			}
		}
		var_parent = rt.new_null()
		mut var_bitrate := rt.new_null()
		mut var_channels := rt.new_null()
		mut var_duration := rt.new_null()
		mut var_expression := rt.new_null()
		mut var_framerate := rt.new_null()
		mut var_height := rt.new_null()
		mut var_javascript := rt.new_null()
		mut var_lang := rt.new_null()
		mut var_length := rt.new_null()
		mut var_medium := rt.new_null()
		mut var_samplingrate := rt.new_null()
		mut var_type := rt.new_null()
		mut var_url := rt.new_null()
		mut var_width := rt.new_null()
		var_captions = rt.new_null()
		mut var_categories := rt.new_null()
		mut var_copyrights := rt.new_null()
		var_credits = rt.new_null()
		mut var_description := rt.new_null()
		mut var_hashes := rt.new_null()
		var_keywords = rt.new_null()
		mut var_player := rt.new_null()
		var_ratings = rt.new_null()
		var_restrictions = rt.new_null()
		var_thumbnails = rt.new_null()
		mut var_title := rt.new_null()
		mut iter_38 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).str(), 'group')).iterator()
		for {
			item_38 := iter_38.next() or { break }
			mut var_group := item_38.val
			if var_group.array_isset(rt.new_string('child')) && var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('content')) {
				mut iter_39 := rt.cast_array(var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('content'))).iterator()
				for {
					item_39 := iter_39.next() or { break }
					mut var_content := item_39.val
					if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('url')) {
						var_bitrate = rt.new_null()
						var_channels = rt.new_null()
						var_duration = rt.new_null()
						var_expression = rt.new_null()
						var_framerate = rt.new_null()
						var_height = rt.new_null()
						var_javascript = rt.new_null()
						var_lang = rt.new_null()
						var_length = rt.new_null()
						var_medium = rt.new_null()
						var_samplingrate = rt.new_null()
						var_type = rt.new_null()
						var_url = rt.new_null()
						var_width = rt.new_null()
						var_captions = rt.new_null()
						var_categories = rt.new_null()
						var_copyrights = rt.new_null()
						var_credits = rt.new_null()
						var_description = rt.new_null()
						var_hashes = rt.new_null()
						var_keywords = rt.new_null()
						var_player = rt.new_null()
						var_ratings = rt.new_null()
						var_restrictions = rt.new_null()
						var_thumbnails = rt.new_null()
						var_title = rt.new_null()
						if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('bitrate')) {
						var_bitrate = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('bitrate'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						}
						if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('channels')) {
						var_channels = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('channels'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						}
						if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('duration')) {
						var_duration = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('duration'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						} else {
						var_duration = var_duration_parent.clone()
						}
						if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('expression')) {
						var_expression = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('expression'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						}
						if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('framerate')) {
						var_framerate = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('framerate'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						}
						if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('height')) {
						var_height = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('height'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						}
						if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('lang')) {
						var_lang = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('lang'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						}
						if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('fileSize')) {
						var_length = rt.new_int(var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('fileSize')).to_i64())
						}
						if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('medium')) {
						var_medium = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('medium'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						}
						if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('samplingrate')) {
						var_samplingrate = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('samplingrate'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						}
						if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('type')) {
						var_type = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('type'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						}
						if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('width')) {
						var_width = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('width'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						}
						var_url = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_content)))
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('text')) {
							mut iter_40 := var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('text')).iterator()
							for {
								item_40 := iter_40.next() or { break }
								mut var_caption := item_40.val
								mut var_caption_type := rt.new_null()
								mut var_caption_lang := rt.new_null()
								mut var_caption_startTime := rt.new_null()
								mut var_caption_endTime := rt.new_null()
								mut var_caption_text := rt.new_null()
								if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('type')) {
								var_caption_type = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('type'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('lang')) {
								var_caption_lang = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('lang'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('start')) {
								var_caption_startTime = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('start'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('end')) {
								var_caption_endTime = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('end'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_caption.array_isset(rt.new_string('data')) {
								var_caption_text = this.sanitize((var_caption.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								var_captions.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Caption.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_caption_type }, rt.ArrayItem{ key: none, val: var_caption_lang }, rt.ArrayItem{ key: none, val: var_caption_startTime }, rt.ArrayItem{ key: none, val: var_caption_endTime }, rt.ArrayItem{ key: none, val: var_caption_text }])]))
							}
							if rt.is_true(rt.new_bool(var_captions.clone().is_array())) {
							var_captions = rt.call_function('array_values', [rt.call_function('array_unique', [var_captions.clone()])])
							}
						} else if var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('text')) {
							mut iter_41 := var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('text')).iterator()
							for {
								item_41 := iter_41.next() or { break }
								mut var_caption := item_41.val
								mut var_caption_type := rt.new_null()
								mut var_caption_lang := rt.new_null()
								mut var_caption_startTime := rt.new_null()
								mut var_caption_endTime := rt.new_null()
								mut var_caption_text := rt.new_null()
								if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('type')) {
								var_caption_type = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('type'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('lang')) {
								var_caption_lang = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('lang'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('start')) {
								var_caption_startTime = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('start'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('end')) {
								var_caption_endTime = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('end'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_caption.array_isset(rt.new_string('data')) {
								var_caption_text = this.sanitize((var_caption.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								var_captions.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Caption.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_caption_type }, rt.ArrayItem{ key: none, val: var_caption_lang }, rt.ArrayItem{ key: none, val: var_caption_startTime }, rt.ArrayItem{ key: none, val: var_caption_endTime }, rt.ArrayItem{ key: none, val: var_caption_text }])]))
							}
							if rt.is_true(rt.new_bool(var_captions.clone().is_array())) {
							var_captions = rt.call_function('array_values', [rt.call_function('array_unique', [var_captions.clone()])])
							}
						} else {
						var_captions = var_captions_parent.clone()
						}
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('category')) {
							mut iter_42 := rt.cast_array(var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('category'))).iterator()
							for {
								item_42 := iter_42.next() or { break }
								mut var_category := item_42.val
								mut var_term := rt.new_null()
								mut var_scheme := rt.new_null()
								mut var_label := rt.new_null()
								if var_category.array_isset(rt.new_string('data')) {
								var_term = this.sanitize((var_category.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
								var_scheme = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								} else {
								var_scheme = rt.new_string('http://search.yahoo.com/mrss/category_schema')
								}
								if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('label')) {
								var_label = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('label'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_term }, rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: var_label }])]))
							}
						}
						if var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('category')) {
							mut iter_43 := rt.cast_array(var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('category'))).iterator()
							for {
								item_43 := iter_43.next() or { break }
								mut var_category := item_43.val
								mut var_term := rt.new_null()
								mut var_scheme := rt.new_null()
								mut var_label := rt.new_null()
								if var_category.array_isset(rt.new_string('data')) {
								var_term = this.sanitize((var_category.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
								var_scheme = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								} else {
								var_scheme = rt.new_string('http://search.yahoo.com/mrss/category_schema')
								}
								if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('label')) {
								var_label = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('label'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_term }, rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: var_label }])]))
							}
						}
						if var_categories.clone().is_array() && var_categories_parent.clone().is_array() {
						var_categories = rt.call_function('array_values', [rt.call_function('array_unique', [rt.call_function('array_merge', [var_categories.clone(), var_categories_parent.clone()])])])
						} else if rt.is_true(rt.new_bool(var_categories.clone().is_array())) {
						var_categories = rt.call_function('array_values', [rt.call_function('array_unique', [var_categories.clone()])])
						} else if rt.is_true(rt.new_bool(var_categories_parent.clone().is_array())) {
						var_categories = rt.call_function('array_values', [rt.call_function('array_unique', [var_categories_parent.clone()])])
						}
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('copyright')) {
							var_copyright_url = rt.new_null()
							var_copyright_label = rt.new_null()
							if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('copyright')).array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('url')) {
							var_copyright_url = this.sanitize((var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('copyright')).array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('copyright')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
							var_copyright_label = this.sanitize((var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('copyright')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
						var_copyrights = rt.call_method(this.registry, 'create', [Class_SimplePie_Copyright.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_copyright_url }, rt.ArrayItem{ key: none, val: var_copyright_label }])])
						} else if var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('copyright')) {
							var_copyright_url = rt.new_null()
							var_copyright_label = rt.new_null()
							if var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('copyright')).array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('url')) {
							var_copyright_url = this.sanitize((var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('copyright')).array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							if var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('copyright')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
							var_copyright_label = this.sanitize((var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('copyright')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
						var_copyrights = rt.call_method(this.registry, 'create', [Class_SimplePie_Copyright.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_copyright_url }, rt.ArrayItem{ key: none, val: var_copyright_label }])])
						} else {
						var_copyrights = var_copyrights_parent.clone()
						}
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('credit')) {
							mut iter_44 := var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('credit')).iterator()
							for {
								item_44 := iter_44.next() or { break }
								mut var_credit := item_44.val
								mut var_credit_role := rt.new_null()
								mut var_credit_scheme := rt.new_null()
								mut var_credit_name := rt.new_null()
								if var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('role')) {
								var_credit_role = this.sanitize((var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('role'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
								var_credit_scheme = this.sanitize((var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								} else {
								var_credit_scheme = rt.new_string('urn:ebu')
								}
								if var_credit.array_isset(rt.new_string('data')) {
								var_credit_name = this.sanitize((var_credit.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								var_credits.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Credit.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_credit_role }, rt.ArrayItem{ key: none, val: var_credit_scheme }, rt.ArrayItem{ key: none, val: var_credit_name }])]))
							}
							if rt.is_true(rt.new_bool(var_credits.clone().is_array())) {
							var_credits = rt.call_function('array_values', [rt.call_function('array_unique', [var_credits.clone()])])
							}
						} else if var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('credit')) {
							mut iter_45 := var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('credit')).iterator()
							for {
								item_45 := iter_45.next() or { break }
								mut var_credit := item_45.val
								mut var_credit_role := rt.new_null()
								mut var_credit_scheme := rt.new_null()
								mut var_credit_name := rt.new_null()
								if var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('role')) {
								var_credit_role = this.sanitize((var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('role'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
								var_credit_scheme = this.sanitize((var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								} else {
								var_credit_scheme = rt.new_string('urn:ebu')
								}
								if var_credit.array_isset(rt.new_string('data')) {
								var_credit_name = this.sanitize((var_credit.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								var_credits.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Credit.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_credit_role }, rt.ArrayItem{ key: none, val: var_credit_scheme }, rt.ArrayItem{ key: none, val: var_credit_name }])]))
							}
							if rt.is_true(rt.new_bool(var_credits.clone().is_array())) {
							var_credits = rt.call_function('array_values', [rt.call_function('array_unique', [var_credits.clone()])])
							}
						} else {
						var_credits = var_credits_parent.clone()
						}
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('description')) {
						var_description = this.sanitize((var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('description')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						} else if var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('description')) {
						var_description = this.sanitize((var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('description')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						} else {
						var_description = var_description_parent.clone()
						}
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('hash')) {
							mut iter_46 := var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('hash')).iterator()
							for {
								item_46 := iter_46.next() or { break }
								mut var_hash := item_46.val
								mut var_value := rt.new_null()
								mut var_algo := rt.new_null()
								if var_hash.array_isset(rt.new_string('data')) {
								var_value = this.sanitize((var_hash.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_hash.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('algo')) {
								var_algo = this.sanitize((var_hash.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('algo'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								} else {
								var_algo = rt.new_string('md5')
								}
								var_hashes.array_push((var_algo).str() + ':' + (var_value).str())
							}
							if rt.is_true(rt.new_bool(var_hashes.clone().is_array())) {
							var_hashes = rt.call_function('array_values', [rt.call_function('array_unique', [var_hashes.clone()])])
							}
						} else if var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('hash')) {
							mut iter_47 := var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('hash')).iterator()
							for {
								item_47 := iter_47.next() or { break }
								mut var_hash := item_47.val
								mut var_value := rt.new_null()
								mut var_algo := rt.new_null()
								if var_hash.array_isset(rt.new_string('data')) {
								var_value = this.sanitize((var_hash.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_hash.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('algo')) {
								var_algo = this.sanitize((var_hash.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('algo'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								} else {
								var_algo = rt.new_string('md5')
								}
								var_hashes.array_push((var_algo).str() + ':' + (var_value).str())
							}
							if rt.is_true(rt.new_bool(var_hashes.clone().is_array())) {
							var_hashes = rt.call_function('array_values', [rt.call_function('array_unique', [var_hashes.clone()])])
							}
						} else {
						var_hashes = var_hashes_parent.clone()
						}
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('keywords')) {
							if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('keywords')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
								var_temp = rt.call_function('explode', [rt.new_string(','), this.sanitize((var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('keywords')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')])
								mut iter_48 := var_temp.iterator()
								for {
									item_48 := iter_48.next() or { break }
									mut var_word := item_48.val
									var_keywords.array_push(var_word.clone().to_string().trim_space())
								}
								var_temp = rt.new_null()
							}
							if rt.is_true(rt.new_bool(var_keywords.clone().is_array())) {
							var_keywords = rt.call_function('array_values', [rt.call_function('array_unique', [var_keywords.clone()])])
							}
						} else if var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('keywords')) {
							if var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('keywords')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
								var_temp = rt.call_function('explode', [rt.new_string(','), this.sanitize((var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('keywords')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')])
								mut iter_49 := var_temp.iterator()
								for {
									item_49 := iter_49.next() or { break }
									mut var_word := item_49.val
									var_keywords.array_push(var_word.clone().to_string().trim_space())
								}
								var_temp = rt.new_null()
							}
							if rt.is_true(rt.new_bool(var_keywords.clone().is_array())) {
							var_keywords = rt.call_function('array_values', [rt.call_function('array_unique', [var_keywords.clone()])])
							}
						} else {
						var_keywords = var_keywords_parent.clone()
						}
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('player')) {
						mut var_playerElem := var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('player')).array_get(rt.new_int(0))
						var_player = this.sanitize((var_playerElem.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_playerElem)))
						} else if var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('player')) {
						var_playerElem = var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('player')).array_get(rt.new_int(0))
						var_player = this.sanitize((var_playerElem.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_playerElem)))
						} else {
						var_player = var_player_parent.clone()
						}
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('rating')) {
							mut iter_50 := var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('rating')).iterator()
							for {
								item_50 := iter_50.next() or { break }
								mut var_rating := item_50.val
								mut var_rating_scheme := rt.new_null()
								mut var_rating_value := rt.new_null()
								if var_rating.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
								var_rating_scheme = this.sanitize((var_rating.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								} else {
								var_rating_scheme = rt.new_string('urn:simple')
								}
								if var_rating.array_isset(rt.new_string('data')) {
								var_rating_value = this.sanitize((var_rating.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								var_ratings.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Rating.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_rating_scheme }, rt.ArrayItem{ key: none, val: var_rating_value }])]))
							}
							if rt.is_true(rt.new_bool(var_ratings.clone().is_array())) {
							var_ratings = rt.call_function('array_values', [rt.call_function('array_unique', [var_ratings.clone()])])
							}
						} else if var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('rating')) {
							mut iter_51 := var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('rating')).iterator()
							for {
								item_51 := iter_51.next() or { break }
								mut var_rating := item_51.val
								mut var_rating_scheme := rt.new_null()
								mut var_rating_value := rt.new_null()
								if var_rating.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
								var_rating_scheme = this.sanitize((var_rating.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								} else {
								var_rating_scheme = rt.new_string('urn:simple')
								}
								if var_rating.array_isset(rt.new_string('data')) {
								var_rating_value = this.sanitize((var_rating.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								var_ratings.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Rating.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_rating_scheme }, rt.ArrayItem{ key: none, val: var_rating_value }])]))
							}
							if rt.is_true(rt.new_bool(var_ratings.clone().is_array())) {
							var_ratings = rt.call_function('array_values', [rt.call_function('array_unique', [var_ratings.clone()])])
							}
						} else {
						var_ratings = var_ratings_parent.clone()
						}
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('restriction')) {
							mut iter_52 := var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('restriction')).iterator()
							for {
								item_52 := iter_52.next() or { break }
								mut var_restriction := item_52.val
								mut var_restriction_relationship := rt.new_null()
								mut var_restriction_type := rt.new_null()
								mut var_restriction_value := rt.new_null()
								if var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('relationship')) {
								var_restriction_relationship = this.sanitize((var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('relationship'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('type')) {
								var_restriction_type = this.sanitize((var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('type'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_restriction.array_isset(rt.new_string('data')) {
								var_restriction_value = this.sanitize((var_restriction.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								var_restrictions.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Restriction.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_restriction_relationship }, rt.ArrayItem{ key: none, val: var_restriction_type }, rt.ArrayItem{ key: none, val: var_restriction_value }])]))
							}
							if rt.is_true(rt.new_bool(var_restrictions.clone().is_array())) {
							var_restrictions = rt.call_function('array_values', [rt.call_function('array_unique', [var_restrictions.clone()])])
							}
						} else if var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('restriction')) {
							mut iter_53 := var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('restriction')).iterator()
							for {
								item_53 := iter_53.next() or { break }
								mut var_restriction := item_53.val
								mut var_restriction_relationship := rt.new_null()
								mut var_restriction_type := rt.new_null()
								mut var_restriction_value := rt.new_null()
								if var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('relationship')) {
								var_restriction_relationship = this.sanitize((var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('relationship'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('type')) {
								var_restriction_type = this.sanitize((var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('type'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								if var_restriction.array_isset(rt.new_string('data')) {
								var_restriction_value = this.sanitize((var_restriction.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
								}
								var_restrictions.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Restriction.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_restriction_relationship }, rt.ArrayItem{ key: none, val: var_restriction_type }, rt.ArrayItem{ key: none, val: var_restriction_value }])]))
							}
							if rt.is_true(rt.new_bool(var_restrictions.clone().is_array())) {
							var_restrictions = rt.call_function('array_values', [rt.call_function('array_unique', [var_restrictions.clone()])])
							}
						} else {
						var_restrictions = var_restrictions_parent.clone()
						}
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('thumbnail')) {
							mut iter_54 := var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('thumbnail')).iterator()
							for {
								item_54 := iter_54.next() or { break }
								mut var_thumbnail := item_54.val
								var_thumbnails.array_push(this.sanitize((var_thumbnail.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_thumbnail))))
							}
							if rt.is_true(rt.new_bool(var_thumbnails.clone().is_array())) {
							var_thumbnails = rt.call_function('array_values', [rt.call_function('array_unique', [var_thumbnails.clone()])])
							}
						} else if var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('thumbnail')) {
							mut iter_55 := var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('thumbnail')).iterator()
							for {
								item_55 := iter_55.next() or { break }
								mut var_thumbnail := item_55.val
								var_thumbnails.array_push(this.sanitize((var_thumbnail.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_thumbnail))))
							}
							if rt.is_true(rt.new_bool(var_thumbnails.clone().is_array())) {
							var_thumbnails = rt.call_function('array_values', [rt.call_function('array_unique', [var_thumbnails.clone()])])
							}
						} else {
						var_thumbnails = var_thumbnails_parent.clone()
						}
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('title')) {
						var_title = this.sanitize((var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('title')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						} else if var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('title')) {
						var_title = this.sanitize((var_group.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('title')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						} else {
						var_title = var_title_parent.clone()
						}
						this.data.array_get_mut('enclosures').array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Enclosure.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_url }, rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: var_length }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_bitrate }, rt.ArrayItem{ key: none, val: var_captions }, rt.ArrayItem{ key: none, val: var_categories }, rt.ArrayItem{ key: none, val: var_channels }, rt.ArrayItem{ key: none, val: var_copyrights }, rt.ArrayItem{ key: none, val: var_credits }, rt.ArrayItem{ key: none, val: var_description }, rt.ArrayItem{ key: none, val: var_duration }, rt.ArrayItem{ key: none, val: var_expression }, rt.ArrayItem{ key: none, val: var_framerate }, rt.ArrayItem{ key: none, val: var_hashes }, rt.ArrayItem{ key: none, val: var_height }, rt.ArrayItem{ key: none, val: var_keywords }, rt.ArrayItem{ key: none, val: var_lang }, rt.ArrayItem{ key: none, val: var_medium }, rt.ArrayItem{ key: none, val: var_player }, rt.ArrayItem{ key: none, val: var_ratings }, rt.ArrayItem{ key: none, val: var_restrictions }, rt.ArrayItem{ key: none, val: var_samplingrate }, rt.ArrayItem{ key: none, val: var_thumbnails }, rt.ArrayItem{ key: none, val: var_title }, rt.ArrayItem{ key: none, val: var_width }])]))
					}
				}
			}
		}
		if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('content')) {
			mut iter_56 := rt.cast_array(this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('content'))).iterator()
			for {
				item_56 := iter_56.next() or { break }
				mut var_content := item_56.val
				if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('url')) || var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('player')) {
					var_bitrate = rt.new_null()
					var_channels = rt.new_null()
					var_duration = rt.new_null()
					var_expression = rt.new_null()
					var_framerate = rt.new_null()
					var_height = rt.new_null()
					var_javascript = rt.new_null()
					var_lang = rt.new_null()
					var_length = rt.new_null()
					var_medium = rt.new_null()
					var_samplingrate = rt.new_null()
					var_type = rt.new_null()
					var_url = rt.new_null()
					var_width = rt.new_null()
					var_captions = rt.new_null()
					var_categories = rt.new_null()
					var_copyrights = rt.new_null()
					var_credits = rt.new_null()
					var_description = rt.new_null()
					var_hashes = rt.new_null()
					var_keywords = rt.new_null()
					var_player = rt.new_null()
					var_ratings = rt.new_null()
					var_restrictions = rt.new_null()
					var_thumbnails = rt.new_null()
					var_title = rt.new_null()
					if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('bitrate')) {
					var_bitrate = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('bitrate'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
					}
					if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('channels')) {
					var_channels = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('channels'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
					}
					if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('duration')) {
					var_duration = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('duration'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
					} else {
					var_duration = var_duration_parent.clone()
					}
					if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('expression')) {
					var_expression = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('expression'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
					}
					if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('framerate')) {
					var_framerate = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('framerate'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
					}
					if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('height')) {
					var_height = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('height'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
					}
					if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('lang')) {
					var_lang = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('lang'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
					}
					if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('fileSize')) {
					var_length = rt.new_int(var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('fileSize')).to_i64())
					}
					if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('medium')) {
					var_medium = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('medium'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
					}
					if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('samplingrate')) {
					var_samplingrate = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('samplingrate'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
					}
					if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('type')) {
					var_type = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('type'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
					}
					if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('width')) {
					var_width = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('width'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
					}
					if var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('url')) {
					var_url = this.sanitize((var_content.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_content)))
					}
					if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('text')) {
						mut iter_57 := var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('text')).iterator()
						for {
							item_57 := iter_57.next() or { break }
							mut var_caption := item_57.val
							mut var_caption_type := rt.new_null()
							mut var_caption_lang := rt.new_null()
							mut var_caption_startTime := rt.new_null()
							mut var_caption_endTime := rt.new_null()
							mut var_caption_text := rt.new_null()
							if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('type')) {
							var_caption_type = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('type'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('lang')) {
							var_caption_lang = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('lang'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('start')) {
							var_caption_startTime = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('start'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							if var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('end')) {
							var_caption_endTime = this.sanitize((var_caption.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('end'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							if var_caption.array_isset(rt.new_string('data')) {
							var_caption_text = this.sanitize((var_caption.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							var_captions.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Caption.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_caption_type }, rt.ArrayItem{ key: none, val: var_caption_lang }, rt.ArrayItem{ key: none, val: var_caption_startTime }, rt.ArrayItem{ key: none, val: var_caption_endTime }, rt.ArrayItem{ key: none, val: var_caption_text }])]))
						}
						if rt.is_true(rt.new_bool(var_captions.clone().is_array())) {
						var_captions = rt.call_function('array_values', [rt.call_function('array_unique', [var_captions.clone()])])
						}
					} else {
					var_captions = var_captions_parent.clone()
					}
					if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('category')) {
						mut iter_58 := rt.cast_array(var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('category'))).iterator()
						for {
							item_58 := iter_58.next() or { break }
							mut var_category := item_58.val
							mut var_term := rt.new_null()
							mut var_scheme := rt.new_null()
							mut var_label := rt.new_null()
							if var_category.array_isset(rt.new_string('data')) {
							var_term = this.sanitize((var_category.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
							var_scheme = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							} else {
							var_scheme = rt.new_string('http://search.yahoo.com/mrss/category_schema')
							}
							if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('label')) {
							var_label = this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('label'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_term }, rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: var_label }])]))
						}
					}
					if var_categories.clone().is_array() && var_categories_parent.clone().is_array() {
					var_categories = rt.call_function('array_values', [rt.call_function('array_unique', [rt.call_function('array_merge', [var_categories.clone(), var_categories_parent.clone()])])])
					} else if rt.is_true(rt.new_bool(var_categories.clone().is_array())) {
					var_categories = rt.call_function('array_values', [rt.call_function('array_unique', [var_categories.clone()])])
					} else if rt.is_true(rt.new_bool(var_categories_parent.clone().is_array())) {
					var_categories = rt.call_function('array_values', [rt.call_function('array_unique', [var_categories_parent.clone()])])
					} else {
					var_categories = rt.new_null()
					}
					if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('copyright')) {
						var_copyright_url = rt.new_null()
						var_copyright_label = rt.new_null()
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('copyright')).array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('url')) {
						var_copyright_url = this.sanitize((var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('copyright')).array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						}
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('copyright')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
						var_copyright_label = this.sanitize((var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('copyright')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
						}
					var_copyrights = rt.call_method(this.registry, 'create', [Class_SimplePie_Copyright.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_copyright_url }, rt.ArrayItem{ key: none, val: var_copyright_label }])])
					} else {
					var_copyrights = var_copyrights_parent.clone()
					}
					if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('credit')) {
						mut iter_59 := var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('credit')).iterator()
						for {
							item_59 := iter_59.next() or { break }
							mut var_credit := item_59.val
							mut var_credit_role := rt.new_null()
							mut var_credit_scheme := rt.new_null()
							mut var_credit_name := rt.new_null()
							if var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('role')) {
							var_credit_role = this.sanitize((var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('role'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							if var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
							var_credit_scheme = this.sanitize((var_credit.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							} else {
							var_credit_scheme = rt.new_string('urn:ebu')
							}
							if var_credit.array_isset(rt.new_string('data')) {
							var_credit_name = this.sanitize((var_credit.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							var_credits.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Credit.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_credit_role }, rt.ArrayItem{ key: none, val: var_credit_scheme }, rt.ArrayItem{ key: none, val: var_credit_name }])]))
						}
						if rt.is_true(rt.new_bool(var_credits.clone().is_array())) {
						var_credits = rt.call_function('array_values', [rt.call_function('array_unique', [var_credits.clone()])])
						}
					} else {
					var_credits = var_credits_parent.clone()
					}
					if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('description')) {
					var_description = this.sanitize((var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('description')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
					} else {
					var_description = var_description_parent.clone()
					}
					if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('hash')) {
						mut iter_60 := var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('hash')).iterator()
						for {
							item_60 := iter_60.next() or { break }
							mut var_hash := item_60.val
							mut var_value := rt.new_null()
							mut var_algo := rt.new_null()
							if var_hash.array_isset(rt.new_string('data')) {
							var_value = this.sanitize((var_hash.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							if var_hash.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('algo')) {
							var_algo = this.sanitize((var_hash.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('algo'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							} else {
							var_algo = rt.new_string('md5')
							}
							var_hashes.array_push((var_algo).str() + ':' + (var_value).str())
						}
						if rt.is_true(rt.new_bool(var_hashes.clone().is_array())) {
						var_hashes = rt.call_function('array_values', [rt.call_function('array_unique', [var_hashes.clone()])])
						}
					} else {
					var_hashes = var_hashes_parent.clone()
					}
					if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('keywords')) {
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('keywords')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
							var_temp = rt.call_function('explode', [rt.new_string(','), this.sanitize((var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('keywords')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')])
							mut iter_61 := var_temp.iterator()
							for {
								item_61 := iter_61.next() or { break }
								mut var_word := item_61.val
								var_keywords.array_push(var_word.clone().to_string().trim_space())
							}
							var_temp = rt.new_null()
						}
						if rt.is_true(rt.new_bool(var_keywords.clone().is_array())) {
						var_keywords = rt.call_function('array_values', [rt.call_function('array_unique', [var_keywords.clone()])])
						}
					} else {
					var_keywords = var_keywords_parent.clone()
					}
					if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('player')) {
						if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('player')).array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('url')) {
						mut var_playerElem := var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('player')).array_get(rt.new_int(0))
						var_player = this.sanitize((var_playerElem.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_playerElem)))
						}
					} else {
					var_player = var_player_parent.clone()
					}
					if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('rating')) {
						mut iter_62 := var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('rating')).iterator()
						for {
							item_62 := iter_62.next() or { break }
							mut var_rating := item_62.val
							mut var_rating_scheme := rt.new_null()
							mut var_rating_value := rt.new_null()
							if var_rating.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
							var_rating_scheme = this.sanitize((var_rating.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							} else {
							var_rating_scheme = rt.new_string('urn:simple')
							}
							if var_rating.array_isset(rt.new_string('data')) {
							var_rating_value = this.sanitize((var_rating.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							var_ratings.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Rating.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_rating_scheme }, rt.ArrayItem{ key: none, val: var_rating_value }])]))
						}
						if rt.is_true(rt.new_bool(var_ratings.clone().is_array())) {
						var_ratings = rt.call_function('array_values', [rt.call_function('array_unique', [var_ratings.clone()])])
						}
					} else {
					var_ratings = var_ratings_parent.clone()
					}
					if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('restriction')) {
						mut iter_63 := var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('restriction')).iterator()
						for {
							item_63 := iter_63.next() or { break }
							mut var_restriction := item_63.val
							mut var_restriction_relationship := rt.new_null()
							mut var_restriction_type := rt.new_null()
							mut var_restriction_value := rt.new_null()
							if var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('relationship')) {
							var_restriction_relationship = this.sanitize((var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('relationship'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							if var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('type')) {
							var_restriction_type = this.sanitize((var_restriction.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('type'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							if var_restriction.array_isset(rt.new_string('data')) {
							var_restriction_value = this.sanitize((var_restriction.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
							}
							var_restrictions.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Restriction.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_restriction_relationship }, rt.ArrayItem{ key: none, val: var_restriction_type }, rt.ArrayItem{ key: none, val: var_restriction_value }])]))
						}
						if rt.is_true(rt.new_bool(var_restrictions.clone().is_array())) {
						var_restrictions = rt.call_function('array_values', [rt.call_function('array_unique', [var_restrictions.clone()])])
						}
					} else {
					var_restrictions = var_restrictions_parent.clone()
					}
					if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('thumbnail')) {
						mut iter_64 := var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('thumbnail')).iterator()
						for {
							item_64 := iter_64.next() or { break }
							mut var_thumbnail := item_64.val
							if var_thumbnail.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('url')) {
								var_thumbnails.array_push(this.sanitize((var_thumbnail.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_thumbnail))))
							}
						}
						if rt.is_true(rt.new_bool(var_thumbnails.clone().is_array())) {
						var_thumbnails = rt.call_function('array_values', [rt.call_function('array_unique', [var_thumbnails.clone()])])
						}
					} else {
					var_thumbnails = var_thumbnails_parent.clone()
					}
					if var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_isset(rt.new_string('title')) {
					var_title = this.sanitize((var_content.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_mediarss()).array_get(rt.new_string('title')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
					} else {
					var_title = var_title_parent.clone()
					}
					this.data.array_get_mut('enclosures').array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Enclosure.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_url }, rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: var_length }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_bitrate }, rt.ArrayItem{ key: none, val: var_captions }, rt.ArrayItem{ key: none, val: var_categories }, rt.ArrayItem{ key: none, val: var_channels }, rt.ArrayItem{ key: none, val: var_copyrights }, rt.ArrayItem{ key: none, val: var_credits }, rt.ArrayItem{ key: none, val: var_description }, rt.ArrayItem{ key: none, val: var_duration }, rt.ArrayItem{ key: none, val: var_expression }, rt.ArrayItem{ key: none, val: var_framerate }, rt.ArrayItem{ key: none, val: var_hashes }, rt.ArrayItem{ key: none, val: var_height }, rt.ArrayItem{ key: none, val: var_keywords }, rt.ArrayItem{ key: none, val: var_lang }, rt.ArrayItem{ key: none, val: var_medium }, rt.ArrayItem{ key: none, val: var_player }, rt.ArrayItem{ key: none, val: var_ratings }, rt.ArrayItem{ key: none, val: var_restrictions }, rt.ArrayItem{ key: none, val: var_samplingrate }, rt.ArrayItem{ key: none, val: var_thumbnails }, rt.ArrayItem{ key: none, val: var_title }, rt.ArrayItem{ key: none, val: var_width }])]))
				}
			}
		}
		mut iter_65 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'link')).iterator()
		for {
			item_65 := iter_65.next() or { break }
			mut var_link := item_65.val
			if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('href')) && !(!rt.is_true(var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('rel')))) && rt.is_true(rt.identical(var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('rel')), rt.new_string('enclosure'))) {
				var_bitrate = rt.new_null()
				var_channels = rt.new_null()
				var_duration = rt.new_null()
				var_expression = rt.new_null()
				var_framerate = rt.new_null()
				var_height = rt.new_null()
				var_javascript = rt.new_null()
				var_lang = rt.new_null()
				var_length = rt.new_null()
				var_medium = rt.new_null()
				var_samplingrate = rt.new_null()
				var_type = rt.new_null()
				var_url = rt.new_null()
				var_width = rt.new_null()
				var_url = this.sanitize((var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('href'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_link)))
				if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('type')) {
				var_type = this.sanitize((var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('type'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('length')) {
				var_length = rt.new_int(var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('length')).to_i64())
				}
				if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('title')) {
				var_title = this.sanitize((var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('title'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				} else {
				var_title = var_title_parent.clone()
				}
				this.data.array_get_mut('enclosures').array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Enclosure.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_url }, rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: var_length }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_bitrate }, rt.ArrayItem{ key: none, val: var_captions_parent }, rt.ArrayItem{ key: none, val: var_categories_parent }, rt.ArrayItem{ key: none, val: var_channels }, rt.ArrayItem{ key: none, val: var_copyrights_parent }, rt.ArrayItem{ key: none, val: var_credits_parent }, rt.ArrayItem{ key: none, val: var_description_parent }, rt.ArrayItem{ key: none, val: var_duration_parent }, rt.ArrayItem{ key: none, val: var_expression }, rt.ArrayItem{ key: none, val: var_framerate }, rt.ArrayItem{ key: none, val: var_hashes_parent }, rt.ArrayItem{ key: none, val: var_height }, rt.ArrayItem{ key: none, val: var_keywords_parent }, rt.ArrayItem{ key: none, val: var_lang }, rt.ArrayItem{ key: none, val: var_medium }, rt.ArrayItem{ key: none, val: var_player_parent }, rt.ArrayItem{ key: none, val: var_ratings_parent }, rt.ArrayItem{ key: none, val: var_restrictions_parent }, rt.ArrayItem{ key: none, val: var_samplingrate }, rt.ArrayItem{ key: none, val: var_thumbnails_parent }, rt.ArrayItem{ key: none, val: var_title }, rt.ArrayItem{ key: none, val: var_width }])]))
			}
		}
		mut iter_66 := rt.cast_array(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'link')).iterator()
		for {
			item_66 := iter_66.next() or { break }
			mut var_link := item_66.val
			if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('href')) && !(!rt.is_true(var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('rel')))) && rt.is_true(rt.identical(var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('rel')), rt.new_string('enclosure'))) {
				var_bitrate = rt.new_null()
				var_channels = rt.new_null()
				var_duration = rt.new_null()
				var_expression = rt.new_null()
				var_framerate = rt.new_null()
				var_height = rt.new_null()
				var_javascript = rt.new_null()
				var_lang = rt.new_null()
				var_length = rt.new_null()
				var_medium = rt.new_null()
				var_samplingrate = rt.new_null()
				var_type = rt.new_null()
				var_url = rt.new_null()
				var_width = rt.new_null()
				var_url = this.sanitize((var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('href'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_link)))
				if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('type')) {
				var_type = this.sanitize((var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('type'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('length')) {
				var_length = rt.new_int(var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('length')).to_i64())
				}
				this.data.array_get_mut('enclosures').array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Enclosure.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_url }, rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: var_length }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_bitrate }, rt.ArrayItem{ key: none, val: var_captions_parent }, rt.ArrayItem{ key: none, val: var_categories_parent }, rt.ArrayItem{ key: none, val: var_channels }, rt.ArrayItem{ key: none, val: var_copyrights_parent }, rt.ArrayItem{ key: none, val: var_credits_parent }, rt.ArrayItem{ key: none, val: var_description_parent }, rt.ArrayItem{ key: none, val: var_duration_parent }, rt.ArrayItem{ key: none, val: var_expression }, rt.ArrayItem{ key: none, val: var_framerate }, rt.ArrayItem{ key: none, val: var_hashes_parent }, rt.ArrayItem{ key: none, val: var_height }, rt.ArrayItem{ key: none, val: var_keywords_parent }, rt.ArrayItem{ key: none, val: var_lang }, rt.ArrayItem{ key: none, val: var_medium }, rt.ArrayItem{ key: none, val: var_player_parent }, rt.ArrayItem{ key: none, val: var_ratings_parent }, rt.ArrayItem{ key: none, val: var_restrictions_parent }, rt.ArrayItem{ key: none, val: var_samplingrate }, rt.ArrayItem{ key: none, val: var_thumbnails_parent }, rt.ArrayItem{ key: none, val: var_title_parent }, rt.ArrayItem{ key: none, val: var_width }])]))
			}
		}
		mut iter_67 := if !(this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'enclosure')).is_null() { this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'enclosure') } else { rt.new_array() }.iterator()
		for {
			item_67 := iter_67.next() or { break }
			mut var_enclosure := item_67.val
			if var_enclosure.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('url')) {
				var_bitrate = rt.new_null()
				var_channels = rt.new_null()
				var_duration = rt.new_null()
				var_expression = rt.new_null()
				var_framerate = rt.new_null()
				var_height = rt.new_null()
				var_javascript = rt.new_null()
				var_lang = rt.new_null()
				var_length = rt.new_null()
				var_medium = rt.new_null()
				var_samplingrate = rt.new_null()
				var_type = rt.new_null()
				var_url = rt.new_null()
				var_width = rt.new_null()
				var_url = this.sanitize((var_enclosure.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('url'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), this.get_own_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_enclosure)))
				var_url = rt.call_method(this.get_sanitize(), 'https_url', [var_url.clone()])
				if var_enclosure.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('type')) {
				var_type = this.sanitize((var_enclosure.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('type'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '')
				}
				if var_enclosure.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('length')) {
				var_length = rt.new_int(var_enclosure.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('length')).to_i64())
				}
				this.data.array_get_mut('enclosures').array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Enclosure.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_url }, rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: var_length }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_bitrate }, rt.ArrayItem{ key: none, val: var_captions_parent }, rt.ArrayItem{ key: none, val: var_categories_parent }, rt.ArrayItem{ key: none, val: var_channels }, rt.ArrayItem{ key: none, val: var_copyrights_parent }, rt.ArrayItem{ key: none, val: var_credits_parent }, rt.ArrayItem{ key: none, val: var_description_parent }, rt.ArrayItem{ key: none, val: var_duration_parent }, rt.ArrayItem{ key: none, val: var_expression }, rt.ArrayItem{ key: none, val: var_framerate }, rt.ArrayItem{ key: none, val: var_hashes_parent }, rt.ArrayItem{ key: none, val: var_height }, rt.ArrayItem{ key: none, val: var_keywords_parent }, rt.ArrayItem{ key: none, val: var_lang }, rt.ArrayItem{ key: none, val: var_medium }, rt.ArrayItem{ key: none, val: var_player_parent }, rt.ArrayItem{ key: none, val: var_ratings_parent }, rt.ArrayItem{ key: none, val: var_restrictions_parent }, rt.ArrayItem{ key: none, val: var_samplingrate }, rt.ArrayItem{ key: none, val: var_thumbnails_parent }, rt.ArrayItem{ key: none, val: var_title_parent }, rt.ArrayItem{ key: none, val: var_width }])]))
			}
		}
		if this.data.array_get(rt.new_string('enclosures')).array_count() == 0 && rt.is_true(var_url) || rt.is_true(var_type) || rt.is_true(var_length) || rt.is_true(var_bitrate) || rt.is_true(var_captions_parent) || rt.is_true(var_categories_parent) || rt.is_true(var_channels) || rt.is_true(var_copyrights_parent) || rt.is_true(var_credits_parent) || rt.is_true(var_description_parent) || rt.is_true(var_duration_parent) || rt.is_true(var_expression) || rt.is_true(var_framerate) || rt.is_true(var_hashes_parent) || rt.is_true(var_height) || rt.is_true(var_keywords_parent) || rt.is_true(var_lang) || rt.is_true(var_medium) || rt.is_true(var_player_parent) || rt.is_true(var_ratings_parent) || rt.is_true(var_samplingrate) || rt.is_true(var_thumbnails_parent) || rt.is_true(var_title_parent) || rt.is_true(var_width) {
			this.data.array_get_mut('enclosures').array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Enclosure.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_url }, rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: var_length }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: var_bitrate }, rt.ArrayItem{ key: none, val: var_captions_parent }, rt.ArrayItem{ key: none, val: var_categories_parent }, rt.ArrayItem{ key: none, val: var_channels }, rt.ArrayItem{ key: none, val: var_copyrights_parent }, rt.ArrayItem{ key: none, val: var_credits_parent }, rt.ArrayItem{ key: none, val: var_description_parent }, rt.ArrayItem{ key: none, val: var_duration_parent }, rt.ArrayItem{ key: none, val: var_expression }, rt.ArrayItem{ key: none, val: var_framerate }, rt.ArrayItem{ key: none, val: var_hashes_parent }, rt.ArrayItem{ key: none, val: var_height }, rt.ArrayItem{ key: none, val: var_keywords_parent }, rt.ArrayItem{ key: none, val: var_lang }, rt.ArrayItem{ key: none, val: var_medium }, rt.ArrayItem{ key: none, val: var_player_parent }, rt.ArrayItem{ key: none, val: var_ratings_parent }, rt.ArrayItem{ key: none, val: var_restrictions_parent }, rt.ArrayItem{ key: none, val: var_samplingrate }, rt.ArrayItem{ key: none, val: var_thumbnails_parent }, rt.ArrayItem{ key: none, val: var_title_parent }, rt.ArrayItem{ key: none, val: var_width }])]))
		}
		this.data.array_set('enclosures', rt.call_function('array_values', [rt.call_function('array_unique', [this.data.array_get(rt.new_string('enclosures'))])]))
	}
	if !(!rt.is_true(this.data.array_get(rt.new_string('enclosures')))) {
		return this.data.array_get(rt.new_string('enclosures'))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_latitude() rt.PhpVal {
	mut var_match := rt.new_null()
	mut var_return := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_w3c_basic_geo()).str(), 'lat')
	if rt.is_true(var_return) {
		return rt.new_float((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).to_f64())
	var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_georss()).str(), 'point')
	} else if rt.is_true(var_return) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^((?:-)?[0-9]+(?:\\.[0-9]+)) ((?:-)?[0-9]+(?:\\.[0-9]+))$/'), rt.new_string(var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')).to_string().trim_space()), var_match.clone()])) {
		return rt.new_float((var_match.array_get(rt.new_int(1))).to_f64())
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_longitude() rt.PhpVal {
	mut var_match := rt.new_null()
	mut var_return := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_w3c_basic_geo()).str(), 'long')
	if rt.is_true(var_return) {
		return rt.new_float((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).to_f64())
	var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_w3c_basic_geo()).str(), 'lon')
	} else if rt.is_true(var_return) {
		return rt.new_float((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).to_f64())
	var_return = this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_georss()).str(), 'point')
	} else if rt.is_true(var_return) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^((?:-)?[0-9]+(?:\\.[0-9]+)) ((?:-)?[0-9]+(?:\\.[0-9]+))$/'), rt.new_string(var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')).to_string().trim_space()), var_match.clone()])) {
		return rt.new_float((var_match.array_get(rt.new_int(2))).to_f64())
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) get_source() rt.PhpVal {
	mut var_return := this.get_item_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'source')
	if rt.is_true(var_return) {
		return rt.call_method(this.registry, 'create', [Class_SimplePie_Source.class(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('SimplePie_Item', ['RegistryAware'], &this) }, rt.ArrayItem{ key: none, val: var_return.array_get(rt.new_int(0)) }])])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Item) set_sanitize(mut var_sanitize Class_SimplePie_Sanitize) {
	this.sanitize = var_sanitize
}

fn (mut this Class_SimplePie_Item) get_sanitize() rt.PhpVal {
	if rt.is_true(rt.identical(this.sanitize, rt.new_null())) {
		this.sanitize = create_simplepie_sanitize()
	}
	return this.sanitize
}

struct Class_SimplePie_SimplePie_Restriction {
	rt.PhpObjectBase
}

struct Class_SimplePie_Sanitize {
	rt.PhpObjectBase
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

fn create_simplepie_simplepie_restriction(_args ...rt.PhpVal) &Class_SimplePie_SimplePie_Restriction {
	mut obj := &Class_SimplePie_SimplePie_Restriction{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_sanitize(_args ...rt.PhpVal) &Class_SimplePie_Sanitize {
	mut obj := &Class_SimplePie_Sanitize{
		PhpObjectBase: rt.PhpObjectBase{}
	}
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


fn (mut this Class_SimplePie_SimplePie_Restriction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_SimplePie_Restriction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_SimplePie_Restriction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_Sanitize) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Sanitize) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Sanitize) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [rt.new_string('SimplePie\\Item'), rt.new_string('SimplePie_Item')])
}
