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

fn (mut this Class_WP_HTML_Tag_Processor) construct(var_html rt.PhpVal) {
	mut var_html_mutated := var_html
	if !(var_html_mutated.clone().is_string()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The HTML parameter must be a string.')]), rt.new_string('6.9.0')])
	var_html_mutated = rt.new_string('')
	}
	this.html = var_html_mutated.clone()
}

fn (mut this Class_WP_HTML_Tag_Processor) change_parsing_namespace(new_namespace string) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(new_namespace), rt.create_array([rt.ArrayItem{ key: none, val: 'html' }, rt.ArrayItem{ key: none, val: 'math' }, rt.ArrayItem{ key: none, val: 'svg' }]), rt.new_bool(true)]))))) {
		return false
	}
	this.parsing_namespace = rt.new_string(new_namespace)
	return true
}

fn (mut this Class_WP_HTML_Tag_Processor) next_tag(var_query rt.PhpVal) bool {
	this.parse_query(var_query.clone())
	mut var_already_found := rt.new_int(0)
	for {
		if rt.is_true(rt.identical(rt.new_bool(false), this.next_token())) {
			return false
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)))) {
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
	if rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_complete(), this.parser_state)) || rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_incomplete_input(), this.parser_state)) {
		return false
	}
	this.parser_state = Class_WP_HTML_Tag_Processor.state_ready()
	if rt.is_true(rt.greater_equal(this.bytes_already_parsed, rt.new_int(this.html.to_string().len))) {
		this.parser_state = Class_WP_HTML_Tag_Processor.state_complete()
		return false
	}
	if rt.is_true(rt.identical(rt.new_bool(false), this.parse_next_tag())) {
		if rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_incomplete_input(), this.parser_state)) {
			this.bytes_already_parsed = var_was_at.clone()
		}
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_incomplete_input(), this.parser_state)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_complete(), this.parser_state)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)))) {
		return true
	}
	for this.parse_next_attribute() {
		continue
	}
	if rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_incomplete_input(), this.parser_state)) || rt.is_true(rt.greater_equal(this.bytes_already_parsed, rt.new_int(this.html.to_string().len))) {
		this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
		this.bytes_already_parsed = var_was_at.clone()
		return false
	}
	mut var_tag_ends_at := rt.call_function('strpos', [this.html, rt.new_string('>'), this.bytes_already_parsed])
	if rt.is_true(rt.identical(rt.new_bool(false), var_tag_ends_at)) {
		this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
		this.bytes_already_parsed = var_was_at.clone()
		return false
	}
	this.parser_state = Class_WP_HTML_Tag_Processor.state_matched_tag()
	this.bytes_already_parsed = rt.add(var_tag_ends_at, rt.new_int(1))
	this.token_length = rt.sub(this.bytes_already_parsed, this.token_starts_at)
	if rt.is_true(this.is_closing_tag) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('html'), this.parsing_namespace)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), rt.call_function('strspn', [this.html, rt.new_string('iIlLnNpPsStTxX'), this.tag_name_starts_at, rt.new_int(1)]))))) {
		return true
	}
	mut var_tag_name := rt.new_string(this.get_tag())
	if rt.is_true(rt.identical(rt.new_string('LISTING'), var_tag_name)) || rt.is_true(rt.identical(rt.new_string('PRE'), var_tag_name)) {
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
		this.bytes_already_parsed = var_was_at.clone()
		return false
	}
	this.token_starts_at = var_was_at.clone()
	this.token_length = rt.sub(this.bytes_already_parsed, this.token_starts_at)
	this.text_starts_at = var_tag_ends_at.clone()
	this.text_length = rt.sub(this.tag_name_starts_at, this.text_starts_at)
	this.tag_name_starts_at = var_tag_name_starts_at.clone()
	this.tag_name_length = var_tag_name_length.clone()
	this.attributes = var_attributes.clone()
	this.duplicate_attributes = var_duplicate_attributes.clone()
	return true
}

fn (mut this Class_WP_HTML_Tag_Processor) paused_at_incomplete_token() bool {
	return (rt.identical(Class_WP_HTML_Tag_Processor.state_incomplete_input(), this.parser_state)).to_bool()
}

fn (mut this Class_WP_HTML_Tag_Processor) class_list() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)))) {
		return
	}
	mut var_class := this.get_attribute(rt.new_string('class'))
	if !(var_class.clone().is_string()) {
		return
	}
	mut var_seen := []rt.PhpVal{}
	mut var_is_quirks := rt.identical(Class_WP_HTML_Tag_Processor.quirks_mode(), this.compat_mode)
	mut var_at := rt.new_int(0)
	for rt.is_true(rt.less(var_at, rt.new_int(var_class.clone().to_string().len))) {
		var_at = rt.add(var_at, rt.call_function('strspn', [var_class.clone(), rt.new_string(' \t\r\n'), var_at.clone()]))
		if rt.is_true(rt.greater_equal(var_at, rt.new_int(var_class.clone().to_string().len))) {
			return
		}
		mut var_length := rt.call_function('strcspn', [var_class.clone(), rt.new_string(' \t\r\n'), var_at.clone()])
		if rt.is_true(rt.identical(rt.new_int(0), var_length)) {
			return
		}
		mut var_name := rt.call_function('str_replace', [rt.new_string(''), rt.new_string('�'), rt.call_function('substr', [var_class.clone(), var_at.clone(), var_length.clone()])])
		if rt.is_true(var_is_quirks) {
		var_name = rt.new_string(var_name.clone().to_string().to_lower())
		}
		var_at = rt.add(var_at, var_length)
		if rt.is_true(rt.call_function('in_array', [var_name.clone(), rt.create_array_from_list(var_seen), rt.new_bool(true)])) {
			continue
		}
		var_seen << var_name.clone()
		rt.new_null()
	}
}

fn (mut this Class_WP_HTML_Tag_Processor) has_class(var_wanted_class rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)))) {
		return (rt.new_null()).to_bool()
	}
	mut var_case_insensitive := rt.identical(Class_WP_HTML_Tag_Processor.quirks_mode(), this.compat_mode)
	mut var_wanted_length := rt.new_int(var_wanted_class.clone().to_string().len)
	mut iter_1 := this.class_list().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_class_name := item_1.val
		if rt.is_true(rt.identical(rt.new_int(var_class_name.clone().to_string().len), var_wanted_length)) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [var_class_name.clone(), var_wanted_class.clone(), rt.new_int(0), rt.new_int(var_wanted_class.clone().to_string().len), var_case_insensitive.clone()]))) {
			return true
		}
	}
	return false
}

fn (mut this Class_WP_HTML_Tag_Processor) set_bookmark(var_name rt.PhpVal) bool {
	mut var_name_mutated := var_name
	if rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_complete(), this.parser_state)) || rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_incomplete_input(), this.parser_state)) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.bookmarks.array_isset(var_name_mutated.clone())))))) && rt.is_true(rt.greater_equal(rt.new_int(this.bookmarks.array_count()), Class_static.max_bookmarks())) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Too many bookmarks: cannot create any more.')]), rt.new_string('6.2.0')])
		return false
	}
	this.bookmarks.array_set(var_name_mutated, create_wp_html_span(this.token_starts_at, this.token_length))
	return true
}

fn (mut this Class_WP_HTML_Tag_Processor) release_bookmark(var_name rt.PhpVal) bool {
	mut var_name_mutated := var_name
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.bookmarks.array_isset(var_name_mutated.clone())))))) {
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
	mut var_doc_length := rt.new_int(var_html.clone().to_string().len)
	mut var_tag_length := rt.new_int(tag_name_mutated.len)
	mut var_at := this.bytes_already_parsed
	for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_at)))) && rt.is_true(rt.less(var_at, var_doc_length)) {
		var_at = rt.call_function('strpos', [this.html, rt.new_string('</'), var_at.clone()])
		this.tag_name_starts_at = var_at.clone()
		if rt.is_true(rt.identical(rt.new_bool(false), var_at)) || rt.is_true(rt.greater_equal(rt.add(var_at, var_tag_length), var_doc_length)) {
			return false
		}
		var_at = rt.add(var_at, rt.new_int(2))
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, var_tag_length))) { break }
			mut var_tag_char := rt.new_string(tag_name_mutated).array_get(var_i)
			mut var_html_char := var_html.array_get(rt.add(var_at, var_i))
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_html_char, var_tag_char)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(var_html_char.clone().to_string().to_upper()), var_tag_char)))) {
				var_at = rt.add(var_at, var_i)
				continue
			}
			rt.post_inc(var_i)
		}
		var_at = rt.add(var_at, var_tag_length)
		this.bytes_already_parsed = var_at.clone()
		if rt.is_true(rt.greater_equal(var_at, rt.new_int(var_html.clone().to_string().len))) {
			return false
		}
		mut var_c := var_html.array_get(var_at)
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(' '), var_c)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('\t'), var_c)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('\r'), var_c)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('\n'), var_c)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/'), var_c)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('>'), var_c)))) {
			continue
		}
		for this.parse_next_attribute() {
			continue
		}
		mut var_at := this.bytes_already_parsed
		if rt.is_true(rt.greater_equal(var_at, rt.new_int(this.html.to_string().len))) {
			return false
		}
		if rt.is_true(rt.identical(rt.new_string('>'), var_html.array_get(var_at))) {
			this.bytes_already_parsed = rt.add(var_at, rt.new_int(1))
			return true
		}
		if rt.is_true(rt.greater_equal(rt.add(var_at, rt.new_int(1)), rt.new_int(this.html.to_string().len))) {
			return false
		}
		if rt.is_true(rt.identical(rt.new_string('/'), var_html.array_get(var_at))) && rt.is_true(rt.identical(rt.new_string('>'), var_html.array_get(rt.add(var_at, rt.new_int(1))))) {
			this.bytes_already_parsed = rt.add(var_at, rt.new_int(2))
			return true
		}
	}
	return false
}

