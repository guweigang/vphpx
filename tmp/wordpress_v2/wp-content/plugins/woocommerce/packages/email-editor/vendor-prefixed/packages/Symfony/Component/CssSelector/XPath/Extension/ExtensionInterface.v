import rt

interface ExtensionInterface {
	getnodetranslators() rt.PhpVal
	getcombinationtranslators() rt.PhpVal
	getfunctiontranslators() rt.PhpVal
	getpseudoclasstranslators() rt.PhpVal
	getattributematchingtranslators() rt.PhpVal
	getname() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
