module main

@[heap]
@[php_class]
@[php_attr: 'PhpDispatchable("worker")']
struct DispatchableSample {
pub mut:
	name string
}

@[php_method]
pub fn (mut s DispatchableSample) construct(name string) &DispatchableSample {
	s.name = name
	return s
}
