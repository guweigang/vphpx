import rt

fn wp_get_db_schema(scope string, var_blog_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_charset_collate := rt.call_method(var_wpdb, 'get_charset_collate', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(var_blog_id) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_old_blog_id := rt.call_method(var_wpdb, 'set_blog_id', [var_blog_id.dup()])
	}
	mut var_is_multisite := rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_INSTALLING_NETWORK')])) && rt.is_true(rt.get_constant('WP_INSTALLING_NETWORK'))))
	mut var_max_index_length := 191
	mut var_blog_tables := rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CREATE TABLE '), rt.get_property(var_wpdb, 'termmeta')), rt.new_string(' (\n\tmeta_id bigint(20) unsigned NOT NULL auto_increment,\n\tterm_id bigint(20) unsigned NOT NULL default \'0\',\n\tmeta_key varchar(255) default NULL,\n\tmeta_value longtext,\n\tPRIMARY KEY  (meta_id),\n\tKEY term_id (term_id),\n\tKEY meta_key (meta_key(')), rt.new_int(var_max_index_length)), rt.new_string('))\n) ')), var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'terms')), rt.new_string(' (\n term_id bigint(20) unsigned NOT NULL auto_increment,\n name varchar(200) NOT NULL default \'\',\n slug varchar(200) NOT NULL default \'\',\n term_group bigint(10) NOT NULL default 0,\n PRIMARY KEY  (term_id),\n KEY slug (slug(')), rt.new_int(var_max_index_length)), rt.new_string(')),\n KEY name (name(')), rt.new_int(var_max_index_length)), rt.new_string('))\n) ')), var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' (\n term_taxonomy_id bigint(20) unsigned NOT NULL auto_increment,\n term_id bigint(20) unsigned NOT NULL default 0,\n taxonomy varchar(32) NOT NULL default \'\',\n description longtext NOT NULL,\n parent bigint(20) unsigned NOT NULL default 0,\n count bigint(20) NOT NULL default 0,\n PRIMARY KEY  (term_taxonomy_id),\n UNIQUE KEY term_id_taxonomy (term_id,taxonomy),\n KEY taxonomy (taxonomy)\n) ')), var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' (\n object_id bigint(20) unsigned NOT NULL default 0,\n term_taxonomy_id bigint(20) unsigned NOT NULL default 0,\n term_order int(11) NOT NULL default 0,\n PRIMARY KEY  (object_id,term_taxonomy_id),\n KEY term_taxonomy_id (term_taxonomy_id)\n) ')), var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'commentmeta')), rt.new_string(' (\n\tmeta_id bigint(20) unsigned NOT NULL auto_increment,\n\tcomment_id bigint(20) unsigned NOT NULL default \'0\',\n\tmeta_key varchar(255) default NULL,\n\tmeta_value longtext,\n\tPRIMARY KEY  (meta_id),\n\tKEY comment_id (comment_id),\n\tKEY meta_key (meta_key(')), rt.new_int(var_max_index_length)), rt.new_string('))\n) ')), var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'comments')), rt.new_string(' (\n\tcomment_ID bigint(20) unsigned NOT NULL auto_increment,\n\tcomment_post_ID bigint(20) unsigned NOT NULL default \'0\',\n\tcomment_author tinytext NOT NULL,\n\tcomment_author_email varchar(100) NOT NULL default \'\',\n\tcomment_author_url varchar(200) NOT NULL default \'\',\n\tcomment_author_IP varchar(100) NOT NULL default \'\',\n\tcomment_date datetime NOT NULL default \'0000-00-00 00:00:00\',\n\tcomment_date_gmt datetime NOT NULL default \'0000-00-00 00:00:00\',\n\tcomment_content text NOT NULL,\n\tcomment_karma int(11) NOT NULL default \'0\',\n\tcomment_approved varchar(20) NOT NULL default \'1\',\n\tcomment_agent varchar(255) NOT NULL default \'\',\n\tcomment_type varchar(20) NOT NULL default \'comment\',\n\tcomment_parent bigint(20) unsigned NOT NULL default \'0\',\n\tuser_id bigint(20) unsigned NOT NULL default \'0\',\n\tPRIMARY KEY  (comment_ID),\n\tKEY comment_post_ID (comment_post_ID),\n\tKEY comment_approved_date_gmt (comment_approved,comment_date_gmt),\n\tKEY comment_date_gmt (comment_date_gmt),\n\tKEY comment_parent (comment_parent),\n\tKEY comment_author_email (comment_author_email(10))\n) ')), var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'links')), rt.new_string(' (\n\tlink_id bigint(20) unsigned NOT NULL auto_increment,\n\tlink_url varchar(255) NOT NULL default \'\',\n\tlink_name varchar(255) NOT NULL default \'\',\n\tlink_image varchar(255) NOT NULL default \'\',\n\tlink_target varchar(25) NOT NULL default \'\',\n\tlink_description varchar(255) NOT NULL default \'\',\n\tlink_visible varchar(20) NOT NULL default \'Y\',\n\tlink_owner bigint(20) unsigned NOT NULL default \'1\',\n\tlink_rating int(11) NOT NULL default \'0\',\n\tlink_updated datetime NOT NULL default \'0000-00-00 00:00:00\',\n\tlink_rel varchar(255) NOT NULL default \'\',\n\tlink_notes mediumtext NOT NULL,\n\tlink_rss varchar(255) NOT NULL default \'\',\n\tPRIMARY KEY  (link_id),\n\tKEY link_visible (link_visible)\n) ')), var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'options')), rt.new_string(' (\n\toption_id bigint(20) unsigned NOT NULL auto_increment,\n\toption_name varchar(191) NOT NULL default \'\',\n\toption_value longtext NOT NULL,\n\tautoload varchar(20) NOT NULL default \'yes\',\n\tPRIMARY KEY  (option_id),\n\tUNIQUE KEY option_name (option_name),\n\tKEY autoload (autoload)\n) ')), var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' (\n\tmeta_id bigint(20) unsigned NOT NULL auto_increment,\n\tpost_id bigint(20) unsigned NOT NULL default \'0\',\n\tmeta_key varchar(255) default NULL,\n\tmeta_value longtext,\n\tPRIMARY KEY  (meta_id),\n\tKEY post_id (post_id),\n\tKEY meta_key (meta_key(')), rt.new_int(var_max_index_length)), rt.new_string('))\n) ')), var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' (\n\tID bigint(20) unsigned NOT NULL auto_increment,\n\tpost_author bigint(20) unsigned NOT NULL default \'0\',\n\tpost_date datetime NOT NULL default \'0000-00-00 00:00:00\',\n\tpost_date_gmt datetime NOT NULL default \'0000-00-00 00:00:00\',\n\tpost_content longtext NOT NULL,\n\tpost_title text NOT NULL,\n\tpost_excerpt text NOT NULL,\n\tpost_status varchar(20) NOT NULL default \'publish\',\n\tcomment_status varchar(20) NOT NULL default \'open\',\n\tping_status varchar(20) NOT NULL default \'open\',\n\tpost_password varchar(255) NOT NULL default \'\',\n\tpost_name varchar(200) NOT NULL default \'\',\n\tto_ping text NOT NULL,\n\tpinged text NOT NULL,\n\tpost_modified datetime NOT NULL default \'0000-00-00 00:00:00\',\n\tpost_modified_gmt datetime NOT NULL default \'0000-00-00 00:00:00\',\n\tpost_content_filtered longtext NOT NULL,\n\tpost_parent bigint(20) unsigned NOT NULL default \'0\',\n\tguid varchar(255) NOT NULL default \'\',\n\tmenu_order int(11) NOT NULL default \'0\',\n\tpost_type varchar(20) NOT NULL default \'post\',\n\tpost_mime_type varchar(100) NOT NULL default \'\',\n\tcomment_count bigint(20) NOT NULL default \'0\',\n\tPRIMARY KEY  (ID),\n\tKEY post_name (post_name(')), rt.new_int(var_max_index_length)), rt.new_string(')),\n\tKEY type_status_date (post_type,post_status,post_date,ID),\n\tKEY post_parent (post_parent),\n\tKEY post_author (post_author),\n\tKEY type_status_author (post_type,post_status,post_author)\n) ')), var_charset_collate), rt.new_string(';\n'))
	mut var_users_single_table := rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CREATE TABLE '), rt.get_property(var_wpdb, 'users')), rt.new_string(' (\n\tID bigint(20) unsigned NOT NULL auto_increment,\n\tuser_login varchar(60) NOT NULL default \'\',\n\tuser_pass varchar(255) NOT NULL default \'\',\n\tuser_nicename varchar(50) NOT NULL default \'\',\n\tuser_email varchar(100) NOT NULL default \'\',\n\tuser_url varchar(100) NOT NULL default \'\',\n\tuser_registered datetime NOT NULL default \'0000-00-00 00:00:00\',\n\tuser_activation_key varchar(255) NOT NULL default \'\',\n\tuser_status int(11) NOT NULL default \'0\',\n\tdisplay_name varchar(250) NOT NULL default \'\',\n\tPRIMARY KEY  (ID),\n\tKEY user_login_key (user_login),\n\tKEY user_nicename (user_nicename),\n\tKEY user_email (user_email)\n) ')), var_charset_collate), rt.new_string(';\n'))
	mut var_users_multi_table := rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CREATE TABLE '), rt.get_property(var_wpdb, 'users')), rt.new_string(' (\n\tID bigint(20) unsigned NOT NULL auto_increment,\n\tuser_login varchar(60) NOT NULL default \'\',\n\tuser_pass varchar(255) NOT NULL default \'\',\n\tuser_nicename varchar(50) NOT NULL default \'\',\n\tuser_email varchar(100) NOT NULL default \'\',\n\tuser_url varchar(100) NOT NULL default \'\',\n\tuser_registered datetime NOT NULL default \'0000-00-00 00:00:00\',\n\tuser_activation_key varchar(255) NOT NULL default \'\',\n\tuser_status int(11) NOT NULL default \'0\',\n\tdisplay_name varchar(250) NOT NULL default \'\',\n\tspam tinyint(2) NOT NULL default \'0\',\n\tdeleted tinyint(2) NOT NULL default \'0\',\n\tPRIMARY KEY  (ID),\n\tKEY user_login_key (user_login),\n\tKEY user_nicename (user_nicename),\n\tKEY user_email (user_email)\n) ')), var_charset_collate), rt.new_string(';\n'))
	mut var_usermeta_table := rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CREATE TABLE '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string(' (\n\tumeta_id bigint(20) unsigned NOT NULL auto_increment,\n\tuser_id bigint(20) unsigned NOT NULL default \'0\',\n\tmeta_key varchar(255) default NULL,\n\tmeta_value longtext,\n\tPRIMARY KEY  (umeta_id),\n\tKEY user_id (user_id),\n\tKEY meta_key (meta_key(')), rt.new_int(var_max_index_length)), rt.new_string('))\n) ')), var_charset_collate), rt.new_string(';\n'))
	if var_is_multisite {
		mut var_global_tables := rt.new_string(var_users_multi_table + var_usermeta_table)
	} else {
		var_global_tables = rt.new_string(var_users_single_table + var_usermeta_table)
	}
	mut var_ms_global_tables := rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CREATE TABLE '), rt.get_property(var_wpdb, 'blogs')), rt.new_string(' (\n\tblog_id bigint(20) unsigned NOT NULL auto_increment,\n\tsite_id bigint(20) unsigned NOT NULL default \'0\',\n\tdomain varchar(200) NOT NULL default \'\',\n\tpath varchar(100) NOT NULL default \'\',\n\tregistered datetime NOT NULL default \'0000-00-00 00:00:00\',\n\tlast_updated datetime NOT NULL default \'0000-00-00 00:00:00\',\n\tpublic tinyint(2) NOT NULL default \'1\',\n\tarchived tinyint(2) NOT NULL default \'0\',\n\tmature tinyint(2) NOT NULL default \'0\',\n\tspam tinyint(2) NOT NULL default \'0\',\n\tdeleted tinyint(2) NOT NULL default \'0\',\n\tlang_id int(11) NOT NULL default \'0\',\n\tPRIMARY KEY  (blog_id),\n\tKEY domain (domain(50),path(5)),\n\tKEY lang_id (lang_id)\n) ')), var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'blogmeta')), rt.new_string(' (\n\tmeta_id bigint(20) unsigned NOT NULL auto_increment,\n\tblog_id bigint(20) unsigned NOT NULL default \'0\',\n\tmeta_key varchar(255) default NULL,\n\tmeta_value longtext,\n\tPRIMARY KEY  (meta_id),\n\tKEY meta_key (meta_key(')), rt.new_int(var_max_index_length)), rt.new_string(')),\n\tKEY blog_id (blog_id)\n) ')), var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'registration_log')), rt.new_string(' (\n\tID bigint(20) unsigned NOT NULL auto_increment,\n\temail varchar(255) NOT NULL default \'\',\n\tIP varchar(30) NOT NULL default \'\',\n\tblog_id bigint(20) unsigned NOT NULL default \'0\',\n\tdate_registered datetime NOT NULL default \'0000-00-00 00:00:00\',\n\tPRIMARY KEY  (ID),\n\tKEY IP (IP)\n) ')), var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'site')), rt.new_string(' (\n\tid bigint(20) unsigned NOT NULL auto_increment,\n\tdomain varchar(200) NOT NULL default \'\',\n\tpath varchar(100) NOT NULL default \'\',\n\tPRIMARY KEY  (id),\n\tKEY domain (domain(140),path(51))\n) ')), var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'sitemeta')), rt.new_string(' (\n\tmeta_id bigint(20) unsigned NOT NULL auto_increment,\n\tsite_id bigint(20) unsigned NOT NULL default \'0\',\n\tmeta_key varchar(255) default NULL,\n\tmeta_value longtext,\n\tPRIMARY KEY  (meta_id),\n\tKEY meta_key (meta_key(')), rt.new_int(var_max_index_length)), rt.new_string(')),\n\tKEY site_id (site_id)\n) ')), var_charset_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'signups')), rt.new_string(' (\n\tsignup_id bigint(20) unsigned NOT NULL auto_increment,\n\tdomain varchar(200) NOT NULL default \'\',\n\tpath varchar(100) NOT NULL default \'\',\n\ttitle longtext NOT NULL,\n\tuser_login varchar(60) NOT NULL default \'\',\n\tuser_email varchar(100) NOT NULL default \'\',\n\tregistered datetime NOT NULL default \'0000-00-00 00:00:00\',\n\tactivated datetime NOT NULL default \'0000-00-00 00:00:00\',\n\tactive tinyint(1) NOT NULL default \'0\',\n\tactivation_key varchar(50) NOT NULL default \'\',\n\tmeta longtext,\n\tPRIMARY KEY  (signup_id),\n\tKEY activation_key (activation_key),\n\tKEY user_email (user_email),\n\tKEY user_login_email (user_login,user_email),\n\tKEY domain_path (domain(140),path(51))\n) ')), var_charset_collate), rt.new_string(';'))
	mut switch_val_1 := rt.new_string(scope)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('blog'))) {
		mut var_queries := rt.new_string(rt.new_string(var_blog_tables)).dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('global'))) {
		var_queries = var_global_tables.dup()
		if var_is_multisite {
			// unsupported expression: Expr_AssignOp_Concat
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('ms_global'))) {
		var_queries = rt.new_string(rt.new_string(var_ms_global_tables)).dup()
	} else {
		var_queries = rt.new_string((var_global_tables).str() + var_blog_tables)
		if var_is_multisite {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if !(var_old_blog_id).is_null() {
		rt.call_method(var_wpdb, 'set_blog_id', [var_old_blog_id.dup()])
	}
	return var_queries.dup()
}

fn populate_options(var_options rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_wp_db_version := rt.new_null()
	mut var_wp_current_db_version := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_guessurl := rt.call_function('wp_guess_url', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('populate_options')])
	mut var_stylesheet := rt.get_constant('WP_DEFAULT_THEME')
	mut var_template := rt.get_constant('WP_DEFAULT_THEME')
	mut var_theme := rt.call_function('wp_get_theme', [rt.get_constant('WP_DEFAULT_THEME')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{}))))) {
		var_theme = fn () rt.PhpVal { mut temp := Class_WP_Theme{}; return temp.get_core_default_theme() }()
	}
	if rt.is_true(var_theme) {
		var_stylesheet = rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{})
		var_template = rt.call_method(var_theme, 'get_template', []rt.PhpVal{})
	}
	mut var_timezone_string := rt.new_string(rt.new_string(''))
	mut var_gmt_offset := rt.new_int(rt.new_int(0))
	mut var_offset_or_tz := rt.call_function('_x', [rt.new_string('0'), rt.new_string('default GMT offset or timezone string')])
	if rt.is_true(rt.new_bool(var_offset_or_tz.dup().is_long() || var_offset_or_tz.dup().is_double())) {
		var_gmt_offset = var_offset_or_tz.dup()
	} else if rt.is_true(rt.new_bool(rt.is_true(var_offset_or_tz) && rt.is_true(rt.call_function('in_array', [var_offset_or_tz.dup(), rt.call_function('timezone_identifiers_list', [Class_DateTimeZone.all_with_bc()]), rt.new_bool(true)])))) {
		var_timezone_string = var_offset_or_tz.dup()
	}
	mut var_defaults := { 'siteurl': var_guessurl, 'home': var_guessurl, 'blogname': rt.call_function('__', [rt.new_string('My Site')]), 'blogdescription': rt.new_string(''), 'users_can_register': rt.new_int(0), 'admin_email': rt.new_string('you@example.com'), 'start_of_week': rt.call_function('_x', [rt.new_string('1'), rt.new_string('start of week')]), 'use_balanceTags': rt.new_int(0), 'use_smilies': rt.new_int(1), 'require_name_email': rt.new_int(1), 'comments_notify': rt.new_int(1), 'posts_per_rss': rt.new_int(10), 'rss_use_excerpt': rt.new_int(0), 'mailserver_url': rt.new_string('mail.example.com'), 'mailserver_login': rt.new_string('login@example.com'), 'mailserver_pass': rt.new_string(''), 'mailserver_port': rt.new_int(110), 'default_category': rt.new_int(1), 'default_comment_status': rt.new_string('open'), 'default_ping_status': rt.new_string('open'), 'default_pingback_flag': rt.new_int(1), 'posts_per_page': rt.new_int(10), 'date_format': rt.call_function('__', [rt.new_string('F j, Y')]), 'time_format': rt.call_function('__', [rt.new_string('g:i a')]), 'links_updated_date_format': rt.call_function('__', [rt.new_string('F j, Y g:i a')]), 'comment_moderation': rt.new_int(0), 'moderation_notify': rt.new_int(1), 'permalink_structure': rt.new_string(''), 'rewrite_rules': rt.new_string(''), 'hack_file': rt.new_int(0), 'blog_charset': rt.new_string('UTF-8'), 'moderation_keys': rt.new_string(''), 'active_plugins': map[string]rt.PhpVal{}, 'category_base': rt.new_string(''), 'ping_sites': rt.new_string('https://rpc.pingomatic.com/'), 'comment_max_links': rt.new_int(2), 'gmt_offset': var_gmt_offset, 'default_email_category': rt.new_int(1), 'recently_edited': rt.new_string(''), 'template': var_template, 'stylesheet': var_stylesheet, 'comment_registration': rt.new_int(0), 'html_type': rt.new_string('text/html'), 'use_trackback': rt.new_int(0), 'default_role': rt.new_string('subscriber'), 'db_version': var_wp_db_version, 'uploads_use_yearmonth_folders': rt.new_int(1), 'upload_path': rt.new_string(''), 'blog_public': rt.new_string('1'), 'default_link_category': rt.new_int(2), 'show_on_front': rt.new_string('posts'), 'tag_base': rt.new_string(''), 'show_avatars': rt.new_string('1'), 'avatar_rating': rt.new_string('G'), 'upload_url_path': rt.new_string(''), 'thumbnail_size_w': rt.new_int(150), 'thumbnail_size_h': rt.new_int(150), 'thumbnail_crop': rt.new_int(1), 'medium_size_w': rt.new_int(300), 'medium_size_h': rt.new_int(300), 'avatar_default': rt.new_string('mystery'), 'large_size_w': rt.new_int(1024), 'large_size_h': rt.new_int(1024), 'image_default_link_type': rt.new_string('none'), 'image_default_size': rt.new_string(''), 'image_default_align': rt.new_string(''), 'close_comments_for_old_posts': rt.new_int(0), 'close_comments_days_old': rt.new_int(14), 'thread_comments': rt.new_int(1), 'thread_comments_depth': rt.new_int(5), 'page_comments': rt.new_int(0), 'comments_per_page': rt.new_int(50), 'default_comments_page': rt.new_string('newest'), 'comment_order': rt.new_string('asc'), 'sticky_posts': map[string]rt.PhpVal{}, 'widget_categories': map[string]rt.PhpVal{}, 'widget_text': map[string]rt.PhpVal{}, 'widget_rss': map[string]rt.PhpVal{}, 'uninstall_plugins': map[string]rt.PhpVal{}, 'timezone_string': var_timezone_string, 'page_for_posts': rt.new_int(0), 'page_on_front': rt.new_int(0), 'default_post_format': rt.new_int(0), 'link_manager_enabled': rt.new_int(0), 'finished_splitting_shared_terms': rt.new_int(1), 'site_icon': rt.new_int(0), 'medium_large_size_w': rt.new_int(768), 'medium_large_size_h': rt.new_int(0), 'wp_page_for_privacy_policy': rt.new_int(0), 'show_comments_cookies_opt_in': rt.new_int(1), 'admin_email_lifespan': rt.call_function('time', []rt.PhpVal{}) + 6 * rt.get_constant('MONTH_IN_SECONDS'), 'disallowed_keys': rt.new_string(''), 'comment_previously_approved': rt.new_int(1), 'auto_plugin_theme_update_emails': map[string]rt.PhpVal{}, 'auto_update_core_dev': rt.new_string('enabled'), 'auto_update_core_minor': rt.new_string('enabled'), 'auto_update_core_major': rt.new_string('enabled'), 'wp_force_deactivated_plugins': map[string]rt.PhpVal{}, 'wp_attachment_pages_enabled': rt.new_int(0), 'wp_notes_notify': rt.new_int(1) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_defaults['initial_db_version'] = if rt.is_true(rt.new_bool(!(!rt.is_true(var_wp_current_db_version)) && rt.is_true(rt.less(var_wp_current_db_version, var_wp_db_version)))) { var_wp_current_db_version } else { var_wp_db_version }
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_defaults['permalink_structure'] = rt.new_string('/%year%/%monthnum%/%day%/%postname%/')
	}
	var_options = rt.call_function('wp_parse_args', [var_options.dup(), var_defaults.dup()])
	mut var_fat_options := ['moderation_keys', 'recently_edited', 'disallowed_keys', 'uninstall_plugins', 'auto_plugin_theme_update_emails']
	mut var_keys := rt.new_string('\'' + (rt.call_function('implode', [rt.new_string('\', \''), rt.func_array_keys(var_options.dup())])).str() + '\'')
	mut var_existing_options := rt.call_method(var_wpdb, 'get_col', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT option_name FROM '), rt.get_property(var_wpdb, 'options')), rt.new_string(' WHERE option_name in ( ')), var_keys), rt.new_string(' )'))])
	mut var_insert := ''
	{
		mut iter_1 := var_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_option := item_1.key
			if rt.is_true(rt.call_function('in_array', [var_option.dup(), var_existing_options.dup(), rt.new_bool(true)])) {
				continue
			}
			if rt.is_true(rt.call_function('in_array', [var_option.dup(), var_fat_options.dup(), rt.new_bool(true)])) {
				mut var_autoload := 'off'
			} else {
				var_autoload = 'on'
			}
			if !(var_insert == '') {
				// unsupported expression: Expr_AssignOp_Concat
			}
			var_value = rt.call_function('maybe_serialize', [rt.call_function('sanitize_option', [var_option.dup(), var_value.dup()])])
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if !(var_insert == '') {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb, 'options')), rt.new_string(' (option_name, option_value, autoload) VALUES ')) + var_insert])
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('__get_option', [rt.new_string('home')]))))) {
		rt.call_function('update_option', [rt.new_string('home'), var_guessurl.dup()])
	}
	mut var_unusedoptions := ['blodotgsping_url', 'bodyterminator', 'emailtestonly', 'phoneemail_separator', 'smilies_directory', 'subjectprefix', 'use_bbcode', 'use_blodotgsping', 'use_phoneemail', 'use_quicktags', 'use_weblogsping', 'weblogs_cache_file', 'use_preview', 'use_htmltrans', 'smilies_directory', 'fileupload_allowedusers', 'use_phoneemail', 'default_post_status', 'default_post_category', 'archive_mode', 'time_difference', 'links_minadminlevel', 'links_use_adminlevels', 'links_rating_type', 'links_rating_char', 'links_rating_ignore_zero', 'links_rating_single_image', 'links_rating_image0', 'links_rating_image1', 'links_rating_image2', 'links_rating_image3', 'links_rating_image4', 'links_rating_image5', 'links_rating_image6', 'links_rating_image7', 'links_rating_image8', 'links_rating_image9', 'links_recently_updated_time', 'links_recently_updated_prepend', 'links_recently_updated_append', 'weblogs_cacheminutes', 'comment_allowed_tags', 'search_engine_friendly_urls', 'default_geourl_lat', 'default_geourl_lon', 'use_default_geourl', 'weblogs_xml_url', 'new_users_can_blog', '_wpnonce', '_wp_http_referer', 'Update', 'action', 'rich_editing', 'autosave_interval', 'deactivated_plugins', 'can_compress_scripts', 'page_uris', 'update_core', 'update_plugins', 'update_themes', 'doing_cron', 'random_seed', 'rss_excerpt_length', 'secret', 'use_linksupdate', 'default_comment_status_page', 'wporg_popular_tags', 'what_to_show', 'rss_language', 'language', 'enable_xmlrpc', 'enable_app', 'embed_autourls', 'default_post_edit_rows', 'gzipcompression', 'advanced_edit']
	for var_option in var_unusedoptions {
		rt.call_function('delete_option', [rt.new_string(option)])
	}
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'options')), rt.new_string(' WHERE option_name REGEXP \'^rss_[0-9a-f]{32}(_ts)?$\''))])
	rt.call_function('delete_expired_transients', [rt.new_bool(true)])
}

