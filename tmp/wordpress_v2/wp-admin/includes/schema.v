import rt
import crypto.md5

var_charset_collate = rt.call_method(var_wpdb, 'get_charset_collate', []rt.PhpVal{})
fn wp_get_db_schema(scope string, var_blog_id rt.PhpVal) rt.PhpVal {
	mut var_scope := scope
	mut var_wpdb := rt.new_null()
	mut var_charset_collate := rt.new_null()
	mut var_old_blog_id := rt.new_null()
	mut var_is_multisite := false
	mut var_max_index_length := i64(0)
	mut var_blog_tables := ''
	mut var_users_single_table := ''
	mut var_users_multi_table := ''
	mut var_usermeta_table := ''
	mut var_global_tables := rt.new_null()
	mut var_ms_global_tables := ''
	mut var_queries := rt.new_null()
	var_charset_collate = rt.call_method(var_wpdb, 'get_charset_collate', []rt.PhpVal{})
	if rt.is_true(var_blog_id)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(var_blog_id.to_i64()), rt.get_property(var_wpdb, 'blogid'))))) {
		var_old_blog_id = rt.call_method(var_wpdb, 'set_blog_id', [
			var_blog_id.clone()])
	}
	var_is_multisite = rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('defined', [rt.new_string('WP_INSTALLING_NETWORK')]))
		&& rt.is_true(rt.get_constant('WP_INSTALLING_NETWORK'))
	var_max_index_length = 191
	var_blog_tables = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CREATE TABLE '), rt.get_property(var_wpdb,
		'termmeta')),
		rt.new_string(" (\n\tmeta_id bigint(20) unsigned NOT NULL auto_increment,\n\tterm_id bigint(20) unsigned NOT NULL default '0',\n\tmeta_key varchar(255) default NULL,\n\tmeta_value longtext,\n\tPRIMARY KEY  (meta_id),\n\tKEY term_id (term_id),\n\tKEY meta_key (meta_key(")),
		rt.new_int(var_max_index_length)), rt.new_string('))\n) ')), var_charset_collate),
		rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'terms')),
		rt.new_string(" (\n term_id bigint(20) unsigned NOT NULL auto_increment,\n name varchar(200) NOT NULL default '',\n slug varchar(200) NOT NULL default '',\n term_group bigint(10) NOT NULL default 0,\n PRIMARY KEY  (term_id),\n KEY slug (slug(")),
		rt.new_int(var_max_index_length)), rt.new_string(')),\n KEY name (name(')),
		rt.new_int(var_max_index_length)), rt.new_string('))\n) ')), var_charset_collate),
		rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'term_taxonomy')),
		rt.new_string(" (\n term_taxonomy_id bigint(20) unsigned NOT NULL auto_increment,\n term_id bigint(20) unsigned NOT NULL default 0,\n taxonomy varchar(32) NOT NULL default '',\n description longtext NOT NULL,\n parent bigint(20) unsigned NOT NULL default 0,\n count bigint(20) NOT NULL default 0,\n PRIMARY KEY  (term_taxonomy_id),\n UNIQUE KEY term_id_taxonomy (term_id,taxonomy),\n KEY taxonomy (taxonomy)\n) ")),
		var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb,
		'term_relationships')),
		rt.new_string(' (\n object_id bigint(20) unsigned NOT NULL default 0,\n term_taxonomy_id bigint(20) unsigned NOT NULL default 0,\n term_order int(11) NOT NULL default 0,\n PRIMARY KEY  (object_id,term_taxonomy_id),\n KEY term_taxonomy_id (term_taxonomy_id)\n) ')),
		var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb,
		'commentmeta')),
		rt.new_string(" (\n\tmeta_id bigint(20) unsigned NOT NULL auto_increment,\n\tcomment_id bigint(20) unsigned NOT NULL default '0',\n\tmeta_key varchar(255) default NULL,\n\tmeta_value longtext,\n\tPRIMARY KEY  (meta_id),\n\tKEY comment_id (comment_id),\n\tKEY meta_key (meta_key(")),
		rt.new_int(var_max_index_length)), rt.new_string('))\n) ')), var_charset_collate),
		rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'comments')),
		rt.new_string(" (\n\tcomment_ID bigint(20) unsigned NOT NULL auto_increment,\n\tcomment_post_ID bigint(20) unsigned NOT NULL default '0',\n\tcomment_author tinytext NOT NULL,\n\tcomment_author_email varchar(100) NOT NULL default '',\n\tcomment_author_url varchar(200) NOT NULL default '',\n\tcomment_author_IP varchar(100) NOT NULL default '',\n\tcomment_date datetime NOT NULL default '0000-00-00 00:00:00',\n\tcomment_date_gmt datetime NOT NULL default '0000-00-00 00:00:00',\n\tcomment_content text NOT NULL,\n\tcomment_karma int(11) NOT NULL default '0',\n\tcomment_approved varchar(20) NOT NULL default '1',\n\tcomment_agent varchar(255) NOT NULL default '',\n\tcomment_type varchar(20) NOT NULL default 'comment',\n\tcomment_parent bigint(20) unsigned NOT NULL default '0',\n\tuser_id bigint(20) unsigned NOT NULL default '0',\n\tPRIMARY KEY  (comment_ID),\n\tKEY comment_post_ID (comment_post_ID),\n\tKEY comment_approved_date_gmt (comment_approved,comment_date_gmt),\n\tKEY comment_date_gmt (comment_date_gmt),\n\tKEY comment_parent (comment_parent),\n\tKEY comment_author_email (comment_author_email(10))\n) ")),
		var_charset_collate), rt.new_string(';\nCREATE TABLE ')),
		rt.get_property(var_wpdb, 'links')),
		rt.new_string(" (\n\tlink_id bigint(20) unsigned NOT NULL auto_increment,\n\tlink_url varchar(255) NOT NULL default '',\n\tlink_name varchar(255) NOT NULL default '',\n\tlink_image varchar(255) NOT NULL default '',\n\tlink_target varchar(25) NOT NULL default '',\n\tlink_description varchar(255) NOT NULL default '',\n\tlink_visible varchar(20) NOT NULL default 'Y',\n\tlink_owner bigint(20) unsigned NOT NULL default '1',\n\tlink_rating int(11) NOT NULL default '0',\n\tlink_updated datetime NOT NULL default '0000-00-00 00:00:00',\n\tlink_rel varchar(255) NOT NULL default '',\n\tlink_notes mediumtext NOT NULL,\n\tlink_rss varchar(255) NOT NULL default '',\n\tPRIMARY KEY  (link_id),\n\tKEY link_visible (link_visible)\n) ")),
		var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb,
		'options')),
		rt.new_string(" (\n\toption_id bigint(20) unsigned NOT NULL auto_increment,\n\toption_name varchar(191) NOT NULL default '',\n\toption_value longtext NOT NULL,\n\tautoload varchar(20) NOT NULL default 'yes',\n\tPRIMARY KEY  (option_id),\n\tUNIQUE KEY option_name (option_name),\n\tKEY autoload (autoload)\n) ")),
		var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb,
		'postmeta')),
		rt.new_string(" (\n\tmeta_id bigint(20) unsigned NOT NULL auto_increment,\n\tpost_id bigint(20) unsigned NOT NULL default '0',\n\tmeta_key varchar(255) default NULL,\n\tmeta_value longtext,\n\tPRIMARY KEY  (meta_id),\n\tKEY post_id (post_id),\n\tKEY meta_key (meta_key(")),
		rt.new_int(var_max_index_length)), rt.new_string('))\n) ')), var_charset_collate),
		rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'posts')),
		rt.new_string(" (\n\tID bigint(20) unsigned NOT NULL auto_increment,\n\tpost_author bigint(20) unsigned NOT NULL default '0',\n\tpost_date datetime NOT NULL default '0000-00-00 00:00:00',\n\tpost_date_gmt datetime NOT NULL default '0000-00-00 00:00:00',\n\tpost_content longtext NOT NULL,\n\tpost_title text NOT NULL,\n\tpost_excerpt text NOT NULL,\n\tpost_status varchar(20) NOT NULL default 'publish',\n\tcomment_status varchar(20) NOT NULL default 'open',\n\tping_status varchar(20) NOT NULL default 'open',\n\tpost_password varchar(255) NOT NULL default '',\n\tpost_name varchar(200) NOT NULL default '',\n\tto_ping text NOT NULL,\n\tpinged text NOT NULL,\n\tpost_modified datetime NOT NULL default '0000-00-00 00:00:00',\n\tpost_modified_gmt datetime NOT NULL default '0000-00-00 00:00:00',\n\tpost_content_filtered longtext NOT NULL,\n\tpost_parent bigint(20) unsigned NOT NULL default '0',\n\tguid varchar(255) NOT NULL default '',\n\tmenu_order int(11) NOT NULL default '0',\n\tpost_type varchar(20) NOT NULL default 'post',\n\tpost_mime_type varchar(100) NOT NULL default '',\n\tcomment_count bigint(20) NOT NULL default '0',\n\tPRIMARY KEY  (ID),\n\tKEY post_name (post_name(")),
		rt.new_int(var_max_index_length)),
		rt.new_string(')),\n\tKEY type_status_date (post_type,post_status,post_date,ID),\n\tKEY post_parent (post_parent),\n\tKEY post_author (post_author),\n\tKEY type_status_author (post_type,post_status,post_author)\n) ')),
		var_charset_collate), rt.new_string(';\n'))
	var_users_single_table = rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CREATE TABLE '), rt.get_property(var_wpdb,
		'users')),
		rt.new_string(" (\n\tID bigint(20) unsigned NOT NULL auto_increment,\n\tuser_login varchar(60) NOT NULL default '',\n\tuser_pass varchar(255) NOT NULL default '',\n\tuser_nicename varchar(50) NOT NULL default '',\n\tuser_email varchar(100) NOT NULL default '',\n\tuser_url varchar(100) NOT NULL default '',\n\tuser_registered datetime NOT NULL default '0000-00-00 00:00:00',\n\tuser_activation_key varchar(255) NOT NULL default '',\n\tuser_status int(11) NOT NULL default '0',\n\tdisplay_name varchar(250) NOT NULL default '',\n\tPRIMARY KEY  (ID),\n\tKEY user_login_key (user_login),\n\tKEY user_nicename (user_nicename),\n\tKEY user_email (user_email)\n) ")),
		var_charset_collate), rt.new_string(';\n'))
	var_users_multi_table = rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CREATE TABLE '), rt.get_property(var_wpdb,
		'users')),
		rt.new_string(" (\n\tID bigint(20) unsigned NOT NULL auto_increment,\n\tuser_login varchar(60) NOT NULL default '',\n\tuser_pass varchar(255) NOT NULL default '',\n\tuser_nicename varchar(50) NOT NULL default '',\n\tuser_email varchar(100) NOT NULL default '',\n\tuser_url varchar(100) NOT NULL default '',\n\tuser_registered datetime NOT NULL default '0000-00-00 00:00:00',\n\tuser_activation_key varchar(255) NOT NULL default '',\n\tuser_status int(11) NOT NULL default '0',\n\tdisplay_name varchar(250) NOT NULL default '',\n\tspam tinyint(2) NOT NULL default '0',\n\tdeleted tinyint(2) NOT NULL default '0',\n\tPRIMARY KEY  (ID),\n\tKEY user_login_key (user_login),\n\tKEY user_nicename (user_nicename),\n\tKEY user_email (user_email)\n) ")),
		var_charset_collate), rt.new_string(';\n'))
	var_usermeta_table = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CREATE TABLE '), rt.get_property(var_wpdb,
		'usermeta')),
		rt.new_string(" (\n\tumeta_id bigint(20) unsigned NOT NULL auto_increment,\n\tuser_id bigint(20) unsigned NOT NULL default '0',\n\tmeta_key varchar(255) default NULL,\n\tmeta_value longtext,\n\tPRIMARY KEY  (umeta_id),\n\tKEY user_id (user_id),\n\tKEY meta_key (meta_key(")),
		rt.new_int(var_max_index_length)), rt.new_string('))\n) ')), var_charset_collate),
		rt.new_string(';\n'))
	if var_is_multisite {
		var_global_tables = rt.new_string((var_users_multi_table + var_usermeta_table).str())
	} else {
		var_global_tables = rt.new_string((var_users_single_table + var_usermeta_table).str())
	}
	var_ms_global_tables = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CREATE TABLE '), rt.get_property(var_wpdb,
		'blogs')),
		rt.new_string(" (\n\tblog_id bigint(20) unsigned NOT NULL auto_increment,\n\tsite_id bigint(20) unsigned NOT NULL default '0',\n\tdomain varchar(200) NOT NULL default '',\n\tpath varchar(100) NOT NULL default '',\n\tregistered datetime NOT NULL default '0000-00-00 00:00:00',\n\tlast_updated datetime NOT NULL default '0000-00-00 00:00:00',\n\tpublic tinyint(2) NOT NULL default '1',\n\tarchived tinyint(2) NOT NULL default '0',\n\tmature tinyint(2) NOT NULL default '0',\n\tspam tinyint(2) NOT NULL default '0',\n\tdeleted tinyint(2) NOT NULL default '0',\n\tlang_id int(11) NOT NULL default '0',\n\tPRIMARY KEY  (blog_id),\n\tKEY domain (domain(50),path(5)),\n\tKEY lang_id (lang_id)\n) ")),
		var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb,
		'blogmeta')),
		rt.new_string(" (\n\tmeta_id bigint(20) unsigned NOT NULL auto_increment,\n\tblog_id bigint(20) unsigned NOT NULL default '0',\n\tmeta_key varchar(255) default NULL,\n\tmeta_value longtext,\n\tPRIMARY KEY  (meta_id),\n\tKEY meta_key (meta_key(")),
		rt.new_int(var_max_index_length)), rt.new_string(')),\n\tKEY blog_id (blog_id)\n) ')),
		var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb,
		'registration_log')),
		rt.new_string(" (\n\tID bigint(20) unsigned NOT NULL auto_increment,\n\temail varchar(255) NOT NULL default '',\n\tIP varchar(30) NOT NULL default '',\n\tblog_id bigint(20) unsigned NOT NULL default '0',\n\tdate_registered datetime NOT NULL default '0000-00-00 00:00:00',\n\tPRIMARY KEY  (ID),\n\tKEY IP (IP)\n) ")),
		var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'site')),
		rt.new_string(" (\n\tid bigint(20) unsigned NOT NULL auto_increment,\n\tdomain varchar(200) NOT NULL default '',\n\tpath varchar(100) NOT NULL default '',\n\tPRIMARY KEY  (id),\n\tKEY domain (domain(140),path(51))\n) ")),
		var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb,
		'sitemeta')),
		rt.new_string(" (\n\tmeta_id bigint(20) unsigned NOT NULL auto_increment,\n\tsite_id bigint(20) unsigned NOT NULL default '0',\n\tmeta_key varchar(255) default NULL,\n\tmeta_value longtext,\n\tPRIMARY KEY  (meta_id),\n\tKEY meta_key (meta_key(")),
		rt.new_int(var_max_index_length)), rt.new_string(')),\n\tKEY site_id (site_id)\n) ')),
		var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb,
		'signups')),
		rt.new_string(" (\n\tsignup_id bigint(20) unsigned NOT NULL auto_increment,\n\tdomain varchar(200) NOT NULL default '',\n\tpath varchar(100) NOT NULL default '',\n\ttitle longtext NOT NULL,\n\tuser_login varchar(60) NOT NULL default '',\n\tuser_email varchar(100) NOT NULL default '',\n\tregistered datetime NOT NULL default '0000-00-00 00:00:00',\n\tactivated datetime NOT NULL default '0000-00-00 00:00:00',\n\tactive tinyint(1) NOT NULL default '0',\n\tactivation_key varchar(50) NOT NULL default '',\n\tmeta longtext,\n\tPRIMARY KEY  (signup_id),\n\tKEY activation_key (activation_key),\n\tKEY user_email (user_email),\n\tKEY user_login_email (user_login,user_email),\n\tKEY domain_path (domain(140),path(51))\n) ")),
		var_charset_collate), rt.new_string(';'))
	mut switch_val_1 := rt.new_string(scope)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('blog'))) {
		var_queries = rt.new_string(var_blog_tables.str()).clone()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('global'))) {
		var_queries = var_global_tables.clone()
		if var_is_multisite {
			var_queries = rt.concat(var_queries, rt.new_string(var_ms_global_tables.str()))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('ms_global'))) {
		var_queries = rt.new_string(var_ms_global_tables.str()).clone()
	} else {
		var_queries = rt.new_string(var_global_tables.str() + var_blog_tables)
		if var_is_multisite {
			var_queries = rt.concat(var_queries, rt.new_string(var_ms_global_tables.str()))
		}
	}
	if !var_old_blog_id.is_null() {
		rt.call_method(var_wpdb, 'set_blog_id', [var_old_blog_id.clone()])
	}
	return var_queries.clone()
}

