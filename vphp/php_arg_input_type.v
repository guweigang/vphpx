module vphp

pub type PhpArgInput = PhpArray
	| PhpArrayAccess
	| PhpArg
	| PhpBool
	| PhpCallable
	| PhpClosure
	| PhpCountable
	| PhpDateInterval
	| PhpDateTimeImmutable
	| PhpDateTimeInterface
	| PhpDouble
	| PhpEnumCase
	| PhpFiber
	| PhpInt
	| PhpGenerator
	| PhpIterable
	| PhpIterator
	| PhpIteratorAggregate
	| PhpJsonSerializable
	| PhpNull
	| PhpObject
	| PhpReference
	| PhpResource
	| PhpScalar
	| PhpString
	| PhpStringable
	| PhpThrowable
	| PhpValue
	| PhpWeakMap
	| PhpWeakReference

pub fn (arg PhpArgInput) to_zval() ZVal {
	return match arg {
		PhpArray { arg.to_zval() }
		PhpArrayAccess { arg.to_zval() }
		PhpArg { arg.to_zval() }
		PhpBool { arg.to_zval() }
		PhpCallable { arg.to_zval() }
		PhpClosure { arg.to_zval() }
		PhpCountable { arg.to_zval() }
		PhpDateInterval { arg.to_zval() }
		PhpDateTimeImmutable { arg.to_zval() }
		PhpDateTimeInterface { arg.to_zval() }
		PhpDouble { arg.to_zval() }
		PhpEnumCase { arg.to_zval() }
		PhpFiber { arg.to_zval() }
		PhpInt { arg.to_zval() }
		PhpIterable { arg.to_zval() }
		PhpIterator { arg.to_zval() }
		PhpIteratorAggregate { arg.to_zval() }
		PhpJsonSerializable { arg.to_zval() }
		PhpGenerator { arg.to_zval() }
		PhpNull { arg.to_zval() }
		PhpObject { arg.to_zval() }
		PhpReference { arg.to_zval() }
		PhpResource { arg.to_zval() }
		PhpScalar { arg.to_zval() }
		PhpString { arg.to_zval() }
		PhpStringable { arg.to_zval() }
		PhpThrowable { arg.to_zval() }
		PhpValue { arg.to_zval() }
		PhpWeakMap { arg.to_zval() }
		PhpWeakReference { arg.to_zval() }
	}
}

pub fn (arg PhpArgInput) to_value() PhpValue {
	return PhpValue.from_zval(arg.to_zval())
}

pub fn (arg PhpArgInput) value_at(key string) PhpValue {
	return PhpValue.from_zval(arg.to_zval().value_at(key))
}

pub fn php_arg_inputs_to_zvals(args []PhpArgInput) []ZVal {
	mut out := []ZVal{cap: args.len}
	for arg in args {
		out << arg.to_zval()
	}
	return out
}

fn php_with_call_result[T, R](z ZVal, run fn (T) R) !R {
	if has_exception() {
		return error('PHP call threw an exception')
	}
	$if T is PhpValue || T is PhpReference {
		return run(php_call_result_as[T](z)!)
	} $else {
		if reference := PhpReference.from_zval(z) {
			mut value := reference.deref().to_request_owned()
			defer {
				value.release()
			}
			return run(php_call_result_as[T](value.to_zval())!)
		}
		return run(php_call_result_as[T](z)!)
	}
}

fn php_call_result_as[T](z ZVal) !T {
	if has_exception() {
		return error('PHP call threw an exception')
	}
	if !z.is_valid() || z.is_undef() {
		return error('PHP call did not produce a result')
	}
	$if T is PhpValue {
		return PhpValue.from_zval(z)
	} $else $if T is PhpNull {
		return PhpNull.must_from_zval(z)!
	} $else $if T is PhpBool {
		return PhpBool.must_from_zval(z)!
	} $else $if T is PhpInt {
		return PhpInt.must_from_zval(z)!
	} $else $if T is PhpDouble {
		return PhpDouble.must_from_zval(z)!
	} $else $if T is PhpString {
		return PhpString.must_from_zval(z)!
	} $else $if T is PhpScalar {
		return PhpScalar.must_from_zval(z)!
	} $else $if T is PhpArray {
		return PhpArray.must_from_zval(z)!
	} $else $if T is PhpObject {
		return PhpObject.must_from_zval(z)!
	} $else $if T is PhpCallable {
		return PhpCallable.must_from_zval(z)!
	} $else $if T is PhpClosure {
		return PhpClosure.must_from_zval(z)!
	} $else $if T is PhpResource {
		return PhpResource.must_from_zval(z)!
	} $else $if T is PhpIterable {
		return PhpIterable.must_from_zval(z)!
	} $else $if T is PhpGenerator {
		return PhpGenerator.must_from_zval(z)!
	} $else $if T is PhpFiber {
		return PhpFiber.must_from_zval(z)!
	} $else $if T is PhpDateInterval {
		return PhpDateInterval.must_from_zval(z)!
	} $else $if T is PhpDateTimeInterface {
		return PhpDateTimeInterface.must_from_zval(z)!
	} $else $if T is PhpDateTimeImmutable {
		return PhpDateTimeImmutable.must_from_zval(z)!
	} $else $if T is PhpJsonSerializable {
		return PhpJsonSerializable.must_from_zval(z)!
	} $else $if T is PhpStringable {
		return PhpStringable.must_from_zval(z)!
	} $else $if T is PhpCountable {
		return PhpCountable.must_from_zval(z)!
	} $else $if T is PhpArrayAccess {
		return PhpArrayAccess.must_from_zval(z)!
	} $else $if T is PhpWeakMap {
		return PhpWeakMap.must_from_zval(z)!
	} $else $if T is PhpWeakReference {
		return PhpWeakReference.must_from_zval(z)!
	} $else $if T is PhpIterator {
		return PhpIterator.must_from_zval(z)!
	} $else $if T is PhpIteratorAggregate {
		return PhpIteratorAggregate.must_from_zval(z)!
	} $else $if T is PhpReference {
		return PhpReference.must_from_zval(z)!
	} $else $if T is PhpThrowable {
		return PhpThrowable.must_from_zval(z)!
	} $else $if T is PhpEnumCase {
		return PhpEnumCase.must_from_zval(z)!
	} $else {
		return error('unsupported PHP call result type')
	}
}

fn php_call_copied_result_as[T](z ZVal) !T {
	if has_exception() {
		return error('PHP call threw an exception')
	}
	if !z.is_valid() || z.is_undef() {
		return error('PHP call did not produce a result')
	}
	$if T is PhpNull {
		_ := PhpNull.must_from_zval(z)!
		return PhpNull.value()
	} $else $if T is PhpBool {
		return PhpBool.of(z.to_bool())
	} $else $if T is PhpInt {
		return PhpInt.of(z.to_i64())
	} $else $if T is PhpDouble {
		return PhpDouble.of(z.to_f64())
	} $else $if T is PhpString {
		return PhpString.of(z.to_string())
	} $else {
		return error('call[T] only supports copied scalar PHP result wrappers; use with_result[T, R] or lifecycle APIs for borrowed values')
	}
}

fn php_call_reference_result(mut result RequestOwnedZBox) !PhpReference {
	defer {
		result.release()
	}
	if has_exception() {
		return error('PHP callable threw an exception')
	}
	reference := PhpReference.from_request_owned_zbox(result) or {
		return error('PHP callable did not return a reference')
	}
	_ = result.take_zval()
	return reference
}
