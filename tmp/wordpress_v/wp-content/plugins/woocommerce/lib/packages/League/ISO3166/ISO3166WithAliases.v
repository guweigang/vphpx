import rt

pub fn Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166WithAliases.aliases() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'Bolivia', val: 'Bolivia (Plurinational State of)' },
		rt.ArrayItem{
			key: 'Bolivia, Plurinational State of'
			val: 'Bolivia (Plurinational State of)'
		},
		rt.ArrayItem{ key: 'Congo-Kinshasa', val: 'Congo (Democratic Republic of the)' },
		rt.ArrayItem{
			key: 'Congo, Democratic Republic of the'
			val: 'Congo (Democratic Republic of the)'
		},
		rt.ArrayItem{ key: 'Czech Republic', val: 'Czechia' },
		rt.ArrayItem{ key: 'Iran', val: 'Iran (Islamic Republic of)' },
		rt.ArrayItem{ key: 'North Korea', val: "Korea (Democratic People's Republic of)" },
		rt.ArrayItem{ key: 'South Korea', val: 'Korea (Republic of)' },
		rt.ArrayItem{ key: 'Laos', val: "Lao People's Democratic Republic" },
		rt.ArrayItem{ key: 'Micronesia', val: 'Micronesia (Federated States of)' },
		rt.ArrayItem{ key: 'Moldova', val: 'Moldova (Republic of)' },
		rt.ArrayItem{ key: 'Palestine', val: 'Palestine, State of' },
		rt.ArrayItem{ key: 'Russia', val: 'Russian Federation' },
		rt.ArrayItem{ key: 'Saint Martin', val: 'Saint Martin (French part)' },
		rt.ArrayItem{ key: 'Sint Maarten', val: 'Sint Maarten (Dutch part)' },
		rt.ArrayItem{ key: 'Taiwan', val: 'Taiwan (Province of China)' },
		rt.ArrayItem{ key: 'Tanzania', val: 'Tanzania, United Republic of' },
		rt.ArrayItem{
			key: 'United Kingdom'
			val: 'United Kingdom of Great Britain and Northern Ireland'
		},
		rt.ArrayItem{ key: 'United States', val: 'United States of America' },
		rt.ArrayItem{ key: 'USA', val: 'United States of America' },
		rt.ArrayItem{ key: 'Venezuela', val: 'Venezuela (Bolivarian Republic of)' },
		rt.ArrayItem{ key: 'Vietnam', val: 'Viet Nam' },
	])
}

struct Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166WithAliases {
	rt.PhpObjectBase
pub mut:
	source rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166WithAliases) construct(mut var_iso3166 Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166DataProvider) {
	this.source = var_iso3166.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166WithAliases) name(name string) rt.PhpVal {
	mut name_mutated := name
	{
		mut iter_1 :=
			Class_Automattic_WooCommerce_Vendor_League_ISO3166_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166WithAliases.aliases().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_original := item_1.val
			mut var_alias := item_1.key
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [
				var_alias.dup(),
				rt.new_string(name_mutated).dup(),
			])))
			{
				name_mutated = var_original.str()
				break
			}
		}
	}
	return rt.call_method(this.source, 'name', [rt.new_string(name_mutated).dup()])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166WithAliases) alpha2(alpha2 string) rt.PhpVal {
	return rt.call_method(this.source, 'alpha2', [rt.new_string(alpha2)])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166WithAliases) alpha3(alpha3 string) rt.PhpVal {
	return rt.call_method(this.source, 'alpha3', [rt.new_string(alpha3)])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166WithAliases) numeric(numeric string) rt.PhpVal {
	return rt.call_method(this.source, 'numeric', [rt.new_string(numeric)])
}

fn create_automattic_woocommerce_vendor_league_iso3166_iso3166withaliases(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166WithAliases {
	mut obj := &Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166WithAliases{
		PhpObjectBase: rt.PhpObjectBase{}
		source:        rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166WithAliases) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166DataProvider](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.name(dispatch_arg_0)
		}
		'alpha2' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.alpha2(dispatch_arg_0)
		}
		'alpha3' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.alpha3(dispatch_arg_0)
		}
		'numeric' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.numeric(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166WithAliases) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'source' { return this.source }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_League_ISO3166_ISO3166WithAliases) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'source' {
			this.source = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_league_iso3166_iso3166withaliases_php() {
	// unsupported statement: Stmt_Declare
}
