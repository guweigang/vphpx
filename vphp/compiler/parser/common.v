module parser

fn strip_module(mut_typ_name string) string {
	return mut_typ_name.replace('main.', '')
}

fn is_context_type(type_name string) bool {
	return type_name == 'Context' || type_name == 'vphp.Context'
}
