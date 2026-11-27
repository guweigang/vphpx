module vphp

import time
import vphp.object
import vphp.zend

// PhpGenerator holds a native PHP Generator.
pub struct PhpGenerator {
	PhpIterator
}

pub enum PhpGeneratorResumeKind {
	start
	yield_resume
	delegate_resume
}

// Inputs borrow the PHP values for the duration of a producer callback.
pub struct PhpGeneratorInput {
pub:
	kind             PhpGeneratorResumeKind
	sent             PhpValue
	exception        ?PhpThrowable
	delegated_return ?PhpValue
	capture          PhpValue
}

// The steps passed to the PHP frame use these numeric values.
enum PhpGeneratorStepKind {
	yield_value
	finish
	delegate
	throw_exception
}

pub struct PhpGeneratorStep {
	kind      PhpGeneratorStepKind
	value     PhpValue
	key       ?PhpValue
	reference ?PhpReference
	delegate  PhpIterable
	exception PhpThrowable
}

pub fn PhpGeneratorStep.yield_value(value PhpValue) PhpGeneratorStep {
	return PhpGeneratorStep{ value: value }
}

pub fn PhpGeneratorStep.yield_keyed(key PhpValue, value PhpValue) PhpGeneratorStep {
	return PhpGeneratorStep{ value: value, key: key }
}

pub fn PhpGeneratorStep.yield_reference(reference PhpReference) PhpGeneratorStep {
	return PhpGeneratorStep{ reference: reference }
}

pub fn PhpGeneratorStep.yield_keyed_reference(key PhpValue, reference PhpReference) PhpGeneratorStep {
	return PhpGeneratorStep{ key: key, reference: reference }
}

pub fn PhpGeneratorStep.finish(value PhpValue) PhpGeneratorStep {
	return PhpGeneratorStep{ kind: .finish, value: value }
}

// throw_exception propagates the original PHP Throwable out of the generator.
pub fn PhpGeneratorStep.throw_exception(exception PhpThrowable) PhpGeneratorStep {
	return PhpGeneratorStep{ kind: .throw_exception, exception: exception }
}

// yield_from delegates iteration to an array or a native PHP Traversable.
pub fn PhpGeneratorStep.yield_from(iterable PhpIterable) PhpGeneratorStep {
	return PhpGeneratorStep{ kind: .delegate, delegate: iterable }
}

pub struct PhpGeneratorProducer {
	release_capture_after_start bool
pub:
	resume             fn (PhpGeneratorInput) !PhpGeneratorStep @[required]
	close              fn ()         = unsafe { nil }
	close_with_capture fn (PhpValue) = unsafe { nil }
	by_reference       bool
	capture            PhpValue = PhpValue.invalid()
}

pub fn PhpGenerator.from_zval(z ZVal) ?PhpGenerator {
	if !z.is_object() || !z.is_instance_of('Generator') {
		return none
	}
	return PhpGenerator{ PhpIterator: PhpIterator.from_zval(z)? }
}

pub fn PhpGenerator.must_from_zval(z ZVal) !PhpGenerator {
	return PhpGenerator.from_zval(z) or { error('zval is not a PHP Generator') }
}

pub fn (g PhpGenerator) to_borrowed() PhpGenerator {
	return PhpGenerator{ PhpIterator: PhpIterator{ object: g.to_object().to_borrowed() } }
}

pub fn (g PhpGenerator) borrowed() PhpGenerator {
	return g.to_borrowed()
}

pub fn (g PhpGenerator) borrow() PhpGenerator {
	return g.to_borrowed()
}

pub fn (g PhpGenerator) to_request_owned() PhpGenerator {
	return PhpGenerator{ PhpIterator: PhpIterator{ object: g.to_object().to_request_owned() } }
}

pub fn (g PhpGenerator) owned() PhpGenerator {
	return g.to_request_owned()
}

pub fn (g PhpGenerator) to_persistent_owned() PhpGenerator {
	return PhpGenerator{ PhpIterator: PhpIterator{ object: g.to_object().to_persistent_owned() } }
}

pub fn (g PhpGenerator) retain() PhpGenerator {
	return g.to_persistent_owned()
}

