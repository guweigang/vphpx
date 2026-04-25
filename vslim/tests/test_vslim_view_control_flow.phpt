--TEST--
VSlim View supports simple if/else and for control flow tokens
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$tmpDir = sys_get_temp_dir() . '/vslim_view_cf_' . uniqid('', true);
@mkdir($tmpDir, 0777, true);
$tpl = <<<'HTML'
{{if:show_title}}<h1>{{ title }}</h1>{{/if}}
{{if:show_desc}}<p>{{ desc }}</p>{{else}}<p>NO-DESC</p>{{/if}}
<ul>
{{for:tags}}<li data-i="{{index}}">{{item}}</li>{{/for}}
</ul>
<p id="trim">{{ trim(title_spaced) }}</p>
<p id="first">{{ first(tags) }}</p>
<p id="last">{{ last(tags) }}</p>
<p id="join">{{ tags | join(" + ") }}</p>
<p id="join-mixed">{{ tags | join(", ") }}</p>
<p id="default-title">{{ default(missing_title, "Fallback Title") }}</p>
<p id="default-title-mixed">{{ default(missing_title, "Mixed Title") }}</p>
<p id="default-name">{{ default(missing_name, title) }}</p>
<p id="reduce-sum">{{ scores | reduce("sum") }}</p>
<p id="reduce-count">{{ scores | reduce("count") }}</p>
<p id="reduce-seed">{{ scores | reduce("acc+item", 10) }}</p>
<p id="reduce-seed-var">{{ scores | reduce("acc+item", seed_num) }}</p>
<p id="reduce-expr">{{ scores | reduce("acc*2+item", 1) }}</p>
{{if:eq|title, "Hello"}}<p id="eq-new">EQ-NEW</p>{{/if}}
{{if:ne|title, "World"}}<p id="ne-new">NE-NEW</p>{{/if}}
{{if:contains|title, "ell"}}<p id="contains-text">CONTAINS-TEXT</p>{{/if}}
{{if:contains|tags, "php"}}<p id="contains-list-new">CONTAINS-LIST-NEW</p>{{/if}}
{{if:in|title, list(allowed_titles)}}<p id="in-list-new">IN-LIST-NEW</p>{{/if}}
{{if:not_in|title, "World,Other"}}<p id="not-in-list-new">NOT-IN-LIST-NEW</p>{{/if}}
{{if:eq|status_num, "10"}}<p id="eq-num">EQ-NUM</p>{{/if}}
{{if:ne|status_num, "9"}}<p id="ne-num">NE-NUM</p>{{/if}}
{{if:in|status_num, list(allowed_codes)}}<p id="in-num">IN-NUM</p>{{/if}}
{{if:contains|flags, true}}<p id="contains-bool">CONTAINS-BOOL</p>{{/if}}
{{if:eq|is_ready, true}}<p id="eq-bool">EQ-BOOL</p>{{/if}}
{{if:eq|empty_value, null}}<p id="eq-null">EQ-NULL</p>{{/if}}
{{if:empty|missing_title}}<p id="empty">EMPTY</p>{{/if}}
{{if:not_empty|title}}<p id="not-empty">NOT-EMPTY</p>{{/if}}
{{if:|status_num == 10 && seed_num == 10 && profile.age > 14}}<p id="expr-and">EXPR-AND</p>{{/if}}
{{if:|(status_num == 10 && seed_num == 10) && !missing_title}}<p id="expr-paren-not">EXPR-PAREN-NOT</p>{{/if}}
{{if:|profile.age >= 18 || title == "World"}}<p id="expr-or">EXPR-OR</p>{{/if}}
{{if:|user.display_name() == "NEO"}}<p id="expr-method">EXPR-METHOD</p>{{/if}}
<section id="nested-if-if">
{{if:outer_flag}}{{if:inner_flag}}<span>IF-IN-IF</span>{{/if}}{{/if}}
</section>
<section id="nested-if-for">
{{if:show_matrix}}{{for:matrix}}<b>{{item}}</b>{{/for}}{{/if}}
</section>
<section id="nested-for-if">
{{for:rows}}{{if:item.visible}}<i>{{item.name}}</i>{{/if}}{{/for}}
</section>
<section id="nested-for-for">
{{for:group_labels}}<div>{{item}}:{{for:group_members}}<em>{{item}}</em>{{/for}}</div>{{/for}}
</section>
HTML;
file_put_contents($tmpDir . '/view_control_flow.inline.html', $tpl);
$app->setViewBasePath($tmpDir);
$view = $app->makeView();

