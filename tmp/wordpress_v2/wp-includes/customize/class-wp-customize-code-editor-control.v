import rt

struct Class_WP_Customize_Code_Editor_Control {
	rt.PhpObjectBase
pub mut:
	prop_type       rt.PhpVal = rt.new_string('code_editor')
	code_type       rt.PhpVal = rt.new_string('')
	editor_settings rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Customize_Code_Editor_Control) enqueue() {
	this.editor_settings = rt.call_function('wp_enqueue_code_editor', [
		rt.call_function('array_merge', [
			rt.create_array([rt.ArrayItem{ key: 'type', val: this.code_type },
				rt.ArrayItem{ key: 'codemirror', val: rt.create_array([
					rt.ArrayItem{ key: 'indentUnit', val: 2 },
					rt.ArrayItem{ key: 'tabSize', val: 2 },
				]) }]),
			this.editor_settings,
		]),
	])
}

fn (mut this Class_WP_Customize_Code_Editor_Control) json() rt.PhpVal {
	mut var_json := this.Class_WP_Customize_Control.json()
	var_json.array_set('editor_settings', this.editor_settings)
	var_json.array_set('input_attrs', rt.get_property(rt.new_object('WP_Customize_Code_Editor_Control', [
		'WP_Customize_Control',
	], &this), 'input_attrs'))
	return var_json.clone()
}

fn (mut this Class_WP_Customize_Code_Editor_Control) render_content() {
}

fn (mut this Class_WP_Customize_Code_Editor_Control) content_template() {
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_code_editor_control(_args ...rt.PhpVal) &Class_WP_Customize_Code_Editor_Control {
	mut obj := &Class_WP_Customize_Code_Editor_Control{
		PhpObjectBase:   rt.PhpObjectBase{}
		prop_type:       rt.new_string('code_editor')
		code_type:       rt.new_string('')
		editor_settings: rt.new_array()
	}
	return obj
}

fn create_wp_customize_control(_args ...rt.PhpVal) &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Code_Editor_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'enqueue' {
			this.enqueue()
			return rt.new_null()
		}
		'json' {
			return this.json()
		}
		'render_content' {
			this.render_content()
			return rt.new_null()
		}
		'content_template' {
			this.content_template()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Code_Editor_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'code_type' { return this.code_type }
		'editor_settings' { return this.editor_settings }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Code_Editor_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'code_type' {
			this.code_type = val
			return true
		}
		'editor_settings' {
			this.editor_settings = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Customize_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
