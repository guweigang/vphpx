module vphp

// PhpBoolParam describes the PHP signature of a V boolean parameter.
@[attribute]
pub struct PhpBoolParam {
pub:
	v_name        string
	php_name      string
	default_value bool
	optional      bool
}
