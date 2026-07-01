import rt

pub fn Class_WP_HTML_Tag_Processor.max_bookmarks() i64 {
	return 10
}
pub fn Class_WP_HTML_Tag_Processor.max_seek_ops() i64 {
	return 1000
}
pub fn Class_WP_HTML_Tag_Processor.add_class() bool {
	return true
}
pub fn Class_WP_HTML_Tag_Processor.remove_class() bool {
	return false
}
pub fn Class_WP_HTML_Tag_Processor.skip_class() rt.PhpVal {
	return none
}
pub fn Class_WP_HTML_Tag_Processor.state_ready() string {
	return 'STATE_READY'
}
pub fn Class_WP_HTML_Tag_Processor.state_complete() string {
	return 'STATE_COMPLETE'
}
pub fn Class_WP_HTML_Tag_Processor.state_incomplete_input() string {
	return 'STATE_INCOMPLETE_INPUT'
}
pub fn Class_WP_HTML_Tag_Processor.state_matched_tag() string {
	return 'STATE_MATCHED_TAG'
}
pub fn Class_WP_HTML_Tag_Processor.state_text_node() string {
	return 'STATE_TEXT_NODE'
}
pub fn Class_WP_HTML_Tag_Processor.state_cdata_node() string {
	return 'STATE_CDATA_NODE'
}
pub fn Class_WP_HTML_Tag_Processor.state_comment() string {
	return 'STATE_COMMENT'
}
pub fn Class_WP_HTML_Tag_Processor.state_doctype() string {
	return 'STATE_DOCTYPE'
}
pub fn Class_WP_HTML_Tag_Processor.state_presumptuous_tag() string {
	return 'STATE_PRESUMPTUOUS_TAG'
}
pub fn Class_WP_HTML_Tag_Processor.state_funky_comment() string {
	return 'STATE_WP_FUNKY'
}
pub fn Class_WP_HTML_Tag_Processor.comment_as_abruptly_closed_comment() string {
	return 'COMMENT_AS_ABRUPTLY_CLOSED_COMMENT'
}
pub fn Class_WP_HTML_Tag_Processor.comment_as_cdata_lookalike() string {
	return 'COMMENT_AS_CDATA_LOOKALIKE'
}
pub fn Class_WP_HTML_Tag_Processor.comment_as_html_comment() string {
	return 'COMMENT_AS_HTML_COMMENT'
}
pub fn Class_WP_HTML_Tag_Processor.comment_as_pi_node_lookalike() string {
	return 'COMMENT_AS_PI_NODE_LOOKALIKE'
}
pub fn Class_WP_HTML_Tag_Processor.comment_as_invalid_html() string {
	return 'COMMENT_AS_INVALID_HTML'
}
pub fn Class_WP_HTML_Tag_Processor.no_quirks_mode() string {
	return 'no-quirks-mode'
}
pub fn Class_WP_HTML_Tag_Processor.quirks_mode() string {
	return 'quirks-mode'
}
pub fn Class_WP_HTML_Tag_Processor.text_is_generic() string {
	return 'TEXT_IS_GENERIC'
}
pub fn Class_WP_HTML_Tag_Processor.text_is_null_sequence() string {
	return 'TEXT_IS_NULL_SEQUENCE'
}
pub fn Class_WP_HTML_Tag_Processor.text_is_whitespace() string {
	return 'TEXT_IS_WHITESPACE'
}
struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
pub mut:
		html rt.PhpVal = rt.new_null()
		last_query rt.PhpVal = rt.new_null()
		sought_tag_name rt.PhpVal = rt.new_null()
		sought_class_name rt.PhpVal = rt.new_null()
		sought_match_offset rt.PhpVal = rt.new_null()
		stop_on_tag_closers bool
		parser_state rt.PhpVal = rt.new_null()
		compat_mode rt.PhpVal = rt.new_null()
		parsing_namespace rt.PhpVal = rt.new_string('html')
		comment_type rt.PhpVal = rt.new_null()
		text_node_classification rt.PhpVal = rt.new_null()
		bytes_already_parsed rt.PhpVal = rt.new_int(0)
		token_starts_at rt.PhpVal = rt.new_null()
		token_length rt.PhpVal = rt.new_null()
		tag_name_starts_at rt.PhpVal = rt.new_null()
		tag_name_length rt.PhpVal = rt.new_null()
		text_starts_at rt.PhpVal = rt.new_null()
		text_length rt.PhpVal = rt.new_null()
		is_closing_tag rt.PhpVal = rt.new_null()
		attributes rt.PhpVal = rt.new_array()
		duplicate_attributes rt.PhpVal = rt.new_null()
		classname_updates rt.PhpVal = rt.new_array()
		bookmarks rt.PhpVal = rt.new_array()
		lexical_updates rt.PhpVal = rt.new_array()
		seek_count rt.PhpVal = rt.new_int(0)
		skip_newline_at rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_HTML_Tag_Processor) construct(var_html rt.PhpVal)  {
	mut var_html_mutated := var_html
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_html_mutated.dup().is_string()))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The HTML parameter must be a string.')]), rt.new_string('6.9.0')])
		var_html_mutated = rt.new_string(rt.new_string(''))
	}
	this.html = var_html_mutated.dup()
}