fn (mut this Class_WP_HTML_Tag_Processor) skip_script_data() bool {
	mut var_state := rt.new_string('unescaped')
	mut var_html := this.html
	mut var_doc_length := rt.new_int(var_html.clone().to_string().len)
	mut var_at := this.bytes_already_parsed
	for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_at)))) && rt.is_true(rt.less(var_at, var_doc_length)) {
		var_at = rt.add(var_at, rt.call_function('strcspn', [var_html.clone(), rt.new_string('-<'), var_at.clone()]))
		if rt.is_true(rt.greater_equal(rt.add(var_at, rt.new_int(8)), var_doc_length)) {
			return false
		}
		if rt.is_true(rt.identical(rt.new_string('-'), var_html.array_get(var_at))) && rt.is_true(rt.identical(rt.new_string('-'), var_html.array_get(rt.add(var_at, rt.new_int(1))))) && rt.is_true(rt.identical(rt.new_string('>'), var_html.array_get(rt.add(var_at, rt.new_int(2))))) {
			var_at = rt.add(var_at, rt.new_int(3))
			var_state = rt.new_string('unescaped')
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('<'), var_html.array_get(rt.post_inc(var_at)))))) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('unescaped'), var_state)) && rt.is_true(rt.identical(rt.new_string('!'), var_html.array_get(var_at))) && rt.is_true(rt.identical(rt.new_string('-'), var_html.array_get(rt.add(var_at, rt.new_int(1))))) && rt.is_true(rt.identical(rt.new_string('-'), var_html.array_get(rt.add(var_at, rt.new_int(2))))) {
			var_at = rt.add(var_at, rt.new_int(3))
			var_at = rt.add(var_at, rt.call_function('strspn', [var_html.clone(), rt.new_string('-'), var_at.clone()]))
			if rt.is_true(rt.less(var_at, var_doc_length)) && rt.is_true(rt.identical(rt.new_string('>'), var_html.array_get(var_at))) {
				rt.pre_inc(var_at)
				continue
			}
			var_state = rt.new_string('escaped')
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('/'), var_html.array_get(var_at))) {
			mut var_closer_potentially_starts_at := rt.sub(var_at, rt.new_int(1))
			mut var_is_closing := rt.new_bool(true)
			rt.pre_inc(var_at)
		} else {
		var_is_closing = rt.new_bool(false)
		}
		if !(rt.is_true(rt.identical(rt.new_string('s'), var_html.array_get(var_at))) || rt.is_true(rt.identical(rt.new_string('S'), var_html.array_get(var_at))) && rt.is_true(rt.identical(rt.new_string('c'), var_html.array_get(rt.add(var_at, rt.new_int(1))))) || rt.is_true(rt.identical(rt.new_string('C'), var_html.array_get(rt.add(var_at, rt.new_int(1))))) && rt.is_true(rt.identical(rt.new_string('r'), var_html.array_get(rt.add(var_at, rt.new_int(2))))) || rt.is_true(rt.identical(rt.new_string('R'), var_html.array_get(rt.add(var_at, rt.new_int(2))))) && rt.is_true(rt.identical(rt.new_string('i'), var_html.array_get(rt.add(var_at, rt.new_int(3))))) || rt.is_true(rt.identical(rt.new_string('I'), var_html.array_get(rt.add(var_at, rt.new_int(3))))) && rt.is_true(rt.identical(rt.new_string('p'), var_html.array_get(rt.add(var_at, rt.new_int(4))))) || rt.is_true(rt.identical(rt.new_string('P'), var_html.array_get(rt.add(var_at, rt.new_int(4))))) && rt.is_true(rt.identical(rt.new_string('t'), var_html.array_get(rt.add(var_at, rt.new_int(5))))) || rt.is_true(rt.identical(rt.new_string('T'), var_html.array_get(rt.add(var_at, rt.new_int(5)))))) {
			rt.pre_inc(var_at)
			continue
		}
		var_at = rt.add(var_at, rt.new_int(6))
		mut var_c := var_html.array_get(var_at)
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('>'), var_c)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(' '), var_c)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('\n'), var_c)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/'), var_c)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('\t'), var_c)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_c)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('\r'), var_c)))) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('escaped'), var_state)) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_closing)))) {
			var_state = rt.new_string('double-escaped')
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('double-escaped'), var_state)) && rt.is_true(var_is_closing) {
			var_state = rt.new_string('escaped')
			continue
		}
		if rt.is_true(var_is_closing) {
			this.bytes_already_parsed = var_closer_potentially_starts_at.clone()
			this.tag_name_starts_at = var_closer_potentially_starts_at.clone()
			if rt.is_true(rt.greater_equal(this.bytes_already_parsed, var_doc_length)) {
				return false
			}
			for this.parse_next_attribute() {
				continue
			}
			if rt.is_true(rt.greater_equal(this.bytes_already_parsed, var_doc_length)) {
				return false
			}
			if rt.is_true(rt.identical(rt.new_string('>'), var_html.array_get(this.bytes_already_parsed))) {
				rt.pre_inc(this.bytes_already_parsed)
				return true
			}
		}
		rt.pre_inc(var_at)
	}
	return false
}

