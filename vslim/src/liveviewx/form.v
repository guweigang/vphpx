module liveviewx

import vphp

@[php_class: 'VSlim\\Live\\Form']
@[heap]
pub struct VSlimLiveForm {
pub mut:
	name             string
	socket_ref       &VSlimLiveSocket = unsafe { nil } @[php_ignore]
	fields           []string
	last_error_count int @[php_prop: lastErrorCount]
	validated        bool
}

@[php_method]
pub fn (form &VSlimLiveForm) name() string {
	return form.name
}

@[php_method]
pub fn (form &VSlimLiveForm) available() bool {
	return !isnil(form.socket_ref)
}

@[php_method]
pub fn (mut form VSlimLiveForm) fill(values vphp.PhpArray) &VSlimLiveForm {
	if isnil(form.socket_ref) {
		return &form
	}
	form.track_fields(values)
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.assign_form(values)
	}
	return &form
}

@[php_method]
pub fn (mut form VSlimLiveForm) reset(values vphp.PhpArray) &VSlimLiveForm {
	if isnil(form.socket_ref) {
		return &form
	}
	form.track_fields(values)
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.reset_form(values)
	}
	form.last_error_count = 0
	form.validated = false
	return &form
}

@[php_method]
pub fn (mut form VSlimLiveForm) validate(validator vphp.PhpValue) &VSlimLiveForm {
	form.validated = true
	form.last_error_count = 0
	if isnil(form.socket_ref) {
		return &form
	}
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.clear_errors()
		mut errors := vphp.PhpValue.null()
		if validator.is_valid() && !validator.is_null() && !validator.is_undef() {
			if callable := validator.as_callable() {
				mut result := callable.invoke(form.data())
				errors = result.owned()
			} else if validator.is_array() {
				errors = validator.owned()
			}
		}
		defer {
			errors.release()
		}
		if errors.is_valid() && !errors.is_null() && !errors.is_undef() && errors.is_array() {
			errors_arr := errors.as_array() or { vphp.PhpArray.empty() }
			socket.assign_errors(errors_arr)
			form.last_error_count = errors_arr.assoc_keys().len
		}
	}
	return &form
}

@[php_method]
pub fn (mut form VSlimLiveForm) errors(values vphp.PhpArray) &VSlimLiveForm {
	if isnil(form.socket_ref) {
		return &form
	}
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.assign_errors(values)
	}
	form.last_error_count = values.assoc_keys().len
	form.validated = true
	return &form
}

@[php_method: 'clearErrors']
pub fn (mut form VSlimLiveForm) clear_errors() &VSlimLiveForm {
	if isnil(form.socket_ref) {
		return &form
	}
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.clear_errors()
	}
	form.last_error_count = 0
	return &form
}

@[php_method: 'clearError']
pub fn (mut form VSlimLiveForm) clear_error(field string) &VSlimLiveForm {
	if isnil(form.socket_ref) {
		return &form
	}
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.clear_error(field)
	}
	return &form
}

@[php_method]
pub fn (mut form VSlimLiveForm) forget(field string) &VSlimLiveForm {
	if isnil(form.socket_ref) {
		return &form
	}
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.forget_input(field)
	}
	return &form
}

@[php_method: 'forgetMany']
pub fn (mut form VSlimLiveForm) forget_many(fields vphp.PhpArray) &VSlimLiveForm {
	if isnil(form.socket_ref) {
		return &form
	}
	unsafe {
		mut socket := &VSlimLiveSocket(form.socket_ref)
		socket.forget_inputs(fields)
	}
	return &form
}

@[php_method]
pub fn (form &VSlimLiveForm) input(field string) string {
	if isnil(form.socket_ref) {
		return ''
	}
	return form.socket_ref.input(field)
}

@[php_method: 'inputOr']
pub fn (form &VSlimLiveForm) input_or(field string, fallback string) string {
	value := form.input(field)
	return if value == '' { fallback } else { value }
}

@[php_method]
pub fn (form &VSlimLiveForm) error(field string) string {
	if isnil(form.socket_ref) {
		return ''
	}
	return form.socket_ref.error(field)
}

@[php_method: 'hasError']
pub fn (form &VSlimLiveForm) has_error(field string) bool {
	return !isnil(form.socket_ref) && form.socket_ref.has_error(field)
}

@[php_method]
pub fn (form &VSlimLiveForm) valid() bool {
	return form.validated && form.last_error_count == 0
}

@[php_method]
pub fn (form &VSlimLiveForm) invalid() bool {
	return form.last_error_count > 0
}

@[php_method: 'errorCount']
pub fn (form &VSlimLiveForm) error_count() int {
	return form.last_error_count
}

@[php_method]
pub fn (form &VSlimLiveForm) data() vphp.PhpArray {
	mut out := vphp.PhpArray.new()
	if isnil(form.socket_ref) {
		return out
	}
	for field in form.field_names() {
		out.string(field, form.socket_ref.input(field))
	}
	return out
}

fn (mut form VSlimLiveForm) track_fields(values vphp.PhpArray) {
	if !values.is_valid() {
		return
	}
	for key in values.assoc_keys() {
		field := key.trim_space()
		if field == '' || field in form.fields {
			continue
		}
		form.fields << field
	}
}

fn (form &VSlimLiveForm) field_names() []string {
	return form.fields.clone()
}
