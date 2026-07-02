import rt

const global_const_found = 0
const global_const_not_found = 1
const global_const_truncated = 2
const global_const_aborted = 3
const global_const_invalid = 4
const global_const_max_size = 4294967295
const global_const_max_num_boxes = 4096
const global_const_max_value = 255
const global_const_max_tiles = 16
const global_const_max_props = 32
const global_const_max_features = 8
const global_const_undefined = 0
fn read_big_endian(var_input rt.PhpVal, var_num_bytes rt.PhpVal) i64 {
	mut var_bytes := rt.new_null()
	if rt.is_true(rt.equal(var_num_bytes, rt.new_int(1))) {
		return (rt.call_function('unpack', [rt.new_string('C'), var_input.clone()]).array_get(rt.new_int(1))).to_i64()
	} else {
		if rt.is_true(rt.equal(var_num_bytes, rt.new_int(2))) {
			return (rt.call_function('unpack', [rt.new_string('n'), var_input.clone()]).array_get(rt.new_int(1))).to_i64()
		} else {
			if rt.is_true(rt.equal(var_num_bytes, rt.new_int(3))) {
				var_bytes = rt.call_function('unpack', [rt.new_string('C3'), var_input.clone()])
				return rt.bitwise_or(rt.shift_left(var_bytes.array_get(rt.new_int(1)), rt.new_int(16)) | rt.shift_left(var_bytes.array_get(rt.new_int(2)), rt.new_int(8)), var_bytes.array_get(rt.new_int(3)))
			} else {
				return (rt.call_function('unpack', [rt.new_string('N'), var_input.clone()]).array_get(rt.new_int(1))).to_i64()
			}
		}
	}
	return 0
}

fn read(var_handle rt.PhpVal, var_num_bytes rt.PhpVal) rt.PhpVal {
	mut var_data := rt.new_null()
	var_data = rt.call_function('fread', [var_handle.clone(), var_num_bytes.clone()])
	return if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_data, rt.new_bool(false))))) && rt.is_true(rt.greater_equal(rt.new_int(var_data.clone().to_string().len), var_num_bytes)) { var_data } else { rt.new_bool(false) }
}

fn skip(var_handle rt.PhpVal, var_num_bytes rt.PhpVal) rt.PhpVal {
	return rt.equal(rt.call_function('fseek', [var_handle.clone(), var_num_bytes.clone(), rt.get_constant('SEEK_CUR')]), rt.new_int(0))
}

struct Class_Avifinfo_Tile {
	rt.PhpObjectBase
pub mut:
		tile_item_id rt.PhpVal = rt.new_null()
		parent_item_id rt.PhpVal = rt.new_null()
}

struct Class_Avifinfo_Prop {
	rt.PhpObjectBase
pub mut:
		property_index rt.PhpVal = rt.new_null()
		item_id rt.PhpVal = rt.new_null()
}

struct Class_Avifinfo_Dim_Prop {
	rt.PhpObjectBase
pub mut:
		property_index rt.PhpVal = rt.new_null()
		width rt.PhpVal = rt.new_null()
		height rt.PhpVal = rt.new_null()
}

struct Class_Avifinfo_Chan_Prop {
	rt.PhpObjectBase
pub mut:
		property_index rt.PhpVal = rt.new_null()
		bit_depth rt.PhpVal = rt.new_null()
		num_channels rt.PhpVal = rt.new_null()
}

struct Class_Avifinfo_Features {
	rt.PhpObjectBase
pub mut:
		has_primary_item rt.PhpVal = rt.new_bool(false)
		has_alpha rt.PhpVal = rt.new_bool(false)
		primary_item_id rt.PhpVal = rt.new_null()
		primary_item_features rt.PhpVal = rt.new_array()
		tiles rt.PhpVal = rt.new_array()
		props rt.PhpVal = rt.new_array()
		dim_props rt.PhpVal = rt.new_array()
		chan_props rt.PhpVal = rt.new_array()
}