fn (mut this Class_WP_HTML_Tag_Processor) parse_next_tag() bool {
	this.after_tag()
	mut var_html := this.html
	mut var_doc_length := rt.new_int(var_html.clone().to_string().len)
	mut var_was_at := this.bytes_already_parsed
	mut var_at := var_was_at.clone()
	for rt.is_true(rt.less(var_at, var_doc_length)) {
		var_at = rt.call_function('strpos', [var_html.clone(), rt.new_string('<'), var_at.clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_at)) {
			break
		}
		if rt.is_true(rt.greater(var_at, var_was_at)) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), rt.call_function('strspn', [var_html.clone(), rt.new_string('!/?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'), rt.add(var_at, rt.new_int(1)), rt.new_int(1)]))))) {
				rt.pre_inc(var_at)
				continue
			}
			this.parser_state = Class_WP_HTML_Tag_Processor.state_text_node()
			this.token_starts_at = var_was_at.clone()
			this.token_length = rt.sub(var_at, var_was_at)
			this.text_starts_at = var_was_at.clone()
			this.text_length = this.token_length
			this.bytes_already_parsed = var_at.clone()
			return true
		}
		this.token_starts_at = var_at.clone()
		if rt.is_true(rt.less(rt.add(var_at, rt.new_int(1)), var_doc_length)) && rt.is_true(rt.identical(rt.new_string('/'), this.html.array_get(rt.add(var_at, rt.new_int(1))))) {
			this.is_closing_tag = rt.new_bool(true)
			rt.pre_inc(var_at)
		} else {
			this.is_closing_tag = rt.new_bool(false)
		}
		mut var_tag_name_prefix_length := rt.call_function('strspn', [var_html.clone(), rt.new_string('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'), rt.add(var_at, rt.new_int(1))])
		if rt.is_true(rt.greater(var_tag_name_prefix_length, rt.new_int(0))) {
			rt.pre_inc(var_at)
			this.parser_state = Class_WP_HTML_Tag_Processor.state_matched_tag()
			this.tag_name_starts_at = var_at.clone()
			this.tag_name_length = rt.add(var_tag_name_prefix_length, rt.call_function('strcspn', [var_html.clone(), rt.new_string(' \t\r\n/>'), rt.add(var_at, var_tag_name_prefix_length)]))
			this.bytes_already_parsed = rt.add(var_at, this.tag_name_length)
			return true
		}
		if rt.is_true(rt.greater_equal(rt.add(var_at, rt.new_int(1)), var_doc_length)) {
			this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
			return false
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(this.is_closing_tag)))) && rt.is_true(rt.identical(rt.new_string('!'), var_html.array_get(rt.add(var_at, rt.new_int(1))))) {
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [var_html.clone(), rt.new_string('--'), rt.add(var_at, rt.new_int(2)), rt.new_int(2)]))) {
				mut var_closer_at := rt.add(var_at, rt.new_int(4))
				if rt.is_true(rt.less_equal(var_doc_length, var_closer_at)) {
					this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
					return false
				}
				mut var_span_of_dashes := rt.call_function('strspn', [var_html.clone(), rt.new_string('-'), var_closer_at.clone()])
				if rt.is_true(rt.identical(rt.new_string('>'), var_html.array_get(rt.add(var_closer_at, var_span_of_dashes)))) {
					this.parser_state = Class_WP_HTML_Tag_Processor.state_comment()
					this.comment_type = Class_WP_HTML_Tag_Processor.comment_as_abruptly_closed_comment()
					this.token_length = rt.sub(rt.add(rt.add(var_closer_at, var_span_of_dashes), rt.new_int(1)), this.token_starts_at)
					if rt.is_true(rt.greater_equal(var_span_of_dashes, rt.new_int(2))) {
						this.comment_type = Class_WP_HTML_Tag_Processor.comment_as_html_comment()
						this.text_starts_at = rt.add(this.token_starts_at, rt.new_int(4))
						this.text_length = rt.sub(var_span_of_dashes, rt.new_int(2))
					}
					this.bytes_already_parsed = rt.add(rt.add(var_closer_at, var_span_of_dashes), rt.new_int(1))
					return true
				}
				rt.pre_dec(var_closer_at)
				for rt.is_true(rt.less(rt.pre_inc(var_closer_at), var_doc_length)) {
					var_closer_at = rt.call_function('strpos', [var_html.clone(), rt.new_string('--'), var_closer_at.clone()])
					if rt.is_true(rt.identical(rt.new_bool(false), var_closer_at)) {
						this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
						return false
					}
					if rt.is_true(rt.less(rt.add(var_closer_at, rt.new_int(2)), var_doc_length)) && rt.is_true(rt.identical(rt.new_string('>'), var_html.array_get(rt.add(var_closer_at, rt.new_int(2))))) {
						this.parser_state = Class_WP_HTML_Tag_Processor.state_comment()
						this.comment_type = Class_WP_HTML_Tag_Processor.comment_as_html_comment()
						this.token_length = rt.sub(rt.add(var_closer_at, rt.new_int(3)), this.token_starts_at)
						this.text_starts_at = rt.add(this.token_starts_at, rt.new_int(4))
						this.text_length = rt.sub(var_closer_at, this.text_starts_at)
						this.bytes_already_parsed = rt.add(var_closer_at, rt.new_int(3))
						return true
					}
					if rt.is_true(rt.less(rt.add(var_closer_at, rt.new_int(3)), var_doc_length)) && rt.is_true(rt.identical(rt.new_string('!'), var_html.array_get(rt.add(var_closer_at, rt.new_int(2))))) && rt.is_true(rt.identical(rt.new_string('>'), var_html.array_get(rt.add(var_closer_at, rt.new_int(3))))) {
						this.parser_state = Class_WP_HTML_Tag_Processor.state_comment()
						this.comment_type = Class_WP_HTML_Tag_Processor.comment_as_html_comment()
						this.token_length = rt.sub(rt.add(var_closer_at, rt.new_int(4)), this.token_starts_at)
						this.text_starts_at = rt.add(this.token_starts_at, rt.new_int(4))
						this.text_length = rt.sub(var_closer_at, this.text_starts_at)
						this.bytes_already_parsed = rt.add(var_closer_at, rt.new_int(4))
						return true
					}
				}
			}
			if rt.is_true(rt.greater(var_doc_length, rt.add(var_at, rt.new_int(8)))) && rt.is_true(rt.identical(rt.new_string('D'), var_html.array_get(rt.add(var_at, rt.new_int(2))))) || rt.is_true(rt.identical(rt.new_string('d'), var_html.array_get(rt.add(var_at, rt.new_int(2))))) && rt.is_true(rt.identical(rt.new_string('O'), var_html.array_get(rt.add(var_at, rt.new_int(3))))) || rt.is_true(rt.identical(rt.new_string('o'), var_html.array_get(rt.add(var_at, rt.new_int(3))))) && rt.is_true(rt.identical(rt.new_string('C'), var_html.array_get(rt.add(var_at, rt.new_int(4))))) || rt.is_true(rt.identical(rt.new_string('c'), var_html.array_get(rt.add(var_at, rt.new_int(4))))) && rt.is_true(rt.identical(rt.new_string('T'), var_html.array_get(rt.add(var_at, rt.new_int(5))))) || rt.is_true(rt.identical(rt.new_string('t'), var_html.array_get(rt.add(var_at, rt.new_int(5))))) && rt.is_true(rt.identical(rt.new_string('Y'), var_html.array_get(rt.add(var_at, rt.new_int(6))))) || rt.is_true(rt.identical(rt.new_string('y'), var_html.array_get(rt.add(var_at, rt.new_int(6))))) && rt.is_true(rt.identical(rt.new_string('P'), var_html.array_get(rt.add(var_at, rt.new_int(7))))) || rt.is_true(rt.identical(rt.new_string('p'), var_html.array_get(rt.add(var_at, rt.new_int(7))))) && rt.is_true(rt.identical(rt.new_string('E'), var_html.array_get(rt.add(var_at, rt.new_int(8))))) || rt.is_true(rt.identical(rt.new_string('e'), var_html.array_get(rt.add(var_at, rt.new_int(8))))) {
				var_closer_at = rt.call_function('strpos', [var_html.clone(), rt.new_string('>'), rt.add(var_at, rt.new_int(9))])
				if rt.is_true(rt.identical(rt.new_bool(false), var_closer_at)) {
					this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
					return false
				}
				this.parser_state = Class_WP_HTML_Tag_Processor.state_doctype()
				this.token_length = rt.sub(rt.add(var_closer_at, rt.new_int(1)), this.token_starts_at)
				this.text_starts_at = rt.add(this.token_starts_at, rt.new_int(9))
				this.text_length = rt.sub(var_closer_at, this.text_starts_at)
				this.bytes_already_parsed = rt.add(var_closer_at, rt.new_int(1))
				return true
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('html'), this.parsing_namespace)))) && rt.is_true(rt.greater(rt.new_int(var_html.clone().to_string().len), rt.add(var_at, rt.new_int(8)))) && rt.is_true(rt.identical(rt.new_string('['), var_html.array_get(rt.add(var_at, rt.new_int(2))))) && rt.is_true(rt.identical(rt.new_string('C'), var_html.array_get(rt.add(var_at, rt.new_int(3))))) && rt.is_true(rt.identical(rt.new_string('D'), var_html.array_get(rt.add(var_at, rt.new_int(4))))) && rt.is_true(rt.identical(rt.new_string('A'), var_html.array_get(rt.add(var_at, rt.new_int(5))))) && rt.is_true(rt.identical(rt.new_string('T'), var_html.array_get(rt.add(var_at, rt.new_int(6))))) && rt.is_true(rt.identical(rt.new_string('A'), var_html.array_get(rt.add(var_at, rt.new_int(7))))) && rt.is_true(rt.identical(rt.new_string('['), var_html.array_get(rt.add(var_at, rt.new_int(8))))) {
				var_closer_at = rt.call_function('strpos', [var_html.clone(), rt.new_string(']]>'), rt.add(var_at, rt.new_int(9))])
				if rt.is_true(rt.identical(rt.new_bool(false), var_closer_at)) {
					this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
					return false
				}
				this.parser_state = Class_WP_HTML_Tag_Processor.state_cdata_node()
				this.text_starts_at = rt.add(var_at, rt.new_int(9))
				this.text_length = rt.sub(var_closer_at, this.text_starts_at)
				this.token_length = rt.sub(rt.add(var_closer_at, rt.new_int(3)), this.token_starts_at)
				this.bytes_already_parsed = rt.add(var_closer_at, rt.new_int(3))
				return true
			}
			var_closer_at = rt.call_function('strpos', [var_html.clone(), rt.new_string('>'), rt.add(var_at, rt.new_int(1))])
			if rt.is_true(rt.identical(rt.new_bool(false), var_closer_at)) {
				this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
				return false
			}
			this.parser_state = Class_WP_HTML_Tag_Processor.state_comment()
			this.comment_type = Class_WP_HTML_Tag_Processor.comment_as_invalid_html()
			this.token_length = rt.sub(rt.add(var_closer_at, rt.new_int(1)), this.token_starts_at)
			this.text_starts_at = rt.add(this.token_starts_at, rt.new_int(2))
			this.text_length = rt.sub(var_closer_at, this.text_starts_at)
			this.bytes_already_parsed = rt.add(var_closer_at, rt.new_int(1))
			if rt.is_true(rt.greater_equal(this.token_length, rt.new_int(10))) && rt.is_true(rt.identical(rt.new_string('['), var_html.array_get(rt.add(this.token_starts_at, rt.new_int(2))))) && rt.is_true(rt.identical(rt.new_string('C'), var_html.array_get(rt.add(this.token_starts_at, rt.new_int(3))))) && rt.is_true(rt.identical(rt.new_string('D'), var_html.array_get(rt.add(this.token_starts_at, rt.new_int(4))))) && rt.is_true(rt.identical(rt.new_string('A'), var_html.array_get(rt.add(this.token_starts_at, rt.new_int(5))))) && rt.is_true(rt.identical(rt.new_string('T'), var_html.array_get(rt.add(this.token_starts_at, rt.new_int(6))))) && rt.is_true(rt.identical(rt.new_string('A'), var_html.array_get(rt.add(this.token_starts_at, rt.new_int(7))))) && rt.is_true(rt.identical(rt.new_string('['), var_html.array_get(rt.add(this.token_starts_at, rt.new_int(8))))) && rt.is_true(rt.identical(rt.new_string(']'), var_html.array_get(rt.sub(var_closer_at, rt.new_int(1))))) && rt.is_true(rt.identical(rt.new_string(']'), var_html.array_get(rt.sub(var_closer_at, rt.new_int(2))))) {
				this.parser_state = Class_WP_HTML_Tag_Processor.state_comment()
				this.comment_type = Class_WP_HTML_Tag_Processor.comment_as_cdata_lookalike()
				this.text_starts_at = rt.add(this.text_starts_at, rt.new_int(7))
				this.text_length = rt.sub(this.text_length, rt.new_int(9))
			}
			return true
		}
		if rt.is_true(rt.identical(rt.new_string('>'), var_html.array_get(rt.add(var_at, rt.new_int(1))))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(this.is_closing_tag)))) {
				rt.pre_inc(var_at)
				continue
			}
			this.parser_state = Class_WP_HTML_Tag_Processor.state_presumptuous_tag()
			this.token_length = rt.sub(rt.add(var_at, rt.new_int(2)), this.token_starts_at)
			this.bytes_already_parsed = rt.add(var_at, rt.new_int(2))
			return true
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(this.is_closing_tag)))) && rt.is_true(rt.identical(rt.new_string('?'), var_html.array_get(rt.add(var_at, rt.new_int(1))))) {
			var_closer_at = rt.call_function('strpos', [var_html.clone(), rt.new_string('>'), rt.add(var_at, rt.new_int(2))])
			if rt.is_true(rt.identical(rt.new_bool(false), var_closer_at)) {
				this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
				return false
			}
			this.parser_state = Class_WP_HTML_Tag_Processor.state_comment()
			this.comment_type = Class_WP_HTML_Tag_Processor.comment_as_invalid_html()
			this.token_length = rt.sub(rt.add(var_closer_at, rt.new_int(1)), this.token_starts_at)
			this.text_starts_at = rt.add(this.token_starts_at, rt.new_int(2))
			this.text_length = rt.sub(var_closer_at, this.text_starts_at)
			this.bytes_already_parsed = rt.add(var_closer_at, rt.new_int(1))
			if rt.is_true(rt.greater_equal(this.token_length, rt.new_int(5))) && rt.is_true(rt.identical(rt.new_string('?'), var_html.array_get(rt.sub(var_closer_at, rt.new_int(1))))) {
				mut var_comment_text := rt.call_function('substr', [var_html.clone(), rt.add(this.token_starts_at, rt.new_int(2)), rt.sub(this.token_length, rt.new_int(4))])
				mut var_pi_target_length := rt.call_function('strspn', [var_comment_text.clone(), rt.new_string('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ:_')])
				if rt.is_true(rt.less(rt.new_int(0), var_pi_target_length)) {
					var_pi_target_length = rt.add(var_pi_target_length, rt.call_function('strspn', [var_comment_text.clone(), rt.new_string('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:_-.'), var_pi_target_length.clone()]))
					this.comment_type = Class_WP_HTML_Tag_Processor.comment_as_pi_node_lookalike()
					this.tag_name_starts_at = rt.add(this.token_starts_at, rt.new_int(2))
					this.tag_name_length = var_pi_target_length.clone()
					this.text_starts_at = rt.add(this.text_starts_at, var_pi_target_length)
					this.text_length = rt.sub(this.text_length, rt.add(var_pi_target_length, rt.new_int(1)))
				}
			}
			return true
		}
		if rt.is_true(this.is_closing_tag) {
			if rt.is_true(rt.greater(rt.add(var_at, rt.new_int(3)), var_doc_length)) {
				this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
				return false
			}
			var_closer_at = rt.call_function('strpos', [var_html.clone(), rt.new_string('>'), rt.add(var_at, rt.new_int(2))])
			if rt.is_true(rt.identical(rt.new_bool(false), var_closer_at)) {
				this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
				return false
			}
			this.parser_state = Class_WP_HTML_Tag_Processor.state_funky_comment()
			this.token_length = rt.sub(rt.add(var_closer_at, rt.new_int(1)), this.token_starts_at)
			this.text_starts_at = rt.add(this.token_starts_at, rt.new_int(2))
			this.text_length = rt.sub(var_closer_at, this.text_starts_at)
			this.bytes_already_parsed = rt.add(var_closer_at, rt.new_int(1))
			return true
		}
		rt.pre_inc(var_at)
	}
	this.parser_state = Class_WP_HTML_Tag_Processor.state_text_node()
	this.token_starts_at = var_was_at.clone()
	this.token_length = rt.sub(var_doc_length, var_was_at)
	this.text_starts_at = var_was_at.clone()
	this.text_length = this.token_length
	this.bytes_already_parsed = var_doc_length.clone()
	return true
}

