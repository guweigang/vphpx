--TEST--
VSlim LiveView websocket protocol accepts, joins, preserves state, and emits JSON patches
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php

$app = new VSlim\App();
$app->setViewBasePath(__DIR__ . '/fixtures');
$GLOBALS['ws_app'] = $app;

function find_live_op(array $ops, string $op, string $id): ?array
{
    foreach ($ops as $entry) {
        if (($entry['op'] ?? '') === $op && ($entry['id'] ?? '') === $id) {
            return $entry;
        }
    }
    return null;
}

final class CounterLiveSocketSink
{
    public int $accepted = 0;
    public array $meta = [];
    public array $joined = [];
    public array $left = [];
    public array $dispatches = [];

    public function accept(): void
    {
        $this->accepted++;
    }

    public function setMeta(string $key, string $value): void
    {
        $this->meta[$key] = $value;
    }

    public function clearMeta(string $key): void
    {
        unset($this->meta[$key]);
    }

    public function join(string $room): void
    {
        $this->joined[] = $room;
    }

    public function leave(string $room): void
    {
        $this->left[] = $room;
    }

    public function broadcastDispatch(string $room, string $data, string $exceptId = ''): void
    {
        $this->dispatches[] = [
            'room' => $room,
            'data' => $data,
            'except_id' => $exceptId,
        ];
    }
}

final class CounterLiveWsView extends VSlim\Live\View
{
    private function setProfileState(VSlim\Live\Socket $socket, string $status, string $tone, string $detail, ?string $savedAt = null): void
    {
        $nextSavedAt = $savedAt ?? (string) $socket->get('profile_saved_at');
        $socket
            ->assign('profile_status', $status)
            ->assign('profile_tone', $tone)
            ->assign('profile_detail', $detail)
            ->assign('profile_saved_at', $nextSavedAt)
            ->setText('counter-profile-status', $status)
            ->setText('counter-profile-tone', $tone)
            ->setText('counter-profile-detail', $detail)
            ->setText('counter-profile-saved-at', $nextSavedAt)
            ->setAttr('counter-profile-pill', 'data-state', $tone)
            ->setAttr('counter-profile-state', 'data-state', $tone);
    }

    public function component(string $id, VSlim\Live\Socket $socket): ?VSlim\Live\Component
    {
        if ($id === 'summary') {
            $component = new CounterSummaryComponent();
            $component->setId('summary-root');
            $component->bindSocket($socket);
            return $component;
        }
        if (str_starts_with($id, 'badge-') && $socket->has('badge_label_' . $id)) {
            $component = new CounterBadgeComponent();
            $component->setApp($GLOBALS['ws_app']);
            $component->setTemplate('live_counter_badge_test.html');
            $component->setId($id);
            $component->assign('badge_id', $id);
            $component->assign('label', $socket->get('badge_label_' . $id));
            return $component;
        }
        return null;
    }

    public function mount(VSlim\VHttpd\Request $req, VSlim\Live\Socket $socket): void
    {
        $socket
            ->setRootId('counter-root')
            ->assign('count', 1)
            ->assign('label', 'server-owned counter')
            ->assign('notify_email', 'ops@example.com')
            ->assign('profile_status', 'Draft')
            ->assign('profile_tone', 'draft')
            ->assign('profile_detail', 'Waiting for your first save.')
            ->assign('profile_saved_at', 'Not saved yet')
            ->assign('error_label', '')
            ->assign('error_notify_email', '')
            ->assign('badge_seq', 0)
            ->assign('badge_keys', '');
    }

