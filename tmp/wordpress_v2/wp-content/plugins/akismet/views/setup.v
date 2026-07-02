import rt

struct Class_Akismet {
	rt.PhpObjectBase
}

fn create_akismet(_args ...rt.PhpVal) &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_use_jetpack_connection := rt.new_null()
	mut var_tick_icon := '<svg class="akismet-setup-instructions__icon" width="48" height="48" viewBox="0 0 48 48" aria-hidden="true" focusable="false" xmlns="http://www.w3.org/2000/svg">\n  <circle cx="24" cy="24" r="22" fill="#2E7D32"/>\n  <path d="M16 24l6 6 12-14" fill="none" stroke="#FFFFFF" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>\n</svg>'
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Eliminate spam from your site'),
		rt.new_string('akismet')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Protect your site from comment spam and contact form spam — automatically.'),
		rt.new_string('akismet'),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(var_tick_icon)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Machine learning accuracy'),
		rt.new_string('akismet'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Learns from billions of spam signals across the web to stop junk before it reaches you.'),
		rt.new_string('akismet'),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(var_tick_icon)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Zero effort'),
		rt.new_string('akismet')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Akismet runs quietly in the background, saving you hours of manual moderation.'),
		rt.new_string('akismet'),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(var_tick_icon)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Works with popular contact forms'),
		rt.new_string('akismet'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Seamlessly integrates with plugins like Elementor, Contact Form 7, Jetpack and WPForms.'),
		rt.new_string('akismet'),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(var_tick_icon)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Flexible pricing'),
		rt.new_string('akismet')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [
		rt.new_string('Name your own price for personal sites. Businesses start on a paid plan.'),
		rt.new_string('akismet'),
	]))
	// unsupported statement: Stmt_InlineHTML
	if !rt.is_true(var_use_jetpack_connection) {
		mut iife_temp_0 := Class_Akismet{}
		mut iife_result_0 := iife_temp_0.view(rt.new_string('get'), rt.create_array([
			rt.ArrayItem{ key: 'text', val: rt.call_function('__', [
				rt.new_string('Get started'),
				rt.new_string('akismet'),
			]) },
			rt.ArrayItem{ key: 'classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'akismet-button' },
				rt.ArrayItem{ key: none, val: 'akismet-is-primary' },
				rt.ArrayItem{ key: none, val: 'akismet-setup-instructions__button' },
			]) },
			rt.ArrayItem{ key: 'utm_content', val: 'setup_instructions' },
		]))
	}
	// unsupported statement: Stmt_InlineHTML
}
