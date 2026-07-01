import rt

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_bang() i64 {
	return 33
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_dollar() i64 {
	return 36
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_amp() i64 {
	return 38
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_paren_l() i64 {
	return 40
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_paren_r() i64 {
	return 41
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_dot() i64 {
	return 46
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_colon() i64 {
	return 58
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_equals() i64 {
	return 61
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_at() i64 {
	return 64
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_bracket_l() i64 {
	return 91
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_bracket_r() i64 {
	return 93
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_brace_l() i64 {
	return 123
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_pipe() i64 {
	return 124
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_brace_r() i64 {
	return 125
}
struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer {
	rt.PhpObjectBase
pub mut:
		source rt.PhpVal = rt.new_null()
		options rt.PhpVal = rt.new_null()
		lastToken rt.PhpVal = rt.new_null()
		token rt.PhpVal = rt.new_null()
		line rt.PhpVal = rt.new_int(1)
		lineStart rt.PhpVal = rt.new_int(0)
		position rt.PhpVal = rt.new_int(0)
		byteStreamPosition rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) construct(mut var_source Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array)  {
	mut var_startOfFileToken := create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.sof(), rt.new_int(0), rt.new_int(0), rt.new_int(0), rt.new_int(0))
	this.source = var_source.dup()
	this.options = var_options.dup()
	this.lastToken = var_startOfFileToken.dup()
	this.token = var_startOfFileToken.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) advance() rt.PhpVal {
	this.lastToken = this.token
	return this.token = this.lookahead()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) lookahead() rt.PhpVal {
	mut var_token := this.token
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		for {
			var_token = if !(rt.get_property(var_token, 'next')).is_null() { rt.get_property(var_token, 'next') } else { rt.set_property(var_token, 'next', this.readtoken(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_token))) }
			if !(rt.is_true(rt.identical(rt.get_property(var_token, 'kind'), Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.comment()))) {
				break
			}
		}
	}
	return var_token.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) readtoken(mut var_prev Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) rt.PhpVal {
	mut var_code := rt.new_null()
	mut var_bytes := rt.new_null()
	mut var_charCode1 := rt.new_null()
	mut var_charCode2 := rt.new_null()
	mut var_nextCode := rt.new_null()
	mut var_nextNextCode := rt.new_null()
	mut var_bodyLength := rt.get_property(this.source, 'length')
	this.positionafterwhitespace()
	mut var_position := this.position
	mut var_line := this.line
	mut var_col := rt.sub(rt.add(rt.new_int(1), var_position), this.lineStart)
	if rt.is_true(rt.greater_equal(var_position, var_bodyLength)) {
		return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.eof(), var_bodyLength.dup(), var_bodyLength.dup(), var_line.dup(), var_col.dup(), var_prev.dup())
	}
	// unsupported assign target: Expr_List
	mut switch_val_1 := var_code
	if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_bang())) {
		return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.bang(), var_position.dup(), rt.add(var_position, rt.new_int(1)), var_line.dup(), var_col.dup(), var_prev.dup())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(35))) {
		this.movestringcursor((// unsupported expression: Expr_UnaryMinus).to_i64(), (rt.mul(// unsupported expression: Expr_UnaryMinus, var_bytes)).to_i64())
		return this.readcomment((var_line).to_i64(), (var_col).to_i64(), mut var_prev)
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_dollar())) {
		return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.dollar(), var_position.dup(), rt.add(var_position, rt.new_int(1)), var_line.dup(), var_col.dup(), var_prev.dup())
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_amp())) {
		return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.amp(), var_position.dup(), rt.add(var_position, rt.new_int(1)), var_line.dup(), var_col.dup(), var_prev.dup())
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_paren_l())) {
		return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.paren_l(), var_position.dup(), rt.add(var_position, rt.new_int(1)), var_line.dup(), var_col.dup(), var_prev.dup())
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_paren_r())) {
		return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.paren_r(), var_position.dup(), rt.add(var_position, rt.new_int(1)), var_line.dup(), var_col.dup(), var_prev.dup())
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_dot())) {
		// unsupported assign target: Expr_List
		// unsupported assign target: Expr_List
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_charCode1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_dot())) && rt.is_true(rt.identical(var_charCode2, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_dot())))) {
			return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.spread(), var_position.dup(), rt.add(var_position, rt.new_int(3)), var_line.dup(), var_col.dup(), var_prev.dup())
		}
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_colon())) {
		return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.colon(), var_position.dup(), rt.add(var_position, rt.new_int(1)), var_line.dup(), var_col.dup(), var_prev.dup())
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_equals())) {
		return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.equals(), var_position.dup(), rt.add(var_position, rt.new_int(1)), var_line.dup(), var_col.dup(), var_prev.dup())
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_at())) {
		return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.at(), var_position.dup(), rt.add(var_position, rt.new_int(1)), var_line.dup(), var_col.dup(), var_prev.dup())
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_bracket_l())) {
		return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.bracket_l(), var_position.dup(), rt.add(var_position, rt.new_int(1)), var_line.dup(), var_col.dup(), var_prev.dup())
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_bracket_r())) {
		return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.bracket_r(), var_position.dup(), rt.add(var_position, rt.new_int(1)), var_line.dup(), var_col.dup(), var_prev.dup())
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_brace_l())) {
		return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l(), var_position.dup(), rt.add(var_position, rt.new_int(1)), var_line.dup(), var_col.dup(), var_prev.dup())
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_pipe())) {
		return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.pipe(), var_position.dup(), rt.add(var_position, rt.new_int(1)), var_line.dup(), var_col.dup(), var_prev.dup())
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer.token_brace_r())) {
		return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_r(), var_position.dup(), rt.add(var_position, rt.new_int(1)), var_line.dup(), var_col.dup(), var_prev.dup())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(65))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(66))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(67))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(68))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(69))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(70))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(71))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(72))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(73))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(74))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(75))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(76))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(77))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(78))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(79))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(80))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(81))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(82))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(83))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(84))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(85))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(86))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(87))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(88))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(89))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(90))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(95))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(97))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(98))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(99))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(100))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(101))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(102))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(103))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(104))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(105))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(106))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(107))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(108))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(109))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(110))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(111))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(112))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(113))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(114))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(115))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(116))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(117))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(118))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(119))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(120))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(121))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(122))) {
		return rt.call_method(this.movestringcursor((// unsupported expression: Expr_UnaryMinus).to_i64(), (rt.mul(// unsupported expression: Expr_UnaryMinus, var_bytes)).to_i64()), 'readName', [var_line.dup(), var_col.dup(), var_prev])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(45))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(48))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(49))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(50))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(51))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(52))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(53))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(54))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(55))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(56))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(57))) {
		return rt.call_method(this.movestringcursor((// unsupported expression: Expr_UnaryMinus).to_i64(), (rt.mul(// unsupported expression: Expr_UnaryMinus, var_bytes)).to_i64()), 'readNumber', [var_line.dup(), var_col.dup(), var_prev])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(34))) {
		// unsupported assign target: Expr_List
		// unsupported assign target: Expr_List
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_nextCode, rt.new_int(34))) && rt.is_true(rt.identical(var_nextNextCode, rt.new_int(34))))) {
			return rt.call_method(this.movestringcursor((// unsupported expression: Expr_UnaryMinus).to_i64(), (rt.sub(rt.mul(// unsupported expression: Expr_UnaryMinus, var_bytes), rt.new_int(1))).to_i64()), 'readBlockString', [var_line.dup(), var_col.dup(), var_prev])
		}
		return rt.call_method(this.movestringcursor((// unsupported expression: Expr_UnaryMinus).to_i64(), (rt.sub(rt.mul(// unsupported expression: Expr_UnaryMinus, var_bytes), rt.new_int(1))).to_i64()), 'readString', [var_line.dup(), var_col.dup(), var_prev])
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError', []string{}, create_automattic_woocommerce_vendor_graphql_error_syntaxerror(this.source, var_position.dup(), this.unexpectedcharactermessage(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?int](var_code)))))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) unexpectedcharactermessage(mut var_code Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?int) string {
	mut var_code_mutated := var_code
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.less(var_code_mutated, rt.new_int(32))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return 'Cannot contain the invalid character ' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printcharcode(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?int', []string{}, var_code_mutated))).str()
	}
	if rt.is_true(rt.identical(var_code_mutated, rt.new_int(39))) {
		return 'Unexpected single quote character (\'), did you mean to use a double quote (")?'
	}
	return 'Cannot parse the unexpected character ' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printcharcode(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?int', []string{}, var_code_mutated))).str() + '.'
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) readname(line i64, col i64, mut var_prev Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) rt.PhpVal {
	mut line_mutated := line
	mut col_mutated := col
	mut var_start := this.position
	mut var_body := rt.get_property(this.source, 'body')
	mut var_length := rt.call_function('strspn', [var_body.dup(), rt.new_string('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_'), this.byteStreamPosition])
	mut var_value := rt.call_function('substr', [var_body.dup(), this.byteStreamPosition, var_length.dup()])
	this.movestringcursor((var_length).to_i64(), (var_length).to_i64())
	return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.name(), var_start.dup(), this.position, rt.new_int(line_mutated).dup(), rt.new_int(col_mutated).dup(), var_prev.dup(), var_value.dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) readnumber(line i64, col i64, mut var_prev Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) rt.PhpVal {
	mut var_char := rt.new_null()
	mut var_code := rt.new_null()
	mut line_mutated := line
	mut col_mutated := col
	mut var_value := rt.new_string(rt.new_string(''))
	mut var_start := this.position
	// unsupported assign target: Expr_List
	mut var_isFloat := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.identical(var_code, rt.new_int(45))) {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported assign target: Expr_List
	}
	if rt.is_true(rt.identical(var_code, rt.new_int(48))) {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported assign target: Expr_List
		if rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_code, rt.new_int(48))) && rt.is_true(rt.less_equal(var_code, rt.new_int(57))))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError', []string{}, create_automattic_woocommerce_vendor_graphql_error_syntaxerror(this.source, this.position, 'Invalid number, unexpected digit after 0: ' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printcharcode(arg_0) }(var_code.dup())).str())))
		}
	} else {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported assign target: Expr_List
	}
	if rt.is_true(rt.identical(var_code, rt.new_int(46))) {
		var_isFloat = rt.new_bool(rt.new_bool(true))
		this.movestringcursor(1, 1)
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported assign target: Expr_List
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_code, rt.new_int(69))) || rt.is_true(rt.identical(var_code, rt.new_int(101))))) {
		var_isFloat = rt.new_bool(rt.new_bool(true))
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported assign target: Expr_List
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_code, rt.new_int(43))) || rt.is_true(rt.identical(var_code, rt.new_int(45))))) {
			// unsupported expression: Expr_AssignOp_Concat
			this.movestringcursor(1, 1)
		}
		// unsupported expression: Expr_AssignOp_Concat
	}
	return create_automattic_woocommerce_vendor_graphql_language_token(if rt.is_true(var_isFloat) { Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.float() } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.int() }, var_start.dup(), this.position, rt.new_int(line_mutated).dup(), rt.new_int(col_mutated).dup(), var_prev.dup(), var_value.dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) readdigits() string {
	mut var_char := rt.new_null()
	// unsupported assign target: Expr_List
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_code, rt.new_int(48))) && rt.is_true(rt.less_equal(var_code, rt.new_int(57))))) {
		mut var_value := rt.new_string(rt.new_string(''))
		for {
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported assign target: Expr_List
			if !(rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_code, rt.new_int(48))) && rt.is_true(rt.less_equal(var_code, rt.new_int(57)))))) {
				break
			}
		}
		return (var_value).str()
	}
	if rt.is_true(rt.greater(this.position, rt.sub(rt.get_property(this.source, 'length'), rt.new_int(1)))) {
		mut var_code := rt.new_null()
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError', []string{}, create_automattic_woocommerce_vendor_graphql_error_syntaxerror(this.source, this.position, 'Invalid number, expected digit but got: ' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printcharcode(arg_0) }(var_code.dup())).str())))
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) readstring(line i64, col i64, mut var_prev Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) rt.PhpVal {
	mut var_char := rt.new_null()
	mut var_bytes := rt.new_null()
	mut var_hex := rt.new_null()
	mut var_utf16Continuation := rt.new_null()
	mut line_mutated := line
	mut col_mutated := col
	mut var_start := this.position
	// unsupported assign target: Expr_List
	mut var_chunk := rt.new_string(rt.new_string(''))
	mut var_value := rt.new_string(rt.new_string(''))
	for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_code.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: 10 }, rt.ArrayItem{ key: none, val: 13 }]), rt.new_bool(true)]))))) {
		if rt.is_true(rt.identical(var_code, rt.new_int(34))) {
			// unsupported expression: Expr_AssignOp_Concat
			this.movestringcursor(1, 1)
			return create_automattic_woocommerce_vendor_graphql_language_token(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.string(), var_start.dup(), this.position, rt.new_int(line_mutated).dup(), rt.new_int(col_mutated).dup(), var_prev.dup(), var_value.dup())
		}
		this.assertvalidstringcharactercode((var_code).to_i64(), (this.position).to_i64())
		this.movestringcursor(, ().to_i64())
		if rt.is_true() {
		} else {
		}
		
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) readblockstring(line i64, col i64, mut var_prev Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) rt.PhpVal {
	mut var_char := rt.new_null()
	mut var_code := rt.new_null()
	mut var_bytes := rt.new_null()
	mut var_nextCode := rt.new_null()
	mut var_nextNextCode := rt.new_null()
	mut var_nextNextNextCode := rt.new_null()
	mut line_mutated := line
	mut col_mutated := col
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) assertvalidstringcharactercode(code i64, position i64)  {
	mut code_mutated := code
	mut position_mutated := position
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) assertvalidblockstringcharactercode(code i64, position i64)  {
	mut code_mutated := code
	mut position_mutated := position
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) positionafterwhitespace()  {
	mut var_code := rt.new_null()
	mut var_bytes := rt.new_null()
	mut var_nextCode := rt.new_null()
	mut var_nextBytes := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) readcomment(line i64, col i64, mut var_prev Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) rt.PhpVal {
	mut var_code := rt.new_null()
	mut var_char := rt.new_null()
	mut line_mutated := line
	mut col_mutated := col
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) readchar(advance bool, mut var_byteStreamPosition Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?int) rt.PhpVal {
	mut var_byteStreamPosition_mutated := var_byteStreamPosition
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) readchars(charCount i64) rt.PhpVal {
	mut var_char := rt.new_null()
	mut var_code := rt.new_null()
	mut var_bytes := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) movestringcursor(positionOffset i64, byteStreamOffset i64) rt.PhpVal {
	mut positionOffset_mutated := positionOffset
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_lexer(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer{
		PhpObjectBase: rt.PhpObjectBase{}
		source: rt.new_null()
		options: rt.new_null()
		lastToken: rt.new_null()
		token: rt.new_null()
		line: rt.new_int(1)
		lineStart: rt.new_int(0)
		position: rt.new_int(0)
		byteStreamPosition: rt.new_int(0)
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_token() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_syntaxerror() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_utils() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'advance' {
			return this.advance()
		}
		'lookahead' {
			return this.lookahead()
		}
		'readToken' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.readtoken(mut dispatch_arg_0)
		}
		'unexpectedCharacterMessage' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.unexpectedcharactermessage(mut dispatch_arg_0))
		}
		'readName' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.readname(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'readNumber' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.readnumber(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'readDigits' {
			return rt.new_string(this.readdigits())
		}
		'readString' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.readstring(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'readBlockString' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.readblockstring(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'assertValidStringCharacterCode' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.assertvalidstringcharactercode(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'assertValidBlockStringCharacterCode' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.assertvalidblockstringcharactercode(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'positionAfterWhitespace' {
			this.positionafterwhitespace()
			return rt.new_null()
		}
		'readComment' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.readcomment(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'readChar' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?int](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.readchar(dispatch_arg_0, mut dispatch_arg_1)
		}
		'readChars' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.readchars(dispatch_arg_0)
		}
		'moveStringCursor' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.movestringcursor(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'source' { return this.source }
		'options' { return this.options }
		'lastToken' { return this.lastToken }
		'token' { return this.token }
		'line' { return this.line }
		'lineStart' { return this.lineStart }
		'position' { return this.position }
		'byteStreamPosition' { return this.byteStreamPosition }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'source' { this.source = val; return true }
		'options' { this.options = val; return true }
		'lastToken' { this.lastToken = val; return true }
		'token' { this.token = val; return true }
		'line' { this.line = val; return true }
		'lineStart' { this.lineStart = val; return true }
		'position' { this.position = val; return true }
		'byteStreamPosition' { this.byteStreamPosition = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_language_lexer_php() {
	// unsupported statement: Stmt_Declare
}
