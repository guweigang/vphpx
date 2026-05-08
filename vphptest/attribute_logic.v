module main

import vphp

@[php_attr: 'PhpDispatchable("worker")']
@[heap; php_class]
struct DispatchableSample {
pub mut:
	name string
}

@[php_method]
pub fn (mut s DispatchableSample) construct(name string) &DispatchableSample {
	s.name = name
	return s
}

@[php_param_attr(name: 'FromQuery("name"), MustBeString')]
@[php_method: 'tagged']
pub fn (s &DispatchableSample) tagged(name string) string {
	return '${s.name}:${name}'
}

@[php_param_attr(query: 'FromQuery("q"), MustBeString', page: 'FromQuery("page"), MustBeInt')]
@[php_function]
fn v_php_param_attr_api(query string, page int) string {
	return 'param_attr=${query}:${page}'
}

@[php_function]
fn v_php_arg_attr_runtime_api(ctx vphp.Context) {
	args := ctx.args_with_meta([
		vphp.PhpArgMeta{
			index:      0
			name:       'query'
			attributes: [
				vphp.PhpArgAttribute.named('FromQuery').string('q'),
				vphp.PhpArgAttribute.named('MustBeString'),
			]
		},
		vphp.PhpArgMeta{
			index:      1
			name:       'page'
			attributes: [
				vphp.PhpArgAttribute.named('FromQuery').string('page'),
				vphp.PhpArgAttribute.named('Range').int(1).int(100),
			]
		},
	])
	query := args.at(0)
	page := args.at(1)
	source := query.attr('FromQuery') or { vphp.PhpArgAttribute.named('') }
	range := page.attr('Range') or { vphp.PhpArgAttribute.named('') }
	has_string := query.has_attr('MustBeString')
	ctx.return().string_value('runtime=${query.name()}:${has_string}:${source.args[0].value}:${page.name()}:${range.args.len}:${range.args[1].value}')
}
