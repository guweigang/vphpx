import rt

struct Class_WP_PHPMailer {
	rt.PhpObjectBase
}

fn (mut this Class_WP_PHPMailer) construct(exceptions bool) {
	this.Class_PHPMailer_PHPMailer_PHPMailer.construct(rt.new_bool(exceptions))
	Class_WP_PHPMailer.setlanguage()
}

fn Class_WP_PHPMailer.setlanguage(langcode string, lang_path string) bool {
	// unsupported assign target: Expr_StaticPropertyFetch
	return true
}

struct Class_PHPMailer_PHPMailer_PHPMailer {
	rt.PhpObjectBase
}

fn create_wp_phpmailer(exceptions bool) &Class_WP_PHPMailer {
	mut obj := &Class_WP_PHPMailer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(exceptions)
	return obj
}

fn create_phpmailer_phpmailer_phpmailer() &Class_PHPMailer_PHPMailer_PHPMailer {
	mut obj := &Class_PHPMailer_PHPMailer_PHPMailer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_PHPMailer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'setLanguage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WP_PHPMailer.setlanguage(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_PHPMailer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_PHPMailer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PHPMailer_PHPMailer_PHPMailer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_class_wp_phpmailer_php() {
}
