module viewx

import math

pub fn reduce_template_values(items []string, reducer string, seed string) (string, string) {
	if items.len == 0 && seed.trim_space() == '' {
		return '', ''
	}
	mut reducer_expr := reducer.trim_space()
	if reducer_expr == '' {
		reducer_expr = 'acc+item'
	}
	if reducer_expr.to_lower() == 'avg' {
		mut sum := 0.0
		mut count := 0
		if seed.trim_space() != '' && is_numeric_template_value(seed.trim_space()) {
			sum = seed.trim_space().f64()
			count = 1
		}
		for item in items {
			raw := item.trim_space()
			if !is_numeric_template_value(raw) {
				continue
			}
			sum += raw.f64()
			count++
		}
		if count == 0 {
			return '', ''
		}
		return format_reduced_number(sum / f64(count)), ''
	}
	mut acc := 0.0
	if seed.trim_space() != '' && is_numeric_template_value(seed.trim_space()) {
		acc = seed.trim_space().f64()
	}
	mut seen := seed.trim_space() != ''
	mut last_err := ''
	for item in items {
		raw := item.trim_space()
		if !is_numeric_template_value(raw) {
			continue
		}
		value := raw.f64()
		if !seen && (reducer_expr.to_lower() == 'min' || reducer_expr.to_lower() == 'max') {
			acc = value
			seen = true
			continue
		}
		if !seen {
			acc = 0.0
			seen = true
		}
		if named := apply_named_reducer(reducer_expr, acc, value) {
			acc = named
		} else {
			acc = eval_reduce_expr(reducer_expr, acc, value) or {
				last_err = err.msg()
				acc
			}
		}
	}
	if !seen {
		return '', last_err
	}
	return format_reduced_number(acc), last_err
}

fn apply_named_reducer(name string, acc f64, item f64) ?f64 {
	match name.trim_space().to_lower() {
		'sum', 'add' { return acc + item }
		'count' { return acc + 1.0 }
		'min' { return if acc < item { acc } else { item } }
		'max' { return if acc > item { acc } else { item } }
		else { return none }
	}
}

struct ReduceExprParser {
	src string
mut:
	pos  int
	acc  f64
	item f64
}

fn eval_reduce_expr(expr string, acc f64, item f64) !f64 {
	mut p := ReduceExprParser{
		src:  expr
		acc:  acc
		item: item
	}
	value := p.parse_expr()!
	p.skip_ws()
	if p.pos < p.src.len {
		return error('unexpected token')
	}
	return value
}

fn (mut p ReduceExprParser) parse_expr() !f64 {
	mut left := p.parse_term()!
	for {
		p.skip_ws()
		if p.match_char(`+`) {
			left += p.parse_term()!
		} else if p.match_char(`-`) {
			left -= p.parse_term()!
		} else {
			break
		}
	}
	return left
}

fn (mut p ReduceExprParser) parse_term() !f64 {
	mut left := p.parse_factor()!
	for {
		p.skip_ws()
		if p.match_char(`*`) {
			left *= p.parse_factor()!
		} else if p.match_char(`/`) {
			right := p.parse_factor()!
			if math.abs(right) < 1e-12 {
				return error('division by zero')
			}
			left /= right
		} else {
			break
		}
	}
	return left
}

fn (mut p ReduceExprParser) parse_factor() !f64 {
	p.skip_ws()
	if p.match_char(`+`) {
		return p.parse_factor()!
	}
	if p.match_char(`-`) {
		return -p.parse_factor()!
	}
	if p.match_char(`(`) {
		value := p.parse_expr()!
		p.skip_ws()
		if !p.match_char(`)`) {
			return error('missing )')
		}
		return value
	}
	if ident := p.parse_ident() {
		match ident {
			'acc' { return p.acc }
			'item' { return p.item }
			else { return error('unknown identifier') }
		}
	}
	if num := p.parse_number() {
		return num
	}
	return error('invalid factor')
}

fn (mut p ReduceExprParser) parse_ident() ?string {
	p.skip_ws()
	if p.pos >= p.src.len {
		return none
	}
	first := p.src[p.pos]
	if !first.is_letter() && first != `_` {
		return none
	}
	start := p.pos
	for p.pos < p.src.len {
		ch := p.src[p.pos]
		if ch.is_letter() || ch.is_digit() || ch == `_` {
			p.pos++
			continue
		}
		break
	}
	if p.pos == start {
		return none
	}
	return p.src[start..p.pos]
}

fn (mut p ReduceExprParser) parse_number() ?f64 {
	p.skip_ws()
	start := p.pos
	mut seen_dot := false
	for p.pos < p.src.len {
		ch := p.src[p.pos]
		if ch.is_digit() {
			p.pos++
			continue
		}
		if ch == `.` && !seen_dot {
			seen_dot = true
			p.pos++
			continue
		}
		break
	}
	if p.pos == start {
		return none
	}
	raw := p.src[start..p.pos]
	return raw.f64()
}

fn (mut p ReduceExprParser) skip_ws() {
	for p.pos < p.src.len && p.src[p.pos].is_space() {
		p.pos++
	}
}

fn (mut p ReduceExprParser) match_char(ch u8) bool {
	if p.pos < p.src.len && p.src[p.pos] == ch {
		p.pos++
		return true
	}
	return false
}

fn format_reduced_number(value f64) string {
	as_int := i64(value)
	if math.abs(value - f64(as_int)) < 1e-9 {
		return '${as_int}'
	}
	return '${value}'
}

pub fn is_numeric_template_value(raw string) bool {
	if raw == '' {
		return false
	}
	mut seen_digit := false
	mut seen_dot := false
	for i, ch in raw {
		if (ch == `+` || ch == `-`) && i == 0 {
			continue
		}
		if ch == `.` {
			if seen_dot {
				return false
			}
			seen_dot = true
			continue
		}
		if !ch.is_digit() {
			return false
		}
		seen_digit = true
	}
	return seen_digit
}