fn (mut this Class_WP_HTML_Tag_Processor) parse_next_attribute() bool {
	mut var_doc_length := rt.new_int(this.html.to_string().len)
	this.bytes_already_parsed = rt.add(this.bytes_already_parsed, rt.call_function('strspn', [this.html, rt.new_string(' \t\r\n/'), this.bytes_already_parsed]))
	if rt.is_true(rt.greater_equal(this.bytes_already_parsed, var_doc_length)) {
		this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
		return false
	}
	mut var_name_length := if rt.is_true(rt.identical(rt.new_string('='), this.html.array_get(this.bytes_already_parsed))) { rt.add(rt.new_int(1), rt.call_function('strcspn', [this.html, rt.new_string('=/> \t\r\n'), rt.add(this.bytes_already_parsed, rt.new_int(1))])) } else { rt.call_function('strcspn', [this.html, rt.new_string('=/> \t\r\n'), this.bytes_already_parsed]) }
	if rt.is_true(rt.identical(rt.new_int(0), var_name_length)) || rt.is_true(rt.greater_equal(rt.add(this.bytes_already_parsed, var_name_length), var_doc_length)) {
		return false
	}
	mut var_attribute_start := this.bytes_already_parsed
	mut var_attribute_name := rt.call_function('substr', [this.html, var_attribute_start.clone(), var_name_length.clone()])
	this.bytes_already_parsed = rt.add(this.bytes_already_parsed, var_name_length)
	if rt.is_true(rt.greater_equal(this.bytes_already_parsed, var_doc_length)) {
		this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
		return false
	}
	this.skip_whitespace()
	if rt.is_true(rt.greater_equal(this.bytes_already_parsed, var_doc_length)) {
		this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
		return false
	}
	mut var_has_value := rt.identical(rt.new_string('='), this.html.array_get(this.bytes_already_parsed))
	if rt.is_true(var_has_value) {
		rt.pre_inc(this.bytes_already_parsed)
		this.skip_whitespace()
		if rt.is_true(rt.greater_equal(this.bytes_already_parsed, var_doc_length)) {
			this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
			return false
		}
		mut switch_val_2 := this.html.array_get(this.bytes_already_parsed)
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('\''))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('"'))) {
			mut var_quote := this.html.array_get(this.bytes_already_parsed)
			mut var_value_start := rt.add(this.bytes_already_parsed, rt.new_int(1))
			mut var_end_quote_at := rt.call_function('strpos', [this.html, var_quote.clone(), var_value_start.clone()])
			var_end_quote_at = if rt.is_true(rt.identical(rt.new_bool(false), var_end_quote_at)) { var_doc_length } else { var_end_quote_at }
			mut var_value_length := rt.sub(var_end_quote_at, var_value_start)
			mut var_attribute_end := rt.add(var_end_quote_at, rt.new_int(1))
			this.bytes_already_parsed = var_attribute_end.clone()
		} else {
			var_value_start = this.bytes_already_parsed
			var_value_length = rt.call_function('strcspn', [this.html, rt.new_string('> \t\r\n'), var_value_start.clone()])
			var_attribute_end = rt.add(var_value_start, var_value_length)
			this.bytes_already_parsed = var_attribute_end.clone()
		}
	} else {
	var_value_start = this.bytes_already_parsed
	var_value_length = rt.new_int(0)
	var_attribute_end = rt.add(var_attribute_start, var_name_length)
	}
	if rt.is_true(rt.greater_equal(var_attribute_end, var_doc_length)) {
		this.parser_state = Class_WP_HTML_Tag_Processor.state_incomplete_input()
		return false
	}
	if rt.is_true(this.is_closing_tag) {
		return true
	}
	mut var_comparable_name := rt.new_string(var_attribute_name.clone().to_string().to_lower())
	if !(this.attributes.array_isset(var_comparable_name)) {
		this.attributes.array_set(var_comparable_name, create_wp_html_attribute_token(var_attribute_name.clone(), var_value_start.clone(), var_value_length.clone(), var_attribute_start.clone(), rt.sub(var_attribute_end, var_attribute_start), rt.new_bool(!(rt.is_true(var_has_value)))))
		return true
	}
	mut var_duplicate_span := create_wp_html_span(var_attribute_start.clone(), rt.sub(var_attribute_end, var_attribute_start))
	if rt.is_true(rt.identical(rt.new_null(), this.duplicate_attributes)) {
		this.duplicate_attributes = rt.create_array([rt.ArrayItem{ key: var_comparable_name, val: rt.create_array([rt.ArrayItem{ key: none, val: var_duplicate_span }]) }])
	} else if !(this.duplicate_attributes.array_isset(var_comparable_name)) {
		this.duplicate_attributes.array_set(var_comparable_name, rt.create_array([rt.ArrayItem{ key: none, val: var_duplicate_span }]))
	} else {
		this.duplicate_attributes.array_get_mut(var_comparable_name).array_push(var_duplicate_span)
	}
	return true
}

fn (mut this Class_WP_HTML_Tag_Processor) skip_whitespace() {
	this.bytes_already_parsed = rt.add(this.bytes_already_parsed, rt.call_function('strspn', [this.html, rt.new_string(' \t\r\n'), this.bytes_already_parsed]))
}

fn (mut this Class_WP_HTML_Tag_Processor) after_tag() {
	this.class_name_updates_to_attributes_updates()
	if 1000 < this.lexical_updates.array_count() {
		this.get_updated_html()
	}
	mut iter_2 := this.lexical_updates.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_update := item_2.val
		mut var_name := item_2.key
		if rt.is_true(rt.greater_equal(rt.get_property(var_update, 'start'), this.bytes_already_parsed)) {
			this.get_updated_html()
			break
		}
		if rt.is_true(rt.new_bool(var_name.clone().is_long())) {
			continue
		}
		this.lexical_updates.array_push(var_update.clone())
		this.lexical_updates.array_unset(var_name)
	}
	this.token_starts_at = rt.new_null()
	this.token_length = rt.new_null()
	this.tag_name_starts_at = rt.new_null()
	this.tag_name_length = rt.new_null()
	this.text_starts_at = rt.new_int(0)
	this.text_length = rt.new_int(0)
	this.is_closing_tag = rt.new_null()
	this.attributes = []rt.PhpVal{}
	this.comment_type = rt.new_null()
	this.text_node_classification = Class_WP_HTML_Tag_Processor.text_is_generic()
	this.duplicate_attributes = rt.new_null()
}

fn (mut this Class_WP_HTML_Tag_Processor) class_name_updates_to_attributes_updates() {
	if this.classname_updates.array_count() == 0 {
		return
	}
	mut var_existing_class := this.get_enqueued_attribute_value('class')
	if rt.is_true(rt.identical(rt.new_null(), var_existing_class)) || rt.is_true(rt.identical(rt.new_bool(true), var_existing_class)) {
	var_existing_class = rt.new_string('')
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_existing_class)) && this.attributes.array_isset(rt.new_string('class')) {
	mut iife_temp_0 := Class_WP_HTML_Decoder{}
	mut iife_result_0 := iife_temp_0.decode_attribute(rt.call_function('substr', [this.html, rt.get_property(this.attributes.array_get(rt.new_string('class')), 'value_starts_at'), rt.get_property(this.attributes.array_get(rt.new_string('class')), 'value_length')]))
	var_existing_class = iife_result_0
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_existing_class)) {
	var_existing_class = rt.new_string('')
	}
	mut var_class := rt.new_string('')
	mut var_at := rt.new_int(0)
	mut var_modified := rt.new_bool(false)
	mut var_seen := []rt.PhpVal{}
	mut var_to_remove := []rt.PhpVal{}
	mut var_is_quirks := rt.identical(Class_WP_HTML_Tag_Processor.quirks_mode(), this.compat_mode)
	if rt.is_true(var_is_quirks) {
		mut iter_3 := this.classname_updates.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_action := item_3.val
			mut var_updated_name := item_3.key
			if rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.remove_class(), var_action)) {
				var_to_remove << rt.new_string(var_updated_name.clone().to_string().to_lower())
			}
		}
	} else {
		mut iter_4 := this.classname_updates.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_action := item_4.val
			mut var_updated_name := item_4.key
			if rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.remove_class(), var_action)) {
				var_to_remove << var_updated_name.clone()
			}
		}
	}
	mut var_existing_class_length := rt.new_int(var_existing_class.clone().to_string().len)
	for rt.is_true(rt.less(var_at, var_existing_class_length)) {
		mut var_ws_at := var_at.clone()
		mut var_ws_length := rt.call_function('strspn', [var_existing_class.clone(), rt.new_string(' \t\r\n'), var_ws_at.clone()])
		var_at = rt.add(var_at, var_ws_length)
		mut var_name_length := rt.call_function('strcspn', [var_existing_class.clone(), rt.new_string(' \t\r\n'), var_at.clone()])
		if rt.is_true(rt.identical(rt.new_int(0), var_name_length)) {
			break
		}
		mut var_name := rt.call_function('substr', [var_existing_class.clone(), var_at.clone(), var_name_length.clone()])
		mut var_comparable_class_name := if rt.is_true(var_is_quirks) { rt.new_string(var_name.clone().to_string().to_lower()) } else { var_name }
		var_at = rt.add(var_at, var_name_length)
		if rt.is_true(rt.call_function('in_array', [var_comparable_class_name.clone(), rt.create_array_from_list(var_to_remove), rt.new_bool(true)])) {
			var_modified = rt.new_bool(true)
			continue
		}
		if rt.is_true(rt.call_function('in_array', [var_comparable_class_name.clone(), rt.create_array_from_list(var_seen), rt.new_bool(true)])) {
			continue
		}
		var_seen << var_comparable_class_name.clone()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_class)))) {
			var_class = rt.concat(var_class, rt.call_function('substr', [var_existing_class.clone(), var_ws_at.clone(), var_ws_length.clone()]))
		}
		var_class = rt.concat(var_class, var_name)
	}
	mut iter_5 := this.classname_updates.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_operation := item_5.val
		mut var_name_shadow := item_5.key
		mut var_comparable_name := if rt.is_true(var_is_quirks) { rt.new_string(var_name_shadow.clone().to_string().to_lower()) } else { var_name_shadow }
		if rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.add_class(), var_operation)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_comparable_name.clone(), rt.create_array_from_list(var_seen), rt.new_bool(true)]))))) {
			var_modified = rt.new_bool(true)
			var_class = rt.concat(var_class, if var_class.clone().to_string().len > 0 { ' ' } else { '' })
			var_class = rt.concat(var_class, var_name_shadow)
		}
	}
	this.classname_updates = []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_modified)))) {
		return
	}
	if var_class.clone().to_string().len > 0 {
		this.set_attribute(rt.new_string('class'), var_class.clone())
	} else {
		this.remove_attribute(rt.new_string('class'))
	}
}

fn (mut this Class_WP_HTML_Tag_Processor) apply_attributes_updates(shift_this_point i64) i64 {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(this.lexical_updates.array_count()))))) {
		return 0
	}
	mut var_accumulated_shift_for_given_point := rt.new_int(0)
	rt.call_function('usort', [this.lexical_updates, rt.create_array([rt.ArrayItem{ key: none, val: Class_WP_HTML_Tag_Processor.class() }, rt.ArrayItem{ key: none, val: 'sort_start_ascending' }])])
	mut var_bytes_already_copied := rt.new_int(0)
	mut var_output_buffer := rt.new_string('')
	mut iter_6 := this.lexical_updates.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_diff := item_6.val
		mut var_shift := rt.sub(rt.new_int(rt.get_property(var_diff, 'text').to_string().len), rt.get_property(var_diff, 'length'))
		if rt.is_true(rt.less(rt.get_property(var_diff, 'start'), this.bytes_already_parsed)) {
			this.bytes_already_parsed = rt.add(this.bytes_already_parsed, var_shift)
		}
		if rt.is_true(rt.less(rt.get_property(var_diff, 'start'), rt.new_int(shift_this_point))) {
			var_accumulated_shift_for_given_point = rt.add(var_accumulated_shift_for_given_point, var_shift)
		}
		var_output_buffer = rt.concat(var_output_buffer, rt.call_function('substr', [this.html, var_bytes_already_copied.clone(), rt.sub(rt.get_property(var_diff, 'start'), var_bytes_already_copied)]))
		var_output_buffer = rt.concat(var_output_buffer, rt.get_property(var_diff, 'text'))
	var_bytes_already_copied = rt.add(rt.get_property(var_diff, 'start'), rt.get_property(var_diff, 'length'))
	}
	this.html = (var_output_buffer).str() + (rt.call_function('substr', [this.html, var_bytes_already_copied.clone()])).str()
	mut iter_7 := this.bookmarks.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_bookmark := item_7.val
		mut var_bookmark_name := item_7.key
		mut var_bookmark_end := rt.add(rt.get_property(var_bookmark, 'start'), rt.get_property(var_bookmark, 'length'))
		mut var_head_delta := rt.new_int(0)
		mut var_tail_delta := rt.new_int(0)
		mut iter_8 := this.lexical_updates.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_diff := item_8.val
			mut var_diff_end := rt.add(rt.get_property(var_diff, 'start'), rt.get_property(var_diff, 'length'))
			if rt.is_true(rt.less(rt.get_property(var_bookmark, 'start'), rt.get_property(var_diff, 'start'))) && rt.is_true(rt.less(var_bookmark_end, rt.get_property(var_diff, 'start'))) {
				break
			}
			if rt.is_true(rt.greater_equal(rt.get_property(var_bookmark, 'start'), rt.get_property(var_diff, 'start'))) && rt.is_true(rt.less(var_bookmark_end, var_diff_end)) {
				this.release_bookmark(var_bookmark_name.clone())
				continue
			}
			mut var_delta := rt.sub(rt.new_int(rt.get_property(var_diff, 'text').to_string().len), rt.get_property(var_diff, 'length'))
			if rt.is_true(rt.greater_equal(rt.get_property(var_bookmark, 'start'), rt.get_property(var_diff, 'start'))) {
				var_head_delta = rt.add(var_head_delta, var_delta)
			}
			if rt.is_true(rt.greater_equal(var_bookmark_end, var_diff_end)) {
				var_tail_delta = rt.add(var_tail_delta, var_delta)
			}
		}
		rt.get_property(var_bookmark, 'start') = rt.add(rt.get_property(var_bookmark, 'start'), var_head_delta)
		rt.get_property(var_bookmark, 'length') = rt.add(rt.get_property(var_bookmark, 'length'), rt.sub(var_tail_delta, var_head_delta))
	}
	this.lexical_updates = []rt.PhpVal{}
	return (var_accumulated_shift_for_given_point).to_i64()
}

