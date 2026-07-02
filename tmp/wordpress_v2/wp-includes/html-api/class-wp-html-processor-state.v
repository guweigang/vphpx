import rt

pub fn Class_WP_HTML_Processor_State.insertion_mode_initial() string {
	return 'insertion-mode-initial'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_before_html() string {
	return 'insertion-mode-before-html'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_before_head() string {
	return 'insertion-mode-before-head'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_in_head() string {
	return 'insertion-mode-in-head'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_in_head_noscript() string {
	return 'insertion-mode-in-head-noscript'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_after_head() string {
	return 'insertion-mode-after-head'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_in_body() string {
	return 'insertion-mode-in-body'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_in_table() string {
	return 'insertion-mode-in-table'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_in_table_text() string {
	return 'insertion-mode-in-table-text'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_in_caption() string {
	return 'insertion-mode-in-caption'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_in_column_group() string {
	return 'insertion-mode-in-column-group'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_in_table_body() string {
	return 'insertion-mode-in-table-body'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_in_row() string {
	return 'insertion-mode-in-row'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_in_cell() string {
	return 'insertion-mode-in-cell'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_in_select() string {
	return 'insertion-mode-in-select'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_in_select_in_table() string {
	return 'insertion-mode-in-select-in-table'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_in_template() string {
	return 'insertion-mode-in-template'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_after_body() string {
	return 'insertion-mode-after-body'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_in_frameset() string {
	return 'insertion-mode-in-frameset'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_after_frameset() string {
	return 'insertion-mode-after-frameset'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_after_after_body() string {
	return 'insertion-mode-after-after-body'
}

pub fn Class_WP_HTML_Processor_State.insertion_mode_after_after_frameset() string {
	return 'insertion-mode-after-after-frameset'
}

struct Class_WP_HTML_Processor_State {
	rt.PhpObjectBase
pub mut:
	stack_of_template_insertion_modes rt.PhpVal = rt.new_array()
	stack_of_open_elements            rt.PhpVal = rt.new_null()
	active_formatting_elements        rt.PhpVal = rt.new_null()
	current_token                     rt.PhpVal = rt.new_null()
	insertion_mode                    rt.PhpVal = rt.new_null()
	context_node                      rt.PhpVal = rt.new_null()
	encoding                          rt.PhpVal = rt.new_null()
	encoding_confidence               rt.PhpVal = rt.new_string('tentative')
	head_element                      rt.PhpVal = rt.new_null()
	form_element                      rt.PhpVal = rt.new_null()
	frameset_ok                       rt.PhpVal = rt.new_bool(true)
}

fn (mut this Class_WP_HTML_Processor_State) construct() {
	this.stack_of_open_elements = create_wp_html_open_elements()
	this.active_formatting_elements = create_wp_html_active_formatting_elements()
}

struct Class_WP_HTML_Open_Elements {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Active_Formatting_Elements {
	rt.PhpObjectBase
}

fn create_wp_html_processor_state() &Class_WP_HTML_Processor_State {
	mut obj := &Class_WP_HTML_Processor_State{
		PhpObjectBase:                     rt.PhpObjectBase{}
		stack_of_template_insertion_modes: rt.new_array()
		stack_of_open_elements:            rt.new_null()
		active_formatting_elements:        rt.new_null()
		current_token:                     rt.new_null()
		insertion_mode:                    rt.new_null()
		context_node:                      rt.new_null()
		encoding:                          rt.new_null()
		encoding_confidence:               rt.new_string('tentative')
		head_element:                      rt.new_null()
		form_element:                      rt.new_null()
		frameset_ok:                       rt.new_bool(true)
	}
	obj.construct()
	return obj
}

fn create_wp_html_open_elements(_args ...rt.PhpVal) &Class_WP_HTML_Open_Elements {
	mut obj := &Class_WP_HTML_Open_Elements{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_active_formatting_elements(_args ...rt.PhpVal) &Class_WP_HTML_Active_Formatting_Elements {
	mut obj := &Class_WP_HTML_Active_Formatting_Elements{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_HTML_Processor_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_HTML_Processor_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'stack_of_template_insertion_modes' { return this.stack_of_template_insertion_modes }
		'stack_of_open_elements' { return this.stack_of_open_elements }
		'active_formatting_elements' { return this.active_formatting_elements }
		'current_token' { return this.current_token }
		'insertion_mode' { return this.insertion_mode }
		'context_node' { return this.context_node }
		'encoding' { return this.encoding }
		'encoding_confidence' { return this.encoding_confidence }
		'head_element' { return this.head_element }
		'form_element' { return this.form_element }
		'frameset_ok' { return this.frameset_ok }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTML_Processor_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'stack_of_template_insertion_modes' {
			this.stack_of_template_insertion_modes = val
			return true
		}
		'stack_of_open_elements' {
			this.stack_of_open_elements = val
			return true
		}
		'active_formatting_elements' {
			this.active_formatting_elements = val
			return true
		}
		'current_token' {
			this.current_token = val
			return true
		}
		'insertion_mode' {
			this.insertion_mode = val
			return true
		}
		'context_node' {
			this.context_node = val
			return true
		}
		'encoding' {
			this.encoding = val
			return true
		}
		'encoding_confidence' {
			this.encoding_confidence = val
			return true
		}
		'head_element' {
			this.head_element = val
			return true
		}
		'form_element' {
			this.form_element = val
			return true
		}
		'frameset_ok' {
			this.frameset_ok = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_HTML_Open_Elements) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Open_Elements) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Open_Elements) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_HTML_Active_Formatting_Elements) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Active_Formatting_Elements) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Active_Formatting_Elements) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