fn (mut this Class_Avifinfo_Features) get_item_features(var_target_item_id rt.PhpVal, var_tile_depth rt.PhpVal) rt.PhpVal {
	mut iter_1 := this.props.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_prop := item_1.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.get_property(var_prop, 'item_id'), var_target_item_id)))) {
			continue
		}
		if rt.is_true(rt.equal(var_target_item_id, this.primary_item_id)) && rt.is_true(rt.equal(this.primary_item_features.array_get(rt.new_string('width')), rt.get_constant('UNDEFINED'))) || rt.is_true(rt.equal(this.primary_item_features.array_get(rt.new_string('height')), rt.get_constant('UNDEFINED'))) {
			mut iter_2 := this.dim_props.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_dim_prop := item_2.val
				if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.get_property(var_dim_prop, 'property_index'), rt.get_property(var_prop, 'property_index'))))) {
					continue
				}
				this.primary_item_features.array_set('width', rt.get_property(var_dim_prop, 'width'))
				this.primary_item_features.array_set('height', rt.get_property(var_dim_prop, 'height'))
				if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(this.primary_item_features.array_get(rt.new_string('bit_depth')), rt.get_constant('UNDEFINED'))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(this.primary_item_features.array_get(rt.new_string('num_channels')), rt.get_constant('UNDEFINED'))))) {
					return rt.get_constant('FOUND')
				}
				break
			}
		}
		if rt.is_true(rt.equal(this.primary_item_features.array_get(rt.new_string('bit_depth')), rt.get_constant('UNDEFINED'))) || rt.is_true(rt.equal(this.primary_item_features.array_get(rt.new_string('num_channels')), rt.get_constant('UNDEFINED'))) {
			mut iter_3 := this.chan_props.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_chan_prop := item_3.val
				if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.get_property(var_chan_prop, 'property_index'), rt.get_property(var_prop, 'property_index'))))) {
					continue
				}
				this.primary_item_features.array_set('bit_depth', rt.get_property(var_chan_prop, 'bit_depth'))
				this.primary_item_features.array_set('num_channels', rt.get_property(var_chan_prop, 'num_channels'))
				if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(this.primary_item_features.array_get(rt.new_string('width')), rt.get_constant('UNDEFINED'))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(this.primary_item_features.array_get(rt.new_string('height')), rt.get_constant('UNDEFINED'))))) {
					return rt.get_constant('FOUND')
				}
				break
			}
		}
	}
	if rt.is_true(rt.less(var_tile_depth, rt.new_int(3))) {
		mut iter_4 := this.tiles.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_tile := item_4.val
			if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.get_property(var_tile, 'parent_item_id'), var_target_item_id)))) {
				continue
			}
			mut var_status := this.get_item_features(rt.get_property(var_tile, 'tile_item_id'), rt.add(var_tile_depth, rt.new_int(1)))
			if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_status, rt.get_constant('NOT_FOUND'))))) {
				return var_status.clone()
			}
		}
	}
	return rt.get_constant('NOT_FOUND')
}

fn (mut this Class_Avifinfo_Features) get_primary_item_features() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.has_primary_item)))) {
		return rt.get_constant('NOT_FOUND')
	}
	if !rt.is_true(this.dim_props) || !rt.is_true(this.chan_props) {
		return rt.get_constant('NOT_FOUND')
	}
	mut var_status := this.get_item_features(this.primary_item_id, rt.new_int(0))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_status, rt.get_constant('FOUND'))))) {
		return var_status.clone()
	}
	if rt.is_true(this.has_alpha) {
		rt.pre_inc(this.primary_item_features.array_get(rt.new_string('num_channels')))
	}
	return rt.get_constant('FOUND')
}

struct Class_Avifinfo_Box {
	rt.PhpObjectBase
pub mut:
		size rt.PhpVal = rt.new_null()
		prop_type rt.PhpVal = rt.new_null()
		version i64
		flags i64
		content_size rt.PhpVal = rt.new_null()
}

fn (mut this Class_Avifinfo_Box) parse(var_handle rt.PhpVal, var_num_parsed_boxes rt.PhpVal, var_num_remaining_bytes rt.PhpVal) rt.PhpVal {
	mut var_num_parsed_boxes_mutated := var_num_parsed_boxes
	mut var_header_size := rt.new_int(8)
	if rt.is_true(rt.greater(var_header_size, var_num_remaining_bytes)) {
		return rt.get_constant('INVALID')
	}
	mut var_data := read(var_handle.clone(), rt.new_int(8))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
		return rt.get_constant('TRUNCATED')
	}
	this.size = rt.new_int(read_big_endian(var_data.clone(), rt.new_int(4)))
	this.prop_type = rt.call_function('substr', [var_data.clone(), rt.new_int(4), rt.new_int(4)])
	if rt.is_true(rt.equal(this.size, rt.new_int(1))) {
		var_header_size = rt.add(var_header_size, rt.new_int(8))
		if rt.is_true(rt.greater(var_header_size, var_num_remaining_bytes)) {
			return rt.get_constant('INVALID')
		}
		var_data = read(var_handle.clone(), rt.new_int(8))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
			return rt.get_constant('TRUNCATED')
		}
		if rt.is_true(rt.new_bool(read_big_endian(var_data.clone(), 4) != 0)) {
			return rt.get_constant('ABORTED')
		}
		this.size = rt.new_int(read_big_endian(rt.call_function('substr', [var_data.clone(), rt.new_int(4), rt.new_int(4)]), rt.new_int(4)))
	} else {
		if rt.is_true(rt.equal(this.size, rt.new_int(0))) {
			this.size = var_num_remaining_bytes.clone()
		}
	}
	if rt.is_true(rt.less(this.size, var_header_size)) {
		return rt.get_constant('INVALID')
	}
	if rt.is_true(rt.greater(this.size, var_num_remaining_bytes)) {
		return rt.get_constant('INVALID')
	}
	mut var_has_fullbox_header := rt.new_bool(rt.is_true(rt.equal(this.prop_type, rt.new_string('meta'))) || rt.is_true(rt.equal(this.prop_type, rt.new_string('pitm'))) || rt.is_true(rt.equal(this.prop_type, rt.new_string('ipma'))) || rt.is_true(rt.equal(this.prop_type, rt.new_string('ispe'))) || rt.is_true(rt.equal(this.prop_type, rt.new_string('pixi'))) || rt.is_true(rt.equal(this.prop_type, rt.new_string('iref'))) || rt.is_true(rt.equal(this.prop_type, rt.new_string('auxC'))))
	if rt.is_true(var_has_fullbox_header) {
		var_header_size = rt.add(var_header_size, rt.new_int(4))
	}
	if rt.is_true(rt.less(this.size, var_header_size)) {
		return rt.get_constant('INVALID')
	}
	this.content_size = rt.sub(this.size, var_header_size)
	rt.pre_inc(var_num_parsed_boxes_mutated)
	if rt.is_true(rt.greater_equal(var_num_parsed_boxes_mutated, rt.get_constant('MAX_NUM_BOXES'))) {
		return rt.get_constant('ABORTED')
	}
	this.version = 0
	this.flags = 0
	if rt.is_true(var_has_fullbox_header) {
		var_data = read(var_handle.clone(), rt.new_int(4))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
			return rt.get_constant('TRUNCATED')
		}
		this.version = read_big_endian(var_data.clone(), 1)
		this.flags = read_big_endian(rt.call_function('substr', [var_data.clone(), rt.new_int(1), rt.new_int(3)]), 3)
		mut var_is_parsable := rt.new_bool((((((rt.is_true(rt.equal(this.prop_type, rt.new_string('meta'))) && this.version <= 0) || (rt.is_true(rt.equal(this.prop_type, rt.new_string('pitm'))) && this.version <= 1)) || (rt.is_true(rt.equal(this.prop_type, rt.new_string('ipma'))) && this.version <= 1)) || (rt.is_true(rt.equal(this.prop_type, rt.new_string('ispe'))) && this.version <= 0)) || (rt.is_true(rt.equal(this.prop_type, rt.new_string('pixi'))) && this.version <= 0)) || (rt.is_true(rt.equal(this.prop_type, rt.new_string('iref'))) && this.version <= 1) || rt.is_true(rt.equal(this.prop_type, rt.new_string('auxC'))) && this.version <= 0)
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_parsable)))) {
			this.prop_type = rt.new_string('skip')
		}
	}
	return rt.get_constant('FOUND')
}