fn (mut this Class_WP_HTML_Tag_Processor) has_bookmark(var_bookmark_name rt.PhpVal) bool {
	return this.bookmarks.array_isset(var_bookmark_name.clone())
}

fn (mut this Class_WP_HTML_Tag_Processor) seek(var_bookmark_name rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.bookmarks.array_isset(var_bookmark_name.clone())))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Unknown bookmark name.')]), rt.new_string('6.2.0')])
		return false
	}
	mut var_existing_bookmark := this.bookmarks.array_get(var_bookmark_name)
	if rt.is_true(rt.identical(this.token_starts_at, rt.get_property(var_existing_bookmark, 'start'))) && rt.is_true(rt.identical(this.token_length, rt.get_property(var_existing_bookmark, 'length'))) {
		return true
	}
	if rt.is_true(rt.greater(rt.pre_inc(this.seek_count), Class_static.max_seek_ops())) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Too many calls to seek() - this can lead to performance issues.')]), rt.new_string('6.2.0')])
		return false
	}
	this.get_updated_html()
	this.bytes_already_parsed = rt.get_property(this.bookmarks.array_get(var_bookmark_name), 'start')
	this.parser_state = Class_WP_HTML_Tag_Processor.state_ready()
	return this.next_token()
}

fn Class_WP_HTML_Tag_Processor.sort_start_ascending(mut var_a Class_WP_HTML_Text_Replacement, mut var_b Class_WP_HTML_Text_Replacement) i64 {
	mut var_by_start := rt.sub(rt.get_property(var_a, 'start'), rt.get_property(var_b, 'start'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_by_start)))) {
		return (var_by_start).to_i64()
	}
	mut var_by_text := if !(rt.get_property(var_a, 'text')).is_null() && !(rt.get_property(var_b, 'text')).is_null() { rt.call_function('strcmp', [rt.get_property(var_a, 'text'), rt.get_property(var_b, 'text')]) } else { rt.new_int(0) }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_by_text)))) {
		return (var_by_text).to_i64()
	}
	return (rt.sub(rt.get_property(var_a, 'length'), rt.get_property(var_b, 'length'))).to_i64()
}

fn (mut this Class_WP_HTML_Tag_Processor) get_enqueued_attribute_value(comparable_name string) rt.PhpVal {
	mut comparable_name_mutated := comparable_name
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)))) {
		return rt.new_bool(false)
	}
	if !(this.lexical_updates.array_isset(rt.new_string(comparable_name_mutated))) {
		return rt.new_bool(false)
	}
	mut var_enqueued_text := rt.get_property(this.lexical_updates.array_get(rt.new_string(comparable_name_mutated)), 'text')
	if rt.is_true(rt.identical(rt.new_string(''), var_enqueued_text)) {
		return rt.new_null()
	}
	mut var_equals_at := rt.call_function('strpos', [var_enqueued_text.clone(), rt.new_string('=')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_equals_at)) {
		return rt.new_bool(true)
	}
	mut var_enqueued_value := rt.call_function('substr', [var_enqueued_text.clone(), rt.add(var_equals_at, rt.new_int(2)), rt.new_int(-1)])
	mut iife_temp_1 := Class_WP_HTML_Decoder{}
	mut iife_result_1 := iife_temp_1.decode_attribute(var_enqueued_value.clone())
	return iife_result_1
}

fn (mut this Class_WP_HTML_Tag_Processor) get_attribute(var_name rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)))) {
		return rt.new_null()
	}
	mut var_comparable := rt.new_string(var_name_mutated.clone().to_string().to_lower())
	if rt.is_true(rt.identical(rt.new_string('class'), var_name_mutated)) {
		this.class_name_updates_to_attributes_updates()
	}
	mut var_enqueued_value := this.get_enqueued_attribute_value((var_comparable).str())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_enqueued_value)))) {
		return var_enqueued_value.clone()
	}
	if !(this.attributes.array_isset(var_comparable)) {
		return rt.new_null()
	}
	mut var_attribute := this.attributes.array_get(var_comparable)
	if rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_attribute, 'is_true'))) {
		return rt.new_bool(true)
	}
	mut var_raw_value := rt.call_function('substr', [this.html, rt.get_property(var_attribute, 'value_starts_at'), rt.get_property(var_attribute, 'value_length')])
	mut iife_temp_2 := Class_WP_HTML_Decoder{}
	mut iife_result_2 := iife_temp_2.decode_attribute(var_raw_value.clone())
	return iife_result_2
}

fn (mut this Class_WP_HTML_Tag_Processor) get_attribute_names_with_prefix(var_prefix rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)))) || rt.is_true(this.is_closing_tag) {
		return rt.new_null()
	}
	mut var_comparable := rt.new_string(var_prefix.clone().to_string().to_lower())
	mut var_matches := []rt.PhpVal{}
	mut iter_9 := rt.func_array_keys(this.attributes).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_attr_name := item_9.val
		if rt.is_true(rt.call_function('str_starts_with', [var_attr_name.clone(), var_comparable.clone()])) {
			var_matches << var_attr_name.clone()
		}
	}
	return var_matches.clone()
}

fn (mut this Class_WP_HTML_Tag_Processor) get_namespace() string {
	return (this.parsing_namespace).str()
}

fn (mut this Class_WP_HTML_Tag_Processor) get_tag() string {
	if rt.is_true(rt.identical(rt.new_null(), this.tag_name_starts_at)) {
		return (rt.new_null()).str()
	}
	mut var_tag_name := rt.call_function('substr', [this.html, this.tag_name_starts_at, this.tag_name_length])
	if rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)) {
		return var_tag_name.clone().to_string().to_upper()
	}
	if rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_comment(), this.parser_state)) && rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.comment_as_pi_node_lookalike(), this.get_comment_type())) {
		return (var_tag_name).str()
	}
	return (rt.new_null()).str()
}

fn (mut this Class_WP_HTML_Tag_Processor) get_qualified_tag_name() string {
	mut var_tag_name := rt.new_string(this.get_tag())
	if rt.is_true(rt.identical(rt.new_null(), var_tag_name)) {
		return (rt.new_null()).str()
	}
	if rt.is_true(rt.identical(rt.new_string('html'), this.get_namespace())) {
		return (var_tag_name).str()
	}
	mut var_lower_tag_name := rt.new_string(var_tag_name.clone().to_string().to_lower())
	if rt.is_true(rt.identical(rt.new_string('math'), this.get_namespace())) {
		return (var_lower_tag_name).str()
	}
	if rt.is_true(rt.identical(rt.new_string('svg'), this.get_namespace())) {
		mut switch_val_3 := var_lower_tag_name
		if rt.is_true(rt.equal(switch_val_3, rt.new_string('altglyph'))) {
			return 'altGlyph'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('altglyphdef'))) {
			return 'altGlyphDef'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('altglyphitem'))) {
			return 'altGlyphItem'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('animatecolor'))) {
			return 'animateColor'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('animatemotion'))) {
			return 'animateMotion'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('animatetransform'))) {
			return 'animateTransform'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('clippath'))) {
			return 'clipPath'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('feblend'))) {
			return 'feBlend'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fecolormatrix'))) {
			return 'feColorMatrix'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fecomponenttransfer'))) {
			return 'feComponentTransfer'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fecomposite'))) {
			return 'feComposite'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('feconvolvematrix'))) {
			return 'feConvolveMatrix'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fediffuselighting'))) {
			return 'feDiffuseLighting'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fedisplacementmap'))) {
			return 'feDisplacementMap'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fedistantlight'))) {
			return 'feDistantLight'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fedropshadow'))) {
			return 'feDropShadow'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('feflood'))) {
			return 'feFlood'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fefunca'))) {
			return 'feFuncA'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fefuncb'))) {
			return 'feFuncB'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fefuncg'))) {
			return 'feFuncG'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fefuncr'))) {
			return 'feFuncR'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fegaussianblur'))) {
			return 'feGaussianBlur'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('feimage'))) {
			return 'feImage'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('femerge'))) {
			return 'feMerge'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('femergenode'))) {
			return 'feMergeNode'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('femorphology'))) {
			return 'feMorphology'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('feoffset'))) {
			return 'feOffset'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fepointlight'))) {
			return 'fePointLight'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fespecularlighting'))) {
			return 'feSpecularLighting'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fespotlight'))) {
			return 'feSpotLight'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fetile'))) {
			return 'feTile'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('feturbulence'))) {
			return 'feTurbulence'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('foreignobject'))) {
			return 'foreignObject'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('glyphref'))) {
			return 'glyphRef'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('lineargradient'))) {
			return 'linearGradient'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('radialgradient'))) {
			return 'radialGradient'
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('textpath'))) {
			return 'textPath'
		} else {
			return (var_lower_tag_name).str()
		}
	}
	return (var_tag_name).str()
}