var_wp_queries = wp_get_db_schema('all', rt.new_null())
fn populate_options(var_options_arg rt.PhpVal) {
	mut var_options := var_options_arg
	mut var_wpdb := rt.new_null()
	mut var_wp_db_version := rt.new_null()
	mut var_wp_current_db_version := rt.new_null()
	mut var_guessurl := rt.new_null()
	mut var_stylesheet := rt.new_null()
	mut var_template := rt.new_null()
	mut var_theme := rt.new_null()
	mut var_timezone_string := rt.new_null()
	mut var_gmt_offset := rt.new_null()
	mut var_offset_or_tz := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_fat_options := []rt.PhpVal{}
	mut var_keys := rt.new_null()
	mut var_existing_options := rt.new_null()
	mut var_insert := ''
	mut var_value := rt.new_null()
	mut var_option := rt.new_null()
	mut var_autoload := ''
	mut var_unusedoptions := []rt.PhpVal{}
	var_guessurl = rt.call_function('wp_guess_url', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('populate_options')])
	var_stylesheet = rt.get_constant('WP_DEFAULT_THEME')
	var_template = rt.get_constant('WP_DEFAULT_THEME')
	var_theme = rt.call_function('wp_get_theme', [rt.get_constant('WP_DEFAULT_THEME')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{}))))) {
		mut iife_temp_0 := Class_WP_Theme{}
		mut iife_result_0 := iife_temp_0.get_core_default_theme()
		var_theme = iife_result_0
	}
	if rt.is_true(var_theme) {
		var_stylesheet = rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{})
		var_template = rt.call_method(var_theme, 'get_template', []rt.PhpVal{})
	}
	var_timezone_string = rt.new_string('')
	var_gmt_offset = rt.new_int(0)
	var_offset_or_tz = rt.call_function('_x', [rt.new_string('0'),
		rt.new_string('default GMT offset or timezone string')])
	if rt.is_true(rt.new_bool(var_offset_or_tz.clone().is_long()
		|| var_offset_or_tz.clone().is_double()))
	{
		var_gmt_offset = var_offset_or_tz.clone()
	} else if rt.is_true(var_offset_or_tz)
		&& rt.is_true(rt.call_function('in_array', [var_offset_or_tz.clone(), rt.call_function('timezone_identifiers_list', [Class_DateTimeZone.all_with_bc()]), rt.new_bool(true)])) {
		var_timezone_string = var_offset_or_tz.clone()
	}
	var_defaults = {
		'siteurl':                         var_guessurl
		'home':                            var_guessurl
		'blogname':                        rt.call_function('__', [
			rt.new_string('My Site'),
		])
		'blogdescription':                 rt.new_string('')
		'users_can_register':              rt.new_int(0)
		'admin_email':                     rt.new_string('you@example.com')
		'start_of_week':                   rt.call_function('_x', [
			rt.new_string('1'), rt.new_string('start of week')])
		'use_balanceTags':                 rt.new_int(0)
		'use_smilies':                     rt.new_int(1)
		'require_name_email':              rt.new_int(1)
		'comments_notify':                 rt.new_int(1)
		'posts_per_rss':                   rt.new_int(10)
		'rss_use_excerpt':                 rt.new_int(0)
		'mailserver_url':                  rt.new_string('mail.example.com')
		'mailserver_login':                rt.new_string('login@example.com')
		'mailserver_pass':                 rt.new_string('')
		'mailserver_port':                 rt.new_int(110)
		'default_category':                rt.new_int(1)
		'default_comment_status':          rt.new_string('open')
		'default_ping_status':             rt.new_string('open')
		'default_pingback_flag':           rt.new_int(1)
		'posts_per_page':                  rt.new_int(10)
		'date_format':                     rt.call_function('__', [
			rt.new_string('F j, Y'),
		])
		'time_format':                     rt.call_function('__', [
			rt.new_string('g:i a'),
		])
		'links_updated_date_format':       rt.call_function('__', [
			rt.new_string('F j, Y g:i a'),
		])
		'comment_moderation':              rt.new_int(0)
		'moderation_notify':               rt.new_int(1)
		'permalink_structure':             rt.new_string('')
		'rewrite_rules':                   rt.new_string('')
		'hack_file':                       rt.new_int(0)
		'blog_charset':                    rt.new_string('UTF-8')
		'moderation_keys':                 rt.new_string('')
		'active_plugins':                  map[string]rt.PhpVal{}
		'category_base':                   rt.new_string('')
		'ping_sites':                      rt.new_string('https://rpc.pingomatic.com/')
		'comment_max_links':               rt.new_int(2)
		'gmt_offset':                      var_gmt_offset
		'default_email_category':          rt.new_int(1)
		'recently_edited':                 rt.new_string('')
		'template':                        var_template
		'stylesheet':                      var_stylesheet
		'comment_registration':            rt.new_int(0)
		'html_type':                       rt.new_string('text/html')
		'use_trackback':                   rt.new_int(0)
		'default_role':                    rt.new_string('subscriber')
		'db_version':                      var_wp_db_version
		'uploads_use_yearmonth_folders':   rt.new_int(1)
		'upload_path':                     rt.new_string('')
		'blog_public':                     rt.new_string('1')
		'default_link_category':           rt.new_int(2)
		'show_on_front':                   rt.new_string('posts')
		'tag_base':                        rt.new_string('')
		'show_avatars':                    rt.new_string('1')
		'avatar_rating':                   rt.new_string('G')
		'upload_url_path':                 rt.new_string('')
		'thumbnail_size_w':                rt.new_int(150)
		'thumbnail_size_h':                rt.new_int(150)
		'thumbnail_crop':                  rt.new_int(1)
		'medium_size_w':                   rt.new_int(300)
		'medium_size_h':                   rt.new_int(300)
		'avatar_default':                  rt.new_string('mystery')
		'large_size_w':                    rt.new_int(1024)
		'large_size_h':                    rt.new_int(1024)
		'image_default_link_type':         rt.new_string('none')
		'image_default_size':              rt.new_string('')
		'image_default_align':             rt.new_string('')
		'close_comments_for_old_posts':    rt.new_int(0)
		'close_comments_days_old':         rt.new_int(14)
		'thread_comments':                 rt.new_int(1)
		'thread_comments_depth':           rt.new_int(5)
		'page_comments':                   rt.new_int(0)
		'comments_per_page':               rt.new_int(50)
		'default_comments_page':           rt.new_string('newest')
		'comment_order':                   rt.new_string('asc')
		'sticky_posts':                    map[string]rt.PhpVal{}
		'widget_categories':               map[string]rt.PhpVal{}
		'widget_text':                     map[string]rt.PhpVal{}
		'widget_rss':                      map[string]rt.PhpVal{}
		'uninstall_plugins':               map[string]rt.PhpVal{}
		'timezone_string':                 var_timezone_string
		'page_for_posts':                  rt.new_int(0)
		'page_on_front':                   rt.new_int(0)
		'default_post_format':             rt.new_int(0)
		'link_manager_enabled':            rt.new_int(0)
		'finished_splitting_shared_terms': rt.new_int(1)
		'site_icon':                       rt.new_int(0)
		'medium_large_size_w':             rt.new_int(768)
		'medium_large_size_h':             rt.new_int(0)
		'wp_page_for_privacy_policy':      rt.new_int(0)
		'show_comments_cookies_opt_in':    rt.new_int(1)
		'admin_email_lifespan':            rt.call_function('time', []rt.PhpVal{}) +
			6 * rt.get_constant('MONTH_IN_SECONDS')
		'disallowed_keys':                 rt.new_string('')
		'comment_previously_approved':     rt.new_int(1)
		'auto_plugin_theme_update_emails': map[string]rt.PhpVal{}
		'auto_update_core_dev':            rt.new_string('enabled')
		'auto_update_core_minor':          rt.new_string('enabled')
		'auto_update_core_major':          rt.new_string('enabled')
		'wp_force_deactivated_plugins':    map[string]rt.PhpVal{}
		'wp_attachment_pages_enabled':     rt.new_int(0)
		'wp_notes_notify':                 rt.new_int(1)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_defaults['initial_db_version'] = if !(!rt.is_true(var_wp_current_db_version))
			&& rt.is_true(rt.less(var_wp_current_db_version, var_wp_db_version)) {
			var_wp_current_db_version
		} else {
			var_wp_db_version
		}
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_defaults['permalink_structure'] = rt.new_string('/%year%/%monthnum%/%day%/%postname%/')
	}
	var_options = rt.call_function('wp_parse_args', [var_options.clone(),
		rt.create_array_from_native_map(var_defaults)])
	var_fat_options = ['moderation_keys', 'recently_edited', 'disallowed_keys', 'uninstall_plugins',
		'auto_plugin_theme_update_emails']
	var_keys = rt.new_string("'" +
		(rt.call_function('implode', [rt.new_string("', '"), rt.func_array_keys(var_options.clone())])).str() +
		"'")
	var_existing_options = rt.call_method(var_wpdb, 'get_col', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT option_name FROM '), rt.get_property(var_wpdb,
			'options')), rt.new_string(' WHERE option_name in ( ')), var_keys), rt.new_string(' )')),
	])
	var_insert = ''
	mut iter_1 := var_options.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value_shadow := item_1.val
		mut var_option_shadow := item_1.key
		if rt.is_true(rt.call_function('in_array', [var_option_shadow.clone(),
			var_existing_options.clone(), rt.new_bool(true)]))
		{
			continue
		}
		if rt.is_true(rt.call_function('in_array', [var_option_shadow.clone(),
			rt.create_array_from_list(var_fat_options), rt.new_bool(true)]))
		{
			var_autoload = 'off'
		} else {
			var_autoload = 'on'
		}
		if !(var_insert == '') {
			var_insert = var_insert + ', '
		}
		var_value_shadow = rt.call_function('maybe_serialize', [
			rt.call_function('sanitize_option', [var_option_shadow.clone(),
				var_value_shadow.clone()]),
		])
		var_insert = var_insert +(rt.call_method(var_wpdb, 'prepare', [rt.new_string('(%s, %s, %s)'), var_option_shadow.clone(), var_value_shadow.clone(), rt.new_string(var_autoload.str()).clone()])).str()
	}
	if !(var_insert == '') {
		rt.call_method(var_wpdb, 'query', [
			rt.new_string((
				rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb, 'options')), rt.new_string(' (option_name, option_value, autoload) VALUES ')) +
				var_insert).str()),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('__get_option', [
		rt.new_string('home'),
	])))))
	{
		rt.call_function('update_option', [rt.new_string('home'),
			var_guessurl.clone()])
	}
	var_unusedoptions = ['blodotgsping_url', 'bodyterminator', 'emailtestonly',
		'phoneemail_separator', 'smilies_directory', 'subjectprefix', 'use_bbcode',
		'use_blodotgsping', 'use_phoneemail', 'use_quicktags', 'use_weblogsping',
		'weblogs_cache_file', 'use_preview', 'use_htmltrans', 'smilies_directory',
		'fileupload_allowedusers', 'use_phoneemail', 'default_post_status', 'default_post_category',
		'archive_mode', 'time_difference', 'links_minadminlevel', 'links_use_adminlevels',
		'links_rating_type', 'links_rating_char', 'links_rating_ignore_zero',
		'links_rating_single_image', 'links_rating_image0', 'links_rating_image1',
		'links_rating_image2', 'links_rating_image3', 'links_rating_image4', 'links_rating_image5',
		'links_rating_image6', 'links_rating_image7', 'links_rating_image8', 'links_rating_image9',
		'links_recently_updated_time', 'links_recently_updated_prepend',
		'links_recently_updated_append', 'weblogs_cacheminutes', 'comment_allowed_tags',
		'search_engine_friendly_urls', 'default_geourl_lat', 'default_geourl_lon',
		'use_default_geourl', 'weblogs_xml_url', 'new_users_can_blog', '_wpnonce', '_wp_http_referer',
		'Update', 'action', 'rich_editing', 'autosave_interval', 'deactivated_plugins',
		'can_compress_scripts', 'page_uris', 'update_core', 'update_plugins', 'update_themes',
		'doing_cron', 'random_seed', 'rss_excerpt_length', 'secret', 'use_linksupdate',
		'default_comment_status_page', 'wporg_popular_tags', 'what_to_show', 'rss_language',
		'language', 'enable_xmlrpc', 'enable_app', 'embed_autourls', 'default_post_edit_rows',
		'gzipcompression', 'advanced_edit']
	for var_option_shadow in var_unusedoptions {
		rt.call_function('delete_option', [rt.new_string(var_option_shadow.str()).clone()])
	}
	rt.call_method(var_wpdb, 'query', [
		rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'options')),
			rt.new_string(" WHERE option_name REGEXP '^rss_[0-9a-f]{32}(_ts)?$'")),
	])
	rt.call_function('delete_expired_transients', [rt.new_bool(true)])
}