struct Class_Avifinfo_Parser {
	rt.PhpObjectBase
pub mut:
		handle rt.PhpVal = rt.new_null()
		num_parsed_boxes rt.PhpVal = rt.new_int(0)
		data_was_skipped bool
		features rt.PhpVal = rt.new_null()
}

fn (mut this Class_Avifinfo_Parser) construct(var_handle rt.PhpVal) {
	this.handle = var_handle.clone()
	this.features = create_avifinfo_features()
}

fn (mut this Class_Avifinfo_Parser) parse_ipco(var_num_remaining_bytes rt.PhpVal) rt.PhpVal {
	mut var_box_index := rt.new_int(1)
	for {
		mut var_box := create_avifinfo_box()
		mut var_status := var_box.parse(this.handle, this.num_parsed_boxes, var_num_remaining_bytes.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_status, rt.get_constant('FOUND'))))) {
			return var_status.clone()
		}
		if rt.is_true(rt.equal(var_box.prop_type, rt.new_string('ispe'))) {
			if rt.is_true(rt.less(var_box.content_size, rt.new_int(8))) {
				return rt.get_constant('INVALID')
			}
			mut var_data := read(this.handle, rt.new_int(8))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
				return rt.get_constant('TRUNCATED')
			}
			mut var_width := rt.new_int(read_big_endian(rt.call_function('substr', [var_data.clone(), rt.new_int(0), rt.new_int(4)]), rt.new_int(4)))
			mut var_height := rt.new_int(read_big_endian(rt.call_function('substr', [var_data.clone(), rt.new_int(4), rt.new_int(4)]), rt.new_int(4)))
			if rt.is_true(rt.equal(var_width, rt.new_int(0))) || rt.is_true(rt.equal(var_height, rt.new_int(0))) {
				return rt.get_constant('INVALID')
			}
			if rt.is_true(rt.less_equal(rt.new_int(rt.get_property(this.features, 'dim_props').array_count()), rt.get_constant('MAX_FEATURES'))) && rt.is_true(rt.less_equal(var_box_index, rt.get_constant('MAX_VALUE'))) {
				mut var_dim_prop_count := rt.new_int(rt.get_property(this.features, 'dim_props').array_count())
				rt.get_property(this.features, 'dim_props').array_set(var_dim_prop_count, create_avifinfo_dim_prop())
				rt.set_property(rt.get_property(this.features, 'dim_props').array_get(var_dim_prop_count), 'property_index', var_box_index.clone())
				rt.set_property(rt.get_property(this.features, 'dim_props').array_get(var_dim_prop_count), 'width', var_width.clone())
				rt.set_property(rt.get_property(this.features, 'dim_props').array_get(var_dim_prop_count), 'height', var_height.clone())
			} else {
				this.data_was_skipped = true
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(skip(this.handle, rt.sub(var_box.content_size, rt.new_int(8))))))) {
				return rt.get_constant('TRUNCATED')
			}
		} else {
			if rt.is_true(rt.equal(var_box.prop_type, rt.new_string('pixi'))) {
				if rt.is_true(rt.less(var_box.content_size, rt.new_int(1))) {
					return rt.get_constant('INVALID')
				}
				var_data = read(this.handle, rt.new_int(1))
				if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
					return rt.get_constant('TRUNCATED')
				}
				mut var_num_channels := rt.new_int(read_big_endian(var_data.clone(), rt.new_int(1)))
				if rt.is_true(rt.less(var_num_channels, rt.new_int(1))) {
					return rt.get_constant('INVALID')
				}
				if rt.is_true(rt.less(var_box.content_size, rt.add(rt.new_int(1), var_num_channels))) {
					return rt.get_constant('INVALID')
				}
				var_data = read(this.handle, rt.new_int(1))
				if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
					return rt.get_constant('TRUNCATED')
				}
				mut var_bit_depth := rt.new_int(read_big_endian(var_data.clone(), rt.new_int(1)))
				if rt.is_true(rt.less(var_bit_depth, rt.new_int(1))) {
					return rt.get_constant('INVALID')
				}
				mut var_i := rt.new_int(1)
				for {
					if !(rt.is_true(rt.less(var_i, var_num_channels))) { break }
					var_data = read(this.handle, rt.new_int(1))
					if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
						return rt.get_constant('TRUNCATED')
					}
					if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_int(read_big_endian(var_data.clone(), rt.new_int(1))), var_bit_depth)))) {
						return rt.get_constant('INVALID')
					}
					if rt.is_true(rt.greater(var_i, rt.new_int(32))) {
						return rt.get_constant('ABORTED')
					}
					rt.pre_inc(var_i)
				}
				if rt.is_true(rt.less_equal(rt.new_int(rt.get_property(this.features, 'chan_props').array_count()), rt.get_constant('MAX_FEATURES'))) && rt.is_true(rt.less_equal(var_box_index, rt.get_constant('MAX_VALUE'))) && rt.is_true(rt.less_equal(var_bit_depth, rt.get_constant('MAX_VALUE'))) && rt.is_true(rt.less_equal(var_num_channels, rt.get_constant('MAX_VALUE'))) {
					mut var_chan_prop_count := rt.new_int(rt.get_property(this.features, 'chan_props').array_count())
					rt.get_property(this.features, 'chan_props').array_set(var_chan_prop_count, create_avifinfo_chan_prop())
					rt.set_property(rt.get_property(this.features, 'chan_props').array_get(var_chan_prop_count), 'property_index', var_box_index.clone())
					rt.set_property(rt.get_property(this.features, 'chan_props').array_get(var_chan_prop_count), 'bit_depth', var_bit_depth.clone())
					rt.set_property(rt.get_property(this.features, 'chan_props').array_get(var_chan_prop_count), 'num_channels', var_num_channels.clone())
				} else {
					this.data_was_skipped = true
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(skip(this.handle, rt.sub(var_box.content_size, rt.add(rt.new_int(1), var_num_channels))))))) {
					return rt.get_constant('TRUNCATED')
				}
			} else {
				if rt.is_true(rt.equal(var_box.prop_type, rt.new_string('av1C'))) {
					if rt.is_true(rt.less(var_box.content_size, rt.new_int(3))) {
						return rt.get_constant('INVALID')
					}
					mut var_data := read(this.handle, rt.new_int(3))
					if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
						return rt.get_constant('TRUNCATED')
					}
					mut var_byte := rt.new_int(read_big_endian(rt.call_function('substr', [var_data.clone(), rt.new_int(2), rt.new_int(1)]), rt.new_int(1)))
					mut var_high_bitdepth := rt.new_bool(rt.bitwise_and(var_byte, rt.new_int(64)) != 0)
					mut var_twelve_bit := rt.new_bool(rt.bitwise_and(var_byte, rt.new_int(32)) != 0)
					mut var_monochrome := rt.new_bool(rt.bitwise_and(var_byte, rt.new_int(16)) != 0)
					if rt.is_true(var_twelve_bit) && rt.is_true(rt.new_bool(!(rt.is_true(var_high_bitdepth)))) {
						return rt.get_constant('INVALID')
					}
					if rt.is_true(rt.less_equal(rt.new_int(rt.get_property(this.features, 'chan_props').array_count()), rt.get_constant('MAX_FEATURES'))) && rt.is_true(rt.less_equal(var_box_index, rt.get_constant('MAX_VALUE'))) {
						var_chan_prop_count = rt.new_int(rt.get_property(this.features, 'chan_props').array_count())
						rt.get_property(this.features, 'chan_props').array_set(var_chan_prop_count, create_avifinfo_chan_prop())
						rt.set_property(rt.get_property(this.features, 'chan_props').array_get(var_chan_prop_count), 'property_index', var_box_index.clone())
						rt.set_property(rt.get_property(this.features, 'chan_props').array_get(var_chan_prop_count), 'bit_depth', if rt.is_true(var_high_bitdepth) { if rt.is_true(var_twelve_bit) { 12 } else { 10 } } else { 8 })
						rt.set_property(rt.get_property(this.features, 'chan_props').array_get(var_chan_prop_count), 'num_channels', if rt.is_true(var_monochrome) { 1 } else { 3 })
					} else {
						this.data_was_skipped = true
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(skip(this.handle, rt.sub(var_box.content_size, rt.new_int(3))))))) {
						return rt.get_constant('TRUNCATED')
					}
				} else {
					if rt.is_true(rt.equal(var_box.prop_type, rt.new_string('auxC'))) {
						mut var_kAlphaStr := rt.new_string('urn:mpeg:mpegB:cicp:systems:auxiliary:alpha')
						mut var_kAlphaStrLength := rt.new_int(44)
						if rt.is_true(rt.greater_equal(var_box.content_size, var_kAlphaStrLength)) {
							var_data = read(this.handle, var_kAlphaStrLength.clone())
							if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
								return rt.get_constant('TRUNCATED')
							}
							if rt.is_true(rt.equal(rt.call_function('substr', [var_data.clone(), rt.new_int(0), var_kAlphaStrLength.clone()]), var_kAlphaStr)) {
								rt.set_property(this.features, 'has_alpha', rt.new_bool(true))
							}
							if rt.is_true(rt.new_bool(!(rt.is_true(skip(this.handle, rt.sub(var_box.content_size, var_kAlphaStrLength)))))) {
								return rt.get_constant('TRUNCATED')
							}
						} else {
							if rt.is_true(rt.new_bool(!(rt.is_true(skip(this.handle, var_box.content_size))))) {
								return rt.get_constant('TRUNCATED')
							}
						}
					} else {
						if rt.is_true(rt.new_bool(!(rt.is_true(skip(this.handle, var_box.content_size))))) {
							return rt.get_constant('TRUNCATED')
						}
					}
				}
			}
		}
		rt.pre_inc(var_box_index)
		var_num_remaining_bytes = rt.sub(var_num_remaining_bytes, var_box.size)
		if !(rt.is_true(rt.greater(var_num_remaining_bytes, rt.new_int(0)))) {
			break
		}
	}
	return rt.get_constant('NOT_FOUND')
}

