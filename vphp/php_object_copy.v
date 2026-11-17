module vphp

// PhpObjectCopy opts an exported class into explicit state copying.
@[attribute]
pub struct PhpObjectCopy {
pub:
	cloneable    bool
	serializable bool
}