fn populate_roles() {
	mut var_wp_roles := rt.new_null()
	mut var_original_use_db := rt.new_null()
	var_wp_roles = rt.call_function('wp_roles', []rt.PhpVal{})
	var_original_use_db = rt.get_property(var_wp_roles, 'use_db')
	rt.set_property(var_wp_roles, 'use_db', rt.new_bool(false))
	populate_roles_160()
	populate_roles_210()
	populate_roles_230()
	populate_roles_250()
	populate_roles_260()
	populate_roles_270()
	populate_roles_280()
	populate_roles_300()
	if rt.is_true(var_original_use_db) {
		rt.call_function('update_option', [rt.get_property(var_wp_roles, 'role_key'),
			rt.get_property(var_wp_roles, 'roles'), rt.new_bool(true)])
	}
	rt.set_property(var_wp_roles, 'use_db', var_original_use_db.clone())
}

fn populate_roles_160() {
	mut var_role := rt.new_null()
	rt.call_function('add_role', [rt.new_string('administrator'),
		rt.new_string('Administrator')])
	rt.call_function('add_role', [rt.new_string('editor'), rt.new_string('Editor')])
	rt.call_function('add_role', [rt.new_string('author'), rt.new_string('Author')])
	rt.call_function('add_role', [rt.new_string('contributor'),
		rt.new_string('Contributor')])
	rt.call_function('add_role', [rt.new_string('subscriber'),
		rt.new_string('Subscriber')])
	var_role = rt.call_function('get_role', [rt.new_string('administrator')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('switch_themes')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('edit_themes')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('activate_plugins')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('edit_plugins')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('edit_users')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('edit_files')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('manage_options')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('moderate_comments')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('manage_categories')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('manage_links')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('upload_files')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('import')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('unfiltered_html')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('edit_posts')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('edit_others_posts')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('edit_published_posts')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('publish_posts')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('edit_pages')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('read')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_10')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_9')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_8')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_7')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_6')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_5')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_4')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_3')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_2')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_1')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_0')])
	var_role = rt.call_function('get_role', [rt.new_string('editor')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('moderate_comments')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('manage_categories')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('manage_links')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('upload_files')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('unfiltered_html')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('edit_posts')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('edit_others_posts')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('edit_published_posts')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('publish_posts')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('edit_pages')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('read')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_7')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_6')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_5')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_4')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_3')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_2')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_1')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_0')])
	var_role = rt.call_function('get_role', [rt.new_string('author')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('upload_files')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('edit_posts')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('edit_published_posts')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('publish_posts')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('read')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_2')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_1')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_0')])
	var_role = rt.call_function('get_role', [rt.new_string('contributor')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('edit_posts')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('read')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_1')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_0')])
	var_role = rt.call_function('get_role', [rt.new_string('subscriber')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('read')])
	rt.call_method(var_role, 'add_cap', [rt.new_string('level_0')])
}