fn (mut this Class_WP_HTML_Tag_Processor) get_qualified_attribute_name(var_attribute_name rt.PhpVal) string {
	mut var_attribute_name_mutated := var_attribute_name
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)))) {
		return (rt.new_null()).str()
	}
	mut var_namespace := rt.new_string(this.get_namespace())
	mut var_lower_name := rt.new_string(var_attribute_name_mutated.clone().to_string().to_lower())
	if rt.is_true(rt.identical(rt.new_string('math'), var_namespace)) && rt.is_true(rt.identical(rt.new_string('definitionurl'), var_lower_name)) {
		return 'definitionURL'
	}
	if rt.is_true(rt.identical(rt.new_string('svg'), this.get_namespace())) {
		mut switch_val_4 := var_lower_name
		if rt.is_true(rt.equal(switch_val_4, rt.new_string('attributename'))) {
			return 'attributeName'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('attributetype'))) {
			return 'attributeType'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('basefrequency'))) {
			return 'baseFrequency'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('baseprofile'))) {
			return 'baseProfile'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('calcmode'))) {
			return 'calcMode'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('clippathunits'))) {
			return 'clipPathUnits'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('diffuseconstant'))) {
			return 'diffuseConstant'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('edgemode'))) {
			return 'edgeMode'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('filterunits'))) {
			return 'filterUnits'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('glyphref'))) {
			return 'glyphRef'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('gradienttransform'))) {
			return 'gradientTransform'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('gradientunits'))) {
			return 'gradientUnits'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('kernelmatrix'))) {
			return 'kernelMatrix'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('kernelunitlength'))) {
			return 'kernelUnitLength'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('keypoints'))) {
			return 'keyPoints'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('keysplines'))) {
			return 'keySplines'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('keytimes'))) {
			return 'keyTimes'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('lengthadjust'))) {
			return 'lengthAdjust'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('limitingconeangle'))) {
			return 'limitingConeAngle'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('markerheight'))) {
			return 'markerHeight'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('markerunits'))) {
			return 'markerUnits'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('markerwidth'))) {
			return 'markerWidth'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('maskcontentunits'))) {
			return 'maskContentUnits'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('maskunits'))) {
			return 'maskUnits'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('numoctaves'))) {
			return 'numOctaves'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('pathlength'))) {
			return 'pathLength'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('patterncontentunits'))) {
			return 'patternContentUnits'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('patterntransform'))) {
			return 'patternTransform'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('patternunits'))) {
			return 'patternUnits'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('pointsatx'))) {
			return 'pointsAtX'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('pointsaty'))) {
			return 'pointsAtY'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('pointsatz'))) {
			return 'pointsAtZ'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('preservealpha'))) {
			return 'preserveAlpha'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('preserveaspectratio'))) {
			return 'preserveAspectRatio'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('primitiveunits'))) {
			return 'primitiveUnits'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('refx'))) {
			return 'refX'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('refy'))) {
			return 'refY'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('repeatcount'))) {
			return 'repeatCount'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('repeatdur'))) {
			return 'repeatDur'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('requiredextensions'))) {
			return 'requiredExtensions'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('requiredfeatures'))) {
			return 'requiredFeatures'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('specularconstant'))) {
			return 'specularConstant'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('specularexponent'))) {
			return 'specularExponent'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('spreadmethod'))) {
			return 'spreadMethod'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('startoffset'))) {
			return 'startOffset'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('stddeviation'))) {
			return 'stdDeviation'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('stitchtiles'))) {
			return 'stitchTiles'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('surfacescale'))) {
			return 'surfaceScale'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('systemlanguage'))) {
			return 'systemLanguage'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('tablevalues'))) {
			return 'tableValues'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('targetx'))) {
			return 'targetX'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('targety'))) {
			return 'targetY'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('textlength'))) {
			return 'textLength'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('viewbox'))) {
			return 'viewBox'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('viewtarget'))) {
			return 'viewTarget'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('xchannelselector'))) {
			return 'xChannelSelector'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('ychannelselector'))) {
			return 'yChannelSelector'
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('zoomandpan'))) {
			return 'zoomAndPan'
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('html'), var_namespace)))) {
		mut switch_val_5 := var_lower_name
		if rt.is_true(rt.equal(switch_val_5, rt.new_string('xlink:actuate'))) {
			return 'xlink actuate'
		} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('xlink:arcrole'))) {
			return 'xlink arcrole'
		} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('xlink:href'))) {
			return 'xlink href'
		} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('xlink:role'))) {
			return 'xlink role'
		} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('xlink:show'))) {
			return 'xlink show'
		} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('xlink:title'))) {
			return 'xlink title'
		} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('xlink:type'))) {
			return 'xlink type'
		} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('xml:lang'))) {
			return 'xml lang'
		} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('xml:space'))) {
			return 'xml space'
		} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('xmlns'))) {
			return 'xmlns'
		} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('xmlns:xlink'))) {
			return 'xmlns xlink'
		}
	}
	return (var_attribute_name_mutated).str()
}

fn (mut this Class_WP_HTML_Tag_Processor) has_self_closing_flag() bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)))) {
		return false
	}
	return (rt.identical(rt.new_string('/'), this.html.array_get(rt.sub(rt.add(this.token_starts_at, this.token_length), rt.new_int(2))))).to_bool()
}

fn (mut this Class_WP_HTML_Tag_Processor) is_tag_closer() bool {
	return rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)) && rt.is_true(this.is_closing_tag) && rt.is_true(rt.new_bool('BR' != this.get_tag()))
}

fn (mut this Class_WP_HTML_Tag_Processor) get_token_type() string {
	mut switch_val_6 := this.parser_state
	if rt.is_true(rt.equal(switch_val_6, Class_WP_HTML_Tag_Processor.state_matched_tag())) {
		return '#tag'
	} else if rt.is_true(rt.equal(switch_val_6, Class_WP_HTML_Tag_Processor.state_doctype())) {
		return '#doctype'
	} else {
		return this.get_token_name()
	}
	return ''
}

fn (mut this Class_WP_HTML_Tag_Processor) get_token_name() string {
	mut switch_val_7 := this.parser_state
	if rt.is_true(rt.equal(switch_val_7, Class_WP_HTML_Tag_Processor.state_matched_tag())) {
		return this.get_tag()
	} else if rt.is_true(rt.equal(switch_val_7, Class_WP_HTML_Tag_Processor.state_text_node())) {
		return '#text'
	} else if rt.is_true(rt.equal(switch_val_7, Class_WP_HTML_Tag_Processor.state_cdata_node())) {
		return '#cdata-section'
	} else if rt.is_true(rt.equal(switch_val_7, Class_WP_HTML_Tag_Processor.state_comment())) {
		return '#comment'
	} else if rt.is_true(rt.equal(switch_val_7, Class_WP_HTML_Tag_Processor.state_doctype())) {
		return 'html'
	} else if rt.is_true(rt.equal(switch_val_7, Class_WP_HTML_Tag_Processor.state_presumptuous_tag())) {
		return '#presumptuous-tag'
	} else if rt.is_true(rt.equal(switch_val_7, Class_WP_HTML_Tag_Processor.state_funky_comment())) {
		return '#funky-comment'
	}
	return (rt.new_null()).str()
}

fn (mut this Class_WP_HTML_Tag_Processor) get_comment_type() string {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_comment(), this.parser_state)))) {
		return (rt.new_null()).str()
	}
	return (this.comment_type).str()
}

fn (mut this Class_WP_HTML_Tag_Processor) get_full_comment_text() string {
	if rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_funky_comment(), this.parser_state)) {
		return this.get_modifiable_text()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_comment(), this.parser_state)))) {
		return (rt.new_null()).str()
	}
	mut switch_val_8 := this.get_comment_type()
	if rt.is_true(rt.equal(switch_val_8, Class_WP_HTML_Tag_Processor.comment_as_html_comment())) || rt.is_true(rt.equal(switch_val_8, Class_WP_HTML_Tag_Processor.comment_as_abruptly_closed_comment())) {
		return this.get_modifiable_text()
	} else if rt.is_true(rt.equal(switch_val_8, Class_WP_HTML_Tag_Processor.comment_as_cdata_lookalike())) {
		return rt.concat(rt.concat(rt.new_string('[CDATA['), this.get_modifiable_text()), rt.new_string(']]'))
	} else if rt.is_true(rt.equal(switch_val_8, Class_WP_HTML_Tag_Processor.comment_as_pi_node_lookalike())) {
		return rt.concat(rt.concat(rt.concat(rt.new_string('?'), this.get_tag()), this.get_modifiable_text()), rt.new_string('?'))
	} else if rt.is_true(rt.equal(switch_val_8, Class_WP_HTML_Tag_Processor.comment_as_invalid_html())) {
		mut var_preceding_character := this.html.array_get(rt.sub(this.text_starts_at, rt.new_int(1)))
		mut var_comment_start := rt.new_string((if rt.is_true(rt.identical(rt.new_string('?'), var_preceding_character)) { '?' } else { '' }).str())
		return rt.concat(var_comment_start, this.get_modifiable_text())
	}
	return (rt.new_null()).str()
}

fn (mut this Class_WP_HTML_Tag_Processor) subdivide_text_appropriately() bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_text_node(), this.parser_state)))) {
		return false
	}
	this.text_node_classification = Class_WP_HTML_Tag_Processor.text_is_generic()
	mut var_leading_nulls := rt.call_function('strspn', [this.html, rt.new_string(''), this.text_starts_at, this.text_length])
	if rt.is_true(rt.greater(var_leading_nulls, rt.new_int(0))) {
		this.token_length = var_leading_nulls.clone()
		this.text_length = var_leading_nulls.clone()
		this.bytes_already_parsed = rt.add(this.token_starts_at, var_leading_nulls)
		this.text_node_classification = Class_WP_HTML_Tag_Processor.text_is_null_sequence()
		return true
	}
	mut var_at := this.text_starts_at
	mut var_end := rt.add(this.text_starts_at, this.text_length)
	for rt.is_true(rt.less(var_at, var_end)) {
		mut var_skipped := rt.call_function('strspn', [this.html, rt.new_string(' \t\r\n'), var_at.clone(), rt.sub(var_end, var_at)])
		var_at = rt.add(var_at, var_skipped)
		if rt.is_true(rt.less(var_at, var_end)) && rt.is_true(rt.identical(rt.new_string('&'), this.html.array_get(var_at))) {
			mut var_matched_byte_length := rt.new_null()
			mut iife_temp_3 := Class_WP_HTML_Decoder{}
			mut iife_result_3 := iife_temp_3.read_character_reference(rt.new_string('data'), this.html, var_at.clone(), var_matched_byte_length.clone())
			mut var_replacement := iife_result_3
			if !(var_replacement).is_null() && rt.is_true(rt.identical(rt.new_int(1), rt.call_function('strspn', [var_replacement.clone(), rt.new_string(' \t\r\n')]))) {
				var_at = rt.add(var_at, var_matched_byte_length)
				continue
			}
		}
		break
	}
	if rt.is_true(rt.greater(var_at, this.text_starts_at)) {
		mut var_new_length := rt.sub(var_at, this.text_starts_at)
		this.text_length = var_new_length.clone()
		this.token_length = var_new_length.clone()
		this.bytes_already_parsed = var_at.clone()
		this.text_node_classification = Class_WP_HTML_Tag_Processor.text_is_whitespace()
		return true
	}
	return false
}

