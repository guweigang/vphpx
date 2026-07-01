import rt

pub fn init_wp_content_languages_admin_network_zh_cn_l10n_php() {
	return rt.create_array([rt.ArrayItem{ key: 'x-generator', val: 'GlotPress/4.0.3' },
		rt.ArrayItem{ key: 'translation-revision-date', val: '2025-12-02 05:08:14+0000' },
		rt.ArrayItem{ key: 'plural-forms', val: 'nplurals=1; plural=0;' },
		rt.ArrayItem{
			key: 'project-id-version'
			val: 'WordPress - 7.0.x - Development - Administration - Network Admin'
		}, rt.ArrayItem{ key: 'language', val: 'zh_CN' }, rt.ArrayItem{ key: 'messages', val: rt.create_array([
			rt.ArrayItem{ key: 'Site flagged for deletion.', val: '站点已标记为删除。' },
			rt.ArrayItem{ key: 'Site deletion flag removed.', val: '站点删除标记已移除。' },
			rt.ArrayItem{ key: 'Site permanently deleted.', val: '站点已永久删除。' },
			rt.ArrayItem{ key: 'Sites permanently deleted.', val: '站点已永久删除。' },
			rt.ArrayItem{ key: 'Delete these sites permanently', val: '永久删除这些站点' },
			rt.ArrayItem{
				key: 'Flagging a site for deletion makes the site unavailable to its users and visitors. This is a reversible action. A super admin can permanently delete the site at a later date.'
				val: '将站点标记为删除后，该站点将无法被用户和访客访问。此操作可逆。超级管理员可以在稍后永久删除该站点。'
			},
			rt.ArrayItem{
				key: 'Archiving a site makes the site unavailable to its users and visitors. This is a reversible action.'
				val: '存档站点会使其用户和访问者无法访问该站点。此操作可逆。'
			},
			rt.ArrayItem{
				key: 'You are about to flag the site %s for deletion.'
				val: '您即将标记删除 %s 站点。'
			},
			rt.ArrayItem{
				key: 'You are about to remove the deletion flag from the site %s.'
				val: '您即将移除 %s 站点的删除标记。'
			},
			rt.ArrayItem{ key: 'Flag for Deletion', val: '删除标记' },
			rt.ArrayItem{ key: 'siteRemove Deletion Flag', val: '移除删除标记' },
			rt.ArrayItem{
				key: 'Flagged for Deletion <span class="count">(%s)</span>'
				val: '标记为删除 <span class="count">（%s）</span>'
			},
			rt.ArrayItem{ key: 'Flagged for Deletion', val: '标记为删除' },
			rt.ArrayItem{
				key: '<a href="https://developer.wordpress.org/advanced-administration/multisite/admin/#network-admin-updates-screen">Documentation on Upgrade Network</a>'
				val: '<a href="https://developer.wordpress.org/advanced-administration/multisite/admin/#network-admin-updates-screen">站点网络升级文档</a>'
			},
			rt.ArrayItem{
				key: 'Deleting a site is a permanent action that cannot be undone. This will delete the entire site and its uploads directory.'
				val: '删除站点是不可撤销的永久操作。这将删除整个站点及其上传目录。'
			},
			rt.ArrayItem{ key: 'Delete this site permanently', val: '永久删除这个站点' },
			rt.ArrayItem{
				key: 'Visit to go to the front-end of the live site.'
				val: '点击「访问」可转到该站点的前端。'
			},
			rt.ArrayItem{
				key: '<a href="https://developer.wordpress.org/advanced-administration/multisite/admin/settings/">Documentation on Network Settings</a>'
				val: '<a href="https://developer.wordpress.org/advanced-administration/multisite/admin/settings/">站点网络设置文档</a>'
			},
			rt.ArrayItem{
				key: '<a href="https://developer.wordpress.org/advanced-administration/multisite/admin/">Documentation on the Network Admin</a>'
				val: '<a href="https://developer.wordpress.org/advanced-administration/multisite/admin/">站点网络管理文档</a>'
			},
			rt.ArrayItem{
				key: '<a href="https://developer.wordpress.org/advanced-administration/multisite/create-network/">Documentation on Creating a Network</a>'
				val: '<a href="https://developer.wordpress.org/advanced-administration/multisite/create-network/">站点网络创建文档</a>'
			},
			rt.ArrayItem{
				key: 'https://developer.wordpress.org/advanced-administration/server/web-server/nginx/'
				val: 'https://developer.wordpress.org/advanced-administration/server/web-server/nginx/'
			},
			rt.ArrayItem{ key: 'Missing site title.', val: '缺少网站标题。' },
			rt.ArrayItem{
				key: 'Table ordered by User Registered Date.'
				val: '表按用户注册日期排序。'
			},
			rt.ArrayItem{ key: 'Table ordered by Theme Name.', val: '表按主题名称排序。' },
			rt.ArrayItem{
				key: 'Table ordered by Site Registered Date.'
				val: '表按站点注册日期排序。'
			},
			rt.ArrayItem{
				key: 'Table ordered by Last Updated.'
				val: '表按上次更新顺序排序。'
			},
			rt.ArrayItem{ key: 'Table ordered by Site Path.', val: '表按站点路径排序。' },
			rt.ArrayItem{
				key: 'Table ordered by Site Domain Name.'
				val: '表按站点域名排序。'
			},
			rt.ArrayItem{
				key: 'Network configuration authentication keys'
				val: '站点网络配置验证密钥'
			},
			rt.ArrayItem{
				key: 'Network configuration rules for %s'
				val: '%s 的站点网络配置规则'
			},
			rt.ArrayItem{
				key: 'WordPress has been updated! Next and final step is to individually upgrade the sites in your network.'
				val: 'WordPress 已成功升级！接下来，您需要单独升级您站点网络中的每个站点，即可完成升级。'
			},
			rt.ArrayItem{ key: 'Cannot create an empty site.', val: '不能创建空站点。' },
			rt.ArrayItem{
				key: 'You should back up your existing %s file.'
				val: '您应备份现有的 %s 文件。'
			},
			rt.ArrayItem{
				key: 'You should back up your existing %1$s and %2$s files.'
				val: '您应备份现有的 %1$s 和 %2$s 文件。'
			},
			rt.ArrayItem{ key: 'Visit theme site for %s', val: '访问 %s 的主题站点' },
			rt.ArrayItem{ key: 'Child theme of %s', val: '%s 的子主题' },
			rt.ArrayItem{ key: 'sitePublic', val: '公开' },
			rt.ArrayItem{ key: 'siteNot spam', val: '标记为非垃圾站点' },
			rt.ArrayItem{
				key: '%s theme will no longer be auto-updated.'
				val: '%s 个主题将不再自动更新。'
			},
			rt.ArrayItem{
				key: '%s theme will be auto-updated.'
				val: '%s 个主题将自动更新。'
			},
			rt.ArrayItem{
				key: 'Sorry, you are not allowed to change themes automatic update settings.'
				val: '抱歉，您不能更改主题自动更新设置。'
			},
			rt.ArrayItem{
				key: 'No themes are currently available.'
				val: '当前没有可用的主题。'
			},
			rt.ArrayItem{ key: 'Y/m/d g:i:s a', val: 'Y/n/j H:i:s' },
			rt.ArrayItem{
				key: 'It seems your network is running with Nginx web server. <a href="%s">Learn more about further configuration</a>.'
				val: '您的站点网络似乎正在使用 Nginx Web 服务器运行。<a href="%s">进一步了解更多配置信息</a>。'
			},
			rt.ArrayItem{
				key: 'sitesSpam <span class="count">(%s)</span>'
				val: '垃圾<span class="count">（%s）</span>'
			},
			rt.ArrayItem{
				key: 'Mature <span class="count">(%s)</span>'
				val: '成人<span class="count">（%s）</span>'
			},
			rt.ArrayItem{
				key: 'Archived <span class="count">(%s)</span>'
				val: '已存档<span class="count">（%s）</span>'
			},
			rt.ArrayItem{
				key: 'Public <span class="count">(%s)</span>'
				val: '公开<span class="count">（%s）</span>'
			},
			rt.ArrayItem{
				key: 'sitesAll <span class="count">(%s)</span>'
				val: '全部<span class="count">（%s）</span>'
			},
			rt.ArrayItem{
				key: 'themesUpdate Available <span class="count">(%s)</span>'
				val: '有可用更新<span class="count">（%s）</span>'
			},
			rt.ArrayItem{ key: 'Main', val: '主站点' },
			rt.ArrayItem{
				key: '<a href="https://wordpress.org/documentation/article/tools-network-screen/">Documentation on the Network Screen</a>'
				val: '<a href="https://wordpress.org/documentation/article/tools-network-screen/">站点网络界面文档</a>'
			},
			rt.ArrayItem{
				key: 'The constant %s cannot be defined when creating a network.'
				val: '创建站点网络时无法定义常数 %s。'
			},
			rt.ArrayItem{
				key: 'You are about to delete the following sites:'
				val: '您将要删除以下站点：'
			},
			rt.ArrayItem{
				key: 'User could not be added to this site.'
				val: '未能添加用户到此站点。'
			},
			rt.ArrayItem{
				key: 'The username and a link to set the password will be mailed to this email address.'
				val: '用户名和密码设置链接会被发送到此电子邮箱地址。'
			},
			rt.ArrayItem{
				key: 'There is a pending change of the network admin email to %s.'
				val: '网络管理员电子邮箱地址即将被修改为 %s。'
			},
			rt.ArrayItem{ key: 'Sub-domain Installation', val: '子域名安装' },
			rt.ArrayItem{ key: 'Sub-directory Installation', val: '子目录安装' },
			rt.ArrayItem{ key: 'Active Child Theme', val: '当前子主题' },
			rt.ArrayItem{ key: '%s KB', val: '%s KB' },
			rt.ArrayItem{ key: '%s Sites', val: '%s 站点' },
			rt.ArrayItem{
				key: 'Sorry, you are not allowed to delete themes for this site.'
				val: '抱歉，您不能删除此站点的主题。'
			},
			rt.ArrayItem{
				key: 'Sorry, you are not allowed to manage network themes.'
				val: '抱歉，您无法管理站点网络主题。'
			},
			rt.ArrayItem{
				key: 'Sorry, you are not allowed to delete that site.'
				val: '抱歉，您不能删除该站点。'
			},
			rt.ArrayItem{
				key: 'Sorry, you are not allowed to manage themes for this site.'
				val: '抱歉，您不能管理此站点的主题。'
			},
			rt.ArrayItem{
				key: 'Sorry, you are not allowed to add sites to this network.'
				val: '抱歉，您无法在此站点网络中添加站点。'
			},
			rt.ArrayItem{
				key: 'Sorry, you are not allowed to edit this site.'
				val: '抱歉，您不能编辑此站点。'
			},
			rt.ArrayItem{
				key: 'The email address of the first comment author on a new site.'
				val: '新站点上首个评论者的邮箱地址。'
			},
			rt.ArrayItem{ key: 'First Comment Email', val: '首条评论者的邮箱地址' },
			rt.ArrayItem{
				key: 'That&#8217;s all, stop editing! Happy publishing.'
				val: 'That&#8217;s all, stop editing! Happy publishing.'
			},
			rt.ArrayItem{
				key: 'Add the following to your %1$s file in %2$s <strong>above</strong> the line reading %3$s:'
				val: '将以下内容加入位于 %2$s 的 %1$s 文件，加在 %3$s 这行<strong>上方</strong>：'
			},
			rt.ArrayItem{ key: 'theme%1$s by %2$s', val: '%2$s 的 %1$s' },
			rt.ArrayItem{
				key: 'Only lowercase letters (a-z), numbers, and hyphens are allowed.'
				val: '只允许小写字母（a-z）、数字和连字符。'
			},
			rt.ArrayItem{
				key: 'These unique authentication keys are also missing from your %s file.'
				val: '您的 %s 文件中也缺少这些唯一身份验证密钥。'
			},
			rt.ArrayItem{
				key: 'This unique authentication key is also missing from your %s file.'
				val: '您的 %s 文件中也缺少此唯一身份验证密钥。'
			},
			rt.ArrayItem{
				key: 'Because you are using %1$s, the sites in your WordPress network must use sub-directories. Consider using %2$s if you wish to use sub-domains.'
				val: '因为您在使用 %1$s，您 WordPress 网络中的站点必须使用子目录。如果您想使用子域名，请考虑使用 %2$s。'
			},
			rt.ArrayItem{
				key: 'The internet address of your network will be %s.'
				val: '您网络的互联网地址将会是 %s。'
			},
			rt.ArrayItem{
				key: 'You should consider changing your site domain to %1$s before enabling the network feature. It will still be possible to visit your site using the %3$s prefix with an address like %2$s but any links will not have the %3$s prefix.'
				val: '在启用站点网络功能前，我们建议您将站点域名修改为 %1$s。您将来仍可使用带有 %3$s 前缀的地址（如 %2$s）来访问您的站点，但任何链接将不会带有 %3$s 前缀。'
			},
			rt.ArrayItem{
				key: 'You cannot change this later.'
				val: '您在此后将不能修改此值。'
			},
			rt.ArrayItem{
				key: 'Please choose whether you would like sites in your WordPress network to use sub-domains or sub-directories.'
				val: '请选择您希望您 WordPress 网络中的站点使用子域名还是子目录。'
			},
			rt.ArrayItem{
				key: 'If %1$s is disabled, ask your administrator to enable that module, or look at the <a href="%2$s">Apache documentation</a> or <a href="%3$s">elsewhere</a> for help setting it up.'
				val: '如果 %1$s 未启用，请让您的管理员启用该模块，或者查看 <a href="%2$s">Apache 文档</a>或<a href="%3$s">其他地方</a>以获得设置帮助。'
			},
			rt.ArrayItem{
				key: 'It looks like the Apache %s module is not installed.'
				val: '似乎 Apache 的 %s 模块未被安装。'
			},
			rt.ArrayItem{
				key: 'Please make sure the Apache %s module is installed as it will be used at the end of this installation.'
				val: '请确保 Apache 的 %s 模块已被安装，在安装过程最后会用到该模块。'
			},
			rt.ArrayItem{ key: 'userRegistered', val: '已注册' },
			rt.ArrayItem{
				key: 'Super Admin <span class="count">(%s)</span>'
				val: '超级管理员<span class="count">（%s）</span>'
			},
			rt.ArrayItem{ key: 'userNot spam', val: '标记为非垃圾用户' },
			rt.ArrayItem{ key: 'userMark as spam', val: '标记为垃圾用户' },
			rt.ArrayItem{ key: 'Visit Theme Site', val: '访问主题站点' },
			rt.ArrayItem{ key: 'Broken Theme:', val: '损坏的主题：' },
			rt.ArrayItem{ key: 'Network Disable %s', val: '在站点网络中禁用 %s' },
			rt.ArrayItem{ key: 'Disable %s', val: '禁用 %s' },
			rt.ArrayItem{ key: 'Network Enable %s', val: '在站点网络中启用 %s' },
			rt.ArrayItem{ key: 'Enable %s', val: '启用 %s' },
			rt.ArrayItem{ key: 'Network Disable', val: '在站点网络中禁用' },
			rt.ArrayItem{
				key: 'themesBroken <span class="count">(%s)</span>'
				val: '损坏<span class="count">（%s）</span>'
			},
			rt.ArrayItem{
				key: 'themesDisabled <span class="count">(%s)</span>'
				val: '已禁用<span class="count">（%s）</span>'
			},
			rt.ArrayItem{
				key: 'themesEnabled <span class="count">(%s)</span>'
				val: '已启用<span class="count">（%s）</span>'
			},
			rt.ArrayItem{
				key: 'themesAll <span class="count">(%s)</span>'
				val: '全部<span class="count">（%s）</span>'
			},
			rt.ArrayItem{ key: 'No themes found.', val: '未找到主题。' },
			rt.ArrayItem{ key: 'verb; siteArchive', val: '存档' },
			rt.ArrayItem{ key: 'Unarchive', val: '取消存档' },
			rt.ArrayItem{ key: 'Never', val: '从未' },
			rt.ArrayItem{ key: '%1$s &#8211; %2$s', val: '%1$s &#8211; %2$s' },
			rt.ArrayItem{ key: 'siteRegistered', val: '站点注册时间' },
			rt.ArrayItem{ key: 'Last Updated', val: '上次更新' },
			rt.ArrayItem{ key: 'siteNot Spam', val: '非垃圾站点' },
			rt.ArrayItem{ key: 'siteMark as spam', val: '标记为垃圾站点' },
			rt.ArrayItem{ key: 'No sites found.', val: '未找到站点。' },
			rt.ArrayItem{ key: 'Mature', val: '成人' },
			rt.ArrayItem{ key: 'siteSpam', val: '垃圾站点' },
			rt.ArrayItem{ key: 'Archived', val: '已归档' },
			rt.ArrayItem{
				key: 'A password reset link will be sent to the user via email.'
				val: '密码重设链接将通过邮件发给用户。'
			},
			rt.ArrayItem{
				key: 'If registration is disabled, please set %1$s in %2$s to a URL you will redirect visitors to if they visit a non-existent site.'
				val: '如果注册未启用，请在 %2$s 中设置 %1$s 为您希望重定向不存在站点的访问者到的 URL。'
			},
			rt.ArrayItem{
				key: 'You must define the %1$s constant as true in your %2$s file to allow creation of a Network.'
				val: '您必须在您的 %2$s 文件中将 %1$s 常量设置为「true」才能创建站点网络。'
			},
			rt.ArrayItem{ key: 'Themes list navigation', val: '主题列表导航' },
			rt.ArrayItem{ key: 'Sites list', val: '站点列表' },
			rt.ArrayItem{ key: 'Sites list navigation', val: '站点列表导航' },
			rt.ArrayItem{ key: 'Site users list', val: '站点用户列表' },
			rt.ArrayItem{ key: 'Site users list navigation', val: '站点用户列表导航' },
			rt.ArrayItem{ key: 'Filter site users list', val: '过滤站点用户列表' },
			rt.ArrayItem{ key: 'Site themes list', val: '站点主题列表' },
			rt.ArrayItem{ key: 'Site themes list navigation', val: '站点主题列表导航' },
			rt.ArrayItem{ key: 'Filter site themes list', val: '过滤站点主题列表' },
			rt.ArrayItem{
				key: 'The domain or path entered conflicts with an existing username.'
				val: '输入的域名或路径与现有的用户名冲突。'
			},
			rt.ArrayItem{ key: 'The requested action is not valid.', val: '请求的操作无效。' },
			rt.ArrayItem{
				key: 'You are about to mark the site %s as not mature.'
				val: '您将要将站点 %s 标记为非成人网站。'
			},
			rt.ArrayItem{
				key: 'You are about to mark the site %s as mature.'
				val: '您将要将站点 %s 标记为成人网站。'
			},
			rt.ArrayItem{
				key: 'You are about to delete the site %s.'
				val: '您将要删除站点 %s。'
			},
			rt.ArrayItem{
				key: 'You are about to mark the site %s as spam.'
				val: '您将要将站点 %s 标记为垃圾。'
			},
			rt.ArrayItem{
				key: 'You are about to unspam the site %s.'
				val: '您将要将站点 %s 标记为非垃圾。'
			},
			rt.ArrayItem{
				key: 'You are about to archive the site %s.'
				val: '您将要存档站点 %s。'
			},
			rt.ArrayItem{
				key: 'You are about to unarchive the site %s.'
				val: '您将要取消存档站点 %s。'
			},
			rt.ArrayItem{
				key: 'The requested site does not exist.'
				val: '请求的站点不存在。'
			},
			rt.ArrayItem{ key: 'Path', val: '标签层级' },
			rt.ArrayItem{ key: 'Domain', val: '您的域名' },
			rt.ArrayItem{
				key: '<a href="https://codex.wordpress.org/Network_Admin_Users_Screen">Documentation on Network Users</a>'
				val: '<a href="https://codex.wordpress.org/Network_Admin_Users_Screen">站点网络用户文档</a>'
			},
			rt.ArrayItem{
				key: '<a href="https://codex.wordpress.org/Network_Admin_Themes_Screen">Documentation on Network Themes</a>'
				val: '<a href="https://codex.wordpress.org/Network_Admin_Themes_Screen">站点网络主题文档</a>'
			},
			rt.ArrayItem{
				key: 'Warning! Problem updating %1$s. Your server may not be able to connect to sites running on it. Error message: %2$s'
				val: '警告！升级 %1$s 时遇到问题，您的服务器或许不能连接到运行的站点。错误信息：%2$s'
			},
			rt.ArrayItem{ key: '%s theme deleted.', val: '已删除 %s 个主题。' },
			rt.ArrayItem{ key: '%s theme disabled.', val: '已禁用 %s 个主题。' },
			rt.ArrayItem{ key: '%s theme enabled.', val: '已启用 %s 个主题。' },
			rt.ArrayItem{ key: 'Yes, delete these themes', val: '是，删除这些主题' },
			rt.ArrayItem{
				key: 'You are about to remove the following themes:'
				val: '您将要移除以下主题：'
			},
			rt.ArrayItem{
				key: 'These themes may be active on other sites in the network.'
				val: '这些主题可能已被站点网络中的其他站点启用。'
			},
			rt.ArrayItem{ key: 'Delete Themes', val: '删除主题' },
			rt.ArrayItem{ key: 'Size in kilobytes', val: '大小，千字节' },
			rt.ArrayItem{
				key: 'Allowed file types. Separate types by spaces.'
				val: '允许的文件类型，以空格分隔。'
			},
			rt.ArrayItem{
				key: 'Add the following to your %1$s file in %2$s, <strong>replacing</strong> other WordPress rules:'
				val: '将这些加入您位于 %2$s 的 %1$s 文件，<strong>替换</strong>其他 WordPress 规则：'
			},
			rt.ArrayItem{ key: 'Confirm your action', val: '确认您的操作' },
			rt.ArrayItem{
				key: 'Hover over any user on the list to make the edit links appear. The Edit link on the left will take you to their Edit User profile page; the Edit link on the right by any site name goes to an Edit Site screen for that site.'
				val: '将鼠标移至用户的上方，将出现编辑链接。左侧的编辑链接是编辑用户信息的；而右侧的编辑链接用于编辑其所属站点的信息。'
			},
			rt.ArrayItem{
				key: 'To search for a site, <strong>enter the path or domain</strong>.'
				val: '要搜索站点，请<strong>输入路径或域名</strong>。'
			},
			rt.ArrayItem{
				key: 'To search for a user, <strong>enter an email address or username</strong>. Use a wildcard to search for a partial username, such as user&#42;.'
				val: '要搜索用户，请<strong>输入电子邮箱地址或用户名</strong>。用通配符来匹配用户名的一部分，如 user&#42;。'
			},
			rt.ArrayItem{
				key: 'To add a new site, <strong>click Create a New Site</strong>.'
				val: '要添加新站点，请<strong>点击「添加新站点」</strong>。'
			},
			rt.ArrayItem{
				key: 'To add a new user, <strong>click Create a New User</strong>.'
				val: '要添加新用户，请<strong>点击「添加新用户」</strong>。'
			},
			rt.ArrayItem{ key: 'Quick Tasks', val: '快速任务' },
			rt.ArrayItem{
				key: 'To search for a user or site, use the search boxes.'
				val: '要搜索用户或站点，请使用搜索框。'
			},
			rt.ArrayItem{
				key: 'The Right Now widget on this screen provides current user and site counts on your network.'
				val: '本页面中的「概况」小工具向您显示网络中的用户和站点统计数据。'
			},
			rt.ArrayItem{
				key: 'Modify global network settings'
				val: '修改站点网络全局设置'
			},
			rt.ArrayItem{ key: 'Update your network', val: '升级您的站点网络' },
			rt.ArrayItem{
				key: 'Install and activate themes or plugins'
				val: '安装并启用主题或插件'
			},
			rt.ArrayItem{
				key: 'Add and manage sites or users'
				val: '添加和管理站点或用户'
			},
			rt.ArrayItem{ key: 'From here you can:', val: '从这里您可以：' },
			rt.ArrayItem{
				key: 'Welcome to your Network Admin. This area of the Administration Screens is used for managing all aspects of your Multisite Network.'
				val: '欢迎来到网络管理。这个管理页面可用来管理您的多站点网络的所有方面。'
			},
			rt.ArrayItem{
				key: 'Only use this screen once you have updated to a new version of WordPress through Updates/Available Updates (via the Network Administration navigation menu or the Toolbar). Clicking the Upgrade Network button will step through each site in the network, five at a time, and make sure any database updates are applied.'
				val: '请在「更新」或「可用更新」页面（通过「管理网络」区域的导航菜单或「工具栏」来进入）升级到最新 WordPress 版本之后再使用本页面。点击「升级网络」按钮，WordPress 将自动依次升级站点网络中的所有站点（5 个一次），并确保所有站点的数据库处于最新结构。'
			},
			rt.ArrayItem{ key: 'Upgrade Network', val: '升级站点网络' },
			rt.ArrayItem{
				key: 'Subdirectory networks may not be fully compatible with custom wp-content directories.'
				val: '已子目录形式创建的站点网络可能无法与自定义的 wp-content 目录完全兼容。'
			},
			rt.ArrayItem{
				key: 'Add the designated lines of code to wp-config.php (just before <code>/*...stop editing...*/</code>) and <code>.htaccess</code> (replacing the existing WordPress rules).'
				val: '加入如下内容到 wp-config.php（在<code>/*...stop editing...*/ 或 /*...停止编辑...*/</code>上方）和<code>.htaccess</code>（替换 WordPress 原来生成的内容）。'
			},
			rt.ArrayItem{ key: 'Language Settings', val: '语言设置' },
			rt.ArrayItem{
				key: 'Allow site administrators to add new users to their site via the "Users &rarr; Add User" page'
				val: '允许站点管理员通过「用户 &rarr; 添加用户」页面添加新用户'
			},
			rt.ArrayItem{
				key: 'Super admins can no longer be added on the Options screen. You must now go to the list of existing users on Network Admin > Users and click on Username or the Edit action link below that name. This goes to an Edit User page where you can check a box to grant super admin privileges.'
				val: '现在已经不能在设置页面添加超级管理员了。您需前往「管理网络」&rarr;「用户」页面，然后点击相应的用户名，或其下的编辑链接。之后您可在用户编辑页面为用户授予超级管理员权限。'
			},
			rt.ArrayItem{
				key: 'Enter the username and email.'
				val: '输入用户名和邮箱地址。'
			},
			rt.ArrayItem{ key: 'User created.', val: '用户已创建。' },
			rt.ArrayItem{ key: 'Select a user to remove.', val: '选择要移除的用户。' },
			rt.ArrayItem{
				key: 'Select a user to change role.'
				val: '选择要更改哪位用户的权限。'
			},
			rt.ArrayItem{
				key: 'Enter the username of an existing user.'
				val: '输入现有用户的用户名。'
			},
			rt.ArrayItem{
				key: 'User is already a member of this site.'
				val: '用户已是此站点成员。'
			},
			rt.ArrayItem{ key: 'Site options updated.', val: '站点选项已更新。' },
			rt.ArrayItem{
				key: 'Site added. <a href="%1$s">Visit Dashboard</a> or <a href="%2$s">Edit Site</a>'
				val: '站点已添加。<a href="%1$s">访问仪表盘</a>或<a href="%2$s">编辑站点</a>'
			},
			rt.ArrayItem{
				key: 'This screen is for Super Admins to add new sites to the network. This is not affected by the registration settings.'
				val: '此页面供超级管理员向站点网络添加新站点使用。在这里添加站点不受站点注册策略的限制。'
			},
			rt.ArrayItem{ key: 'Site info updated.', val: '站点信息已更新。' },
			rt.ArrayItem{
				key: 'You cannot delete a theme while it is active on the main site.'
				val: '您不能删除主站点正在使用的主题。'
			},
			rt.ArrayItem{
				key: 'Themes can be enabled on a site by site basis by the network admin on the Edit Site screen (which has a Themes tab); get there via the Edit action link on the All Sites screen. Only network admins are able to install or edit themes.'
				val: '在「编辑站点」的「主题」选项卡，您可以为每个站点设置不同的主题。通过「所有站点」页面上相应站点的「编辑」链接可以找到这个选项卡。只有网络管理员有权安装和编辑主题。'
			},
			rt.ArrayItem{ key: 'No, return me to the theme list', val: '不，返回主题列表' },
			rt.ArrayItem{ key: 'Yes, delete this theme', val: '是，删除这个主题' },
			rt.ArrayItem{
				key: 'Are you sure you want to delete these themes?'
				val: '您确定要删除这些主题吗？'
			},
			rt.ArrayItem{
				key: 'You are about to remove the following theme:'
				val: '您将要移除以下主题：'
			},
			rt.ArrayItem{
				key: 'This theme may be active on other sites in the network.'
				val: '这个主题可能已被站点网络中的其他站点启用。'
			},
			rt.ArrayItem{ key: 'Delete Theme', val: '删除主题' },
			rt.ArrayItem{
				key: 'Network enabled themes are not shown on this screen.'
				val: '在站点网络中启用的主题不会显示在本页面。'
			},
			rt.ArrayItem{ key: 'No theme selected.', val: '未选择主题。' },
			rt.ArrayItem{ key: 'Theme disabled.', val: '主题已禁用。' },
			rt.ArrayItem{ key: 'Theme enabled.', val: '主题已启用。' },
			rt.ArrayItem{ key: 'Edit Site: %s', val: '编辑站点：%s' },
			rt.ArrayItem{ key: 'Invalid site ID.', val: '站点 ID 无效。' },
			rt.ArrayItem{
				key: 'Sorry, you are not allowed to delete the site %s.'
				val: '抱歉，您不能删除站点 %s。'
			},
			rt.ArrayItem{
				key: 'Delete Permanently which is a permanent action after the confirmation screen.'
				val: '「永久删除」是确认屏幕后的永久操作。'
			},
			rt.ArrayItem{
				key: 'Dashboard leads to the Dashboard for that site.'
				val: '点击「仪表盘」链接，则自动跳转至该站点的仪表盘。'
			},
			rt.ArrayItem{
				key: 'An Edit link to a separate Edit Site screen.'
				val: '「编辑」链接，带您前往「编辑站点」页面。'
			},
			rt.ArrayItem{
				key: 'Add Site takes you to the screen for adding a new site to the network. You can search for a site by Name, ID number, or IP address. Screen Options allows you to choose how many sites to display on one page.'
				val: '「添加站点」链接将带您到向站点网络添加新站点的屏幕。您可以按名称、ID 或 IP 地址搜索某站点。显示选项允许您选择在一页上显示多少个站点。'
			},
			rt.ArrayItem{ key: 'Add Users', val: '添加用户' },
			rt.ArrayItem{ key: 'Cannot add user.', val: '无法添加用户。' },
			rt.ArrayItem{
				key: 'Add User will set up a new user account on the network and send that person an email with username and password.'
				val: '点击「添加用户」链接，将会在站点网络中创建用户帐户，并自动向该用户发送包含用户名和密码的邮件。'
			},
			rt.ArrayItem{ key: 'Updates', val: '更新' },
			rt.ArrayItem{ key: 'Network Settings', val: '网络设置' },
			rt.ArrayItem{ key: 'Installed Themes', val: '已安装主题' },
			rt.ArrayItem{ key: 'All Sites', val: '所有站点' },
			rt.ArrayItem{
				key: 'Once you complete these steps, your network is enabled and configured. You will have to log in again.'
				val: '完成这些步骤后，您的站点网络即已启用并配置完成。您将需要重新登录。'
			},
			rt.ArrayItem{
				key: 'To make your installation more secure, you should also add:'
				val: '为使您的 WordPress 安装更加安全，请添加以下行：'
			},
			rt.ArrayItem{
				key: 'Complete the following steps to enable the features for creating a network of sites.'
				val: '完成以下步骤来启用创建站点网络的功能。'
			},
			rt.ArrayItem{ key: 'Enabling the Network', val: '正在启用站点网络' },
			rt.ArrayItem{
				key: 'Please complete the configuration steps. To create a new network, you will need to empty or remove the network database tables.'
				val: '请完成配置步骤。如需创建新的站点网络，您需要清空或删除站点网络的数据库表。'
			},
			rt.ArrayItem{
				key: 'An existing WordPress network was detected.'
				val: '检测到已存在的 WordPress 站点网络。'
			},
			rt.ArrayItem{
				key: 'The original configuration steps are shown here for reference.'
				val: '原始配置步骤作为参考如下所示。'
			},
			rt.ArrayItem{ key: 'Your email address.', val: '您的电子邮箱地址。' },
			rt.ArrayItem{
				key: 'What would you like to call your network?'
				val: '您想怎么称呼您的站点网络？'
			},
			rt.ArrayItem{ key: 'Network Title', val: '网络标题' },
			rt.ArrayItem{
				key: 'Because your installation is not new, the sites in your WordPress network must use sub-domains.'
				val: '因为您的站点网络并非全新安装，您 WordPress 网络中的站点必须使用子域名。'
			},
			rt.ArrayItem{
				key: 'Because your installation is in a directory, the sites in your WordPress network must use sub-directories.'
				val: '因为您的 WordPress 安装位于子目录中，所以您 WordPress 网络中的站点必须使用子目录。'
			},
			rt.ArrayItem{
				key: 'The main site in a sub-directory installation will need to use a modified permalink structure, potentially breaking existing links.'
				val: '子目录安装中的主站点将需要使用修改过的固定链接结构，这可能会损坏已有链接。'
			},
			rt.ArrayItem{ key: 'Network Details', val: '站点网络详情' },
			rt.ArrayItem{ key: 'Server Address', val: '服务器地址' },
			rt.ArrayItem{
				key: 'subdirectory exampleslike <code>%1$s/site1</code> and <code>%1$s/site2</code>'
				val: '如<code>%1$s/site1</code>和<code>%1$s/site2</code>'
			},
			rt.ArrayItem{ key: 'Sub-directories', val: '子目录' },
			rt.ArrayItem{
				key: 'subdomain exampleslike <code>site1.%1$s</code> and <code>site2.%1$s</code>'
				val: '如<code>site1.%1$s</code>和<code>site2.%1$s</code>'
			},
			rt.ArrayItem{ key: 'Sub-domains', val: '子域名' },
			rt.ArrayItem{
				key: 'You will need a wildcard DNS record if you are going to use the virtual host (sub-domain) functionality.'
				val: '如果您希望使用虚拟主机（子域名）功能，您将需要一个通配 DNS 记录。'
			},
			rt.ArrayItem{
				key: 'Addresses of Sites in your Network'
				val: '您在站点网络中的站点地址'
			},
			rt.ArrayItem{
				key: 'Fill in the information below and you&#8217;ll be on your way to creating a network of WordPress sites. Configuration files will be created in the next step.'
				val: '填写以下信息创建 WordPress 站点网络。 配置文件将在下一步骤中创建。'
			},
			rt.ArrayItem{
				key: 'Welcome to the Network installation process!'
				val: '欢迎来到站点网络安装向导！'
			},
			rt.ArrayItem{
				key: 'The network could not be created.'
				val: '无法创建站点网络。'
			},
			rt.ArrayItem{
				key: 'Once the network is created, you may reactivate your plugins.'
				val: '站点网络创建成功后，您可以重新启用插件。'
			},
			rt.ArrayItem{
				key: 'Please <a href="%s">deactivate your plugins</a> before enabling the Network feature.'
				val: '请在启用站点网络功能前<a href="%s">禁用您的插件</a>。'
			},
			rt.ArrayItem{ key: 'Network', val: '站点网络' },
			rt.ArrayItem{
				key: 'The choice of subdirectory sites is disabled if this setup is more than a month old because of permalink problems with &#8220;/blog/&#8221; from the main site. This disabling will be addressed in a future version.'
				val: '若本站点网络配置完成已经超过一个月了。由于主站点「/blog/」固定链接的问题，您不能选择使用子目录。此问题将很快在未来版本中解决。'
			},
			rt.ArrayItem{
				key: 'Once you add this code and refresh your browser, multisite should be enabled. This screen, now in the Network Admin navigation menu, will keep an archive of the added code. You can toggle between Network Admin and Site Admin by clicking on the Network Admin or an individual site name under the My Sites dropdown in the Toolbar.'
				val: '在您添加完代码后，请在浏览器刷新页面，之后多站点功能就应该自动启用了。这个页面将仍然保留这段代码，以备日后使用。您可在「管理网络」界面的导航菜单中再次访问本页面来查看代码。用户可以通过顶部「工具栏」中的「我的站点」下拉菜单在「管理网络」和「管理站点」之间切换。'
			},
			rt.ArrayItem{
				key: 'The next screen for Network Setup will give you individually-generated lines of code to add to your wp-config.php and .htaccess files. Make sure the settings of your FTP client make files starting with a dot visible, so that you can find .htaccess; you may have to create this file if it really is not there. Make backup copies of those two files.'
				val: '在「配置网络」的下一个页面，WordPress 将向您提供专为您生成的几行代码，请将它们按要求加入到 wp-config.php 和 .htaccess 文件中。请确保您的 FTP 客户端不隐藏以点（.）开头的文件，这样您才能看到 .htaccess 文件；若它确实不存在，您需手工创建这个文件。请在对文件作出更改前，备份这两个文件。'
			},
			rt.ArrayItem{
				key: 'Choose subdomains or subdirectories; this can only be switched afterwards by reconfiguring your installation. Fill out the network details, and click Install. If this does not work, you may have to add a wildcard DNS record (for subdomains) or change to another setting in Permalinks (for subdirectories).'
				val: '选择子域名或子目录；此设置只能在事后通过重新配置您的站点网络来更改。填写站点网络详情，然后点击安装。若不起作用，您可能需要添加一个通配 DNS 记录（对于子域名）或修改固定链接的设置（对于子目录）。'
			},
			rt.ArrayItem{
				key: 'This screen allows you to configure a network as having subdomains (<code>site1.example.com</code>) or subdirectories (<code>example.com/site1</code>). Subdomains require wildcard subdomains to be enabled in Apache and DNS records, if your host allows it.'
				val: '您可以在本页面配置使用子域名（<code>site1.example.com</code>）或子目录（<code>example.com/site1</code>）的站点网络。若使用子域名，您需要在 Apache 和 DNS 记录中启用泛域名。'
			},
			rt.ArrayItem{
				key: 'Create a Network of WordPress Sites'
				val: '创建 WordPress 站点网络'
			},
			rt.ArrayItem{
				key: 'The Network creation panel is not for WordPress MU networks.'
				val: '站点网络创建面板不适用于 WordPress MU 网络。'
			},
			rt.ArrayItem{
				key: 'Warning! User cannot be modified. The user %s is a network administrator.'
				val: '警告！无法修改 %s，该用户是网络管理员。'
			},
			rt.ArrayItem{
				key: 'If the admin email for the new site does not exist in the database, a new user will also be created.'
				val: '若新站点填写的管理员电子邮箱地址不存在于站点网络中，新用户也将一并被创建。'
			},
			rt.ArrayItem{
				key: 'Flag for Deletion, Archive, and Spam which lead to confirmation screens. These actions can be reversed later.'
				val: '「标记为删除」、「存档」和「垃圾站点」等操作会弹出确认页面。这些操作之后可以撤销。'
			},
			rt.ArrayItem{
				key: 'Hovering over each site reveals seven options (three for the primary site):'
				val: '将鼠标移至站点上方，会出现 7 个选项（主站点则出现 3 个）：'
			},
			rt.ArrayItem{
				key: 'Operational settings has fields for the network&#8217;s name and admin email.'
				val: '运营设置包括站点网络的名称及管理员电子邮箱地址字段。'
			},
			rt.ArrayItem{
				key: 'The bulk action will permanently delete selected users, or mark/unmark those selected as spam. Spam users will have posts removed and will be unable to sign up again with the same email addresses.'
				val: '批量操作将永久删除选中的用户，或标记 / 取消标记选择的用户为垃圾用户。垃圾用户发布的文章将被移除，并无法再使用相同的电子邮箱地址注册。'
			},
			rt.ArrayItem{
				key: 'You can also go to the user&#8217;s profile page by clicking on the individual username.'
				val: '您也可以通过点击用户名转到用户的个人资料页面。'
			},
			rt.ArrayItem{
				key: 'Upload settings control the size of the uploaded files and the amount of available upload space for each site. You can change the default value for specific sites when you edit a particular site. Allowed file types are also listed (space separated only).'
				val: '上传设置控制每个站点所能上传的文件数目、大小和文件类型（用空格隔开）。您也可以对每个站点做出不同的限制。'
			},
			rt.ArrayItem{
				key: 'You can make an existing user an additional super admin by going to the Edit User profile page and checking the box to grant that privilege.'
				val: '您可以让一个现有的用户成为额外的超级管理员，方法是进入编辑用户个人资料的页面，勾选方框以授予该权限。'
			},
			rt.ArrayItem{
				key: 'Users who are signed up to the network without a site are added as subscribers to the main or primary dashboard site, giving them profile pages to manage their accounts. These users will only see Dashboard and My Sites in the main navigation until a site is created for them.'
				val: '已在站点网络中注册，且不拥有站点的用户将以订阅者的身份加入主仪表盘站点，允许他们在其中修改资料、管理自己的账户。在他们创建自己的站点之前，只能在导航栏中看到「仪表盘」和「我的站点」菜单。'
			},
			rt.ArrayItem{
				key: 'You can sort the table by clicking on any of the table headings and switch between list and excerpt views by using the icons above the users list.'
				val: '您可以点击表头来排序，也可以使用用户列表上方的图标来切换列表和摘要视图。'
			},
			rt.ArrayItem{
				key: 'This table shows all users across the network and the sites to which they are assigned.'
				val: '本表格列出了站点网络中的所有用户，以及它们所在的站点。'
			},
			rt.ArrayItem{
				key: 'If this process fails for any reason, users logging in to their sites will force the same update.'
				val: '若更新的过程因故中断或失败，登录站点的用户将被要求继续进行更新。'
			},
			rt.ArrayItem{
				key: 'If a version update to core has not happened, clicking this button will not affect anything.'
				val: '若您没有升级 WordPress 核心，点击这个按钮是不会起任何作用的。'
			},
			rt.ArrayItem{
				key: 'If the network admin disables a theme that is in use, it can still remain selected on that site. If another theme is chosen, the disabled theme will not appear in the site&#8217;s Appearance > Themes screen.'
				val: '若网络管理员禁用了正在使用的主题，在该站点上，这个主题将依然可用。一旦这位用户选择了其他主题，那么用户就无法再选择回来了。'
			},
			rt.ArrayItem{
				key: 'This screen enables and disables the inclusion of themes available to choose in the Appearance menu for each site. It does not activate or deactivate which theme a site is currently using.'
				val: '本页面设置每个站点的「外观」菜单中，可供用户选择的主题。不能禁用站点正在使用的主题。'
			},
			rt.ArrayItem{
				key: 'This is the main table of all sites on this network. Switch between list and excerpt views by using the icons above the right side of the table.'
				val: '这是本站点网络中所有站点的列表。您可通过点击列表上方的按钮，在「列表视图」和「摘要视图」模式间切换。'
			},
			rt.ArrayItem{
				key: 'Menu setting enables/disables the plugin menus from appearing for non super admins, so that only super admins, not site admins, have access to activate plugins.'
				val: '菜单设置允许您选择一般用户是否有权自行控制插件。'
			},
			rt.ArrayItem{
				key: 'New site settings are defaults applied when a new site is created in the network. These include welcome email for when a new site or user account is registered, and what&#8127;s put in the first post, page, comment, comment author, and comment URL.'
				val: '新站点设置是对于未来注册的站点的默认值。包含「欢迎」邮件、首篇文章、首篇评论、首个页面的内容。'
			},
			rt.ArrayItem{
				key: 'Registration settings can disable/enable public signups. If you let others sign up for a site, install spam plugins. Spaces, not commas, should separate names banned as sites for this network.'
				val: '注册选项可以启用 / 禁用公开注册。如果您允许其他人注册站点，建议您安装「防垃圾内容」的插件。您可以指定一些不允许作为站点名称的词语，用空格隔开（请注意不是逗号）。'
			},
			rt.ArrayItem{
				key: 'This screen sets and changes options for the network as a whole. The first site is the main site in the network and network options are pulled from that original site&#8217;s options.'
				val: '在本页面可对整个站点网络的设置进行修改。第一个站点是网络中的主站点，站点网络的设置从原始站点的设置中继承。'
			},
			rt.ArrayItem{
				key: 'The following words are reserved for use by WordPress functions and cannot be used as site names: %s'
				val: '以下保留字词仅供 WordPress 函数使用，无法用作站点名称：%s'
			},
			rt.ArrayItem{
				key: 'If your browser does not start loading the next page automatically, click this link:'
				val: '若您的浏览器不自动加载下一页，请点击：'
			},
			rt.ArrayItem{
				key: 'If you want to ban domains from site registrations. One domain per line.'
				val: '如果您想禁止使用下列电子邮箱域名的用户注册站点。每行一个域名。'
			},
			rt.ArrayItem{
				key: 'If you want to limit site registrations to certain domains. One domain per line.'
				val: '若您想把站点的注册限制于某些域名。每行一个域名。'
			},
			rt.ArrayItem{
				key: 'Users removed from spam.'
				val: '多个用户已被从垃圾用户列表中移除。'
			},
			rt.ArrayItem{ key: 'Site marked as spam.', val: '站点已被标记为垃圾站点。' },
			rt.ArrayItem{
				key: 'Site removed from spam.'
				val: '站点已被从垃圾站点列表中移除。'
			},
			rt.ArrayItem{
				key: 'Sites marked as spam.'
				val: '多个站点已被标记为垃圾站点。'
			},
			rt.ArrayItem{
				key: 'Sites removed from spam.'
				val: '多个站点已被从垃圾站点列表中移除。'
			},
			rt.ArrayItem{ key: 'Users deleted.', val: '用户已被删除。' },
			rt.ArrayItem{ key: 'Users marked as spam.', val: '用户已被标记为垃圾用户。' },
			rt.ArrayItem{ key: 'Site unarchived.', val: '站点未被存档。' },
			rt.ArrayItem{ key: 'Site archived.', val: '站点已被存档。' },
			rt.ArrayItem{
				key: 'Sorry, you are not allowed to change the current site.'
				val: '抱歉，您不能修改此站点。'
			},
			rt.ArrayItem{
				key: 'There was an error creating the user.'
				val: '创建用户过程中出错。'
			},
			rt.ArrayItem{ key: 'Upload file types', val: '上传文件类型' },
			rt.ArrayItem{
				key: 'Limit total size of files uploaded to %s MB'
				val: '上传文件的总大小不能超过 %s MB'
			},
			rt.ArrayItem{
				key: 'The URL for the first comment on a new site.'
				val: '新站点首条评论者的网址。'
			},
			rt.ArrayItem{
				key: 'The author of the first comment on a new site.'
				val: '新站点首条评论的评论者名称。'
			},
			rt.ArrayItem{
				key: 'The first comment on a new site.'
				val: '新站点的首条评论。'
			},
			rt.ArrayItem{ key: 'The first page on a new site.', val: '新站点的首个页面。' },
			rt.ArrayItem{ key: 'The first post on a new site.', val: '新站点的首篇文章。' },
			rt.ArrayItem{ key: 'All done!', val: '已全部完成！' },
			rt.ArrayItem{
				key: 'Both sites and user accounts can be registered'
				val: '可以注册站点和用户账户'
			},
			rt.ArrayItem{
				key: 'Logged in users may register new sites'
				val: '已登录用户可以注册新站点'
			},
			rt.ArrayItem{ key: 'User accounts may be registered', val: '用户可以注册账户' },
			rt.ArrayItem{ key: 'Registration is disabled', val: '停用注册' },
			rt.ArrayItem{ key: 'Enable administration menus', val: '启用管理菜单' },
			rt.ArrayItem{ key: 'Upload Settings', val: '上传设置' },
			rt.ArrayItem{ key: 'New Site Settings', val: '新站点设置' },
			rt.ArrayItem{ key: 'Registration Settings', val: '注册设置' },
			rt.ArrayItem{ key: 'Operational Settings', val: '操作设置' },
			rt.ArrayItem{ key: 'Missing email address.', val: '电子邮箱地址缺失。' },
			rt.ArrayItem{
				key: 'Missing or invalid site address.'
				val: '站点地址缺少或无效。'
			},
			rt.ArrayItem{ key: 'Next Sites', val: '继续升级下一批站点' },
			rt.ArrayItem{ key: 'Site upload space', val: '站点上传大小配额' },
			rt.ArrayItem{
				key: 'The welcome email sent to new site owners.'
				val: '用以欢迎新站点所有者的邮件内容。'
			},
			rt.ArrayItem{
				key: 'Users are not allowed to register these sites. Separate names by spaces.'
				val: '用户不可注册这些站点。名称间使用空格隔开。'
			},
			rt.ArrayItem{
				key: 'Send the network admin an email notification every time someone registers a site or user account'
				val: '在有人注册站点或用户账户时向网络管理员发送邮件通知'
			},
			rt.ArrayItem{ key: 'Network Admin Email', val: '网络管理员邮箱' },
			rt.ArrayItem{
				key: 'A new user will be created if the above email address is not in the database.'
				val: '若邮箱地址在数据库中不存在，新用户将被创建。'
			},
			rt.ArrayItem{ key: 'Admin Email', val: '管理员邮箱' },
			rt.ArrayItem{ key: 'Add Site', val: '添加站点' },
			rt.ArrayItem{ key: 'Default Language', val: '默认语言' },
			rt.ArrayItem{ key: 'Max upload file size', val: '最大上传文件的大小' },
			rt.ArrayItem{ key: 'First Comment URL', val: '首条评论者的 URL' },
			rt.ArrayItem{ key: 'First Comment Author', val: '首条评论的评论者名称' },
			rt.ArrayItem{ key: 'First Comment', val: '首条评论' },
			rt.ArrayItem{ key: 'First Page', val: '首个页面' },
			rt.ArrayItem{
				key: 'The welcome email sent to new users.'
				val: '要发送给新用户的欢迎邮件内容。'
			},
			rt.ArrayItem{ key: 'Welcome User Email', val: '「欢迎」用户邮件' },
			rt.ArrayItem{ key: 'Welcome Email', val: '「欢迎」邮件' },
			rt.ArrayItem{ key: 'Banned Email Domains', val: '禁止使用的电子邮箱域名' },
			rt.ArrayItem{ key: 'Limited Email Registrations', val: '电子邮箱域名注册限制' },
			rt.ArrayItem{ key: 'Banned Names', val: '不允许使用的名称' },
			rt.ArrayItem{ key: 'Add New User', val: '添加新用户' },
			rt.ArrayItem{ key: 'Registration notification', val: '注册提醒' },
			rt.ArrayItem{ key: 'Allow new registrations', val: '允许新站点注册' },
			rt.ArrayItem{
				key: 'Duplicated username or email address.'
				val: '用户名或电子邮箱地址重复。'
			},
			rt.ArrayItem{ key: 'Cannot create an empty user.', val: '不能创建空用户。' },
			rt.ArrayItem{ key: 'Confirm', val: '确认' },
		]) }])
}
