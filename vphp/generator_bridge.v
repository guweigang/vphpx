module vphp

import vphp.object

fn resume_php_generator(state voidptr, sent &C.zval, exception &C.zval, capture &C.zval, kind i32, ret &C.zval) {
	producer := unsafe { &PhpGeneratorProducer(state) }
	mut scope := PhpScope.once()
	defer {
		scope.close()
	}
	resume_kind := match kind {
		1 { PhpGeneratorResumeKind.yield_resume }
		2 { PhpGeneratorResumeKind.delegate_resume }
		else { PhpGeneratorResumeKind.start }
	}
	injected := PhpThrowable.from_zval(ZVal.from_ptr(exception))
	value := PhpValue.from_zval(ZVal.from_ptr(sent))
	step := producer.resume(PhpGeneratorInput{
		kind:             resume_kind
		capture:          PhpValue.from_zval(ZVal.from_ptr(capture))
		sent:             if resume_kind == .delegate_resume { PhpValue.null() } else { value }
		exception:        injected
		delegated_return: if resume_kind == .delegate_resume && injected == none {
			?PhpValue(value)
		} else {
			none
		}
	}) or {
		raise_return_error(err)
		return
	}
	if has_exception() {
		return
	}
	if step.kind == .throw_exception {
		step.exception.throw()
		return
	}
	mut output := PhpArray.new()
	defer {
		output.release()
	}
	output.push(PhpInt.of(i64(step.kind)))
	if step.kind == .delegate {
		if producer.by_reference {
			PhpException.raise_class('TypeError', 'A by-reference PHP Generator cannot delegate with yield from', 0)
			return
		}
		pushed := step.delegate.value.with_request_zval(fn [output] (raw ZVal) bool {
			_ := PhpIterable.from_zval(raw) or { return false }
			output.push_zval(raw)
			return true
		})
		if !pushed {
			PhpException.raise_class('TypeError', 'PHP Generator delegation requires an iterable value', 0)
			return
		}
		PhpReturn.from_ptr(ret).zval(output.to_zval())
		return
	}
	if key := step.key {
		output.push_value(key)
	}
	if reference := step.reference {
		if !producer.by_reference || reference.to_zval().type_id() != .reference {
			PhpException.raise_class('TypeError', 'Expected a valid reference step from a by-reference PHP Generator', 0)
			return
		}
		output.push(reference)
	} else {
		if producer.by_reference && step.kind == .yield_value {
			PhpException.raise_class('TypeError', 'A by-reference PHP Generator requires a reference yield step', 0)
			return
		}
		output.push_value(step.value)
	}
	PhpReturn.from_ptr(ret).zval(output.to_zval())
}

fn close_php_generator(state voidptr, capture &C.zval) {
	producer := unsafe { &PhpGeneratorProducer(state) }
	mut scope := PhpScope.once()
	defer {
		scope.close()
	}
	if producer.close_with_capture != unsafe { nil } {
		producer.close_with_capture(PhpValue.from_zval(ZVal.from_ptr(capture)))
	}
	if producer.close != unsafe { nil } {
		producer.close()
	}
}

fn release_php_generator(state voidptr) {
	producer := unsafe { &PhpGeneratorProducer(state) }
	object.unregister_root(state)
	unsafe { free(producer) }
}