$body = $view->render('view_control_flow.inline.html', [
    'show_title' => '1',
    'show_desc' => '0',
    'title' => 'Hello',
    'title_spaced' => '  Hello  ',
    'desc' => 'Should not render',
    'tags' => ['go', '<b>x</b>', 'php'],
    'flags' => ['false', 'true'],
    'allowed_titles' => ['Hello', 'Welcome'],
    'allowed_codes' => ['8', '10'],
    'scores' => ['1', '2', '3'],
    'status_num' => 10,
    'is_ready' => true,
    'empty_value' => null,
    'seed_num' => 10,
    'profile' => ['age' => 18],
    'user' => new class {
        public function display_name() {
            return 'NEO';
        }
    },
    'outer_flag' => true,
    'inner_flag' => true,
    'show_matrix' => true,
    'matrix' => ['A', 'B'],
    'rows' => [
        ['name' => 'neo', 'visible' => true],
        ['name' => 'smith', 'visible' => false],
        ['name' => 'trinity', 'visible' => true],
    ],
    'group_labels' => ['Team'],
    'group_members' => ['neo', 'trinity'],
]);

echo (str_contains($body, '<h1>Hello</h1>') ? 'if-ok' : 'if-miss') . PHP_EOL;
echo (str_contains($body, '<p>NO-DESC</p>') ? 'else-ok' : 'else-miss') . PHP_EOL;
echo (str_contains($body, '<li data-i="0">go</li>') ? 'for-0-ok' : 'for-0-miss') . PHP_EOL;
echo (str_contains($body, '<li data-i="1">&lt;b&gt;x&lt;/b&gt;</li>') ? 'for-escape-ok' : 'for-escape-miss') . PHP_EOL;
echo (str_contains($body, '<p id="trim">Hello</p>') ? 'trim-ok' : 'trim-miss') . PHP_EOL;
echo (str_contains($body, '<p id="first">go</p>') ? 'first-ok' : 'first-miss') . PHP_EOL;
echo (str_contains($body, '<p id="last">php</p>') ? 'last-ok' : 'last-miss') . PHP_EOL;
$joinOk = str_contains($body, '<p id="join">go + ')
    && str_contains($body, '&lt;b&gt;x&lt;/b&gt;')
    && str_contains($body, ' + php</p>');
