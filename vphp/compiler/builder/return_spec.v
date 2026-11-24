module builder

import compiler.php_types

pub struct ReturnSpec {
pub:
	return_type     string
	php_return_type string
	return_obj_type string
}

pub fn new_return_spec(return_type string, php_return_type string, return_obj_type string) ReturnSpec {
	return ReturnSpec{
		return_type:     return_type
		php_return_type: php_return_type
		return_obj_type: return_obj_type
	}
}

pub fn (s ReturnSpec) resolved_type() string {
	if s.php_return_type != '' {
		return s.php_return_type
	}
	if php_types.is_reference_return(s.return_type) {
		return 'mixed'
	}
	return s.return_type
}

pub fn (s ReturnSpec) arginfo_return_reference() string {
	return if php_types.is_reference_return(s.return_type) { '1' } else { '0' }
}

pub fn (s ReturnSpec) arginfo_obj_type() string {
	if s.php_return_type != '' {
		return ''
	}
	return s.return_obj_type
}

fn (s ReturnSpec) has_context_object_return() bool {
	return s.return_type.trim_left('!?').starts_with('&')
		&& (s.php_return_type != '' || s.return_obj_type != '')
}
