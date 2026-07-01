import rt

pub fn Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState.eof() rt.PhpVal {
	return none
}
struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState {
	rt.PhpObjectBase
pub mut:
		oParserSettings rt.PhpVal = rt.new_null()
		sText rt.PhpVal = rt.new_null()
		aText rt.PhpVal = rt.new_null()
		iCurrentPosition rt.PhpVal = rt.new_null()
		sCharset rt.PhpVal = rt.new_null()
		iLength i64
		iLineNo rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) construct(var_sText rt.PhpVal, mut var_oParserSettings Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Settings, iLineNo i64)  {
	mut iLineNo_mutated := iLineNo
	this.oParserSettings = var_oParserSettings.dup()
	this.sText = var_sText.dup()
	this.iCurrentPosition = rt.new_int(0)
	this.iLineNo = rt.new_int(iLineNo_mutated).dup()
	this.setcharset(rt.get_property(this.oParserSettings, 'sDefaultCharset'))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) setcharset(var_sCharset rt.PhpVal)  {
	this.sCharset = var_sCharset.dup()
	this.aText = this.strsplit(this.sText)
	if rt.is_true(rt.new_bool(this.aText.is_array())) {
		this.iLength = this.aText.array_count()
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) getcharset() rt.PhpVal {
	return this.sCharset
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) currentline() rt.PhpVal {
	return this.iLineNo
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) currentcolumn() rt.PhpVal {
	return this.iCurrentPosition
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) getsettings() rt.PhpVal {
	return this.oParserSettings
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) anchor() rt.PhpVal {
	return create_automattic_woocommerce_vendor_sabberworm_css_parsing_anchor(this.iCurrentPosition, rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState', []string{}, &this).dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) setposition(var_iPosition rt.PhpVal)  {
	this.iCurrentPosition = var_iPosition.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) parseidentifier(bIgnoreCase bool) rt.PhpVal {
	if rt.is_true(this.isend()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedEOFException', []string{}, create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedeofexception(rt.new_string(''), rt.new_string(''), rt.new_string('identifier'), this.iLineNo)))
	}
	mut var_sResult := this.parsecharacter(rt.new_bool(true))
	if rt.is_true(rt.identical(var_sResult, rt.new_null())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException', []string{}, create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedtokenexception(var_sResult.dup(), this.peek(5, 0), rt.new_string('identifier'), this.iLineNo)))
	}
	mut var_sCharacter := rt.new_null()
	for rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.isend())))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/[a-zA-Z0-9\\x{00A0}-\\x{FFFF}_-]/Sux'), var_sCharacter.dup()])) {
			// unsupported expression: Expr_AssignOp_Concat
		} else {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if var_bIgnoreCase {
		var_sResult = rt.new_string(this.strtolower(var_sResult.dup()))
	}
	return var_sResult.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) parsecharacter(var_bIsForIdentifier rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(this.peek(0, 0), rt.new_string('\\'))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_bIsForIdentifier) && rt.is_true(rt.get_property(this.oParserSettings, 'bLenientParsing')))) && rt.is_true(rt.new_bool(rt.is_true(this.comes(rt.new_string('\\0'), false)) || rt.is_true(this.comes(rt.new_string('\\9'), false)))))) {
			return rt.new_null()
		}
		this.consume('\\')
		if rt.is_true(rt.new_bool(rt.is_true(this.comes(rt.new_string('\\n'), false)) || rt.is_true(this.comes(rt.new_string('\\r'), false)))) {
			return rt.new_string('')
		}
		if rt.is_true(rt.identical(rt.call_function('preg_match', [rt.new_string('/[0-9a-fA-F]/Su'), this.peek(0, 0)]), rt.new_int(0))) {
			return this.consume(1)
		}
		mut var_sUnicode := this.consumeexpression(rt.new_string('/^[0-9a-fA-F]{1,6}/u'), rt.new_int(6))
		if this.strlen(var_sUnicode.dup()) < 6 {
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\s/isSu'), this.peek(0, 0)])) {
				if rt.is_true(this.comes(rt.new_string('\\r\\n'), false)) {
					this.consume(2)
				} else {
					this.consume(1)
				}
			}
		}
		mut var_iUnicode := rt.new_int(rt.new_int(var_sUnicode.dup().to_i64()))
		mut var_sUtf32 := rt.new_string(rt.new_string(''))
		{
			mut var_i := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, rt.new_int(4)))) { break }
				// unsupported expression: Expr_AssignOp_Concat
				var_iUnicode = rt.new_int(rt.shift_right(var_iUnicode, rt.new_int(8)))
				rt.pre_inc(var_i)
			}
		}
		return rt.call_function('iconv', [rt.new_string('utf-32le'), this.sCharset, var_sUtf32.dup()])
	}
	if rt.is_true(var_bIsForIdentifier) {
		mut var_peek := rt.call_function('ord', [this.peek(0, 0)])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_peek, rt.new_int(97))) && rt.is_true(rt.less_equal(var_peek, rt.new_int(122))))) || rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_peek, rt.new_int(65))) && rt.is_true(rt.less_equal(var_peek, rt.new_int(90))))))) || rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_peek, rt.new_int(48))) && rt.is_true(rt.less_equal(var_peek, rt.new_int(57))))))) || rt.is_true(rt.identical(var_peek, rt.new_int(45))))) || rt.is_true(rt.identical(var_peek, rt.new_int(95))))) || rt.is_true(rt.greater(var_peek, rt.new_int(161))))) {
			return this.consume(1)
		}
	} else {
		return this.consume(1)
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) consumewhitespace() rt.PhpVal {
	mut var_aComments := rt.new_array()
	for {
		for rt.is_true(rt.identical(rt.call_function('preg_match', [rt.new_string('/\\s/isSu'), this.peek(0, 0)]), rt.new_int(1))) {
			this.consume(1)
		}
		if rt.is_true(rt.get_property(this.oParserSettings, 'bLenientParsing')) {
			mut var_oComment := this.consumecomment()
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedEOFException') {
				mut var_e := var_e_1.dup()
				this.iCurrentPosition = this.iLength
				return var_aComments.dup()
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		} else {
			var_oComment = this.consumecomment()
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_aComments.array_push(var_oComment.dup())
		}
		if !(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)) {
			break
		}
	}
	return var_aComments.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) comes(var_sString rt.PhpVal, bCaseInsensitive bool) rt.PhpVal {
	mut var_sPeek := rt.new_string(this.peek(var_sString.dup().to_string().len, 0))
	return if rt.is_true(rt.equal(var_sPeek, rt.new_string(''))) { rt.new_bool(false) } else { this.streql(var_sPeek.dup(), var_sString.dup(), bCaseInsensitive) }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) peek(iLength i64, iOffset i64) string {
	mut iLength_mutated := iLength
	// unsupported expression: Expr_AssignOp_Plus
	if iOffset >= this.iLength {
		return ''
	}
	return (this.substr(rt.new_int(iOffset), rt.new_int(iLength_mutated))).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) consume(mValue i64) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.new_int(mValue).is_string())) {
		mut var_iLineCount := rt.call_function('substr_count', [rt.new_int(mValue), rt.new_string('\n')])
		mut var_iLength := rt.new_int(this.strlen(rt.new_int(mValue)))
		if rt.is_true(rt.new_bool(!(rt.is_true(this.streql(this.substr(this.iCurrentPosition, var_iLength.dup()), rt.new_int(mValue), false))))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException', []string{}, create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedtokenexception(rt.new_int(mValue).dup(), this.peek((rt.call_function('max', [var_iLength.dup(), rt.new_int(5)])).to_i64(), 0), this.iLineNo)))
		}
		// unsupported expression: Expr_AssignOp_Plus
		// unsupported expression: Expr_AssignOp_Plus
		return rt.new_int(mValue)
	} else {
		if rt.is_true(rt.greater(rt.add(this.iCurrentPosition, rt.new_int(mValue)), this.iLength)) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedEOFException', []string{}, create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedeofexception(rt.new_int(mValue).dup(), this.peek(5, 0), rt.new_string('count'), this.iLineNo)))
		}
		mut var_sResult := this.substr(this.iCurrentPosition, rt.new_int(mValue))
		var_iLineCount = rt.call_function('substr_count', [var_sResult.dup(), rt.new_string('\n')])
		// unsupported expression: Expr_AssignOp_Plus
		// unsupported expression: Expr_AssignOp_Plus
		return var_sResult.dup()
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) consumeexpression(var_mExpression rt.PhpVal, var_iMaxLength rt.PhpVal) rt.PhpVal {
	mut var_aMatches := rt.new_null()
	mut var_sInput := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { this.peek((var_iMaxLength).to_i64(), 0) } else { this.inputleft() }
	if rt.is_true(rt.identical(rt.call_function('preg_match', [var_mExpression.dup(), var_sInput.dup(), var_aMatches.dup(), rt.get_constant('PREG_OFFSET_CAPTURE')]), rt.new_int(1))) {
		return this.consume((var_aMatches.array_get(0).array_get(0)).to_i64())
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException', []string{}, create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedtokenexception(var_mExpression.dup(), this.peek(5, 0), rt.new_string('expression'), this.iLineNo)))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) consumecomment() rt.PhpVal {
	mut var_mComment := rt.new_bool(rt.new_bool(false))
	if rt.is_true(this.comes(rt.new_string('/*'), false)) {
		mut var_iLineNo := this.iLineNo
		this.consume(1)
		var_mComment = rt.new_string(rt.new_string(''))
		for rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			// unsupported expression: Expr_AssignOp_Concat
			if rt.is_true(this.comes(rt.new_string('*/'), false)) {
				this.consume(2)
				break
			}
		}
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_automattic_woocommerce_vendor_sabberworm_css_comment_comment(rt.call_function('substr', [var_mComment.dup(), rt.new_int(1)]), var_iLineNo.dup())
	}
	return var_mComment.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) isend() rt.PhpVal {
	return rt.greater_equal(this.iCurrentPosition, this.iLength)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) consumeuntil(var_aEnd rt.PhpVal, bIncludeEnd bool, consumeEnd bool, mut var_comments Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_array) rt.PhpVal {
	mut var_aEnd_mutated := var_aEnd
	mut var_comments_mutated := var_comments
	var_aEnd_mutated = if rt.is_true(rt.new_bool(var_aEnd_mutated.dup().is_array())) { var_aEnd_mutated } else { rt.create_array([rt.ArrayItem{ key: none, val: var_aEnd_mutated }]) }
	mut var_out := rt.new_string(rt.new_string(''))
	mut var_start := this.iCurrentPosition
	for rt.is_true(rt.new_bool(!(rt.is_true(this.isend())))) {
		mut var_char := this.consume(1)
		if rt.is_true(rt.call_function('in_array', [var_char.dup(), var_aEnd_mutated.dup()])) {
			if var_bIncludeEnd {
				// unsupported expression: Expr_AssignOp_Concat
			} else if !(var_consumeEnd) {
				// unsupported expression: Expr_AssignOp_Minus
			}
			return var_out.dup()
		}
		// unsupported expression: Expr_AssignOp_Concat
		if rt.is_true(mut var_comment := this.consumecomment()) {
			var_comments_mutated.array_push(var_comment.dup())
		}
	}
	if rt.is_true(rt.call_function('in_array', [Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState.eof(), var_aEnd_mutated.dup()])) {
		return var_out.dup()
	}
	this.iCurrentPosition = .dup()
	
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) inputleft() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) streql(var_sString1 rt.PhpVal, var_sString2 rt.PhpVal, bCaseInsensitive bool) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) backtrack(var_iAmount rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) strlen(var_sString rt.PhpVal) i64 {
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) substr(var_iStart rt.PhpVal, var_iLength rt.PhpVal) rt.PhpVal {
	mut var_iStart_mutated := var_iStart
	mut var_iLength_mutated := var_iLength
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) strtolower(var_sString rt.PhpVal) string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) strsplit(var_sString rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) strpos(var_sString rt.PhpVal, var_sNeedle rt.PhpVal, var_iOffset rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_Anchor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedEOFException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Comment_Comment {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_sabberworm_css_parsing_parserstate(arg_0 rt.PhpVal, iLineNo i64, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState{
		PhpObjectBase: rt.PhpObjectBase{}
		oParserSettings: rt.new_null()
		sText: rt.new_null()
		aText: rt.new_null()
		iCurrentPosition: rt.new_null()
		sCharset: rt.new_null()
		iLength: i64(0)
		iLineNo: rt.new_null()
	}
	obj.construct(arg_0, iLineNo, arg_2)
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_parsing_anchor() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_Anchor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_Anchor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedeofexception() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedEOFException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedEOFException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_parsing_unexpectedtokenexception() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_comment_comment() &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Comment_Comment {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Comment_Comment{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Settings](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'setCharset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setcharset(dispatch_arg_0)
			return rt.new_null()
		}
		'getCharset' {
			return this.getcharset()
		}
		'currentLine' {
			return this.currentline()
		}
		'currentColumn' {
			return this.currentcolumn()
		}
		'getSettings' {
			return this.getsettings()
		}
		'anchor' {
			return this.anchor()
		}
		'setPosition' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setposition(dispatch_arg_0)
			return rt.new_null()
		}
		'parseIdentifier' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.parseidentifier(dispatch_arg_0)
		}
		'parseCharacter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parsecharacter(dispatch_arg_0)
		}
		'consumeWhiteSpace' {
			return this.consumewhitespace()
		}
		'comes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.comes(dispatch_arg_0, dispatch_arg_1)
		}
		'peek' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.peek(dispatch_arg_0, dispatch_arg_1))
		}
		'consume' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.consume(dispatch_arg_0)
		}
		'consumeExpression' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.consumeexpression(dispatch_arg_0, dispatch_arg_1)
		}
		'consumeComment' {
			return this.consumecomment()
		}
		'isEnd' {
			return this.isend()
		}
		'consumeUntil' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_array](if args.len > 3 { args[3] } else { rt.new_null() })
			return this.consumeuntil(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
		}
		'inputLeft' {
			return this.inputleft()
		}
		'streql' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.streql(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'backtrack' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.backtrack(dispatch_arg_0)
			return rt.new_null()
		}
		'strlen' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.strlen(dispatch_arg_0))
		}
		'substr' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.substr(dispatch_arg_0, dispatch_arg_1)
		}
		'strtolower' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.strtolower(dispatch_arg_0))
		}
		'strsplit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.strsplit(dispatch_arg_0)
		}
		'strpos' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.strpos(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'oParserSettings' { return this.oParserSettings }
		'sText' { return this.sText }
		'aText' { return this.aText }
		'iCurrentPosition' { return this.iCurrentPosition }
		'sCharset' { return this.sCharset }
		'iLength' { return rt.new_int(this.iLength) }
		'iLineNo' { return this.iLineNo }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_ParserState) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'oParserSettings' { this.oParserSettings = val; return true }
		'sText' { this.sText = val; return true }
		'aText' { this.aText = val; return true }
		'iCurrentPosition' { this.iCurrentPosition = val; return true }
		'sCharset' { this.sCharset = val; return true }
		'iLength' { this.iLength = (val).to_i64(); return true }
		'iLineNo' { this.iLineNo = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_Anchor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_Anchor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_Anchor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedEOFException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedEOFException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedEOFException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Parsing_UnexpectedTokenException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Comment_Comment) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Comment_Comment) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_Comment_Comment) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_sabberworm_css_parsing_parserstate_php() {
}