    public function handleEvent(string $event, array $payload, VSlim\Live\Socket $socket): void
    {
        if ($event === 'inc') {
            $next = (int) $socket->get('count') + (int) ($payload['step'] ?? 1);
            $socket
                ->assign('count', $next)
                ->pushEvent('saved', '{"ok":true,"count":' . $next . '}');
            return;
        }

        if ($event === 'subscribe') {
            $socket->joinTopic('counter-room');
            return;
        }

        if ($event === 'notify') {
            $socket->broadcastInfo('counter-room', 'inc_remote', [
                'step' => (int) ($payload['step'] ?? 1),
            ], false);
            return;
        }

        if ($event === 'notify_ui') {
            $socket
                ->flash('info', 'Saved from protocol')
                ->navigate('/counter?tab=history');
            return;
        }

        if ($event === 'add_badge') {
            $next = (int) $socket->get('badge_seq') + 1;
            $badgeId = 'badge-' . $next;
            $keys = array_values(array_filter(explode(',', (string) $socket->get('badge_keys'))));
            $keys[] = $badgeId;
            $socket
                ->assign('badge_seq', $next)
                ->assign('badge_keys', implode(',', $keys))
                ->assign('badge_label_' . $badgeId, 'Badge ' . $next)
                ->setText('badge-count', (string) count($keys));
            $badge = $this->component($badgeId, $socket);
            if ($badge instanceof VSlim\Live\Component) {
                $badge->appendTo($socket, 'badge-list');
            }
            return;
        }

        if ($event === 'profile_save') {
            $form = $socket
                ->form('profile')
                ->fill($payload)
                ->validate(static function (array $data): array {
                    $label = trim((string) ($data['label'] ?? ''));
                    $email = trim((string) ($data['notify_email'] ?? ''));
                    $errors = [];
                    if ($label === '') {
                        $errors['label'] = 'Label is required.';
                    } elseif (strlen($label) < 3) {
                        $errors['label'] = 'Use at least 3 characters.';
                    }
                    if ($email === '') {
                        $errors['notify_email'] = 'Email is required.';
                    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                        $errors['notify_email'] = 'Use a valid email address.';
                    }
                    return $errors;
                });
            $label = trim((string) $form->input('label'));
            $email = trim((string) $form->input('notify_email'));
            if ($form->invalid()) {
                $socket
                    ->setText('profile-label-error', $form->error('label'))
                    ->setText('profile-email-error', $form->error('notify_email'));
                $this->setProfileState($socket, 'Invalid', 'invalid', 'Fix the highlighted fields before saving.');
                return;
            }
            $savedAt = '09:30:00';
            $socket
                ->clearErrors()
                ->setText('profile-label-error', '')
                ->setText('profile-email-error', '')
                ->setText('profile-label-value', $label)
                ->setText('profile-email-value', $email)
                ->setText('profile-status', 'Saved')
                ->setText('profile-saved-at', $savedAt)
                ->flash('info', 'Profile saved for ' . $email . ' at ' . $savedAt);
            $this->setProfileState($socket, 'Saved', 'saved', 'Server accepted the latest profile values.', $savedAt);
            return;
        }

        if ($event === 'clear_profile') {
            $socket->form('profile')->reset([
                'label' => '',
                'notify_email' => '',
            ]);
            $socket
                ->setText('profile-label-error', '')
                ->setText('profile-email-error', '')
                ->setText('profile-label-value', '')
                ->setText('profile-email-value', '')
                ->setText('profile-status', 'Draft')
                ->setText('profile-saved-at', 'Not saved yet')
                ->flash('info', 'Cleared form inputs from the server.');
            $this->setProfileState($socket, 'Draft', 'draft', 'Inputs were cleared on the server.', 'Not saved yet');
        }
    }

    public function handleInfo(string $event, array $payload, VSlim\Live\Socket $socket): void
    {
        if ($event === 'inc_remote') {
            $next = (int) $socket->get('count') + (int) ($payload['step'] ?? 1);
            $socket->assign('count', $next);
            return;
        }

        if ($event === 'tag_sync') {
            $tags = [];
            foreach ($payload as $key => $value) {
                if (is_int($key)) {
                    $tags[] = (string) $value;
                }
            }
            $socket->assign('count', implode(',', $tags) . '@' . ($payload['topic'] ?? ''));
        }
    }

