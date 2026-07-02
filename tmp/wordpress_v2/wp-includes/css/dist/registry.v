import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-block-directory' },
			rt.ArrayItem{ key: 'path', val: 'block-directory/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-block-editor' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
				rt.ArrayItem{ key: none, val: 'wp-editor' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-block-editor' },
			rt.ArrayItem{ key: 'path', val: 'block-editor/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-commands' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
				rt.ArrayItem{ key: none, val: 'wp-preferences' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-block-library' },
			rt.ArrayItem{ key: 'path', val: 'block-library/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-block-editor' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
				rt.ArrayItem{ key: none, val: 'wp-patterns' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-commands' },
			rt.ArrayItem{ key: 'path', val: 'commands/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-components' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-components' },
			rt.ArrayItem{ key: 'path', val: 'components/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-customize-widgets' },
			rt.ArrayItem{ key: 'path', val: 'customize-widgets/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-block-editor' },
				rt.ArrayItem{ key: none, val: 'wp-block-library' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
				rt.ArrayItem{ key: none, val: 'wp-media-utils' },
				rt.ArrayItem{ key: none, val: 'wp-preferences' },
				rt.ArrayItem{ key: none, val: 'wp-widgets' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-edit-post' },
			rt.ArrayItem{ key: 'path', val: 'edit-post/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-block-editor' },
				rt.ArrayItem{ key: none, val: 'wp-block-library' },
				rt.ArrayItem{ key: none, val: 'wp-commands' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
				rt.ArrayItem{ key: none, val: 'wp-editor' },
				rt.ArrayItem{ key: none, val: 'wp-preferences' },
				rt.ArrayItem{ key: none, val: 'wp-widgets' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-edit-site' },
			rt.ArrayItem{ key: 'path', val: 'edit-site/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-block-editor' },
				rt.ArrayItem{ key: none, val: 'wp-block-library' },
				rt.ArrayItem{ key: none, val: 'wp-commands' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
				rt.ArrayItem{ key: none, val: 'wp-editor' },
				rt.ArrayItem{ key: none, val: 'wp-patterns' },
				rt.ArrayItem{ key: none, val: 'wp-preferences' },
				rt.ArrayItem{ key: none, val: 'wp-widgets' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-edit-widgets' },
			rt.ArrayItem{ key: 'path', val: 'edit-widgets/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-block-editor' },
				rt.ArrayItem{ key: none, val: 'wp-block-library' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
				rt.ArrayItem{ key: none, val: 'wp-media-utils' },
				rt.ArrayItem{ key: none, val: 'wp-patterns' },
				rt.ArrayItem{ key: none, val: 'wp-preferences' },
				rt.ArrayItem{ key: none, val: 'wp-widgets' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-editor' },
			rt.ArrayItem{ key: 'path', val: 'editor/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-block-editor' },
				rt.ArrayItem{ key: none, val: 'wp-commands' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
				rt.ArrayItem{ key: none, val: 'wp-media-utils' },
				rt.ArrayItem{ key: none, val: 'wp-patterns' },
				rt.ArrayItem{ key: none, val: 'wp-preferences' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-format-library' },
			rt.ArrayItem{ key: 'path', val: 'format-library/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-block-editor' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-list-reusable-blocks' },
			rt.ArrayItem{ key: 'path', val: 'list-reusable-blocks/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-components' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-media-utils' },
			rt.ArrayItem{ key: 'path', val: 'media-utils/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-components' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-nux' },
			rt.ArrayItem{ key: 'path', val: 'nux/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-components' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-patterns' },
			rt.ArrayItem{ key: 'path', val: 'patterns/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-block-editor' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-preferences' },
			rt.ArrayItem{ key: 'path', val: 'preferences/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-components' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-reusable-blocks' },
			rt.ArrayItem{ key: 'path', val: 'reusable-blocks/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-block-editor' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'handle', val: 'wp-widgets' },
			rt.ArrayItem{ key: 'path', val: 'widgets/style' },
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-block-editor' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
			]) },
		]) },
	])
}
