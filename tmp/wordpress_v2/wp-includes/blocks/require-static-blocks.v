import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([rt.ArrayItem{ key: none, val: 'accordion-heading' },
		rt.ArrayItem{ key: none, val: 'accordion-panel' }, rt.ArrayItem{ key: none, val: 'audio' },
		rt.ArrayItem{ key: none, val: 'buttons' }, rt.ArrayItem{ key: none, val: 'code' },
		rt.ArrayItem{ key: none, val: 'column' }, rt.ArrayItem{ key: none, val: 'columns' },
		rt.ArrayItem{ key: none, val: 'embed' }, rt.ArrayItem{ key: none, val: 'freeform' },
		rt.ArrayItem{ key: none, val: 'group' }, rt.ArrayItem{ key: none, val: 'html' },
		rt.ArrayItem{ key: none, val: 'list-item' }, rt.ArrayItem{ key: none, val: 'math' },
		rt.ArrayItem{ key: none, val: 'missing' }, rt.ArrayItem{ key: none, val: 'more' },
		rt.ArrayItem{ key: none, val: 'nextpage' }, rt.ArrayItem{ key: none, val: 'preformatted' },
		rt.ArrayItem{ key: none, val: 'pullquote' }, rt.ArrayItem{ key: none, val: 'quote' },
		rt.ArrayItem{ key: none, val: 'separator' }, rt.ArrayItem{ key: none, val: 'social-links' },
		rt.ArrayItem{ key: none, val: 'spacer' }, rt.ArrayItem{ key: none, val: 'table' },
		rt.ArrayItem{ key: none, val: 'terms-query' }, rt.ArrayItem{ key: none, val: 'text-columns' },
		rt.ArrayItem{ key: none, val: 'verse' }])
}
