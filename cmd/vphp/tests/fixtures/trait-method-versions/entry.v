module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'trait_method_versions_probe' }

@[vphp.PhpExportTrait(name: 'VphpTraitBaseline')]
struct TraitBaseline {}

@[vphp.PhpExportMethod(name: 'select')]
@[vphp.PhpCallableAttribute(name: 'VphpTraitTag', args: 'source: "base"')]
pub fn (owner &TraitBaseline) select() string {
	return 'base'
}

@[vphp.PhpExportMethod(name: 'local')]
pub fn (owner &TraitBaseline) local() string {
	return 'legacy-local'
}

@[vphp.PhpExportMethod(name: 'resolve')]
@[vphp.PhpAbstractMethod]
pub fn (owner &TraitBaseline) resolve() string {
	return ''
}

@[vphp.PhpExportTrait(name: 'VphpTraitFuture')]
struct TraitFuture {}

@[vphp.PhpExportMethod(name: 'select')]
@[vphp.PhpMethodSince(version: .php86)]
@[vphp.PhpCallableAttribute(name: 'VphpTraitTag', args: 'source: "future"')]
pub fn (owner &TraitFuture) select() string {
	return 'future'
}

@[vphp.PhpExportMethod(name: 'tag')]
@[vphp.PhpMethodSince(version: .php85)]
pub fn (owner &TraitFuture) tag() int {
	return 85
}

@[vphp.PhpExportMethod(name: 'resolve')]
@[vphp.PhpMethodSince(version: .php86)]
pub fn (owner &TraitFuture) resolve() string {
	return 'resolved'
}

@[vphp.PhpExportTrait(name: 'VphpTraitCombined')]
struct TraitCombined {}

@[vphp.PhpExportMethod(name: 'local')]
@[vphp.PhpMethodSince(version: .php86)]
pub fn (owner &TraitCombined) local() string {
	return 'new-local'
}

const combined_trait_rules = vphp.PhpTraitRules[TraitCombined]{
	uses:        [vphp.PhpNativeTraitSource(TraitBaseline{}), TraitFuture{}]
	precedences: [vphp.PhpTraitPrecedence{
		source:     TraitFuture{}
		method:     'select'
		instead_of: [TraitBaseline{}]
	}]
	adaptations: [
		vphp.PhpTraitAdaptation{ source: TraitBaseline{}, method: 'select', alias: 'fallback' },
		vphp.PhpTraitAdaptation{
			source:     TraitFuture{}
			method:     'select'
			alias:      'modern'
			visibility: .protected
			is_final:   true
		},
		vphp.PhpTraitAdaptation{ source: TraitFuture{}, method: 'tag', alias: 'versionTag' },
	]
}

@[vphp.PhpExportTrait(name: 'VphpTraitOuter')]
@[vphp.PhpClassAttribute(name: 'Deprecated', args: 'message: "Use VphpTraitCombined", since: "2.0"')]
struct TraitOuter {}

const outer_trait_rules = vphp.PhpTraitRules[TraitOuter]{
	uses:        [TraitCombined{}]
	adaptations: [
		vphp.PhpTraitAdaptation{ source: TraitCombined{}, method: 'select', alias: 'selected' },
		vphp.PhpTraitAdaptation{ source: TraitCombined{}, method: 'modern', alias: 'nestedModern' },
	]
}