fn populate_roles_210() {
	mut var_roles := []rt.PhpVal{}
	mut var_role := rt.new_null()
	var_roles = ['administrator', 'editor']
	for var_role_shadow in var_roles {
		var_role_shadow = (rt.call_function('get_role',
			[rt.new_string(var_role_shadow.str()).clone()])).str()
		if !rt.is_true(rt.new_string(var_role_shadow.str())) {
			continue
		}
		rt.call_method(rt.new_string(var_role_shadow.str()), 'add_cap', [
			rt.new_string('edit_others_pages'),
		])
		rt.call_method(rt.new_string(var_role_shadow.str()), 'add_cap', [
			rt.new_string('edit_published_pages'),
		])
		rt.call_method(rt.new_string(var_role_shadow.str()), 'add_cap', [
			rt.new_string('publish_pages'),
		])
		rt.call_method(rt.new_string(var_role_shadow.str()), 'add_cap', [
			rt.new_string('delete_pages'),
		])
		rt.call_method(rt.new_string(var_role_shadow.str()), 'add_cap', [
			rt.new_string('delete_others_pages'),
		])
		rt.call_method(rt.new_string(var_role_shadow.str()), 'add_cap', [
			rt.new_string('delete_published_pages'),
		])
		rt.call_method(rt.new_string(var_role_shadow.str()), 'add_cap', [
			rt.new_string('delete_posts'),
		])
		rt.call_method(rt.new_string(var_role_shadow.str()), 'add_cap', [
			rt.new_string('delete_others_posts'),
		])
		rt.call_method(rt.new_string(var_role_shadow.str()), 'add_cap', [
			rt.new_string('delete_published_posts'),
		])
		rt.call_method(rt.new_string(var_role_shadow.str()), 'add_cap', [
			rt.new_string('delete_private_posts'),
		])
		rt.call_method(rt.new_string(var_role_shadow.str()), 'add_cap', [
			rt.new_string('edit_private_posts'),
		])
		rt.call_method(rt.new_string(var_role_shadow.str()), 'add_cap', [
			rt.new_string('read_private_posts'),
		])
		rt.call_method(rt.new_string(var_role_shadow.str()), 'add_cap', [
			rt.new_string('delete_private_pages'),
		])
		rt.call_method(rt.new_string(var_role_shadow.str()), 'add_cap', [
			rt.new_string('edit_private_pages'),
		])
		rt.call_method(rt.new_string(var_role_shadow.str()), 'add_cap', [
			rt.new_string('read_private_pages'),
		])
	}
	var_role = rt.call_function('get_role', [rt.new_string('administrator')])
	if !(!rt.is_true(var_role)) {
		rt.call_method(var_role, 'add_cap', [rt.new_string('delete_users')])
		rt.call_method(var_role, 'add_cap', [rt.new_string('create_users')])
	}
	var_role = rt.call_function('get_role', [rt.new_string('author')])
	if !(!rt.is_true(var_role)) {
		rt.call_method(var_role, 'add_cap', [rt.new_string('delete_posts')])
		rt.call_method(var_role, 'add_cap', [rt.new_string('delete_published_posts')])
	}
	var_role = rt.call_function('get_role', [rt.new_string('contributor')])
	if !(!rt.is_true(var_role)) {
		rt.call_method(var_role, 'add_cap', [rt.new_string('delete_posts')])
	}
}

