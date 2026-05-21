module databasex

import vphp

struct PhpValueSubject {
	value vphp.PhpValue
}

fn value_subject(value vphp.PhpValue) PhpValueSubject {
	return PhpValueSubject{
		value: value
	}
}