pub fn (g PhpGenerator) retained() PhpGenerator {
	return g.to_persistent_owned()
}

// Generator operations return request-owned values. On failure, the original
// PHP exception remains pending for the exported V caller to propagate.
pub fn (g PhpGenerator) current() !PhpValue {
	return g.call_generator('current')
}

pub fn (g PhpGenerator) key() !PhpValue {
	return g.call_generator('key')
}

pub fn (g PhpGenerator) send(value PhpArgInput) !PhpValue {
	return g.call_generator('send', value)
}

pub fn (g PhpGenerator) throw_into(exception PhpThrowable) !PhpValue {
	return g.call_generator('throw', exception)
}

pub fn (g PhpGenerator) get_return() !PhpValue {
	return g.call_generator('getReturn')
}

pub fn (g PhpGenerator) valid() !bool {
	mut result := g.call_generator('valid')!
	defer {
		result.release()
	}
	return result.to_bool()
}

pub fn (g PhpGenerator) rewind() ! {
	mut result := g.call_generator('rewind')!
	result.release()
}

pub fn (g PhpGenerator) next() ! {
	mut result := g.call_generator('next')!
	result.release()
}

fn (g PhpGenerator) call_generator(method string, args ...PhpArgInput) !PhpValue {
	mut result := g.to_object().call_method(method, ...args)
	if has_exception() || !result.is_valid() || result.is_undef() {
		result.release()
		return error('PHP Generator::${method}() failed')
	}
	return result
}

// from_iterable_factory calls factory on first iteration and delegates with PHP yield from.
// Once it has a delegate, the generator releases its copy of the factory before iterating.
pub fn PhpGenerator.from_iterable_factory(factory PhpCallable) !PhpGenerator {
	mut args := PhpArray.new()
	defer {
		args.release()
	}
	return PhpGenerator.from_iterable_factory_args(factory, args)
}

@[params]
pub struct PhpIterableFactoryOptions {
pub:
	stream ?PhpStreamGeneratorOptions
}

// from_iterable_factory_args uses PHP argument unpacking when first iterated.
// Set stream to let the factory also return a stream resource for binary chunks.
// The generator releases its copies of the factory and args before delegation.
pub fn PhpGenerator.from_iterable_factory_args(factory PhpCallable, args PhpArray, options PhpIterableFactoryOptions) !PhpGenerator {
	mut capture := PhpArray.new()
	defer {
		capture.release()
	}
	capture.set_callable('factory', factory)
	capture.set('args', args)
	if stream := options.stream {
		set_stream_generator_options(capture, stream)!
	}
	return PhpGenerator.from_producer(
		capture:                     capture.borrowed().to_value()
		resume:                      resume_iterable_factory
		release_capture_after_start: true
	)
}

@[params]
pub struct PhpStreamGeneratorOptions {
pub:
	chunk_size i64 = 8192
	// Per read on a nonblocking stream. A finite timeout also permits waiting
	// outside a scheduled Fiber. -1 waits indefinitely in a scheduled Fiber.
	wait_timeout_ms i64 = -1
}

fn set_stream_generator_options(capture PhpArray, options PhpStreamGeneratorOptions) ! {
	if options.chunk_size <= 0 {
		return error('PHP stream chunk size must be positive')
	}
	validate_task_stream_timeout(options.wait_timeout_ms)!
	capture.int('chunk_size', options.chunk_size)
	capture.int('wait_timeout_ms', options.wait_timeout_ms)
}

// from_stream_resource reads a PHP stream from its current position as the
// Generator advances. The capture keeps the resource alive during iteration.
// A scheduled Fiber waits cooperatively for a nonblocking stream to become readable.
pub fn PhpGenerator.from_stream_resource(stream PhpResource, options PhpStreamGeneratorOptions) !PhpGenerator {
	if !stream.is_stream() {
		return error('Expected an open PHP stream resource')
	}
	mut capture := PhpArray.new()
	defer {
		capture.release()
	}
	set_stream_generator_options(capture, options)!
	capture.set('stream', stream)
	return PhpGenerator.from_producer(
		capture: capture.borrowed().to_value()
		resume:  resume_stream_resource
	)
}