fn (mut this Class_WP_HTML_Tag_Processor) get_modifiable_text() string {
	mut var_has_enqueued_update := rt.new_bool(this.lexical_updates.array_isset(rt.new_string('modifiable text')))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_enqueued_update)))) && rt.is_true(rt.identical(rt.new_null(), this.text_starts_at)) || rt.is_true(rt.identical(rt.new_int(0), this.text_length)) {
		return ''
	}
	mut var_text := if rt.is_true(var_has_enqueued_update) { rt.get_property(this.lexical_updates.array_get(rt.new_string('modifiable text')), 'text') } else { rt.call_function('substr', [this.html, this.text_starts_at, this.text_length]) }
	var_text = rt.call_function('str_replace', [rt.new_string('\r\n'), rt.new_string('\n'), var_text.clone()])
	var_text = rt.call_function('str_replace', [rt.new_string('\r'), rt.new_string('\n'), var_text.clone()])
	if rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_cdata_node(), this.parser_state)) || rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_comment(), this.parser_state)) || rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_doctype(), this.parser_state)) || rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_funky_comment(), this.parser_state)) {
		return (rt.call_function('str_replace', [rt.new_string(''), rt.new_string('�'), var_text.clone()])).str()
	}
	mut var_tag_name := rt.new_string(this.get_token_name())
	if rt.is_true(rt.identical(rt.new_string('SCRIPT'), var_tag_name)) || rt.is_true(rt.identical(rt.new_string('IFRAME'), var_tag_name)) || rt.is_true(rt.identical(rt.new_string('NOEMBED'), var_tag_name)) || rt.is_true(rt.identical(rt.new_string('NOFRAMES'), var_tag_name)) || rt.is_true(rt.identical(rt.new_string('STYLE'), var_tag_name)) || rt.is_true(rt.identical(rt.new_string('XMP'), var_tag_name)) {
		return (rt.call_function('str_replace', [rt.new_string(''), rt.new_string('�'), var_text.clone()])).str()
	}
	mut iife_temp_4 := Class_WP_HTML_Decoder{}
	mut iife_result_4 := iife_temp_4.decode_text_node(var_text.clone())
	mut var_decoded := iife_result_4
	if rt.is_true(rt.identical(rt.new_string('\n'), if !(var_decoded.array_get(rt.new_int(0))).is_null() { var_decoded.array_get(rt.new_int(0)) } else { rt.new_string('') })) && (rt.is_true(rt.identical(this.skip_newline_at, this.token_starts_at)) && rt.is_true(rt.identical(rt.new_string('#text'), var_tag_name))) || rt.is_true(rt.identical(rt.new_string('TEXTAREA'), var_tag_name)) {
	var_decoded = rt.call_function('substr', [var_decoded.clone(), rt.new_int(1)])
	}
	return (if rt.is_true(rt.identical(rt.new_string('#text'), var_tag_name)) && rt.is_true(rt.identical(rt.new_string('html'), this.get_namespace())) { rt.call_function('str_replace', [rt.new_string(''), rt.new_string(''), var_decoded.clone()]) } else { rt.call_function('str_replace', [rt.new_string(''), rt.new_string('�'), var_decoded.clone()]) }).str()
}

fn (mut this Class_WP_HTML_Tag_Processor) set_modifiable_text(plaintext_content string) bool {
	mut plaintext_content_mutated := plaintext_content
	if rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_text_node(), this.parser_state)) {
		this.lexical_updates.array_set('modifiable text', create_wp_html_text_replacement(this.text_starts_at, this.text_length, rt.call_function('strtr', [rt.new_string(plaintext_content_mutated).clone(), rt.create_array([rt.ArrayItem{ key: '<', val: '&lt;' }, rt.ArrayItem{ key: '>', val: '&gt;' }, rt.ArrayItem{ key: '&', val: '&amp;' }, rt.ArrayItem{ key: '"', val: '&quot;' }, rt.ArrayItem{ key: '\'', val: '&apos;' }])])))
		return true
	}
	if rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_comment(), this.parser_state)) && rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.comment_as_html_comment(), this.comment_type)) {
		if rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [rt.new_string('/--!?>/'), rt.new_string(plaintext_content_mutated).clone()]))) {
			return false
		}
		this.lexical_updates.array_set('modifiable text', create_wp_html_text_replacement(this.text_starts_at, this.text_length, rt.new_string(plaintext_content_mutated).clone()))
		return true
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)))) || rt.is_true(rt.new_bool('html' != this.get_namespace())) {
		return false
	}
	mut switch_val_9 := this.get_tag()
	if rt.is_true(rt.equal(switch_val_9, rt.new_string('SCRIPT'))) {
		mut var_script_content_type := rt.new_string(this.get_script_content_type())
		mut switch_val_10 := var_script_content_type
		if rt.is_true(rt.equal(switch_val_10, rt.new_string('javascript'))) || rt.is_true(rt.equal(switch_val_10, rt.new_string('json'))) {
			this.lexical_updates.array_set('modifiable text', create_wp_html_text_replacement(this.text_starts_at, this.text_length, Class_WP_HTML_Tag_Processor.escape_javascript_script_contents(plaintext_content_mutated)))
			return true
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [rt.new_string(plaintext_content_mutated).clone(), rt.new_string('<script')]))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [rt.new_string(plaintext_content_mutated).clone(), rt.new_string('</script')]))))) {
			return false
		}
		this.lexical_updates.array_set('modifiable text', create_wp_html_text_replacement(this.text_starts_at, this.text_length, rt.new_string(plaintext_content_mutated).clone()))
		return true
	} else if rt.is_true(rt.equal(switch_val_9, rt.new_string('STYLE'))) {
		closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_tag_match := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.concat(rt.new_string('\\3c\\2f'), var_tag_match.array_get(rt.new_string('TAG_NAME')))
			}
		plaintext_content_mutated = (rt.call_function('preg_replace_callback', [rt.new_string('~</(?P<TAG_NAME>style)~i'), rt.new_closure(closure_6_fn), rt.new_string(plaintext_content_mutated).clone()])).str()
		this.lexical_updates.array_set('modifiable text', create_wp_html_text_replacement(this.text_starts_at, this.text_length, rt.new_string(plaintext_content_mutated).clone()))
		return true
	} else if rt.is_true(rt.equal(switch_val_9, rt.new_string('TEXTAREA'))) || rt.is_true(rt.equal(switch_val_9, rt.new_string('TITLE'))) {
		closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_tag_match := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.concat(rt.new_string('&lt;/'), var_tag_match.array_get(rt.new_string('TAG_NAME')))
			}
		plaintext_content_mutated = (rt.call_function('preg_replace_callback', [rt.concat(rt.concat(rt.new_string('~</(?P<TAG_NAME>'), this.get_tag()), rt.new_string(')~i')), rt.new_closure(closure_7_fn), rt.new_string(plaintext_content_mutated).clone()])).str()
		if rt.is_true(rt.identical(rt.new_string('TEXTAREA'), this.get_tag())) && rt.is_true(rt.identical(rt.new_int(1), rt.call_function('strspn', [rt.new_string(plaintext_content_mutated).clone(), rt.new_string('\n\r'), rt.new_int(0), rt.new_int(1)]))) {
		plaintext_content_mutated = "\n${var_plaintext_content.to_string()}"
		}
		this.lexical_updates.array_set('modifiable text', create_wp_html_text_replacement(this.text_starts_at, this.text_length, rt.new_string(plaintext_content_mutated).clone()))
		return true
	}
	return false
}

fn (mut this Class_WP_HTML_Tag_Processor) get_script_content_type() string {
	if rt.is_true(rt.new_bool('SCRIPT' != this.get_tag())) || rt.is_true(rt.new_bool(this.get_namespace() != 'html')) {
		return (rt.new_null()).str()
	}
	mut var_type := this.get_attribute(rt.new_string('type'))
	mut var_lang := this.get_attribute(rt.new_string('language'))
	if rt.is_true(rt.identical(rt.new_bool(true), var_type)) || rt.is_true(rt.identical(rt.new_string(''), var_type)) {
		return 'javascript'
	}
	if rt.is_true(rt.identical(rt.new_null(), var_type)) && rt.is_true(rt.identical(rt.new_null(), var_lang)) || rt.is_true(rt.identical(rt.new_bool(true), var_lang)) || rt.is_true(rt.identical(rt.new_string(''), var_lang)) {
		return 'javascript'
	}
	mut var_type_string := rt.new_string((if var_type.clone().is_string() { var_type.clone().to_string().trim_space() } else { "text/${var_lang.to_string()}" }).str())
	var_type_string = rt.new_string(var_type_string.clone().to_string().to_lower())
	mut switch_val_11 := var_type_string
	if rt.is_true(rt.equal(switch_val_11, rt.new_string('application/ecmascript'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('application/javascript'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('application/x-ecmascript'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('application/x-javascript'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('text/ecmascript'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('text/javascript'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('text/javascript1.0'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('text/javascript1.1'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('text/javascript1.2'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('text/javascript1.3'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('text/javascript1.4'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('text/javascript1.5'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('text/jscript'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('text/livescript'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('text/x-ecmascript'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('text/x-javascript'))) {
		return 'javascript'
	} else if rt.is_true(rt.equal(switch_val_11, rt.new_string('module'))) {
		return 'javascript'
	} else if rt.is_true(rt.equal(switch_val_11, rt.new_string('importmap'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('speculationrules'))) {
		return 'json'
	} else if rt.is_true(rt.equal(switch_val_11, rt.new_string('application/json'))) || rt.is_true(rt.equal(switch_val_11, rt.new_string('text/json'))) {
		return 'json'
	}
	return (rt.new_null()).str()
}

fn Class_WP_HTML_Tag_Processor.escape_javascript_script_contents(sourcecode string) string {
	mut var_at := rt.new_int(0)
	mut var_was_at := rt.new_int(0)
	mut var_end := rt.new_int(sourcecode.len)
	mut var_escaped := rt.new_string('')
	for rt.is_true(rt.less(var_at, var_end)) {
		mut var_tag_at := rt.call_function('strpos', [rt.new_string(sourcecode), rt.new_string('<'), var_at.clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_tag_at)) {
			break
		}
		mut var_tag_name_at := rt.add(var_tag_at, rt.new_int(1))
		mut var_has_closing_slash := rt.new_bool(rt.is_true(rt.less(var_tag_name_at, var_end)) && rt.is_true(rt.identical(rt.new_string('/'), rt.new_string(sourcecode).array_get(var_tag_name_at))))
		var_tag_name_at = rt.add(var_tag_name_at, if rt.is_true(var_has_closing_slash) { 1 } else { 0 })
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [rt.new_string(sourcecode), rt.new_string('script'), var_tag_name_at.clone(), rt.new_int(6), rt.new_bool(true)]))))) {
			var_at = rt.add(var_tag_at, rt.new_int(1))
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), rt.call_function('strspn', [rt.new_string(sourcecode), rt.new_string(' \t\r\n/>'), rt.add(var_tag_name_at, rt.new_int(6)), rt.new_int(1)]))))) {
			var_at = rt.add(var_tag_name_at, rt.new_int(6))
			continue
		}
		var_escaped = rt.concat(var_escaped, rt.call_function('substr', [rt.new_string(sourcecode), var_was_at.clone(), rt.sub(var_tag_name_at, var_was_at)]))
		var_escaped = rt.concat(var_escaped, if rt.is_true(rt.identical(rt.new_string('s'), rt.new_string(sourcecode).array_get(var_tag_name_at))) { '\\u0073' } else { '\\u0053' })
	var_was_at = rt.add(var_tag_name_at, rt.new_int(1))
	var_at = rt.add(var_tag_name_at, rt.new_int(7))
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_escaped)) {
		return sourcecode
	}
	if rt.is_true(rt.less(var_was_at, var_end)) {
		var_escaped = rt.concat(var_escaped, rt.call_function('substr', [rt.new_string(sourcecode), var_was_at.clone()]))
	}
	return (var_escaped).str()
}

fn (mut this Class_WP_HTML_Tag_Processor) set_attribute(var_name rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_name_mutated := var_name
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)))) || rt.is_true(this.is_closing_tag) {
		return false
	}
	mut var_name_length := rt.new_int(var_name_mutated.clone().to_string().len)
	if rt.is_true(rt.identical(rt.new_int(0), var_name_length)) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strcspn', [var_name_mutated.clone(), rt.new_string('"\'>&</ =')]), var_name_length)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strcspn', [var_name_mutated.clone(), rt.new_string('' + '')]), var_name_length)))) || rt.is_true(rt.call_function('wp_has_noncharacters', [var_name_mutated.clone()])) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Invalid attribute name.')]), rt.new_string('6.2.0')])
		return false
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_value)) {
		return this.remove_attribute(var_name_mutated.clone())
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_value)) {
	mut var_updated_attribute := var_name_mutated.clone()
	} else {
		mut var_comparable_name := rt.new_string(var_name_mutated.clone().to_string().to_lower())
		mut var_escaped_new_value := if rt.is_true(rt.call_function('in_array', [var_comparable_name.clone(), rt.call_function('wp_kses_uri_attributes', []rt.PhpVal{}), rt.new_bool(true)])) { rt.call_function('esc_url', [var_value.clone()]) } else { rt.call_function('strtr', [var_value.clone(), rt.create_array([rt.ArrayItem{ key: '<', val: '&lt;' }, rt.ArrayItem{ key: '>', val: '&gt;' }, rt.ArrayItem{ key: '&', val: '&amp;' }, rt.ArrayItem{ key: '"', val: '&quot;' }, rt.ArrayItem{ key: '\'', val: '&apos;' }])]) }
		if rt.is_true(rt.identical(rt.new_string(''), var_escaped_new_value)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_value)))) {
			return false
		}
	var_updated_attribute = rt.new_string("${var_name.to_string()}=\"${var_escaped_new_value.to_string()}\"")
	}
	var_comparable_name = rt.new_string(var_name_mutated.clone().to_string().to_lower())
	if this.attributes.array_isset(var_comparable_name) {
		mut var_existing_attribute := this.attributes.array_get(var_comparable_name)
		this.lexical_updates.array_set(var_comparable_name, create_wp_html_text_replacement(rt.get_property(var_existing_attribute, 'start'), rt.get_property(var_existing_attribute, 'length'), var_updated_attribute.clone()))
	} else {
		this.lexical_updates.array_set(var_comparable_name, create_wp_html_text_replacement(rt.add(this.tag_name_starts_at, this.tag_name_length), rt.new_int(0), ' ' + (var_updated_attribute).str()))
	}
	if rt.is_true(rt.identical(rt.new_string('class'), var_comparable_name)) && !(!rt.is_true(this.classname_updates)) {
		this.classname_updates = []rt.PhpVal{}
	}
	return true
}

