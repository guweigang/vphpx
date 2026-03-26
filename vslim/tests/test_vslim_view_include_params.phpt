--TEST--
VSlim View include supports local scalar and list assignments
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$tmpDir = sys_get_temp_dir() . '/vslim_view_include_params_' . uniqid('', true);
@mkdir($tmpDir, 0777, true);

file_put_contents($tmpDir . '/card.html', <<<'HTML'
<section>
  <h2>{{title}}</h2>
  <p>{{note}}</p>
  <ul>{{for:items}}<li>{{item}}</li>{{/for}}</ul>
</section>
HTML);

file_put_contents($tmpDir . '/page.html', <<<'HTML'
{{include:card.html|title=page_title,note="Local Note",items=list(tags)}}
HTML);

file_put_contents($tmpDir . '/profile.html', <<<'HTML'
<article>
  <h3>{{user_copy.name}}</h3>
  <p>{{user_copy.meta.role}}</p>
  <ul>{{for:user_copy.skills}}<li>{{item}}</li>{{/for}}</ul>
</article>
HTML);

file_put_contents($tmpDir . '/profile_alias.html', <<<'HTML'
<article>
  <h4>{{profile.name}}</h4>
  <p>{{profile.meta.role}}</p>
  <ul>{{for:profile.skills}}<li>{{item}}</li>{{/for}}</ul>
</article>
HTML);

file_put_contents($tmpDir . '/page_mixed.html', <<<'HTML'
{{include:card.html|title=page_title,note="Mixed Note",items=list(tags)}}
HTML);

file_put_contents($tmpDir . '/page_map.html', <<<'HTML'
{{include:profile.html|user_copy=map(user)}}
HTML);

file_put_contents($tmpDir . '/page_map_nested.html', <<<'HTML'
{{include:profile_alias.html|profile=map(user.profile)}}
HTML);

$app->set_view_base_path($tmpDir);
$view = $app->make_view();
$body = $view->render('page.html', [
    'page_title' => 'Include Card',
    'tags' => ['go', 'php'],
]);

echo (str_contains($body, '<h2>Include Card</h2>') ? 'include-title-ok' : 'include-title-miss') . PHP_EOL;
echo (str_contains($body, '<p>Local Note</p>') ? 'include-literal-ok' : 'include-literal-miss') . PHP_EOL;
echo (str_contains($body, '<li>go</li><li>php</li>') ? 'include-list-ok' : 'include-list-miss') . PHP_EOL;

$mixed = $view->render('page_mixed.html', [
    'page_title' => 'Mixed Include Card',
    'tags' => ['v', 'zig'],
]);

echo (str_contains($mixed, '<h2>Mixed Include Card</h2>') ? 'include-mixed-title-ok' : 'include-mixed-title-miss') . PHP_EOL;
echo (str_contains($mixed, '<p>Mixed Note</p>') ? 'include-mixed-literal-ok' : 'include-mixed-literal-miss') . PHP_EOL;
echo (str_contains($mixed, '<li>v</li><li>zig</li>') ? 'include-mixed-list-ok' : 'include-mixed-list-miss') . PHP_EOL;

$mapped = $view->render('page_map.html', [
    'user' => [
        'name' => 'Neo',
        'meta' => ['role' => 'captain'],
        'skills' => ['v', 'php'],
    ],
]);

echo (str_contains($mapped, '<h3>Neo</h3>') ? 'include-map-name-ok' : 'include-map-name-miss') . PHP_EOL;
echo (str_contains($mapped, '<p>captain</p>') ? 'include-map-role-ok' : 'include-map-role-miss') . PHP_EOL;
echo (str_contains($mapped, '<li>v</li><li>php</li>') ? 'include-map-list-ok' : 'include-map-list-miss') . PHP_EOL;

$nested = $view->render('page_map_nested.html', [
    'user' => [
        'profile' => [
            'name' => 'Trinity',
            'meta' => ['role' => 'operator'],
            'skills' => ['ops', 'rescue'],
        ],
    ],
]);

echo (str_contains($nested, '<h4>Trinity</h4>') ? 'include-map-nested-name-ok' : 'include-map-nested-name-miss') . PHP_EOL;
echo (str_contains($nested, '<p>operator</p>') ? 'include-map-nested-role-ok' : 'include-map-nested-role-miss') . PHP_EOL;
echo (str_contains($nested, '<li>ops</li><li>rescue</li>') ? 'include-map-nested-list-ok' : 'include-map-nested-list-miss') . PHP_EOL;

@unlink($tmpDir . '/card.html');
@unlink($tmpDir . '/page.html');
@unlink($tmpDir . '/profile.html');
@unlink($tmpDir . '/profile_alias.html');
@unlink($tmpDir . '/page_mixed.html');
@unlink($tmpDir . '/page_map.html');
@unlink($tmpDir . '/page_map_nested.html');
@rmdir($tmpDir);
?>
--EXPECT--
include-title-ok
include-literal-ok
include-list-ok
include-mixed-title-ok
include-mixed-literal-ok
include-mixed-list-ok
include-map-name-ok
include-map-role-ok
include-map-list-ok
include-map-nested-name-ok
include-map-nested-role-ok
include-map-nested-list-ok
