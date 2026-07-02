import rt

struct Class_WP_Text_Diff_Renderer_inline {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Text_Diff_Renderer_inline) _splitonwords(var_string rt.PhpVal, newlineEscape string) rt.PhpVal {
	mut var_string_mutated := var_string
	var_string_mutated = rt.call_function('str_replace', [rt.new_string(''),
		rt.new_string(''), var_string_mutated.clone()])
	mut var_words := rt.call_function('preg_split', [rt.new_string('/([^\\w])/u'),
		var_string_mutated.clone(), rt.new_int(-1), rt.get_constant('PREG_SPLIT_DELIM_CAPTURE')])
	var_words = rt.call_function('str_replace', [rt.new_string('\n'),
		rt.new_string(newlineEscape), var_words.clone()])
	return var_words.clone()
}

struct Class_Text_Diff_Renderer_inline {
	rt.PhpObjectBase
}

fn create_wp_text_diff_renderer_inline(_args ...rt.PhpVal) &Class_WP_Text_Diff_Renderer_inline {
	mut obj := &Class_WP_Text_Diff_Renderer_inline{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_text_diff_renderer_inline(_args ...rt.PhpVal) &Class_Text_Diff_Renderer_inline {
	mut obj := &Class_Text_Diff_Renderer_inline{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Text_Diff_Renderer_inline) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'_splitOnWords' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this._splitonwords(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Text_Diff_Renderer_inline) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Text_Diff_Renderer_inline) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Text_Diff_Renderer_inline) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Text_Diff_Renderer_inline) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Text_Diff_Renderer_inline) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
