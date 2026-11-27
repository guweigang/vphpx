module viewx

import arena

fn reduce_template_values_in_arena(items []string, reducer string, seed string) (string, string) {
	mut scratch := arena.new(chunk_size: 4096)
	defer {
		scratch.free()
	}
	scratch.push()
	value, message := reduce_template_values_scratch(items, reducer, seed)
	scratch.pop()
	// The result and any diagnostic outlive this scratch region.
	return value.clone(), message.clone()
}