echo ($joinOk ? 'join-ok' : 'join-miss') . PHP_EOL;
echo (str_contains($body, '<p id="join-mixed">go, &lt;b&gt;x&lt;/b&gt;, php</p>') ? 'join-mixed-ok' : 'join-mixed-miss') . PHP_EOL;
echo (str_contains($body, '<p id="default-title">Fallback Title</p>') ? 'default-literal-ok' : 'default-literal-miss') . PHP_EOL;
echo (str_contains($body, '<p id="default-title-mixed">Mixed Title</p>') ? 'default-literal-mixed-ok' : 'default-literal-mixed-miss') . PHP_EOL;
echo (str_contains($body, '<p id="default-name">Hello</p>') ? 'default-var-ok' : 'default-var-miss') . PHP_EOL;
echo (str_contains($body, '<p id="reduce-sum">6</p>') ? 'reduce-sum-ok' : 'reduce-sum-miss') . PHP_EOL;
echo (str_contains($body, '<p id="reduce-count">3</p>') ? 'reduce-count-ok' : 'reduce-count-miss') . PHP_EOL;
echo (str_contains($body, '<p id="reduce-seed">16</p>') ? 'reduce-seed-ok' : 'reduce-seed-miss') . PHP_EOL;
echo (str_contains($body, '<p id="reduce-seed-var">16</p>') ? 'reduce-seed-var-ok' : 'reduce-seed-var-miss') . PHP_EOL;
echo (str_contains($body, '<p id="reduce-expr">19</p>') ? 'reduce-expr-ok' : 'reduce-expr-miss') . PHP_EOL;
echo (str_contains($body, '<p id="eq-new">EQ-NEW</p>') ? 'eq-new-ok' : 'eq-new-miss') . PHP_EOL;
echo (str_contains($body, '<p id="ne-new">NE-NEW</p>') ? 'ne-new-ok' : 'ne-new-miss') . PHP_EOL;
echo (str_contains($body, '<p id="contains-text">CONTAINS-TEXT</p>') ? 'contains-text-ok' : 'contains-text-miss') . PHP_EOL;
echo (str_contains($body, '<p id="contains-list-new">CONTAINS-LIST-NEW</p>') ? 'contains-list-new-ok' : 'contains-list-new-miss') . PHP_EOL;
echo (str_contains($body, '<p id="in-list-new">IN-LIST-NEW</p>') ? 'in-list-new-ok' : 'in-list-new-miss') . PHP_EOL;
echo (str_contains($body, '<p id="not-in-list-new">NOT-IN-LIST-NEW</p>') ? 'not-in-list-new-ok' : 'not-in-list-new-miss') . PHP_EOL;
echo (str_contains($body, '<p id="eq-num">EQ-NUM</p>') ? 'eq-num-ok' : 'eq-num-miss') . PHP_EOL;
echo (str_contains($body, '<p id="ne-num">NE-NUM</p>') ? 'ne-num-ok' : 'ne-num-miss') . PHP_EOL;
echo (str_contains($body, '<p id="in-num">IN-NUM</p>') ? 'in-num-ok' : 'in-num-miss') . PHP_EOL;
echo (str_contains($body, '<p id="contains-bool">CONTAINS-BOOL</p>') ? 'contains-bool-ok' : 'contains-bool-miss') . PHP_EOL;
echo (str_contains($body, '<p id="eq-bool">EQ-BOOL</p>') ? 'eq-bool-ok' : 'eq-bool-miss') . PHP_EOL;
echo (str_contains($body, '<p id="eq-null">EQ-NULL</p>') ? 'eq-null-ok' : 'eq-null-miss') . PHP_EOL;
echo (str_contains($body, '<p id="empty">EMPTY</p>') ? 'empty-ok' : 'empty-miss') . PHP_EOL;
echo (str_contains($body, '<p id="not-empty">NOT-EMPTY</p>') ? 'not-empty-ok' : 'not-empty-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-and">EXPR-AND</p>') ? 'expr-and-ok' : 'expr-and-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-paren-not">EXPR-PAREN-NOT</p>') ? 'expr-paren-not-ok' : 'expr-paren-not-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-or">EXPR-OR</p>') ? 'expr-or-ok' : 'expr-or-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-method">EXPR-METHOD</p>') ? 'expr-method-ok' : 'expr-method-miss') . PHP_EOL;
echo (str_contains($body, '<section id="nested-if-if">' . "\n" . '<span>IF-IN-IF</span>' . "\n" . '</section>') ? 'nested-if-if-ok' : 'nested-if-if-miss') . PHP_EOL;
echo (str_contains($body, '<section id="nested-if-for">' . "\n" . '<b>A</b><b>B</b>' . "\n" . '</section>') ? 'nested-if-for-ok' : 'nested-if-for-miss') . PHP_EOL;
echo (str_contains($body, '<section id="nested-for-if">' . "\n" . '<i>neo</i><i>trinity</i>' . "\n" . '</section>') ? 'nested-for-if-ok' : 'nested-for-if-miss') . PHP_EOL;
echo (str_contains($body, '<section id="nested-for-for">' . "\n" . '<div>Team:<em>neo</em><em>trinity</em></div>' . "\n" . '</section>') ? 'nested-for-for-ok' : 'nested-for-for-miss') . PHP_EOL;
@unlink($tmpDir . '/view_control_flow.inline.html');
@rmdir($tmpDir);
?>
--EXPECT--
if-ok
else-ok
for-0-ok
for-escape-ok
trim-ok
first-ok
last-ok
join-ok
join-mixed-ok
default-literal-ok
default-literal-mixed-ok
default-var-ok
reduce-sum-ok
reduce-count-ok
reduce-seed-ok
reduce-seed-var-ok
reduce-expr-ok
eq-new-ok
ne-new-ok
contains-text-ok
contains-list-new-ok
in-list-new-ok
not-in-list-new-ok
eq-num-ok
ne-num-ok
in-num-ok
contains-bool-ok
eq-bool-ok
eq-null-ok
empty-ok
not-empty-ok
expr-and-ok
expr-paren-not-ok
expr-or-ok
expr-method-ok
nested-if-if-ok
nested-if-for-ok
nested-for-if-ok
nested-for-for-ok