fn (mut this Class_WP_HTML_Tag_Processor) remove_attribute(var_name rt.PhpVal) bool {
	mut var_name_mutated := var_name
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)))) || rt.is_true(this.is_closing_tag) {
		return false
	}
	var_name_mutated = rt.new_string(var_name_mutated.clone().to_string().to_lower())
	if rt.is_true(rt.identical(rt.new_string('class'), var_name_mutated)) && rt.is_true(rt.new_bool(this.classname_updates.array_count() != 0)) {
		this.classname_updates = []rt.PhpVal{}
	}
	if !(this.attributes.array_isset(var_name_mutated)) {
		if this.lexical_updates.array_isset(var_name_mutated) {
			this.lexical_updates.array_unset(var_name_mutated)
		}
		return false
	}
	this.lexical_updates.array_set(var_name_mutated, create_wp_html_text_replacement(rt.get_property(this.attributes.array_get(var_name_mutated), 'start'), rt.get_property(this.attributes.array_get(var_name_mutated), 'length'), rt.new_string('')))
	mut iter_10 := if !(this.duplicate_attributes.array_get(var_name_mutated)).is_null() { this.duplicate_attributes.array_get(var_name_mutated) } else { []rt.PhpVal{} }.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_attribute_token := item_10.val
		this.lexical_updates.array_push(create_wp_html_text_replacement(rt.get_property(var_attribute_token, 'start'), rt.get_property(var_attribute_token, 'length'), rt.new_string('')))
	}
	return true
}

fn (mut this Class_WP_HTML_Tag_Processor) add_class(var_class_name rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)))) || rt.is_true(this.is_closing_tag) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.quirks_mode(), this.compat_mode)))) {
		this.classname_updates.array_set(var_class_name, Class_WP_HTML_Tag_Processor.add_class())
		return true
	}
	mut var_class_name_length := rt.new_int(var_class_name.clone().to_string().len)
	mut iter_11 := this.classname_updates.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_action := item_11.val
		mut var_updated_name := item_11.key
		if rt.is_true(rt.identical(rt.new_int(var_updated_name.clone().to_string().len), var_class_name_length)) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [var_updated_name.clone(), var_class_name.clone(), rt.new_int(0), var_class_name_length.clone(), rt.new_bool(true)]))) {
			this.classname_updates.array_set(var_updated_name, Class_WP_HTML_Tag_Processor.add_class())
			return true
		}
	}
	this.classname_updates.array_set(var_class_name, Class_WP_HTML_Tag_Processor.add_class())
	return true
}

fn (mut this Class_WP_HTML_Tag_Processor) remove_class(var_class_name rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_matched_tag(), this.parser_state)))) || rt.is_true(this.is_closing_tag) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.quirks_mode(), this.compat_mode)))) {
		this.classname_updates.array_set(var_class_name, Class_WP_HTML_Tag_Processor.remove_class())
		return true
	}
	mut var_class_name_length := rt.new_int(var_class_name.clone().to_string().len)
	mut iter_12 := this.classname_updates.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_action := item_12.val
		mut var_updated_name := item_12.key
		if rt.is_true(rt.identical(rt.new_int(var_updated_name.clone().to_string().len), var_class_name_length)) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [var_updated_name.clone(), var_class_name.clone(), rt.new_int(0), var_class_name_length.clone(), rt.new_bool(true)]))) {
			this.classname_updates.array_set(var_updated_name, Class_WP_HTML_Tag_Processor.remove_class())
			return true
		}
	}
	this.classname_updates.array_set(var_class_name, Class_WP_HTML_Tag_Processor.remove_class())
	return true
}

fn (mut this Class_WP_HTML_Tag_Processor) magic_tostring() string {
	return this.get_updated_html()
}

fn (mut this Class_WP_HTML_Tag_Processor) get_updated_html() string {
	mut var_requires_no_updating := rt.new_bool(0 == this.classname_updates.array_count() && 0 == this.lexical_updates.array_count())
	if rt.is_true(var_requires_no_updating) {
		return (this.html).str()
	}
	mut var_before_current_tag := if !(this.token_starts_at).is_null() { this.token_starts_at } else { rt.new_int(0) }
	this.class_name_updates_to_attributes_updates()
	var_before_current_tag = rt.add(var_before_current_tag, this.apply_attributes_updates((var_before_current_tag).to_i64()))
	this.bytes_already_parsed = var_before_current_tag.clone()
	this.base_class_next_token()
	return (this.html).str()
}

fn (mut this Class_WP_HTML_Tag_Processor) parse_query(var_query rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_query)))) && rt.is_true(rt.identical(var_query, this.last_query)) {
		return
	}
	this.last_query = var_query.clone()
	this.sought_tag_name = rt.new_null()
	this.sought_class_name = rt.new_null()
	this.sought_match_offset = rt.new_int(1)
	this.stop_on_tag_closers = false
	if rt.is_true(rt.new_bool(var_query.clone().is_string())) {
		this.sought_tag_name = var_query.clone()
		return
	}
	if rt.is_true(rt.identical(rt.new_null(), var_query)) {
		return
	}
	if !(var_query.clone().is_array()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The query argument must be an array or a tag name.')]), rt.new_string('6.2.0')])
		return
	}
	if var_query.array_isset(rt.new_string('tag_name')) && var_query.array_get(rt.new_string('tag_name')).is_string() {
		this.sought_tag_name = var_query.array_get(rt.new_string('tag_name'))
	}
	if var_query.array_isset(rt.new_string('class_name')) && var_query.array_get(rt.new_string('class_name')).is_string() {
		this.sought_class_name = var_query.array_get(rt.new_string('class_name'))
	}
	if var_query.array_isset(rt.new_string('match_offset')) && var_query.array_get(rt.new_string('match_offset')).is_long() && rt.is_true(rt.less(rt.new_int(0), var_query.array_get(rt.new_string('match_offset')))) {
		this.sought_match_offset = var_query.array_get(rt.new_string('match_offset'))
	}
	if var_query.array_isset(rt.new_string('tag_closers')) {
		this.stop_on_tag_closers = rt.identical(rt.new_string('visit'), var_query.array_get(rt.new_string('tag_closers')))
	}
}

fn (mut this Class_WP_HTML_Tag_Processor) matches() bool {
	if rt.is_true(this.is_closing_tag) && !(this.stop_on_tag_closers) {
		return false
	}
	if !(this.sought_tag_name).is_null() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(this.sought_tag_name.to_string().len), this.tag_name_length)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [this.html, this.sought_tag_name, this.tag_name_starts_at, this.tag_name_length, rt.new_bool(true)]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.sought_class_name)))) && !(this.has_class(this.sought_class_name)) {
		return false
	}
	return true
}

fn (mut this Class_WP_HTML_Tag_Processor) get_doctype_info() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_HTML_Tag_Processor.state_doctype(), this.parser_state)))) {
		return rt.new_null()
	}
	mut iife_temp_7 := Class_WP_HTML_Doctype_Info{}
	mut iife_result_7 := iife_temp_7.from_doctype_token(rt.call_function('substr', [this.html, this.token_starts_at, this.token_length]))
	return iife_result_7
}

fn (mut this Class_WP_HTML_Tag_Processor) magic_wakeup() {
	rt.throw_exception(rt.new_object('LogicException', []string{}, create_logicexception(@STRUCT + ' should never be unserialized')))
}

struct Class_WP_HTML_Span {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Attribute_Token {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Decoder {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Text_Replacement {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Doctype_Info {
	rt.PhpObjectBase
}

struct Class_LogicException {
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

fn create_wp_html_span(_args ...rt.PhpVal) &Class_WP_HTML_Span {
	mut obj := &Class_WP_HTML_Span{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_attribute_token(_args ...rt.PhpVal) &Class_WP_HTML_Attribute_Token {
	mut obj := &Class_WP_HTML_Attribute_Token{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_decoder(_args ...rt.PhpVal) &Class_WP_HTML_Decoder {
	mut obj := &Class_WP_HTML_Decoder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_text_replacement(_args ...rt.PhpVal) &Class_WP_HTML_Text_Replacement {
	mut obj := &Class_WP_HTML_Text_Replacement{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_doctype_info(_args ...rt.PhpVal) &Class_WP_HTML_Doctype_Info {
	mut obj := &Class_WP_HTML_Doctype_Info{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_logicexception(_args ...rt.PhpVal) &Class_LogicException {
	mut obj := &Class_LogicException{
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


fn (mut this Class_WP_HTML_Attribute_Token) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Attribute_Token) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Attribute_Token) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_HTML_Decoder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Decoder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Decoder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_HTML_Text_Replacement) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Text_Replacement) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Text_Replacement) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_HTML_Doctype_Info) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Doctype_Info) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Doctype_Info) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_LogicException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_LogicException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_LogicException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