fn (mut this Class_Avifinfo_Parser) parse_iprp(var_num_remaining_bytes rt.PhpVal) rt.PhpVal {
	for {
		mut var_box := create_avifinfo_box()
		mut var_status := var_box.parse(this.handle, this.num_parsed_boxes, var_num_remaining_bytes.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_status, rt.get_constant('FOUND'))))) {
			return var_status.clone()
		}
		if rt.is_true(rt.equal(var_box.prop_type, rt.new_string('ipco'))) {
			var_status = this.parse_ipco(var_box.content_size)
			if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_status, rt.get_constant('NOT_FOUND'))))) {
				return var_status.clone()
			}
		} else {
			if rt.is_true(rt.equal(var_box.prop_type, rt.new_string('ipma'))) {
				mut var_num_read_bytes := rt.new_int(4)
				if rt.is_true(rt.less(var_box.content_size, var_num_read_bytes)) {
					return rt.get_constant('INVALID')
				}
				mut var_data := read(this.handle, var_num_read_bytes.clone())
				if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
					return rt.get_constant('TRUNCATED')
				}
				mut var_entry_count := rt.new_int(read_big_endian(var_data.clone(), rt.new_int(4)))
				mut var_id_num_bytes := rt.new_int(if var_box.version < 1 { 2 } else { 4 })
				mut var_index_num_bytes := rt.new_int(if rt.is_true(var_box.flags & 1) { 2 } else { 1 })
				mut var_essential_bit_mask := rt.new_int(if rt.is_true(var_box.flags & 1) { 32768 } else { 128 })
				mut var_entry := rt.new_int(0)
				for {
					if !(rt.is_true(rt.less(var_entry, var_entry_count))) { break }
					if rt.is_true(rt.greater_equal(var_entry, rt.get_constant('MAX_PROPS'))) || rt.is_true(rt.greater_equal(rt.new_int(rt.get_property(this.features, 'props').array_count()), rt.get_constant('MAX_PROPS'))) {
						this.data_was_skipped = true
						break
					}
					var_num_read_bytes = rt.add(var_num_read_bytes, rt.add(var_id_num_bytes, rt.new_int(1)))
					if rt.is_true(rt.less(var_box.content_size, var_num_read_bytes)) {
						return rt.get_constant('INVALID')
					}
					var_data = read(this.handle, rt.add(var_id_num_bytes, rt.new_int(1)))
					if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
						return rt.get_constant('TRUNCATED')
					}
					mut var_item_id := rt.new_int(read_big_endian(rt.call_function('substr', [var_data.clone(), rt.new_int(0), var_id_num_bytes.clone()]), var_id_num_bytes.clone()))
					mut var_association_count := rt.new_int(read_big_endian(rt.call_function('substr', [var_data.clone(), var_id_num_bytes.clone(), rt.new_int(1)]), rt.new_int(1)))
					mut var_property := rt.new_int(0)
					for {
						if !(rt.is_true(rt.less(var_property, var_association_count))) { break }
						if rt.is_true(rt.greater_equal(var_property, rt.get_constant('MAX_PROPS'))) || rt.is_true(rt.greater_equal(rt.new_int(rt.get_property(this.features, 'props').array_count()), rt.get_constant('MAX_PROPS'))) {
							this.data_was_skipped = true
							break
						}
						var_num_read_bytes = rt.add(var_num_read_bytes, var_index_num_bytes)
						if rt.is_true(rt.less(var_box.content_size, var_num_read_bytes)) {
							return rt.get_constant('INVALID')
						}
						var_data = read(this.handle, var_index_num_bytes.clone())
						if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
							return rt.get_constant('TRUNCATED')
						}
						mut var_value := rt.new_int(read_big_endian(var_data.clone(), var_index_num_bytes.clone()))
						mut var_property_index := rt.new_int(rt.bitwise_and(var_value, rt.bitwise_not(var_essential_bit_mask)))
						if rt.is_true(rt.less_equal(var_property_index, rt.get_constant('MAX_VALUE'))) && rt.is_true(rt.less_equal(var_item_id, rt.get_constant('MAX_VALUE'))) {
							mut var_prop_count := rt.new_int(rt.get_property(this.features, 'props').array_count())
							rt.get_property(this.features, 'props').array_set(var_prop_count, create_avifinfo_prop())
							rt.set_property(rt.get_property(this.features, 'props').array_get(var_prop_count), 'property_index', var_property_index.clone())
							rt.set_property(rt.get_property(this.features, 'props').array_get(var_prop_count), 'item_id', var_item_id.clone())
						} else {
							this.data_was_skipped = true
						}
						rt.pre_inc(var_property)
					}
					if rt.is_true(rt.less(var_property, var_association_count)) {
						break
					}
					rt.pre_inc(var_entry)
				}
				mut var_status := rt.call_method(this.features, 'get_primary_item_features', []rt.PhpVal{})
				if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_status, rt.get_constant('NOT_FOUND'))))) {
					return var_status.clone()
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(skip(this.handle, rt.sub(var_box.content_size, var_num_read_bytes)))))) {
					return rt.get_constant('TRUNCATED')
				}
			} else {
				if rt.is_true(rt.new_bool(!(rt.is_true(skip(this.handle, var_box.content_size))))) {
					return rt.get_constant('TRUNCATED')
				}
			}
		}
		var_num_remaining_bytes = rt.sub(var_num_remaining_bytes, var_box.size)
		if !(rt.is_true(rt.greater(var_num_remaining_bytes, rt.new_int(0)))) {
			break
		}
	}
	return rt.get_constant('NOT_FOUND')
}