fn resume_stream_resource(input PhpGeneratorInput) !PhpGeneratorStep {
	if raised := input.exception {
		return PhpGeneratorStep.throw_exception(raised)
	}
	capture := input.capture.require_array()!
	stream := PhpResource.must_from_zval(capture.value('stream')!.to_zval())!
	length := capture.value('chunk_size')!.to_i64()
	timeout_ms := capture.value('wait_timeout_ms')!.to_i64()
	mut deadline := i64(0)
	mut waiting := false
	for {
		content := stream.read(length) or { return error('Unable to read from PHP stream') }
		if content != '' {
			mut chunk := PhpValue.string(content)
			return PhpGeneratorStep.yield_value(chunk.move_to_request_scope())
		}
		if stream.eof() {
			return PhpGeneratorStep.finish(PhpValue.null())
		}
		if !waiting {
			if (timeout_ms < 0 && !zend.task_can_suspend()) || !stream.is_nonblocking_stream() {
				return error('PHP stream returned no bytes before reaching EOF')
			}
			deadline = task_stream_deadline(timeout_ms)
			waiting = true
		} else if deadline > 0 && time.sys_mono_now() >= u64(deadline) {
			return error('Timed out waiting for PHP stream data')
		}
		if !wait_php_stream_until(stream, false, deadline)! {
			if !stream.is_stream() {
				return error('PHP stream closed while waiting for data')
			}
			return error('Timed out waiting for PHP stream data')
		}
		if !stream.is_nonblocking_stream() {
			return error('PHP stream became blocking while waiting for data')
		}
	}
}

fn resume_iterable_factory(input PhpGeneratorInput) !PhpGeneratorStep {
	if raised := input.exception {
		return PhpGeneratorStep.throw_exception(raised)
	}
	if input.kind == .start {
		capture := input.capture.require_array()!
		factory := capture.value('factory')!.require_callable()!
		args := capture.value('args')!.require_array()!
		mut result := factory.invoke_args_by_value(args)
		if has_exception() {
			result.release()
			return error('PHP generator factory failed')
		}
		if chunk_size := capture.find('chunk_size') {
			if resource := result.as_resource() {
				defer {
					result.release()
				}
				chunks := PhpGenerator.from_stream_resource(resource,
					chunk_size:      chunk_size.to_i64()
					wait_timeout_ms: capture.value('wait_timeout_ms')!.to_i64()
				)!
				return PhpGeneratorStep.yield_from(chunks.to_iterable())
			}
		}
		value := result.move_to_request_scope()
		iterable := value.as_iterable() or {
			if has_exception() {
				return error('PHP generator factory failed')
			}
			message := 'Can use "yield from" only with arrays and Traversables'
			PhpException.raise_class('Error', message, 0)
			return error(message)
		}
		return PhpGeneratorStep.yield_from(iterable)
	}
	value := input.delegated_return or { return error('missing delegated return value') }
	return PhpGeneratorStep.finish(value)
}

// from_producer creates a request-scoped native Generator without starting it.
// Values in resume inputs are borrowed during the callback. The generator
// copies yielded and returned values before leaving that callback's scope.
pub fn PhpGenerator.from_producer(producer PhpGeneratorProducer) !PhpGenerator {
	state := &PhpGeneratorProducer{
		release_capture_after_start: producer.release_capture_after_start
		resume:                      producer.resume
		close:                       producer.close
		close_with_capture:          producer.close_with_capture
		by_reference:                producer.by_reference
	}
	object.register_root(state)
	mut result := ZVal.new_request()
	created := producer.capture.value.with_request_zval(fn [result, state] (capture ZVal) bool {
		return zend.create_generator(result.raw_ptr(), capture.raw_ptr(), state, resume_php_generator,
			close_php_generator, release_php_generator, state.by_reference,
			state.release_capture_after_start)
	})
	if !created {
		result.release()
		return error('could not create PHP Generator')
	}
	generator := PhpGenerator.from_zval(result) or {
		result.release()
		return error('PHP generator factory did not return a Generator')
	}
	RequestScope.autorelease_add_handle(result.handle())
	return generator
}
