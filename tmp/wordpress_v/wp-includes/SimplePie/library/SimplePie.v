import rt

const global_const_simplepie_name = Class_SimplePie_SimplePie.name()
const global_const_simplepie_version = Class_SimplePie_SimplePie.version()
const global_const_simplepie_build = rt.call_function('gmdate', [rt.new_string('YmdHis'), fn () rt.PhpVal { mut temp := Class_SimplePie_Misc{}; return temp.get_build() }()])
const global_const_simplepie_url = Class_SimplePie_SimplePie.url()
const global_const_simplepie_useragent = fn () rt.PhpVal { mut temp := Class_SimplePie_Misc{}; return temp.get_default_useragent() }()
const global_const_simplepie_linkback = Class_SimplePie_SimplePie.linkback()
const global_const_simplepie_locator_none = Class_SimplePie_SimplePie.locator_none()
const global_const_simplepie_locator_autodiscovery = Class_SimplePie_SimplePie.locator_autodiscovery()
const global_const_simplepie_locator_local_extension = Class_SimplePie_SimplePie.locator_local_extension()
const global_const_simplepie_locator_local_body = Class_SimplePie_SimplePie.locator_local_body()
const global_const_simplepie_locator_remote_extension = Class_SimplePie_SimplePie.locator_remote_extension()
const global_const_simplepie_locator_remote_body = Class_SimplePie_SimplePie.locator_remote_body()
const global_const_simplepie_locator_all = Class_SimplePie_SimplePie.locator_all()
const global_const_simplepie_type_none = Class_SimplePie_SimplePie.type_none()
const global_const_simplepie_type_rss_090 = Class_SimplePie_SimplePie.type_rss_090()
const global_const_simplepie_type_rss_091_netscape = Class_SimplePie_SimplePie.type_rss_091_netscape()
const global_const_simplepie_type_rss_091_userland = Class_SimplePie_SimplePie.type_rss_091_userland()
const global_const_simplepie_type_rss_091 = Class_SimplePie_SimplePie.type_rss_091()
const global_const_simplepie_type_rss_092 = Class_SimplePie_SimplePie.type_rss_092()
const global_const_simplepie_type_rss_093 = Class_SimplePie_SimplePie.type_rss_093()
const global_const_simplepie_type_rss_094 = Class_SimplePie_SimplePie.type_rss_094()
const global_const_simplepie_type_rss_10 = Class_SimplePie_SimplePie.type_rss_10()
const global_const_simplepie_type_rss_20 = Class_SimplePie_SimplePie.type_rss_20()
const global_const_simplepie_type_rss_rdf = Class_SimplePie_SimplePie.type_rss_rdf()
const global_const_simplepie_type_rss_syndication = Class_SimplePie_SimplePie.type_rss_syndication()
const global_const_simplepie_type_rss_all = Class_SimplePie_SimplePie.type_rss_all()
const global_const_simplepie_type_atom_03 = Class_SimplePie_SimplePie.type_atom_03()
const global_const_simplepie_type_atom_10 = Class_SimplePie_SimplePie.type_atom_10()
const global_const_simplepie_type_atom_all = Class_SimplePie_SimplePie.type_atom_all()
const global_const_simplepie_type_all = Class_SimplePie_SimplePie.type_all()
const global_const_simplepie_construct_none = Class_SimplePie_SimplePie.construct_none()
const global_const_simplepie_construct_text = Class_SimplePie_SimplePie.construct_text()
const global_const_simplepie_construct_html = Class_SimplePie_SimplePie.construct_html()
const global_const_simplepie_construct_xhtml = Class_SimplePie_SimplePie.construct_xhtml()
const global_const_simplepie_construct_base64 = Class_SimplePie_SimplePie.construct_base64()
const global_const_simplepie_construct_iri = Class_SimplePie_SimplePie.construct_iri()
const global_const_simplepie_construct_maybe_html = Class_SimplePie_SimplePie.construct_maybe_html()
const global_const_simplepie_construct_all = Class_SimplePie_SimplePie.construct_all()
const global_const_simplepie_same_case = Class_SimplePie_SimplePie.same_case()
const global_const_simplepie_lowercase = Class_SimplePie_SimplePie.lowercase()
const global_const_simplepie_uppercase = Class_SimplePie_SimplePie.uppercase()
const global_const_simplepie_pcre_html_attribute = Class_SimplePie_SimplePie.pcre_html_attribute()
const global_const_simplepie_pcre_xml_attribute = Class_SimplePie_SimplePie.pcre_xml_attribute()
const global_const_simplepie_namespace_xml = Class_SimplePie_SimplePie.namespace_xml()
const global_const_simplepie_namespace_atom_10 = Class_SimplePie_SimplePie.namespace_atom_10()
const global_const_simplepie_namespace_atom_03 = Class_SimplePie_SimplePie.namespace_atom_03()
const global_const_simplepie_namespace_rdf = Class_SimplePie_SimplePie.namespace_rdf()
const global_const_simplepie_namespace_rss_090 = Class_SimplePie_SimplePie.namespace_rss_090()
const global_const_simplepie_namespace_rss_10 = Class_SimplePie_SimplePie.namespace_rss_10()
const global_const_simplepie_namespace_rss_10_modules_content = Class_SimplePie_SimplePie.namespace_rss_10_modules_content()
const global_const_simplepie_namespace_rss_20 = Class_SimplePie_SimplePie.namespace_rss_20()
const global_const_simplepie_namespace_dc_10 = Class_SimplePie_SimplePie.namespace_dc_10()
const global_const_simplepie_namespace_dc_11 = Class_SimplePie_SimplePie.namespace_dc_11()
const global_const_simplepie_namespace_w3c_basic_geo = Class_SimplePie_SimplePie.namespace_w3c_basic_geo()
const global_const_simplepie_namespace_georss = Class_SimplePie_SimplePie.namespace_georss()
const global_const_simplepie_namespace_mediarss = Class_SimplePie_SimplePie.namespace_mediarss()
const global_const_simplepie_namespace_mediarss_wrong = Class_SimplePie_SimplePie.namespace_mediarss_wrong()
const global_const_simplepie_namespace_mediarss_wrong2 = Class_SimplePie_SimplePie.namespace_mediarss_wrong2()
const global_const_simplepie_namespace_mediarss_wrong3 = Class_SimplePie_SimplePie.namespace_mediarss_wrong3()
const global_const_simplepie_namespace_mediarss_wrong4 = Class_SimplePie_SimplePie.namespace_mediarss_wrong4()
const global_const_simplepie_namespace_mediarss_wrong5 = Class_SimplePie_SimplePie.namespace_mediarss_wrong5()
const global_const_simplepie_namespace_itunes = Class_SimplePie_SimplePie.namespace_itunes()
const global_const_simplepie_namespace_xhtml = Class_SimplePie_SimplePie.namespace_xhtml()
const global_const_simplepie_iana_link_relations_registry = Class_SimplePie_SimplePie.iana_link_relations_registry()
const global_const_simplepie_file_source_none = Class_SimplePie_SimplePie.file_source_none()
const global_const_simplepie_file_source_remote = Class_SimplePie_SimplePie.file_source_remote()
const global_const_simplepie_file_source_local = Class_SimplePie_SimplePie.file_source_local()
const global_const_simplepie_file_source_fsockopen = Class_SimplePie_SimplePie.file_source_fsockopen()
const global_const_simplepie_file_source_curl = Class_SimplePie_SimplePie.file_source_curl()
const global_const_simplepie_file_source_file_get_contents = Class_SimplePie_SimplePie.file_source_file_get_contents()
struct Class_SimplePie {
	rt.PhpObjectBase
}

struct Class_SimplePie_SimplePie {
	rt.PhpObjectBase
}

struct Class_SimplePie_Misc {
	rt.PhpObjectBase
}

fn create_simplepie() &Class_SimplePie {
	mut obj := &Class_SimplePie{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_simplepie() &Class_SimplePie_SimplePie {
	mut obj := &Class_SimplePie_SimplePie{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_misc() &Class_SimplePie_Misc {
	mut obj := &Class_SimplePie_Misc{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_SimplePie) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_SimplePie) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_SimplePie) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_Misc) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Misc) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Misc) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_simplepie_library_simplepie_php() {
	// unsupported statement: Stmt_Declare
	rt.call_function('class_exists', [rt.new_string('SimplePie\\SimplePie')])
	if false {
	}
}