fn (mut this Class_Avifinfo_Parser) parse_iref(var_num_remaining_bytes rt.PhpVal) rt.PhpVal {
	for rt.is_true(rt.greater(var_num_remaining_bytes, rt.new_int(0))) {
		mut var_box := create_avifinfo_box()
		mut var_status := var_box.parse(this.handle, this.num_parsed_boxes, var_num_remaining_bytes.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_status, rt.get_constant('FOUND'))))) {
			return var_status.clone()
		}
		if rt.is_true(rt.equal(var_box.prop_type, rt.new_string('dimg'))) {
			mut var_num_bytes_per_id := rt.new_int(if var_box.version == 0 { 2 } else { 4 })
			mut var_num_read_bytes := rt.add(var_num_bytes_per_id, rt.new_int(2))
			if rt.is_true(rt.less(var_box.content_size, var_num_read_bytes)) {
				return rt.get_constant('INVALID')
			}
			mut var_data := read(this.handle, var_num_read_bytes.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
				return rt.get_constant('TRUNCATED')
			}
			mut var_from_item_id := rt.new_int(read_big_endian(var_data.clone(), var_num_bytes_per_id.clone()))
			mut var_reference_count := rt.new_int(read_big_endian(rt.call_function('substr', [var_data.clone(), var_num_bytes_per_id.clone(), rt.new_int(2)]), rt.new_int(2)))
			mut var_i := rt.new_int(0)
			for {
				if !(rt.is_true(rt.less(var_i, var_reference_count))) { break }
				if rt.is_true(rt.greater_equal(var_i, rt.get_constant('MAX_TILES'))) {
					this.data_was_skipped = true
					break
				}
				var_num_read_bytes = rt.add(var_num_read_bytes, var_num_bytes_per_id)
				if rt.is_true(rt.less(var_box.content_size, var_num_read_bytes)) {
					return rt.get_constant('INVALID')
				}
				var_data = read(this.handle, var_num_bytes_per_id.clone())
				if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
					return rt.get_constant('TRUNCATED')
				}
				mut var_to_item_id := rt.new_int(read_big_endian(var_data.clone(), var_num_bytes_per_id.clone()))
				mut var_tile_count := rt.new_int(rt.get_property(this.features, 'tiles').array_count())
				if rt.is_true(rt.less_equal(var_from_item_id, rt.get_constant('MAX_VALUE'))) && rt.is_true(rt.less_equal(var_to_item_id, rt.get_constant('MAX_VALUE'))) && rt.is_true(rt.less(var_tile_count, rt.get_constant('MAX_TILES'))) {
					rt.get_property(this.features, 'tiles').array_set(var_tile_count, create_avifinfo_tile())
					rt.set_property(rt.get_property(this.features, 'tiles').array_get(var_tile_count), 'tile_item_id', var_to_item_id.clone())
					rt.set_property(rt.get_property(this.features, 'tiles').array_get(var_tile_count), 'parent_item_id', var_from_item_id.clone())
				} else {
					this.data_was_skipped = true
				}
				rt.pre_inc(var_i)
			}
			mut var_status := rt.call_method(this.features, 'get_primary_item_features', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_status, rt.get_constant('NOT_FOUND'))))) {
				return var_status.clone()
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(skip(this.handle, rt.sub(var_box.content_size, var_num_read_bytes)))))) {
				return rt.get_constant('TRUNCATED')
			}
		} else {
			if rt.is_true(rt.new_bool(!(rt.is_true(skip(this.handle, var_box.content_size))))) {
				return rt.get_constant('TRUNCATED')
			}
		}
		var_num_remaining_bytes = rt.sub(var_num_remaining_bytes, var_box.size)
	}
	return rt.get_constant('NOT_FOUND')
}