fn populate_roles() {
	mut var_wp_roles := rt.call_function('wp_roles', []rt.PhpVal{})
	mut var_original_use_db := rt.get_property(var_wp_roles, 'use_db')
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
		rt.call_function('update_option', [rt.get_property(var_wp_roles, 'role_key'), rt.get_property(var_wp_roles, 'roles'), rt.new_bool(true)])
	}
	rt.set_property(var_wp_roles, 'use_db', var_original_use_db.dup())
}

fn populate_roles_160() {
	rt.call_function('add_role', [rt.new_string('administrator'), rt.new_string('Administrator')])
	rt.call_function('add_role', [rt.new_string('editor'), rt.new_string('Editor')])
	rt.call_function('add_role', [rt.new_string('author'), rt.new_string('Author')])
	rt.call_function('add_role', [rt.new_string('contributor'), rt.new_string('Contributor')])
	rt.call_function('add_role', [rt.new_string('subscriber'), rt.new_string('Subscriber')])
	mut var_role := rt.call_function('get_role', [rt.new_string('administrator')])
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
	rt.call_method(, 'add_cap', [])
	
}

struct Class_WP_Theme {
	rt.PhpObjectBase
}

fn create_wp_theme() &Class_WP_Theme {
	mut obj := &Class_WP_Theme{
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




pub fn init_wp_admin_includes_schema_php() {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_charset_collate := rt.call_method(var_wpdb, 'get_charset_collate', []rt.PhpVal{})
	mut var_wp_queries := wp_get_db_schema('all', rt.new_null())
}