    public function render(VSlim\VHttpd\Request $req, VSlim\Live\Socket $socket): string
    {
        return '<section id="counter-root">' . $socket->get('count') . '</section>';
    }
}

final class CounterSummaryComponent extends VSlim\Live\Component
{
    public function handleEvent(string $event, array $payload, VSlim\Live\Socket $socket): void
    {
        if ($event === 'component_ping') {
            $this->state()
                ->set('mode', 'event')
                ->set('last_source', 'component');
            $socket->flash('info', 'Component pong');
        }
    }

    public function handleInfo(string $event, array $payload, VSlim\Live\Socket $socket): void
    {
        if ($event === 'component_sync') {
            $this->state()
                ->set('mode', 'info')
                ->set('last_source', 'room');
            $socket
                ->setText('summary-root', '<aside>component info</aside>')
                ->flash('info', 'Component info pong');
        }
    }
}

final class CounterBadgeComponent extends VSlim\Live\Component
{
    public function handleEvent(string $event, array $payload, VSlim\Live\Socket $socket): void
    {
        if ($event !== 'badge_remove') {
            return;
        }
        $badgeId = $this->id();
        $keys = array_values(array_filter(
            explode(',', (string) $socket->get('badge_keys')),
            static fn (string $key): bool => $key !== '' && $key !== $badgeId
        ));
        $socket
            ->assign('badge_keys', implode(',', $keys))
            ->forget('badge_label_' . $badgeId)
            ->setText('badge-count', (string) count($keys));
        $this->remove($socket);
    }
}

$app->websocket('/live', new CounterLiveWsView());
$conn = new CounterLiveSocketSink();

$open = $app->handleWebSocket([
    'event' => 'open',
    'id' => 'lv-1',
    'path' => '/live',
], $conn);

echo ($open === null ? "open-null\n" : "open-value\n");
echo $conn->accepted . "\n";

$join = $app->handleWebSocket([
    'event' => 'message',
    'id' => 'lv-1',
    'path' => '/live',
    'data' => json_encode([
        'type' => 'join',
        'path' => '/counter',
        'root_id' => 'counter-root',
    ]),
], $conn);

$joinPayload = json_decode($join, true);
echo ($joinPayload['type'] ?? '') . "\n";
echo ($joinPayload['ops'][0]['id'] ?? '') . '|' . ($joinPayload['ops'][0]['html'] ?? '') . "\n";
echo count($joinPayload['events'] ?? []) . "\n";
echo (str_contains(($joinPayload['ops'][0]['html'] ?? ''), '<!doctype html>') ? "join-doc\n" : "join-fragment\n");

$event = $app->handleWebSocket([
    'event' => 'message',
    'id' => 'lv-1',
    'path' => '/live',
    'data' => json_encode([
        'type' => 'event',
        'event' => 'inc',
        'payload' => [
            'step' => 2,
        ],
    ]),
], $conn);

$eventPayload = json_decode($event, true);
echo ($eventPayload['ops'][0]['html'] ?? '') . "\n";
echo ($eventPayload['events'][0]['event'] ?? '') . "\n";
echo json_encode($eventPayload['events'][0]['payload'] ?? null) . "\n";

$live = new CounterLiveWsView();
$live->setRootId('counter-root');
$conn2 = new CounterLiveSocketSink();
$frame2 = [
    'event' => 'message',
    'id' => 'lv-2',
    'path' => '/live',
    'data' => json_encode([
        'type' => 'join',
        'path' => '/counter',
        'root_id' => 'counter-root',
    ]),
];
$direct = $app->liveWs($live, $frame2, $conn2);
$directPayload = json_decode($direct, true);
echo ($directPayload['ops'][0]['id'] ?? '') . "\n";

