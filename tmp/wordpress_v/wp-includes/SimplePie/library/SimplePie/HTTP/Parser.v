import rt

struct Class_SimplePie_HTTP_Parser {
	rt.PhpObjectBase
}

fn create_simplepie_http_parser() &Class_SimplePie_HTTP_Parser {
	mut obj := &Class_SimplePie_HTTP_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_HTTP_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_HTTP_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_HTTP_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_simplepie_library_simplepie_http_parser_php() {
	// unsupported statement: Stmt_Declare
	rt.call_function('class_exists', [rt.new_string('SimplePie\\HTTP\\Parser')])
	if false {
	}
}