fn (mut this Class_Avifinfo_Parser) parse_meta(var_num_remaining_bytes rt.PhpVal) rt.PhpVal {
	for {
		mut var_box := create_avifinfo_box()
		mut var_status := var_box.parse(this.handle, this.num_parsed_boxes, var_num_remaining_bytes.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_status, rt.get_constant('FOUND'))))) {
			return var_status.clone()
		}
		if rt.is_true(rt.equal(var_box.prop_type, rt.new_string('pitm'))) {
			mut var_num_bytes_per_id := rt.new_int(if var_box.version == 0 { 2 } else { 4 })
			if rt.is_true(rt.greater(var_num_bytes_per_id, var_num_remaining_bytes)) {
				return rt.get_constant('INVALID')
			}
			mut var_data := read(this.handle, var_num_bytes_per_id.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
				return rt.get_constant('TRUNCATED')
			}
			mut var_primary_item_id := rt.new_int(read_big_endian(var_data.clone(), var_num_bytes_per_id.clone()))
			if rt.is_true(rt.greater(var_primary_item_id, rt.get_constant('MAX_VALUE'))) {
				return rt.get_constant('ABORTED')
			}
			rt.set_property(this.features, 'has_primary_item', rt.new_bool(true))
			rt.set_property(this.features, 'primary_item_id', var_primary_item_id.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(skip(this.handle, rt.sub(var_box.content_size, var_num_bytes_per_id)))))) {
				return rt.get_constant('TRUNCATED')
			}
		} else {
			if rt.is_true(rt.equal(var_box.prop_type, rt.new_string('iprp'))) {
				var_status = this.parse_iprp(var_box.content_size)
				if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_status, rt.get_constant('NOT_FOUND'))))) {
					return var_status.clone()
				}
			} else {
				if rt.is_true(rt.equal(var_box.prop_type, rt.new_string('iref'))) {
					var_status = this.parse_iref(var_box.content_size)
					if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_status, rt.get_constant('NOT_FOUND'))))) {
						return var_status.clone()
					}
				} else {
					if rt.is_true(rt.new_bool(!(rt.is_true(skip(this.handle, var_box.content_size))))) {
						return rt.get_constant('TRUNCATED')
					}
				}
			}
		}
		var_num_remaining_bytes = rt.sub(var_num_remaining_bytes, var_box.size)
		if !(rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_num_remaining_bytes, rt.new_int(0)))))) {
			break
		}
	}
	return rt.get_constant('INVALID')
}

