module vphp

// PhpStringParam describes the PHP signature of a V string parameter.
// default_value is used by PHP when optional is true.
@[attribute: 'fn']
pub struct PhpStringParam {
pub:
	v_name        string
	php_name      string
	default_value string
	optional      bool
}