$heartbeat = $app->handleWebSocket([
    'event' => 'message',
    'id' => 'lv-1',
    'path' => '/live',
    'data' => json_encode([
        'type' => 'heartbeat',
    ]),
], $conn);
$heartbeatPayload = json_decode($heartbeat, true);
echo ($heartbeatPayload['type'] ?? '') . '|' . (($heartbeatPayload['ok'] ?? false) ? 'ok' : 'bad') . "\n";

$dispatchJoinConn = new CounterLiveSocketSink();
$dispatchApp = new VSlim\App();
$dispatchApp->websocket('/live', new CounterLiveWsView());
$dispatchJoin = $dispatchApp->handleWebSocket([
    'mode' => 'websocket_dispatch',
    'event' => 'message',
    'id' => 'lv-dispatch-1',
    'path' => '/live',
    'metadata' => [],
    'data' => json_encode([
        'type' => 'join',
        'path' => '/counter',
        'root_id' => 'counter-root',
    ]),
], $dispatchJoinConn);
$dispatchJoinPayload = json_decode($dispatchJoin, true);
echo ($dispatchJoinPayload['ops'][0]['html'] ?? '') . "\n";
$dispatchSession = json_decode($dispatchJoinConn->meta['_vslim_live_session'] ?? 'null', true);
echo (($dispatchSession['root_id'] ?? '') === 'counter-root' ? 'meta-saved' : 'meta-missing') . "\n";
echo (($dispatchSession['view'] ?? '') === CounterLiveWsView::class ? 'meta-view' : 'meta-no-view') . "\n";

$dispatchEventConn = new CounterLiveSocketSink();
$dispatchEventApp = new VSlim\App();
$dispatchEventApp->websocket('/live', new CounterLiveWsView());
$dispatchEvent = $dispatchEventApp->handleWebSocket([
    'mode' => 'websocket_dispatch',
    'event' => 'message',
    'id' => 'lv-dispatch-1',
    'path' => '/live',
    'metadata' => $dispatchJoinConn->meta,
    'data' => json_encode([
        'type' => 'event',
        'event' => 'inc',
        'payload' => [
            'step' => 4,
        ],
    ]),
], $dispatchEventConn);
$dispatchEventPayload = json_decode($dispatchEvent, true);
echo ($dispatchEventPayload['ops'][0]['html'] ?? '') . "\n";
$dispatchEventSession = json_decode($dispatchEventConn->meta['_vslim_live_session'] ?? 'null', true);
echo ((($dispatchEventSession['assigns']['count'] ?? '') === '5') ? 'meta-restored' : 'meta-bad') . "\n";

$topicConn = new CounterLiveSocketSink();
$topicApp = new VSlim\App();
$topicApp->websocket('/live', new CounterLiveWsView());
$topicJoin = $topicApp->handleWebSocket([
    'event' => 'message',
    'id' => 'lv-topic-1',
    'path' => '/live',
    'data' => json_encode([
        'type' => 'join',
        'path' => '/counter',
        'root_id' => 'counter-root',
    ]),
], $topicConn);
$topicSubscribe = $topicApp->handleWebSocket([
    'event' => 'message',
    'id' => 'lv-topic-1',
    'path' => '/live',
    'data' => json_encode([
        'type' => 'event',
        'event' => 'subscribe',
        'payload' => [],
    ]),
], $topicConn);
echo (($topicConn->joined[0] ?? '') === 'counter-room' ? 'topic-joined' : 'topic-missing') . "\n";

$topicNotify = $topicApp->handleWebSocket([
    'event' => 'message',
    'id' => 'lv-topic-1',
    'path' => '/live',
    'data' => json_encode([
        'type' => 'event',
        'event' => 'notify',
        'payload' => [
            'step' => 3,
        ],
    ]),
], $topicConn);
$dispatchWire = json_decode($topicConn->dispatches[0]['data'] ?? 'null', true);
echo (($topicConn->dispatches[0]['room'] ?? '') === 'counter-room' ? 'topic-broadcast' : 'topic-no-broadcast') . "\n";
echo (($topicConn->dispatches[0]['except_id'] ?? '') === 'lv-topic-1' ? 'topic-self-skipped' : 'topic-self-bad') . "\n";
echo (($dispatchWire['event'] ?? '') === 'inc_remote' ? 'topic-info' : 'topic-no-info') . "\n";