fn (mut this Class_Avifinfo_Parser) parse_ftyp() bool {
	mut var_box := create_avifinfo_box()
	mut var_status := var_box.parse(this.handle, this.num_parsed_boxes, rt.new_null())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_status, rt.get_constant('FOUND'))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_box.prop_type, rt.new_string('ftyp'))))) {
		return false
	}
	if rt.is_true(rt.less(var_box.content_size, rt.new_int(8))) {
		return false
	}
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less_equal(rt.add(var_i, rt.new_int(4)), var_box.content_size))) { break }
		mut var_data := read(this.handle, rt.new_int(4))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
			return false
		}
		if rt.is_true(rt.equal(var_i, rt.new_int(4))) {
			continue
		}
		if rt.is_true(rt.equal(rt.call_function('substr', [var_data.clone(), rt.new_int(0), rt.new_int(4)]), rt.new_string('avif'))) || rt.is_true(rt.equal(rt.call_function('substr', [var_data.clone(), rt.new_int(0), rt.new_int(4)]), rt.new_string('avis'))) {
			return (skip(this.handle, rt.sub(var_box.content_size, rt.add(var_i, rt.new_int(4))))).to_bool()
		}
		if rt.is_true(rt.greater(var_i, 32 * 4)) {
			return false
		}
		var_i = rt.add(var_i, rt.new_int(4))
	}
	return false
	return false
}

fn (mut this Class_Avifinfo_Parser) parse_file() bool {
	mut var_box := create_avifinfo_box()
	for rt.is_true(rt.equal(var_box.parse(this.handle, this.num_parsed_boxes, rt.new_null()), rt.get_constant('FOUND'))) {
		if rt.is_true(rt.identical(var_box.prop_type, rt.new_string('meta'))) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(this.parse_meta(var_box.content_size), rt.get_constant('FOUND'))))) {
				return false
			}
			return true
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(skip(this.handle, var_box.content_size))))) {
			return false
		}
	}
	return false
	return false
}

fn create_avifinfo_tile(_args ...rt.PhpVal) &Class_Avifinfo_Tile {
	mut obj := &Class_Avifinfo_Tile{
		PhpObjectBase: rt.PhpObjectBase{}
		tile_item_id: rt.new_null()
		parent_item_id: rt.new_null()
	}
	return obj
}

fn create_avifinfo_prop(_args ...rt.PhpVal) &Class_Avifinfo_Prop {
	mut obj := &Class_Avifinfo_Prop{
		PhpObjectBase: rt.PhpObjectBase{}
		property_index: rt.new_null()
		item_id: rt.new_null()
	}
	return obj
}

fn create_avifinfo_dim_prop(_args ...rt.PhpVal) &Class_Avifinfo_Dim_Prop {
	mut obj := &Class_Avifinfo_Dim_Prop{
		PhpObjectBase: rt.PhpObjectBase{}
		property_index: rt.new_null()
		width: rt.new_null()
		height: rt.new_null()
	}
	return obj
}