fn (mut this Class_WP_HTML_Tag_Processor) change_parsing_namespace(new_namespace string) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(new_namespace), rt.create_array([rt.ArrayItem{ key: none, val: 'html' }, rt.ArrayItem{ key: none, val: 'math' }, rt.ArrayItem{ key: none, val: 'svg' }]), rt.new_bool(true)]))))) {
		return false
	}
	this.parsing_namespace = rt.new_string(new_namespace).dup()
	return true
}

fn (mut this Class_WP_HTML_Tag_Processor) next_tag(var_query rt.PhpVal) bool {
	this.parse_query(var_query.dup())
	mut var_already_found := rt.new_int(rt.new_int(0))
	for {
		if rt.is_true(rt.identical(rt.new_bool(false), this.next_token())) {
			return false
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			continue
		}
		if this.matches() {
			rt.pre_inc(var_already_found)
		}
		if !(rt.is_true(rt.less(var_already_found, this.sought_match_offset))) {
			break
		}
	}
	return true
}

fn (mut this Class_WP_HTML_Tag_Processor) next_token() bool {
	return this.base_class_next_token()
}

fn (mut this Class_WP_HTML_Tag_Processor) base_class_next_token() bool {
	mut var_was_at := this.bytes_already_parsed
	this.after_tag()
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_complete(), this.parser_state)) || rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_incomplete_input(), this.parser_state)))) {
		return false
	}
	this.parser_state = Class_WP_HTML_Tag_Processor.state_ready()
	if rt.is_true(rt.greater_equal(this.bytes_already_parsed, rt.new_int(this.html.to_string().len))) {
		this.parser_state = Class_WP_HTML_Tag_Processor.state_complete()
		return false
	}
	if rt.is_true(rt.identical(rt.new_bool(false), this.parse_next_tag())) {
		if rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_incomplete_input(), this.parser_state)) {
			this.bytes_already_parsed = var_was_at.dup()
		}
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return true
	}
	for this.parse_next_attribute() {
		continue
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_incomplete_input(), this.parser_state)) || rt.is_true(rt.greater_equal(this.bytes_already_parsed, rt.new_int(this.html.to_string().len))))) {
		this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
		this.bytes_already_parsed = var_was_at.dup()
		return false
	}
	mut var_tag_ends_at := rt.call_function('strpos', [this.html, rt.new_string('>'), this.bytes_already_parsed])
	if rt.is_true(rt.identical(rt.new_bool(false), var_tag_ends_at)) {
		this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
		this.bytes_already_parsed = var_was_at.dup()
		return false
	}
	this.parser_state = Class_WP_HTML_Tag_Processor.state_matched_tag()
	this.bytes_already_parsed = rt.add(var_tag_ends_at, rt.new_int(1))
	this.token_length = rt.sub(this.bytes_already_parsed, this.token_starts_at)
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.is_closing_tag) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return true
	}
	mut var_tag_name := rt.new_string(this.get_tag())
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('LISTING'), var_tag_name)) || rt.is_true(rt.identical(rt.new_string('PRE'), var_tag_name)))) {
		this.skip_newline_at = this.bytes_already_parsed
		return true
	}
	mut var_tag_name_starts_at := this.tag_name_starts_at
	mut var_tag_name_length := this.tag_name_length
	var_tag_ends_at = rt.add(this.token_starts_at, this.token_length)
	mut var_attributes := this.attributes
	mut var_duplicate_attributes := this.duplicate_attributes
	mut switch_val_1 := var_tag_name
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('SCRIPT'))) {
		mut var_found_closer := rt.new_bool(this.skip_script_data())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('TEXTAREA'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('TITLE'))) {
		var_found_closer = rt.new_bool(this.skip_rcdata((var_tag_name).str()))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('IFRAME'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('NOEMBED'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('NOFRAMES'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('STYLE'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('XMP'))) {
		var_found_closer = rt.new_bool(this.skip_rawtext((var_tag_name).str()))
	} else {
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_found_closer)))) {
		this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
		this.bytes_already_parsed = var_was_at.dup()
		return false
	}
	this.token_starts_at = var_was_at.dup()
	this.token_length = rt.sub(this.bytes_already_parsed, this.token_starts_at)
	this.text_starts_at = var_tag_ends_at.dup()
	this.text_length = rt.sub(this.tag_name_starts_at, this.text_starts_at)
	this.tag_name_starts_at = var_tag_name_starts_at.dup()
	this.tag_name_length = var_tag_name_length.dup()
	this.attributes = var_attributes.dup()
	this.duplicate_attributes = var_duplicate_attributes.dup()
	return true
}