fn populate_roles_230() {
	mut var_role := rt.new_null()
	var_role = rt.call_function('get_role', [rt.new_string('administrator')])
	if !(!rt.is_true(var_role)) {
		rt.call_method(var_role, 'add_cap', [rt.new_string('unfiltered_upload')])
	}
}

fn populate_roles_250() {
	mut var_role := rt.new_null()
	var_role = rt.call_function('get_role', [rt.new_string('administrator')])
	if !(!rt.is_true(var_role)) {
		rt.call_method(var_role, 'add_cap', [rt.new_string('edit_dashboard')])
	}
}

fn populate_roles_260() {
	mut var_role := rt.new_null()
	var_role = rt.call_function('get_role', [rt.new_string('administrator')])
	if !(!rt.is_true(var_role)) {
		rt.call_method(var_role, 'add_cap', [rt.new_string('update_plugins')])
		rt.call_method(var_role, 'add_cap', [rt.new_string('delete_plugins')])
	}
}

fn populate_roles_270() {
	mut var_role := rt.new_null()
	var_role = rt.call_function('get_role', [rt.new_string('administrator')])
	if !(!rt.is_true(var_role)) {
		rt.call_method(var_role, 'add_cap', [rt.new_string('install_plugins')])
		rt.call_method(var_role, 'add_cap', [rt.new_string('update_themes')])
	}
}