$componentEvent = $topicApp->handleWebSocket([
    'event' => 'message',
    'id' => 'lv-topic-1',
    'path' => '/live',
    'data' => json_encode([
        'type' => 'event',
        'event' => 'component_ping',
        'payload' => [
            'target' => 'component:summary',
        ],
    ]),
], $topicConn);
$componentPayload = json_decode($componentEvent, true);
echo (($componentPayload['flash'][0]['message'] ?? '') === 'Component pong' ? 'component-routed' : 'component-miss') . "\n";

$componentInfo = $topicApp->handleWebSocket([
    'event' => 'info',
    'id' => 'lv-topic-1',
    'path' => '/live',
    'room' => 'counter-room',
    'data' => json_encode([
        'type' => 'info',
        'event' => 'component_sync',
        'payload' => [
            'target' => 'component:summary',
        ],
    ]),
], $topicConn);
$componentInfoPayload = json_decode($componentInfo, true);
echo (($componentInfoPayload['ops'][0]['id'] ?? '') === 'summary-root' ? 'component-info-routed' : 'component-info-miss') . "\n";
echo (($componentInfoPayload['flash'][0]['message'] ?? '') === 'Component info pong' ? 'component-info-flash' : 'component-info-flash-miss') . "\n";

$badgeAddEvent = $topicApp->handleWebSocket([
    'event' => 'message',
    'id' => 'lv-topic-1',
    'path' => '/live',
    'data' => json_encode([
        'type' => 'event',
        'event' => 'add_badge',
        'payload' => [],
    ]),
], $topicConn);
$badgeAddPayload = json_decode($badgeAddEvent, true);
echo (($badgeAddPayload['ops'][0]['op'] ?? '') === 'set_text' ? 'badge-count-updated' : 'badge-count-miss') . "\n";
echo (($badgeAddPayload['ops'][1]['op'] ?? '') === 'append' ? 'badge-appended' : 'badge-append-miss') . "\n";
echo ((str_contains($badgeAddPayload['ops'][1]['html'] ?? '', 'badge_remove') && str_contains($badgeAddPayload['ops'][1]['id'] ?? '', 'badge-list')) ? 'badge-html-ok' : 'badge-html-miss') . "\n";

$badgeRemoveEvent = $topicApp->handleWebSocket([
    'event' => 'message',
    'id' => 'lv-topic-1',
    'path' => '/live',
    'data' => json_encode([
        'type' => 'event',
        'event' => 'badge_remove',
        'payload' => [
            'target' => 'component:badge-1',
        ],
    ]),
], $topicConn);
$badgeRemovePayload = json_decode($badgeRemoveEvent, true);
echo (($badgeRemovePayload['ops'][0]['op'] ?? '') === 'set_text' ? 'badge-count-down' : 'badge-count-down-miss') . "\n";
echo ((($badgeRemovePayload['ops'][1]['op'] ?? '') === 'remove') && (($badgeRemovePayload['ops'][1]['id'] ?? '') === 'badge-1') ? 'badge-removed' : 'badge-remove-miss') . "\n";

$uiEvent = $topicApp->handleWebSocket([
    'event' => 'message',
    'id' => 'lv-topic-1',
    'path' => '/live',
    'data' => json_encode([
        'type' => 'event',
        'event' => 'notify_ui',
        'payload' => [],
    ]),
], $topicConn);
$uiPayload = json_decode($uiEvent, true);
echo (($uiPayload['flash'][0]['kind'] ?? '') === 'info' ? 'flash-kind' : 'flash-missing') . "\n";
echo (($uiPayload['flash'][0]['message'] ?? '') === 'Saved from protocol' ? 'flash-message' : 'flash-bad') . "\n";
echo (($uiPayload['navigate_to'] ?? '') === '/counter?tab=history' ? 'navigate-ok' : 'navigate-bad') . "\n";

