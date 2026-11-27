module vphp

// PhpObjectCopy opts an exported class into explicit state copying.
@[attribute]
pub struct PhpObjectCopy {
pub:
	cloneable    bool
	serializable bool
}

// PhpZendPropertyCopy uses PHP's default clone and serialization for classes
// whose instance state is stored entirely in declared PHP properties.
@[attribute: 'struct']
pub struct PhpZendPropertyCopy {}
