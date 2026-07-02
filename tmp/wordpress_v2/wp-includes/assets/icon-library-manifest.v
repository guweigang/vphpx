import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('Silence is golden.')).str())
			exit(0)
		}()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'arrow-down-left', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Arrow Down Left'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'arrow-down-left.svg' },
		]) },
		rt.ArrayItem{ key: 'arrow-down-right', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Arrow Down Right'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'arrow-down-right.svg' },
		]) },
		rt.ArrayItem{ key: 'arrow-down', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Arrow Down'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'arrow-down.svg' },
		]) },
		rt.ArrayItem{ key: 'arrow-left', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Arrow Left'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'arrow-left.svg' },
		]) },
		rt.ArrayItem{ key: 'arrow-right', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Arrow Right'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'arrow-right.svg' },
		]) },
		rt.ArrayItem{ key: 'arrow-up-left', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Arrow Up Left'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'arrow-up-left.svg' },
		]) },
		rt.ArrayItem{ key: 'arrow-up-right', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Arrow Up Right'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'arrow-up-right.svg' },
		]) },
		rt.ArrayItem{ key: 'arrow-up', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Arrow Up'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'arrow-up.svg' },
		]) },
		rt.ArrayItem{ key: 'at-symbol', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('At Symbol (@)'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'at-symbol.svg' },
		]) },
		rt.ArrayItem{ key: 'audio', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Audio'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'audio.svg' },
		]) },
		rt.ArrayItem{ key: 'bell', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Bell'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'bell.svg' },
		]) },
		rt.ArrayItem{ key: 'block-default', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Block Default'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'block-default.svg' },
		]) },
		rt.ArrayItem{ key: 'block-meta', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Block Meta'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'block-meta.svg' },
		]) },
		rt.ArrayItem{ key: 'block-table', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Block Table'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'block-table.svg' },
		]) },
		rt.ArrayItem{ key: 'calendar', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Calendar'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'calendar.svg' },
		]) },
		rt.ArrayItem{ key: 'capture-photo', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Capture Photo'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'capture-photo.svg' },
		]) },
		rt.ArrayItem{ key: 'capture-video', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Capture Video'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'capture-video.svg' },
		]) },
		rt.ArrayItem{ key: 'cart', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Cart'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'cart.svg' },
		]) },
		rt.ArrayItem{ key: 'category', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Category'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'category.svg' },
		]) },
		rt.ArrayItem{ key: 'caution', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Caution'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'caution.svg' },
		]) },
		rt.ArrayItem{ key: 'chart-bar', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Chart Bar'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'chart-bar.svg' },
		]) },
		rt.ArrayItem{ key: 'check', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Check'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'check.svg' },
		]) },
		rt.ArrayItem{ key: 'chevron-down', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Chevron Down'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'chevron-down.svg' },
		]) },
		rt.ArrayItem{ key: 'chevron-down-small', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Chevron Down Small'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'chevron-down-small.svg' },
		]) },
		rt.ArrayItem{ key: 'chevron-left', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Chevron Left'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'chevron-left.svg' },
		]) },
		rt.ArrayItem{ key: 'chevron-left-small', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Chevron Left Small'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'chevron-left-small.svg' },
		]) },
		rt.ArrayItem{ key: 'chevron-right', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Chevron Right'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'chevron-right.svg' },
		]) },
		rt.ArrayItem{ key: 'chevron-right-small', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Chevron Right Small'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'chevron-right-small.svg' },
		]) },
		rt.ArrayItem{ key: 'chevron-up', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Chevron Up'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'chevron-up.svg' },
		]) },
		rt.ArrayItem{ key: 'chevron-up-down', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Chevron Up Down'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'chevron-up-down.svg' },
		]) },
		rt.ArrayItem{ key: 'chevron-up-small', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Chevron Up Small'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'chevron-up-small.svg' },
		]) },
		rt.ArrayItem{ key: 'comment', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Comment'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'comment.svg' },
		]) },
		rt.ArrayItem{ key: 'cover', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Cover'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'cover.svg' },
		]) },
		rt.ArrayItem{ key: 'create', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Create'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'create.svg' },
		]) },
		rt.ArrayItem{ key: 'desktop', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Desktop'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'desktop.svg' },
		]) },
		rt.ArrayItem{ key: 'download', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Download'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'download.svg' },
		]) },
		rt.ArrayItem{ key: 'drawer-left', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Drawer Left'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'drawer-left.svg' },
		]) },
		rt.ArrayItem{ key: 'drawer-right', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Drawer Right'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'drawer-right.svg' },
		]) },
		rt.ArrayItem{ key: 'envelope', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Envelope'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'envelope.svg' },
		]) },
		rt.ArrayItem{ key: 'error', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Error'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'error.svg' },
		]) },
		rt.ArrayItem{ key: 'external', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('External'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'external.svg' },
		]) },
		rt.ArrayItem{ key: 'file', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('File'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'file.svg' },
		]) },
		rt.ArrayItem{ key: 'gallery', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Gallery'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'gallery.svg' },
		]) },
		rt.ArrayItem{ key: 'group', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Group'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'group.svg' },
		]) },
		rt.ArrayItem{ key: 'heading', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Heading'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'heading.svg' },
		]) },
		rt.ArrayItem{ key: 'help', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Help'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'help.svg' },
		]) },
		rt.ArrayItem{ key: 'home', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Home'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'home.svg' },
		]) },
		rt.ArrayItem{ key: 'image', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Image'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'image.svg' },
		]) },
		rt.ArrayItem{ key: 'info', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Info'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'info.svg' },
		]) },
		rt.ArrayItem{ key: 'key', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Key'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'key.svg' },
		]) },
		rt.ArrayItem{ key: 'language', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Language'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'language.svg' },
		]) },
		rt.ArrayItem{ key: 'map-marker', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Map Marker'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'map-marker.svg' },
		]) },
		rt.ArrayItem{ key: 'menu', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Menu'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'menu.svg' },
		]) },
		rt.ArrayItem{ key: 'mobile', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Mobile'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'mobile.svg' },
		]) },
		rt.ArrayItem{ key: 'more-horizontal', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('More Horizontal'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'more-horizontal.svg' },
		]) },
		rt.ArrayItem{ key: 'more-vertical', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('More Vertical'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'more-vertical.svg' },
		]) },
		rt.ArrayItem{ key: 'next', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Next'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'next.svg' },
		]) },
		rt.ArrayItem{ key: 'paragraph', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Paragraph'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'paragraph.svg' },
		]) },
		rt.ArrayItem{ key: 'payment', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Payment'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'payment.svg' },
		]) },
		rt.ArrayItem{ key: 'pencil', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Pencil'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'pencil.svg' },
		]) },
		rt.ArrayItem{ key: 'people', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('People'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'people.svg' },
		]) },
		rt.ArrayItem{ key: 'plus', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Plus'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'plus.svg' },
		]) },
		rt.ArrayItem{ key: 'plus-circle', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Plus Circle'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'plus-circle.svg' },
		]) },
		rt.ArrayItem{ key: 'previous', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Previous'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'previous.svg' },
		]) },
		rt.ArrayItem{ key: 'published', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Published'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'published.svg' },
		]) },
		rt.ArrayItem{ key: 'quote', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Quote'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'quote.svg' },
		]) },
		rt.ArrayItem{ key: 'receipt', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Receipt'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'receipt.svg' },
		]) },
		rt.ArrayItem{ key: 'rss', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('RSS'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'rss.svg' },
		]) },
		rt.ArrayItem{ key: 'scheduled', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Scheduled'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'scheduled.svg' },
		]) },
		rt.ArrayItem{ key: 'search', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Search'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'search.svg' },
		]) },
		rt.ArrayItem{ key: 'settings', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Settings'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'settings.svg' },
		]) },
		rt.ArrayItem{ key: 'shadow', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Shadow'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'shadow.svg' },
		]) },
		rt.ArrayItem{ key: 'share', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Share'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'share.svg' },
		]) },
		rt.ArrayItem{ key: 'shield', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Shield'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'shield.svg' },
		]) },
		rt.ArrayItem{ key: 'shuffle', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Shuffle'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'shuffle.svg' },
		]) },
		rt.ArrayItem{ key: 'star-empty', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Star Empty'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'star-empty.svg' },
		]) },
		rt.ArrayItem{ key: 'star-filled', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Star Filled'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'star-filled.svg' },
		]) },
		rt.ArrayItem{ key: 'star-half', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Star Half'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'star-half.svg' },
		]) },
		rt.ArrayItem{ key: 'store', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Store'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'store.svg' },
		]) },
		rt.ArrayItem{ key: 'styles', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Styles'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'styles.svg' },
		]) },
		rt.ArrayItem{ key: 'symbol', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Symbol'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'symbol.svg' },
		]) },
		rt.ArrayItem{ key: 'symbol-filled', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Symbol Filled'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'symbol-filled.svg' },
		]) },
		rt.ArrayItem{ key: 'table', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Table'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'table.svg' },
		]) },
		rt.ArrayItem{ key: 'tablet', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Tablet'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'tablet.svg' },
		]) },
		rt.ArrayItem{ key: 'tag', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Tag'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'tag.svg' },
		]) },
		rt.ArrayItem{ key: 'tip', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Tip'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'tip.svg' },
		]) },
		rt.ArrayItem{ key: 'upload', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Upload'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'upload.svg' },
		]) },
		rt.ArrayItem{ key: 'verse', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Verse'),
				rt.new_string('icon label'),
			]) },
			rt.ArrayItem{ key: 'filePath', val: 'verse.svg' },
		]) },
	])
}