fn (mut this Class_WP_HTML_Tag_Processor) paused_at_incomplete_token() bool {
	return (rt.identical(Class_WP_HTML_Tag_Processor.state_incomplete_input(), this.parser_state)).to_bool()
}

fn (mut this Class_WP_HTML_Tag_Processor) class_list()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	mut var_class := this.get_attribute(rt.new_string('class'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_class.dup().is_string()))))) {
		return rt.new_null()
	}
	mut var_seen := []rt.PhpVal{}
	mut var_is_quirks := rt.identical(Class_WP_HTML_Tag_Processor.quirks_mode(), this.compat_mode)
	mut var_at := rt.new_int(rt.new_int(0))
	for rt.is_true(rt.less(var_at, rt.new_int(var_class.dup().to_string().len))) {
		// unsupported expression: Expr_AssignOp_Plus
		if rt.is_true(rt.greater_equal(var_at, rt.new_int(var_class.dup().to_string().len))) {
			return rt.new_null()
		}
		mut var_length := rt.call_function('strcspn', [var_class.dup(), rt.new_string(' \t\r\n'), var_at.dup()])
		if rt.is_true(rt.identical(rt.new_int(0), var_length)) {
			return rt.new_null()
		}
		mut var_name := rt.call_function('str_replace', [rt.new_string(''), rt.new_string('�'), rt.call_function('substr', [var_class.dup(), var_at.dup(), var_length.dup()])])
		if rt.is_true(var_is_quirks) {
			var_name = rt.new_string(rt.new_string(var_name.dup().to_string().to_lower()))
		}
		// unsupported expression: Expr_AssignOp_Plus
		if rt.is_true(rt.call_function('in_array', [var_name.dup(), var_seen.dup(), rt.new_bool(true)])) {
			continue
		}
		var_seen << var_name.dup()
		// unsupported expression: Expr_Yield
	}
}

fn (mut this Class_WP_HTML_Tag_Processor) has_class(var_wanted_class rt.PhpVal) bool {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (rt.new_null()).to_bool()
	}
	mut var_case_insensitive := rt.identical(Class_WP_HTML_Tag_Processor.quirks_mode(), this.compat_mode)
	mut var_wanted_length := rt.new_int(rt.new_int(var_wanted_class.dup().to_string().len))
	{
		mut iter_1 := this.class_list().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_class_name := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(var_class_name.dup().to_string().len), var_wanted_length)) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [var_class_name.dup(), var_wanted_class.dup(), rt.new_int(0), rt.new_int(var_wanted_class.dup().to_string().len), var_case_insensitive.dup()]))))) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_WP_HTML_Tag_Processor) set_bookmark(var_name rt.PhpVal) bool {
	mut var_name_mutated := var_name
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_complete(), this.parser_state)) || rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_incomplete_input(), this.parser_state)))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.bookmarks.array_isset(var_name_mutated.dup())))))) && rt.is_true(rt.greater_equal(rt.new_int(this.bookmarks.array_count()), Class_static.max_bookmarks())))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Too many bookmarks: cannot create any more.')]), rt.new_string('6.2.0')])
		return false
	}
	this.bookmarks.array_set(var_name_mutated, create_wp_html_span(this.token_starts_at, this.token_length))
	return true
}

fn (mut this Class_WP_HTML_Tag_Processor) release_bookmark(var_name rt.PhpVal) bool {
	mut var_name_mutated := var_name
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.bookmarks.array_isset(var_name_mutated.dup())))))) {
		return false
	}
	this.bookmarks.array_unset(var_name_mutated)
	return true
}