fn populate_roles_280() {
	mut var_role := rt.new_null()
	var_role = rt.call_function('get_role', [rt.new_string('administrator')])
	if !(!rt.is_true(var_role)) {
		rt.call_method(var_role, 'add_cap', [rt.new_string('install_themes')])
	}
}

fn populate_roles_300() {
	mut var_role := rt.new_null()
	var_role = rt.call_function('get_role', [rt.new_string('administrator')])
	if !(!rt.is_true(var_role)) {
		rt.call_method(var_role, 'add_cap', [rt.new_string('update_core')])
		rt.call_method(var_role, 'add_cap', [rt.new_string('list_users')])
		rt.call_method(var_role, 'add_cap', [rt.new_string('remove_users')])
		rt.call_method(var_role, 'add_cap', [rt.new_string('promote_users')])
		rt.call_method(var_role, 'add_cap', [rt.new_string('edit_theme_options')])
		rt.call_method(var_role, 'add_cap', [rt.new_string('delete_themes')])
		rt.call_method(var_role, 'add_cap', [rt.new_string('export')])
	}
}

fn install_network() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_INSTALLING_NETWORK'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_INSTALLING_NETWORK'),
			rt.new_bool(true)])
	}
	rt.call_function('dbDelta', [wp_get_db_schema('global', rt.new_null())])
}

fn populate_network(network_id i64, domain string, email string, site_name string, path string, subdomain_install bool) rt.PhpVal {
	mut var_network_id := network_id
	mut var_domain := domain
	mut var_email := email
	mut var_site_name := site_name
	mut var_path := path
	mut var_subdomain_install := subdomain_install
	mut var_wpdb := rt.new_null()
	mut var_wp_rewrite := rt.new_null()
	mut var_errors := rt.new_null()
	mut var_current_site := rt.new_null()
	mut var_site_user_id := rt.new_null()
	mut var_vhost_ok := false
	mut var_errstr := rt.new_null()
	mut var_hostname := rt.new_null()
	mut var_page := rt.new_null()
	mut var_msg := rt.new_null()
	var_network_id = var_network_id
	rt.call_function('do_action', [rt.new_string('before_populate_network'),
		rt.new_int(var_network_id), rt.new_string(domain), rt.new_string(email),
		rt.new_string(site_name), rt.new_string(path), rt.new_bool(subdomain_install)])
	var_errors = create_wp_error()
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(domain))) {
		var_errors.add(rt.new_string('empty_domain'), rt.call_function('__', [
			rt.new_string('You must provide a domain name.'),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(site_name))) {
		var_errors.add(rt.new_string('empty_sitename'), rt.call_function('__', [
			rt.new_string('You must provide a name for your network of sites.'),
		]))
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		if rt.is_true(rt.call_function('get_network', [rt.new_int(var_network_id)])) {
			var_errors.add(rt.new_string('siteid_exists'), rt.call_function('__', [
				rt.new_string('The network already exists.'),
			]))
		}
	} else {
		if var_network_id == rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT id FROM '), rt.get_property(var_wpdb,
					'site')), rt.new_string(' WHERE id = %d')),
				rt.new_int(var_network_id),
			]),
		])).to_i64()) {
			var_errors.add(rt.new_string('siteid_exists'), rt.call_function('__', [
				rt.new_string('The network already exists.'),
			]))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
		rt.new_string(email),
	])))))
	{
		var_errors.add(rt.new_string('invalid_email'), rt.call_function('__', [
			rt.new_string('You must provide a valid email address.'),
		]))
	}
	if rt.is_true(var_errors.has_errors()) {
		return rt.new_object('WP_Error', []string{}, var_errors)
	}
	if 1 == var_network_id {
		rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'site'),
			rt.create_array([rt.ArrayItem{ key: 'domain', val: domain },
				rt.ArrayItem{ key: 'path', val: path }])])
		var_network_id = (rt.get_property(var_wpdb, 'insert_id')).to_i64()
	} else {
		rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'site'),
			rt.create_array([rt.ArrayItem{ key: 'domain', val: domain },
				rt.ArrayItem{ key: 'path', val: path }, rt.ArrayItem{ key: 'id', val: var_network_id }])])
	}
	populate_network_meta(rt.new_int(var_network_id), rt.create_array([
		rt.ArrayItem{ key: 'admin_email', val: email },
		rt.ArrayItem{ key: 'site_name', val: site_name },
		rt.ArrayItem{ key: 'subdomain_install', val: subdomain_install },
	]))
	if rt.is_true(rt.call_function('wp_next_scheduled', [
		rt.new_string('recovery_mode_clean_expired_keys'),
	]))
	{
		rt.call_function('wp_clear_scheduled_hook', [
			rt.new_string('recovery_mode_clean_expired_keys'),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_current_site = create_stdclass()
		rt.set_property(var_current_site, 'domain', rt.new_string(domain))
		rt.set_property(var_current_site, 'path', rt.new_string(path))
		rt.set_property(var_current_site, 'site_name', rt.call_function('ucfirst', [
			rt.new_string(domain),
		]))
		rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'blogs'),
			rt.create_array([rt.ArrayItem{ key: 'site_id', val: var_network_id },
				rt.ArrayItem{ key: 'blog_id', val: 1 }, rt.ArrayItem{ key: 'domain', val: domain },
				rt.ArrayItem{ key: 'path', val: path }, rt.ArrayItem{ key: 'registered', val: rt.call_function('current_time', [
					rt.new_string('mysql'),
				]) }])])
		rt.set_property(var_current_site, 'blog_id', rt.get_property(var_wpdb, 'insert_id'))
		var_site_user_id = rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT meta_value\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
					'sitemeta')), rt.new_string('\n\t\t\t\tWHERE meta_key = %s AND site_id = %d')),
				rt.new_string('admin_user_id'),
				rt.new_int(var_network_id),
			]),
		])).to_i64())
		rt.call_function('update_user_meta', [var_site_user_id.clone(),
			rt.new_string('source_domain'), rt.new_string(domain)])
		rt.call_function('update_user_meta', [var_site_user_id.clone(),
			rt.new_string('primary_blog'), rt.get_property(var_current_site, 'blog_id')])
		rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'sitemeta'),
			rt.create_array([rt.ArrayItem{ key: 'site_id', val: var_network_id },
				rt.ArrayItem{ key: 'meta_key', val: 'main_site' },
				rt.ArrayItem{ key: 'meta_value', val: rt.get_property(var_current_site, 'blog_id') }])])
		if var_subdomain_install {
			rt.call_method(var_wp_rewrite, 'set_permalink_structure', [
				rt.new_string('/%year%/%monthnum%/%day%/%postname%/'),
			])
		} else {
			rt.call_method(var_wp_rewrite, 'set_permalink_structure', [
				rt.new_string('/blog/%year%/%monthnum%/%day%/%postname%/'),
			])
		}
		rt.call_function('flush_rewrite_rules', []rt.PhpVal{})
		rt.call_function('do_action', [rt.new_string('after_upgrade_to_multisite'),
			rt.new_int(var_network_id), rt.new_string(domain),
			rt.new_string(email), rt.new_string(site_name), rt.new_string(path),
			rt.new_bool(subdomain_install)])
		if !var_subdomain_install {
			return rt.new_bool(true)
		}
		var_vhost_ok = false
		var_errstr = rt.new_string('')
		var_hostname = rt.new_string(
			(rt.call_function('substr', [rt.new_string(md5.hexhash(rt.call_function('time', []rt.PhpVal{}).to_string())), rt.new_int(0), rt.new_int(6)])).str() +
			'.' + domain)
		var_page = rt.call_function('wp_remote_get', [
			rt.new_string('http://' + var_hostname.str()),
			rt.create_array([rt.ArrayItem{ key: 'timeout', val: 5 },
				rt.ArrayItem{ key: 'httpversion', val: '1.1' }]),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_page.clone()])) {
			var_errstr = rt.call_method(var_page, 'get_error_message', []rt.PhpVal{})
		} else if rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [
			var_page.clone(),
		])))
		{
			var_vhost_ok = true
		}
		if !var_vhost_ok {
			var_msg = rt.new_string('<p><strong>' +
				(rt.call_function('__', [rt.new_string('Warning! Wildcard DNS may not be configured correctly!')])).str() +
				'</strong></p>')
			var_msg = rt.concat(var_msg, rt.new_string('<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The installer attempted to contact a random hostname (%s) on your domain.')]), rt.new_string('<code>' + var_hostname.str() +
				'</code>')])).str()))
			if !(!rt.is_true(var_errstr)) {
				var_msg = rt.concat(var_msg, rt.new_string(' ' +
					(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This resulted in an error message: %s')]), rt.new_string('<code>' + var_errstr.str() +
					'</code>')])).str()))
			}
			var_msg = rt.concat(var_msg, rt.new_string('</p>'))
			var_msg = rt.concat(var_msg, rt.new_string('<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('To use a subdomain configuration, you must have a wildcard entry in your DNS. This usually means adding a %s hostname record pointing at your web server in your DNS configuration tool.')]), rt.new_string('<code>*</code>')])).str() +
				'</p>'))
			var_msg = rt.concat(var_msg, rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('You can still use your site but any subdomain you create may not be accessible. If you know your DNS is correct, ignore this message.')])).str() +
				'</p>'))
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('no_wildcard_dns'),
				var_msg.clone()))
		}
	}
	rt.call_function('do_action', [rt.new_string('after_populate_network'),
		rt.new_int(var_network_id), rt.new_string(domain), rt.new_string(email),
		rt.new_string(site_name), rt.new_string(path), rt.new_bool(subdomain_install)])
	return rt.new_bool(true)
}