fn create_avifinfo_chan_prop(_args ...rt.PhpVal) &Class_Avifinfo_Chan_Prop {
	mut obj := &Class_Avifinfo_Chan_Prop{
		PhpObjectBase: rt.PhpObjectBase{}
		property_index: rt.new_null()
		bit_depth: rt.new_null()
		num_channels: rt.new_null()
	}
	return obj
}

fn create_avifinfo_features(_args ...rt.PhpVal) &Class_Avifinfo_Features {
	mut obj := &Class_Avifinfo_Features{
		PhpObjectBase: rt.PhpObjectBase{}
		has_primary_item: rt.new_bool(false)
		has_alpha: rt.new_bool(false)
		primary_item_id: rt.new_null()
		primary_item_features: rt.new_array()
		tiles: rt.new_array()
		props: rt.new_array()
		dim_props: rt.new_array()
		chan_props: rt.new_array()
	}
	return obj
}

fn create_avifinfo_box(_args ...rt.PhpVal) &Class_Avifinfo_Box {
	mut obj := &Class_Avifinfo_Box{
		PhpObjectBase: rt.PhpObjectBase{}
		size: rt.new_null()
		prop_type: rt.new_null()
		version: i64(0)
		flags: i64(0)
		content_size: rt.new_null()
	}
	return obj
}

fn create_avifinfo_parser(arg_0 rt.PhpVal) &Class_Avifinfo_Parser {
	mut obj := &Class_Avifinfo_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
		handle: rt.new_null()
		num_parsed_boxes: rt.new_int(0)
		data_was_skipped: false
		features: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Avifinfo_Tile) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Avifinfo_Tile) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tile_item_id' { return this.tile_item_id }
		'parent_item_id' { return this.parent_item_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Avifinfo_Tile) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tile_item_id' { this.tile_item_id = val; return true }
		'parent_item_id' { this.parent_item_id = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Avifinfo_Prop) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Avifinfo_Prop) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'property_index' { return this.property_index }
		'item_id' { return this.item_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Avifinfo_Prop) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'property_index' { this.property_index = val; return true }
		'item_id' { this.item_id = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Avifinfo_Dim_Prop) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Avifinfo_Dim_Prop) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'property_index' { return this.property_index }
		'width' { return this.width }
		'height' { return this.height }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Avifinfo_Dim_Prop) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'property_index' { this.property_index = val; return true }
		'width' { this.width = val; return true }
		'height' { this.height = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Avifinfo_Chan_Prop) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Avifinfo_Chan_Prop) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'property_index' { return this.property_index }
		'bit_depth' { return this.bit_depth }
		'num_channels' { return this.num_channels }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Avifinfo_Chan_Prop) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'property_index' { this.property_index = val; return true }
		'bit_depth' { this.bit_depth = val; return true }
		'num_channels' { this.num_channels = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Avifinfo_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_features' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_item_features(dispatch_arg_0, dispatch_arg_1)
		}
		'get_primary_item_features' {
			return this.get_primary_item_features()
		}
		else { return none }
	}
}

fn (this &Class_Avifinfo_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'has_primary_item' { return this.has_primary_item }
		'has_alpha' { return this.has_alpha }
		'primary_item_id' { return this.primary_item_id }
		'primary_item_features' { return this.primary_item_features }
		'tiles' { return this.tiles }
		'props' { return this.props }
		'dim_props' { return this.dim_props }
		'chan_props' { return this.chan_props }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Avifinfo_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'has_primary_item' { this.has_primary_item = val; return true }
		'has_alpha' { this.has_alpha = val; return true }
		'primary_item_id' { this.primary_item_id = val; return true }
		'primary_item_features' { this.primary_item_features = val; return true }
		'tiles' { this.tiles = val; return true }
		'props' { this.props = val; return true }
		'dim_props' { this.dim_props = val; return true }
		'chan_props' { this.chan_props = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Avifinfo_Box) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'parse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.parse(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Avifinfo_Box) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'size' { return this.size }
		'type' { return this.prop_type }
		'version' { return rt.new_int(this.version) }
		'flags' { return rt.new_int(this.flags) }
		'content_size' { return this.content_size }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Avifinfo_Box) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'size' { this.size = val; return true }
		'type' { this.prop_type = val; return true }
		'version' { this.version = (val).to_i64(); return true }
		'flags' { this.flags = (val).to_i64(); return true }
		'content_size' { this.content_size = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Avifinfo_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'parse_ipco' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_ipco(dispatch_arg_0)
		}
		'parse_iprp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_iprp(dispatch_arg_0)
		}
		'parse_iref' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_iref(dispatch_arg_0)
		}
		'parse_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_meta(dispatch_arg_0)
		}
		'parse_ftyp' {
			return rt.new_bool(this.parse_ftyp())
		}
		'parse_file' {
			return rt.new_bool(this.parse_file())
		}
		else { return none }
	}
}

fn (this &Class_Avifinfo_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'handle' { return this.handle }
		'num_parsed_boxes' { return this.num_parsed_boxes }
		'data_was_skipped' { return rt.new_bool(this.data_was_skipped) }
		'features' { return this.features }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Avifinfo_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'handle' { this.handle = val; return true }
		'num_parsed_boxes' { this.num_parsed_boxes = val; return true }
		'data_was_skipped' { this.data_was_skipped = (val).to_bool(); return true }
		'features' { this.features = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

}