fn (mut this Class_WP_HTML_Tag_Processor) skip_rawtext(tag_name string) bool {
	mut tag_name_mutated := tag_name
	return this.skip_rcdata(tag_name_mutated)
}

fn (mut this Class_WP_HTML_Tag_Processor) skip_rcdata(tag_name string) bool {
	mut tag_name_mutated := tag_name
	mut var_html := this.html
	mut var_doc_length := rt.new_int(rt.new_int(var_html.dup().to_string().len))
	mut var_tag_length := rt.new_int(rt.new_int(.len))
	mut var_at := 
	for rt.is_true() {
	}
}

fn (mut this Class_WP_HTML_Tag_Processor) skip_script_data() bool {
}

fn (mut this Class_WP_HTML_Tag_Processor) parse_next_tag() bool {
}

fn (mut this Class_WP_HTML_Tag_Processor) parse_next_attribute() bool {
}

fn (mut this Class_WP_HTML_Tag_Processor) skip_whitespace()  {
}

fn (mut this Class_WP_HTML_Tag_Processor) after_tag()  {
}

fn (mut this Class_WP_HTML_Tag_Processor) class_name_updates_to_attributes_updates()  {
}

fn (mut this Class_WP_HTML_Tag_Processor) apply_attributes_updates(shift_this_point i64) i64 {
}

fn (mut this Class_WP_HTML_Tag_Processor) has_bookmark(var_bookmark_name rt.PhpVal) bool {
}

fn (mut this Class_WP_HTML_Tag_Processor) seek(var_bookmark_name rt.PhpVal) bool {
}

fn Class_WP_HTML_Tag_Processor.sort_start_ascending(mut var_a Class_WP_HTML_Text_Replacement, mut var_b Class_WP_HTML_Text_Replacement) i64 {
}

fn (mut this Class_WP_HTML_Tag_Processor) get_enqueued_attribute_value(comparable_name string) rt.PhpVal {
	mut comparable_name_mutated := comparable_name
}

fn (mut this Class_WP_HTML_Tag_Processor) get_attribute(var_name rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
}

fn (mut this Class_WP_HTML_Tag_Processor) get_attribute_names_with_prefix(var_prefix rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_HTML_Tag_Processor) get_namespace() string {
}

fn (mut this Class_WP_HTML_Tag_Processor) get_tag() string {
}

fn (mut this Class_WP_HTML_Tag_Processor) get_qualified_tag_name() string {
}

fn (mut this Class_WP_HTML_Tag_Processor) get_qualified_attribute_name(var_attribute_name rt.PhpVal) string {
	mut var_attribute_name_mutated := var_attribute_name
}

fn (mut this Class_WP_HTML_Tag_Processor) has_self_closing_flag() bool {
}

fn (mut this Class_WP_HTML_Tag_Processor) is_tag_closer() bool {
}

fn (mut this Class_WP_HTML_Tag_Processor) get_token_type() string {
	return ''
}

fn (mut this Class_WP_HTML_Tag_Processor) get_token_name() string {
}

fn (mut this Class_WP_HTML_Tag_Processor) get_comment_type() string {
}

fn (mut this Class_WP_HTML_Tag_Processor) get_full_comment_text() string {
}

fn (mut this Class_WP_HTML_Tag_Processor) subdivide_text_appropriately() bool {
}

fn (mut this Class_WP_HTML_Tag_Processor) get_modifiable_text() string {
}

fn (mut this Class_WP_HTML_Tag_Processor) set_modifiable_text(plaintext_content string) bool {
	mut plaintext_content_mutated := plaintext_content
}

fn (mut this Class_WP_HTML_Tag_Processor) get_script_content_type() string {
}

fn Class_WP_HTML_Tag_Processor.escape_javascript_script_contents(sourcecode string) string {
}

fn (mut this Class_WP_HTML_Tag_Processor) set_attribute(var_name rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_name_mutated := var_name
}

fn (mut this Class_WP_HTML_Tag_Processor) remove_attribute(var_name rt.PhpVal) bool {
	mut var_name_mutated := var_name
}

fn (mut this Class_WP_HTML_Tag_Processor) add_class(var_class_name rt.PhpVal) bool {
}

fn (mut this Class_WP_HTML_Tag_Processor) remove_class(var_class_name rt.PhpVal) bool {
}

fn (mut this Class_WP_HTML_Tag_Processor) magic_tostring() string {
}