fn populate_network_meta(var_network_id_arg rt.PhpVal, var_meta rt.PhpVal) {
	mut var_network_id := var_network_id_arg
	mut var_wpdb := rt.new_null()
	mut var_wp_db_version := rt.new_null()
	mut var_email := rt.new_null()
	mut var_subdomain_install := rt.new_null()
	mut var_site_user := rt.new_null()
	mut var_template := rt.new_null()
	mut var_stylesheet := rt.new_null()
	mut var_allowed_themes := rt.new_null()
	mut var_core_default := rt.new_null()
	mut var_site_admins := rt.new_null()
	mut var_users := rt.new_null()
	mut var_user := rt.new_null()
	mut var_welcome_email := rt.new_null()
	mut var_allowed_file_types := rt.new_null()
	mut var_all_mime_types := rt.new_null()
	mut var_mime := rt.new_null()
	mut var_ext := rt.new_null()
	mut var_upload_filetypes := rt.new_null()
	mut var_sitemeta := rt.new_null()
	mut var_insert := ''
	mut var_meta_value := rt.new_null()
	mut var_meta_key := rt.new_null()
	var_network_id = rt.new_int(var_network_id.to_i64())
	var_email = if !(!rt.is_true(var_meta.array_get(rt.new_string('admin_email')))) {
		var_meta.array_get(rt.new_string('admin_email'))
	} else {
		rt.new_string('')
	}
	var_subdomain_install = rt.new_int(if var_meta.array_isset(rt.new_string('subdomain_install')) {
		rt.new_int((var_meta.array_get(rt.new_string('subdomain_install'))).to_i64())
	} else {
		0
	})
	var_site_user = if !(!rt.is_true(var_email)) { rt.call_function('get_user_by', [
			rt.new_string('email'),
			var_email.clone(),
		]) } else { rt.new_bool(false) }
	if rt.is_true(rt.identical(rt.new_bool(false), var_site_user)) {
		var_site_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	}
	if !rt.is_true(var_email) {
		var_email = rt.get_property(var_site_user, 'user_email')
	}
	var_template = rt.call_function('get_option', [rt.new_string('template')])
	var_stylesheet = rt.call_function('get_option', [rt.new_string('stylesheet')])
	var_allowed_themes = rt.create_array([rt.ArrayItem{ key: var_stylesheet, val: true }])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_template, var_stylesheet)))) {
		var_allowed_themes.array_set(var_template, true)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('WP_DEFAULT_THEME'), var_stylesheet))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('WP_DEFAULT_THEME'), var_template)))) {
		var_allowed_themes.array_set(rt.get_constant('WP_DEFAULT_THEME'), true)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('wp_get_theme', [
		rt.get_constant('WP_DEFAULT_THEME'),
	]), 'exists', []rt.PhpVal{})))))
	{
		mut iife_temp_1 := Class_WP_Theme{}
		mut iife_result_1 := iife_temp_1.get_core_default_theme()
		var_core_default = iife_result_1
		if rt.is_true(var_core_default) {
			var_allowed_themes.array_set(rt.call_method(var_core_default, 'get_stylesheet',
				[]rt.PhpVal{}), true)
		}
	}
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('clean_network_cache'),
	]))
	{
		rt.call_function('clean_network_cache', [var_network_id.clone()])
	} else {
		rt.call_function('wp_cache_delete', [var_network_id.clone(),
			rt.new_string('networks')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_site_admins = rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(var_site_user, 'user_login') },
		])
		var_users = rt.call_function('get_users', [
			rt.create_array([
				rt.ArrayItem{ key: 'fields', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'user_login' },
				]) },
				rt.ArrayItem{ key: 'role', val: 'administrator' },
			]),
		])
		if rt.is_true(var_users) {
			mut iter_2 := var_users.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_user_shadow := item_2.val
				var_site_admins.array_push(rt.get_property(var_user_shadow, 'user_login'))
			}
			var_site_admins = rt.call_function('array_unique', [
				var_site_admins.clone()])
		}
	} else {
		var_site_admins = rt.call_function('get_site_option', [
			rt.new_string('site_admins'),
		])
	}
	var_welcome_email = rt.call_function('__', [
		rt.new_string('Howdy USERNAME,\n\nYour new SITE_NAME site has been successfully set up at:\nBLOG_URL\n\nYou can log in to the administrator account with the following information:\n\nUsername: USERNAME\nPassword: PASSWORD\nLog in here: BLOG_URLwp-login.php\n\nWe hope you enjoy your new site. Thanks!\n\n--The Team @ SITE_NAME'),
	])
	var_allowed_file_types = map[string]rt.PhpVal{}
	var_all_mime_types = rt.call_function('get_allowed_mime_types', []rt.PhpVal{})
	mut iter_3 := var_all_mime_types.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_mime_shadow := item_3.val
		mut var_ext_shadow := item_3.key
		var_allowed_file_types.clone().array_push(rt.call_function('explode', [
			rt.new_string('|'),
			var_ext_shadow.clone(),
		]))
	}
	var_upload_filetypes = rt.call_function('array_unique', [
		var_allowed_file_types.clone()])
	var_sitemeta = rt.create_array([
		rt.ArrayItem{ key: 'site_name', val: rt.call_function('__', [
			rt.new_string('My Network'),
		]) },
		rt.ArrayItem{ key: 'admin_email', val: var_email },
		rt.ArrayItem{ key: 'admin_user_id', val: rt.get_property(var_site_user, 'ID') },
		rt.ArrayItem{ key: 'registration', val: 'none' },
		rt.ArrayItem{ key: 'upload_filetypes', val: rt.call_function('implode', [
			rt.new_string(' '),
			var_upload_filetypes.clone(),
		]) },
		rt.ArrayItem{ key: 'blog_upload_space', val: 100 },
		rt.ArrayItem{ key: 'fileupload_maxk', val: 1500 },
		rt.ArrayItem{ key: 'site_admins', val: var_site_admins },
		rt.ArrayItem{ key: 'allowedthemes', val: var_allowed_themes },
		rt.ArrayItem{ key: 'illegal_names', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'www' },
			rt.ArrayItem{ key: none, val: 'web' },
			rt.ArrayItem{ key: none, val: 'root' },
			rt.ArrayItem{ key: none, val: 'admin' },
			rt.ArrayItem{ key: none, val: 'main' },
			rt.ArrayItem{ key: none, val: 'invite' },
			rt.ArrayItem{ key: none, val: 'administrator' },
			rt.ArrayItem{ key: none, val: 'files' },
		]) },
		rt.ArrayItem{ key: 'wpmu_upgrade_site', val: var_wp_db_version },
		rt.ArrayItem{ key: 'welcome_email', val: var_welcome_email },
		rt.ArrayItem{ key: 'first_post', val: rt.call_function('__', [
			rt.new_string('Welcome to %s. This is your first post. Edit or delete it, then start writing!'),
		]) },
		rt.ArrayItem{ key: 'siteurl', val:
			(rt.call_function('get_option', [rt.new_string('siteurl')])).str() + '/' },
		rt.ArrayItem{ key: 'add_new_users', val: '0' },
		rt.ArrayItem{
			key: 'upload_space_check_disabled'
			val: if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { rt.call_function('get_site_option', [
					rt.new_string('upload_space_check_disabled'),
				]) } else { rt.new_string('1') }
		},
		rt.ArrayItem{ key: 'subdomain_install', val: var_subdomain_install },
		rt.ArrayItem{
			key: 'ms_files_rewriting'
			val: if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { rt.call_function('get_site_option', [
					rt.new_string('ms_files_rewriting'),
				]) } else { rt.new_string('0') }
		},
		rt.ArrayItem{ key: 'user_count', val: rt.call_function('get_site_option', [
			rt.new_string('user_count'),
		]) },
		rt.ArrayItem{ key: 'initial_db_version', val: rt.call_function('get_option', [
			rt.new_string('initial_db_version'),
		]) },
		rt.ArrayItem{
			key: 'active_sitewide_plugins'
			val: map[string]rt.PhpVal{}
		},
		rt.ArrayItem{ key: 'WPLANG', val: rt.call_function('get_locale', []rt.PhpVal{}) },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_subdomain_install)))) {
		var_sitemeta.array_get_mut('illegal_names').array_push('blog')
	}
	var_sitemeta = rt.call_function('wp_parse_args', [var_meta.clone(),
		var_sitemeta.clone()])
	var_sitemeta = rt.call_function('apply_filters', [
		rt.new_string('populate_network_meta'),
		var_sitemeta.clone(),
		var_network_id.clone(),
	])
	var_insert = ''
	mut iter_4 := var_sitemeta.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_meta_value_shadow := item_4.val
		mut var_meta_key_shadow := item_4.key
		if rt.is_true(rt.new_bool(var_meta_value_shadow.clone().is_array())) {
			var_meta_value_shadow = rt.call_function('serialize', [
				var_meta_value_shadow.clone()])
		}
		if !(var_insert == '') {
			var_insert = var_insert + ', '
		}
		var_insert = var_insert +(rt.call_method(var_wpdb, 'prepare', [rt.new_string('( %d, %s, %s)'), var_network_id.clone(), var_meta_key_shadow.clone(), var_meta_value_shadow.clone()])).str()
	}
	rt.call_method(var_wpdb, 'query', [
		rt.new_string((
			rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb, 'sitemeta')), rt.new_string(' ( site_id, meta_key, meta_value ) VALUES ')) +
			var_insert).str()),
	])
}