$profileInvalidEvent = $topicApp->handleWebSocket([
    'event' => 'message',
    'id' => 'lv-topic-1',
    'path' => '/live',
    'data' => json_encode([
        'type' => 'event',
        'event' => 'profile_save',
        'payload' => [
            'label' => 'ab',
            'notify_email' => 'not-an-email',
        ],
    ]),
], $topicConn);
$profileInvalidPayload = json_decode($profileInvalidEvent, true);
$invalidLabel = find_live_op($profileInvalidPayload['ops'] ?? [], 'set_text', 'profile-label-error');
$invalidEmail = find_live_op($profileInvalidPayload['ops'] ?? [], 'set_text', 'profile-email-error');
$invalidStatus = find_live_op($profileInvalidPayload['ops'] ?? [], 'set_text', 'counter-profile-status');
$invalidTone = find_live_op($profileInvalidPayload['ops'] ?? [], 'set_attr', 'counter-profile-pill');
echo (($invalidLabel['text'] ?? '') === 'Use at least 3 characters.' ? 'profile-label-error' : 'profile-label-error-miss') . "\n";
echo (($invalidEmail['text'] ?? '') === 'Use a valid email address.' ? 'profile-email-error' : 'profile-email-error-miss') . "\n";
echo (($invalidStatus['text'] ?? '') === 'Invalid' ? 'profile-invalid-state' : 'profile-invalid-state-miss') . "\n";
echo ((($invalidTone['name'] ?? '') === 'data-state') && (($invalidTone['value'] ?? '') === 'invalid') ? 'profile-invalid-tone' : 'profile-invalid-tone-miss') . "\n";
echo (count($profileInvalidPayload['flash'] ?? []) === 0 ? 'profile-no-flash' : 'profile-flash-bad') . "\n";

$profileSaveEvent = $topicApp->handleWebSocket([
    'event' => 'message',
    'id' => 'lv-topic-1',
    'path' => '/live',
    'data' => json_encode([
        'type' => 'event',
        'event' => 'profile_save',
        'payload' => [
            'label' => 'Alice',
            'notify_email' => 'alice@example.com',
        ],
    ]),
], $topicConn);
$profileSavePayload = json_decode($profileSaveEvent, true);
$savedLabel = find_live_op($profileSavePayload['ops'] ?? [], 'set_text', 'profile-label-value');
$savedEmail = find_live_op($profileSavePayload['ops'] ?? [], 'set_text', 'profile-email-value');
$savedStatus = find_live_op($profileSavePayload['ops'] ?? [], 'set_text', 'profile-status');
$savedAt = find_live_op($profileSavePayload['ops'] ?? [], 'set_text', 'profile-saved-at');
$savedTone = find_live_op($profileSavePayload['ops'] ?? [], 'set_attr', 'counter-profile-pill');
echo (($savedLabel['text'] ?? '') === 'Alice' ? 'profile-label-saved' : 'profile-label-saved-miss') . "\n";
echo (($savedEmail['text'] ?? '') === 'alice@example.com' ? 'profile-email-saved' : 'profile-email-saved-miss') . "\n";
echo (($savedStatus['text'] ?? '') === 'Saved' ? 'profile-status-saved' : 'profile-status-saved-miss') . "\n";
echo (($savedAt['text'] ?? '') === '09:30:00' ? 'profile-time-saved' : 'profile-time-saved-miss') . "\n";
echo ((($savedTone['name'] ?? '') === 'data-state') && (($savedTone['value'] ?? '') === 'saved') ? 'profile-tone-saved' : 'profile-tone-saved-miss') . "\n";
echo (($profileSavePayload['flash'][0]['message'] ?? '') === 'Profile saved for alice@example.com at 09:30:00' ? 'profile-flash-saved' : 'profile-flash-saved-miss') . "\n";