fn (mut this Class_WP_HTML_Tag_Processor) get_updated_html() string {
}

fn (mut this Class_WP_HTML_Tag_Processor) parse_query(var_query rt.PhpVal)  {
}

fn (mut this Class_WP_HTML_Tag_Processor) matches() bool {
}

fn (mut this Class_WP_HTML_Tag_Processor) get_doctype_info() rt.PhpVal {
}

fn (mut this Class_WP_HTML_Tag_Processor) magic_wakeup()  {
}

struct Class_WP_HTML_Span {
	rt.PhpObjectBase
}

fn create_wp_html_tag_processor(arg_0 rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
		html: rt.new_null()
		last_query: rt.new_null()
		sought_tag_name: rt.new_null()
		sought_class_name: rt.new_null()
		sought_match_offset: rt.new_null()
		stop_on_tag_closers: false
		parser_state: rt.new_null()
		compat_mode: rt.new_null()
		parsing_namespace: rt.new_string('html')
		comment_type: rt.new_null()
		text_node_classification: rt.new_null()
		bytes_already_parsed: rt.new_int(0)
		token_starts_at: rt.new_null()
		token_length: rt.new_null()
		tag_name_starts_at: rt.new_null()
		tag_name_length: rt.new_null()
		text_starts_at: rt.new_null()
		text_length: rt.new_null()
		is_closing_tag: rt.new_null()
		attributes: rt.new_array()
		duplicate_attributes: rt.new_null()
		classname_updates: rt.new_array()
		bookmarks: rt.new_array()
		lexical_updates: rt.new_array()
		seek_count: rt.new_int(0)
		skip_newline_at: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_html_span() &Class_WP_HTML_Span {
	mut obj := &Class_WP_HTML_Span{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'change_parsing_namespace' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.change_parsing_namespace(dispatch_arg_0))
		}
		'next_tag' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.next_tag(dispatch_arg_0))
		}
		'next_token' {
			return rt.new_bool(this.next_token())
		}
		'base_class_next_token' {
			return rt.new_bool(this.base_class_next_token())
		}
		'paused_at_incomplete_token' {
			return rt.new_bool(this.paused_at_incomplete_token())
		}
		'class_list' {
			this.class_list()
			return rt.new_null()
		}
		'has_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_class(dispatch_arg_0))
		}
		'set_bookmark' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.set_bookmark(dispatch_arg_0))
		}
		'release_bookmark' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.release_bookmark(dispatch_arg_0))
		}
		'skip_rawtext' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.skip_rawtext(dispatch_arg_0))
		}
		'skip_rcdata' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.skip_rcdata(dispatch_arg_0))
		}
		'skip_script_data' {
			return rt.new_bool(this.skip_script_data())
		}
		'parse_next_tag' {
			return rt.new_bool(this.parse_next_tag())
		}
		'parse_next_attribute' {
			return rt.new_bool(this.parse_next_attribute())
		}
		'skip_whitespace' {
			this.skip_whitespace()
			return rt.new_null()
		}
		'after_tag' {
			this.after_tag()
			return rt.new_null()
		}
		'class_name_updates_to_attributes_updates' {
			this.class_name_updates_to_attributes_updates()
			return rt.new_null()
		}
		'apply_attributes_updates' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.apply_attributes_updates(dispatch_arg_0))
		}
		'has_bookmark' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_bookmark(dispatch_arg_0))
		}
		'seek' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.seek(dispatch_arg_0))
		}
		'sort_start_ascending' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_HTML_Text_Replacement](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_HTML_Text_Replacement](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_int(Class_WP_HTML_Tag_Processor.sort_start_ascending(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_enqueued_attribute_value' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_enqueued_attribute_value(dispatch_arg_0)
		}
		'get_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_attribute(dispatch_arg_0)
		}
		'get_attribute_names_with_prefix' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_attribute_names_with_prefix(dispatch_arg_0)
		}
		'get_namespace' {
			return rt.new_string(this.get_namespace())
		}
		'get_tag' {
			return rt.new_string(this.get_tag())
		}
		'get_qualified_tag_name' {
			return rt.new_string(this.get_qualified_tag_name())
		}
		'get_qualified_attribute_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_qualified_attribute_name(dispatch_arg_0))
		}
		'has_self_closing_flag' {
			return rt.new_bool(this.has_self_closing_flag())
		}
		'is_tag_closer' {
			return rt.new_bool(this.is_tag_closer())
		}
		'get_token_type' {
			return rt.new_string(this.get_token_type())
		}
		'get_token_name' {
			return rt.new_string(this.get_token_name())
		}
		'get_comment_type' {
			return rt.new_string(this.get_comment_type())
		}
		'get_full_comment_text' {
			return rt.new_string(this.get_full_comment_text())
		}
		'subdivide_text_appropriately' {
			return rt.new_bool(this.subdivide_text_appropriately())
		}
		'get_modifiable_text' {
			return rt.new_string(this.get_modifiable_text())
		}
		'set_modifiable_text' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.set_modifiable_text(dispatch_arg_0))
		}
		'get_script_content_type' {
			return rt.new_string(this.get_script_content_type())
		}
		'escape_javascript_script_contents' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_WP_HTML_Tag_Processor.escape_javascript_script_contents(dispatch_arg_0))
		}
		'set_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.set_attribute(dispatch_arg_0, dispatch_arg_1))
		}
		'remove_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.remove_attribute(dispatch_arg_0))
		}
		'add_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.add_class(dispatch_arg_0))
		}
		'remove_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.remove_class(dispatch_arg_0))
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'get_updated_html' {
			return rt.new_string(this.get_updated_html())
		}
		'parse_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.parse_query(dispatch_arg_0)
			return rt.new_null()
		}
		'matches' {
			return rt.new_bool(this.matches())
		}
		'get_doctype_info' {
			return this.get_doctype_info()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'html' { return this.html }
		'last_query' { return this.last_query }
		'sought_tag_name' { return this.sought_tag_name }
		'sought_class_name' { return this.sought_class_name }
		'sought_match_offset' { return this.sought_match_offset }
		'stop_on_tag_closers' { return rt.new_bool(this.stop_on_tag_closers) }
		'parser_state' { return this.parser_state }
		'compat_mode' { return this.compat_mode }
		'parsing_namespace' { return this.parsing_namespace }
		'comment_type' { return this.comment_type }
		'text_node_classification' { return this.text_node_classification }
		'bytes_already_parsed' { return this.bytes_already_parsed }
		'token_starts_at' { return this.token_starts_at }
		'token_length' { return this.token_length }
		'tag_name_starts_at' { return this.tag_name_starts_at }
		'tag_name_length' { return this.tag_name_length }
		'text_starts_at' { return this.text_starts_at }
		'text_length' { return this.text_length }
		'is_closing_tag' { return this.is_closing_tag }
		'attributes' { return this.attributes }
		'duplicate_attributes' { return this.duplicate_attributes }
		'classname_updates' { return this.classname_updates }
		'bookmarks' { return this.bookmarks }
		'lexical_updates' { return this.lexical_updates }
		'seek_count' { return this.seek_count }
		'skip_newline_at' { return this.skip_newline_at }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'html' { this.html = val; return true }
		'last_query' { this.last_query = val; return true }
		'sought_tag_name' { this.sought_tag_name = val; return true }
		'sought_class_name' { this.sought_class_name = val; return true }
		'sought_match_offset' { this.sought_match_offset = val; return true }
		'stop_on_tag_closers' { this.stop_on_tag_closers = (val).to_bool(); return true }
		'parser_state' { this.parser_state = val; return true }
		'compat_mode' { this.compat_mode = val; return true }
		'parsing_namespace' { this.parsing_namespace = val; return true }
		'comment_type' { this.comment_type = val; return true }
		'text_node_classification' { this.text_node_classification = val; return true }
		'bytes_already_parsed' { this.bytes_already_parsed = val; return true }
		'token_starts_at' { this.token_starts_at = val; return true }
		'token_length' { this.token_length = val; return true }
		'tag_name_starts_at' { this.tag_name_starts_at = val; return true }
		'tag_name_length' { this.tag_name_length = val; return true }
		'text_starts_at' { this.text_starts_at = val; return true }
		'text_length' { this.text_length = val; return true }
		'is_closing_tag' { this.is_closing_tag = val; return true }
		'attributes' { this.attributes = val; return true }
		'duplicate_attributes' { this.duplicate_attributes = val; return true }
		'classname_updates' { this.classname_updates = val; return true }
		'bookmarks' { this.bookmarks = val; return true }
		'lexical_updates' { this.lexical_updates = val; return true }
		'seek_count' { this.seek_count = val; return true }
		'skip_newline_at' { this.skip_newline_at = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_HTML_Span) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Span) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Span) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_html_api_class_wp_html_tag_processor_php() {
}