fn populate_site_meta(var_site_id_arg rt.PhpVal, var_meta rt.PhpVal) {
	mut var_site_id := var_site_id_arg
	mut var_wpdb := rt.new_null()
	mut var_site_meta := rt.new_null()
	mut var_insert := ''
	mut var_meta_value := rt.new_null()
	mut var_meta_key := rt.new_null()
	var_site_id = rt.new_int(var_site_id.to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_site_meta_supported', []rt.PhpVal{}))))) {
		return
	}
	if !rt.is_true(var_meta) {
		return
	}
	var_site_meta = rt.call_function('apply_filters', [
		rt.new_string('populate_site_meta'),
		var_meta.clone(),
		var_site_id.clone(),
	])
	var_insert = ''
	mut iter_5 := var_site_meta.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_meta_value_shadow := item_5.val
		mut var_meta_key_shadow := item_5.key
		if rt.is_true(rt.new_bool(var_meta_value_shadow.clone().is_array())) {
			var_meta_value_shadow = rt.call_function('serialize', [
				var_meta_value_shadow.clone()])
		}
		if !(var_insert == '') {
			var_insert = var_insert + ', '
		}
		var_insert = var_insert +(rt.call_method(var_wpdb, 'prepare', [rt.new_string('( %d, %s, %s)'), var_site_id.clone(), var_meta_key_shadow.clone(), var_meta_value_shadow.clone()])).str()
	}
	rt.call_method(var_wpdb, 'query', [
		rt.new_string((
			rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb, 'blogmeta')), rt.new_string(' ( blog_id, meta_key, meta_value ) VALUES ')) +
			var_insert).str()),
	])
	rt.call_function('wp_cache_delete', [var_site_id.clone(),
		rt.new_string('blog_meta')])
	rt.call_function('wp_cache_set_sites_last_changed', []rt.PhpVal{})
}

struct Class_WP_Theme {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_theme(_args ...rt.PhpVal) &Class_WP_Theme {
	mut obj := &Class_WP_Theme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Theme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wpdb := rt.new_null()
	mut var_wp_queries := rt.get_superglobal('wp_queries')
	mut var_charset_collate := rt.get_superglobal('charset_collate')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('install_network'),
	])))))
	{
	}
}