$profileClearEvent = $topicApp->handleWebSocket([
    'event' => 'message',
    'id' => 'lv-topic-1',
    'path' => '/live',
    'data' => json_encode([
        'type' => 'event',
        'event' => 'clear_profile',
        'payload' => [],
    ]),
], $topicConn);
$profileClearPayload = json_decode($profileClearEvent, true);
$clearedLabel = find_live_op($profileClearPayload['ops'] ?? [], 'set_text', 'profile-label-value');
$clearedEmail = find_live_op($profileClearPayload['ops'] ?? [], 'set_text', 'profile-email-value');
$clearedStatus = find_live_op($profileClearPayload['ops'] ?? [], 'set_text', 'profile-status');
$clearedTone = find_live_op($profileClearPayload['ops'] ?? [], 'set_attr', 'counter-profile-pill');
echo (($clearedLabel['text'] ?? '') === '' ? 'profile-label-cleared' : 'profile-label-cleared-miss') . "\n";
echo (($clearedEmail['text'] ?? '') === '' ? 'profile-email-cleared' : 'profile-email-cleared-miss') . "\n";
echo (($clearedStatus['text'] ?? '') === 'Draft' ? 'profile-status-cleared' : 'profile-status-cleared-miss') . "\n";
echo ((($clearedTone['name'] ?? '') === 'data-state') && (($clearedTone['value'] ?? '') === 'draft') ? 'profile-tone-cleared' : 'profile-tone-cleared-miss') . "\n";
echo (($profileClearPayload['flash'][0]['message'] ?? '') === 'Cleared form inputs from the server.' ? 'profile-flash-cleared' : 'profile-flash-cleared-miss') . "\n";

$topicInfo = $topicApp->handleWebSocket([
    'event' => 'info',
    'id' => 'lv-topic-1',
    'path' => '/live',
    'room' => 'counter-room',
    'data' => json_encode([
        'type' => 'info',
        'event' => 'inc_remote',
        'payload' => [
            'step' => 3,
        ],
    ]),
], $topicConn);
$topicInfoPayload = json_decode($topicInfo, true);
echo ($topicInfoPayload['ops'][0]['html'] ?? '') . "\n";

$topicListInfo = $topicApp->handleWebSocket([
    'event' => 'info',
    'id' => 'lv-topic-1',
    'path' => '/live',
    'room' => 'counter-room',
    'data' => json_encode([
        'type' => 'info',
        'event' => 'tag_sync',
        'payload' => ['alpha', 'beta'],
    ]),
], $topicConn);
$topicListPayload = json_decode($topicListInfo, true);
echo ($topicListPayload['ops'][0]['html'] ?? '') . "\n";
?>
--EXPECT--
open-null
1
patch
counter-root|<section id="counter-root">1</section>
0
join-fragment
<section id="counter-root">3</section>
saved
{"ok":true,"count":3}
counter-root
heartbeat|ok
<section id="counter-root">1</section>
meta-saved
meta-view
<section id="counter-root">5</section>
meta-restored
topic-joined
topic-broadcast
topic-self-skipped
topic-info
component-routed
component-info-routed
component-info-flash
badge-count-updated
badge-appended
badge-html-ok
badge-count-down
badge-removed
flash-kind
flash-message
navigate-ok
profile-label-error
profile-email-error
profile-invalid-state
profile-invalid-tone
profile-no-flash
profile-label-saved
profile-email-saved
profile-status-saved
profile-time-saved
profile-tone-saved
profile-flash-saved
profile-label-cleared
profile-email-cleared
profile-status-cleared
profile-tone-cleared
profile-flash-cleared
<section id="counter-root">4</section>
<section id="counter-root">alpha,beta@counter-room</section>
