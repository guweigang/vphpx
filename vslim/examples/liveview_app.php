<?php
declare(strict_types=1);

$autoload = __DIR__ . '/vendor/autoload.php';
if (!is_file($autoload)) {
    $autoload = __DIR__ . '/../../../vhttpd/php/package/vendor/autoload.php';
}
if (is_file($autoload)) {
    require_once $autoload;
}

$liveviewDemoTz = getenv('VSLIM_LIVEVIEW_TZ') ?: getenv('TZ') ?: 'Asia/Shanghai';
date_default_timezone_set($liveviewDemoTz);

if (!class_exists('ExampleCounterLiveView', false)) {
    final class ExampleCounterProfileStateComponent extends VSlim\Live\Component
    {
    }

    final class ExampleCounterSummaryComponent extends VSlim\Live\Component
    {
        public function handleEvent(string $event, array $payload, VSlim\Live\Socket $socket): void
        {
            if ($event !== 'summary_ping') {
                return;
            }
            $count = (string) $socket->get('count');
            $room = trim((string) $socket->get('room'));
            $room = $room === '' ? 'counter-demo' : $room;
            $this
                ->assign('count', $count)
                ->assign('status', 'Summary ping handled by component')
                ->assign('mode', 'event')
                ->assign('synced_at', date('H:i:s'))
                ->assign('last_source', 'component')
                ->assign('room', $room);
            $this->state()
                ->set('count', $count)
                ->set('status', 'Summary ping handled by component')
                ->set('mode', 'event')
                ->set('synced_at', date('H:i:s'))
                ->set('last_source', 'component')
                ->set('room', $room);
            $socket
                ->assign('status', 'Summary ping handled by component')
                ->assign('last_source', 'component')
                ->assign('flash_info', 'Summary component handled the event.')
                ->flash('info', 'Summary component handled the event.');
            $this->patch_bound();
        }

        public function handleInfo(string $event, array $payload, VSlim\Live\Socket $socket): void
        {
            if ($event !== 'summary_sync') {
                return;
            }
            $count = (string) ($payload['count'] ?? $socket->get('count'));
            $source = trim((string) ($payload['source'] ?? 'room'));
            $room = trim((string) ($payload['topic'] ?? $socket->get('room')));
            $source = $source === '' ? 'room' : $source;
            $room = $room === '' ? 'counter-demo' : $room;
            $syncedAt = date('H:i:s');
            $this
                ->assign('count', $count)
                ->assign('status', 'Summary synced by component info')
                ->assign('mode', 'info')
                ->assign('synced_at', $syncedAt)
                ->assign('last_source', $source)
                ->assign('room', $room);
            $this->state()
                ->set('count', $count)
                ->set('status', 'Summary synced by component info')
                ->set('mode', 'info')
                ->set('synced_at', $syncedAt)
                ->set('last_source', $source)
                ->set('room', $room);
            $socket
                ->flash('info', 'Summary component synced through room dispatch.');
            $this->patch_bound();
        }
    }

    final class ExampleCounterBadgeComponent extends VSlim\Live\Component
    {
        public function handleEvent(string $event, array $payload, VSlim\Live\Socket $socket): void
        {
            if ($event !== 'badge_remove') {
                return;
            }
            $badgeId = $this->id();
            if ($badgeId === '') {
                return;
            }
            $keys = array_values(array_filter(
                explode(',', (string) $socket->get('badge_keys')),
                static fn (string $key): bool => $key !== '' && $key !== $badgeId
            ));
            $socket
                ->assign('badge_keys', implode(',', $keys))
                ->forget('badge_label_' . $badgeId)
                ->assign('flash_info', 'Removed keyed badge ' . $badgeId . '.')
                ->set_text('counter-badge-count', (string) count($keys))
                ->set_text('counter-badge-empty', count($keys) > 0 ? 'Click remove on a badge to patch only that list item.' : 'No keyed items yet.')
                ->flash('info', 'Removed keyed badge ' . $badgeId . '.');
            $this->remove_bound();
        }
    }

    final class ExampleCounterLiveView extends VSlim\Live\View
    {
        private function setProfileState(VSlim\Live\Socket $socket, string $status, string $tone, string $detail, ?string $savedAt = null): void
        {
            $nextSavedAt = $savedAt ?? (string) $socket->get('profile_saved_at');
            $socket
                ->assign('profile_status', $status)
                ->assign('profile_tone', $tone)
                ->assign('profile_detail', $detail)
                ->assign('profile_saved_at', $nextSavedAt);
            $this->patchProfileState($socket);
            $socket
                ->set_text('counter-profile-status', $status)
                ->set_text('counter-profile-tone', $tone)
                ->set_text('counter-profile-saved-at', $nextSavedAt);
        }

        private function activityHtml(int $index, string $summary): string
        {
            return '<li data-activity-index="' . $index . '">' . htmlspecialchars($summary, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8') . '</li>';
        }

        private function patchSummary(VSlim\Live\Socket $socket): void
        {
            $this->component('summary', $socket)->patch_bound();
        }

        private function patchProfileState(VSlim\Live\Socket $socket): void
        {
            $this->component('profile-state', $socket)->patch_bound();
        }

        private function badgeLabelKey(string $badgeId): string
        {
            return 'badge_label_' . $badgeId;
        }

        private function badgeKeys(VSlim\Live\Socket $socket): array
        {
            return array_values(array_filter(
                explode(',', (string) $socket->get('badge_keys')),
                static fn (string $key): bool => $key !== ''
            ));
        }

        private function badgeComponent(string $badgeId, VSlim\Live\Socket $socket): ?VSlim\Live\Component
        {
            $label = $socket->get($this->badgeLabelKey($badgeId));
            if ($label === '') {
                return null;
            }
            $component = new ExampleCounterBadgeComponent();
            $component->set_app(vslim_liveview_demo_app());
            $component->set_template('live_counter_badge.html');
            $component->set_id($badgeId);
            $component->bind_socket($socket);
            $component->assign('badge_id', $badgeId);
            $component->assign('label', $label);
            return $component;
        }

        private function renderBadgeItems(VSlim\Live\Socket $socket): string
        {
            $html = '';
            foreach ($this->badgeKeys($socket) as $badgeId) {
                $component = $this->badgeComponent($badgeId, $socket);
                if ($component instanceof VSlim\Live\Component) {
                    $html .= $component->html();
                }
            }
            return $html;
        }

        public function component(string $id, VSlim\Live\Socket $socket): ?VSlim\Live\Component
        {
            if ($id === 'profile-state') {
                $component = new ExampleCounterProfileStateComponent();
                $component->set_app(vslim_liveview_demo_app());
                $component->set_template('live_counter_profile_state.html');
                $component->set_id('counter-profile-state');
                $component->bind_socket($socket);
                $component->assign('profile_status', $socket->get('profile_status'));
                $component->assign('profile_tone', $socket->get('profile_tone'));
                $component->assign('profile_detail', $socket->get('profile_detail'));
                return $component;
            }
            if ($id === 'summary') {
                $component = new ExampleCounterSummaryComponent();
                $component->set_app(vslim_liveview_demo_app());
                $component->set_template('live_counter_summary.html');
                $component->set_id('counter-summary');
                $component->bind_socket($socket);
                $component->assign('count', $socket->component_state_or('summary', 'count', $socket->get('count')));
                $component->assign('status', $socket->component_state_or('summary', 'status', $socket->get('status')));
                $component->assign('mode', $socket->component_state_or('summary', 'mode', 'liveview'));
                $component->assign('synced_at', $socket->component_state_or('summary', 'synced_at', 'not yet'));
                $component->assign('last_source', $socket->component_state_or('summary', 'last_source', $socket->get('last_source')));
                $component->assign('room', $socket->component_state_or('summary', 'room', $socket->get('room')));
                return $component;
            }
            if (str_starts_with($id, 'badge-')) {
                return $this->badgeComponent($id, $socket);
            }
            return null;
        }

        private function log(string $message, array $context = []): void
        {
            $line = '[' . date('c') . '][liveview-demo][' . getmypid() . '] ' . $message;
            if ($context !== []) {
                $json = json_encode($context, JSON_UNESCAPED_UNICODE);
                if (is_string($json) && $json !== '') {
                    $line .= ' ' . $json;
                }
            }
            $line .= PHP_EOL;
            file_put_contents('php://stderr', $line);
            $logFile = '';
            $app = vslim_liveview_demo_app();
            if ($app->has_config()) {
                $logFile = (string) $app->config()->get_string('liveview.log_file', '');
            }
            if ($logFile === '') {
                $logFile = (string) (getenv('VSLIM_LIVEVIEW_LOG') ?: '');
            }
            if (is_string($logFile) && $logFile !== '') {
                @mkdir(dirname($logFile), 0777, true);
                @file_put_contents($logFile, $line, FILE_APPEND);
            }
        }

        public function mount(VSlim\Vhttpd\Request $req, VSlim\Live\Socket $socket): void
        {
            $this->log('mount', [
                'path' => $req->path ?? '',
                'target' => $socket->target(),
                'connected' => $socket->connected(),
                'root_id' => $socket->root_id(),
            ]);
            if (!$socket->has('count')) {
                $socket->assign('count', 0);
            }
            if (!$socket->has('label')) {
                $socket->assign('label', 'server-owned counter');
            }
            if (!$socket->has('notify_email')) {
                $socket->assign('notify_email', 'ops@example.com');
            }
            if (!$socket->has('activity_seq')) {
                $socket->assign('activity_seq', 0);
            }
            if (!$socket->has('badge_seq')) {
                $socket->assign('badge_seq', 0);
            }
            if (!$socket->has('badge_keys')) {
                $socket->assign('badge_keys', '');
            }
            $socket
                ->set_root_id('counter-root')
                ->set_target('/')
                ->assign('title', 'VSlim Live Counter')
                ->assign('description', 'A minimal LiveView-style page powered by server-rendered HTML fragments and a tiny websocket runtime.')
                ->assign('note', 'Count changes on the server, then the browser applies focused patch ops to the updated fragment.')
                ->assign('path', '/')
                ->assign('endpoint', '/live')
                ->assign('room', 'counter-demo')
                ->assign('status', 'Ready for server-driven updates')
                ->assign('last_target', 'root')
                ->assign('last_source', 'self')
                ->assign_component_state('summary', 'count', '0')
                ->assign_component_state('summary', 'status', 'Ready for server-driven updates')
                ->assign_component_state('summary', 'mode', 'liveview')
                ->assign_component_state('summary', 'synced_at', 'not yet')
                ->assign_component_state('summary', 'last_source', 'self')
                ->assign_component_state('summary', 'room', 'counter-demo')
                ->assign('flash_info', 'Waiting for the next server-side event.')
                ->assign('profile_status', 'Draft')
                ->assign('profile_tone', 'draft')
                ->assign('profile_detail', 'Waiting for your first save.')
                ->assign('profile_saved_at', 'Not saved yet')
                ->assign('error_label', '')
                ->assign('error_notify_email', '')
                ->assign('milestones', '<li>Waiting for a multiple of five.</li>')
                ->assign('activity_items', '<li data-activity-index="0">Connected clients will prepend updates here.</li>')
                ->assign('badge_empty', 'No keyed items yet.');
            if ($socket->connected()) {
                $socket->join_topic('counter-demo');
            }
        }

        private function applyLiveOps(VSlim\Live\Socket $socket, string $event, array $payload): void
        {
            $count = (int) $socket->get('count');
            $target = trim((string) ($payload['target'] ?? 'root'));
            $target = $target === '' ? 'root' : $target;
            $label = $socket->get('label');
            $email = $socket->get('notify_email');
            $source = trim((string) ($payload['source'] ?? 'self'));
            $source = $source === '' ? 'self' : $source;
            $room = trim((string) ($payload['topic'] ?? $socket->get('room')));
            $room = $room === '' ? 'counter-demo' : $room;
            $summary = match ($event) {
                'inc' => 'Incremented by ' . max(1, (int) ($payload['step'] ?? 1)),
                'dec' => 'Decremented by ' . max(1, (int) ($payload['step'] ?? 1)),
                'reset' => 'Reset counter to zero',
                'rename' => 'Saved label as "' . $label . '"',
                'preview_label' => 'Previewing label "' . $label . '"',
                'sync_inc' => 'Broadcasted +' . max(1, (int) ($payload['step'] ?? 1)) . ' to room ' . $room,
                'remote_sync' => 'Received +' . max(1, (int) ($payload['step'] ?? 1)) . ' from ' . $source,
                default => 'Updated live view',
            };
            $status = ucfirst(str_replace('_', ' ', $event)) . ' on ' . $target;
            if ($event === 'remote_sync') {
                $status .= ' via ' . $room;
            }
            $nextActivity = (int) $socket->get('activity_seq') + 1;
            $socket
                ->assign('activity_seq', $nextActivity)
                ->assign('status', $status)
                ->assign('last_target', $target)
                ->assign('last_source', $source)
                ->assign('room', $room)
                ->assign_component_state('summary', 'count', (string) $count)
                ->assign_component_state('summary', 'status', $status)
                ->assign_component_state('summary', 'last_source', $source)
                ->assign_component_state('summary', 'room', $room)
                ->set_text('counter-value', (string) $count)
                ->set_text('counter-status', $status)
                ->set_text('counter-label-value', $label)
                ->set_text('counter-email-value', $email)
                ->set_text('counter-target-value', $target)
                ->set_text('counter-source-value', $source)
                ->set_text('counter-room-value', $room)
                ->set_attr('counter-root', 'data-count', (string) $count)
                ->prepend('counter-activity', $this->activityHtml($nextActivity, $summary));
            $this->patchSummary($socket);

            if ($count !== 0 && $count % 5 === 0) {
                $socket->append('counter-milestones', $this->activityHtml($count, 'Reached milestone ' . $count));
            }
        }

        public function handleEvent(string $event, array $payload, VSlim\Live\Socket $socket): void
        {
            $this->log('handle_event', [
                'event' => $event,
                'payload' => $payload,
                'count' => $socket->get('count'),
            ]);
            $count = (int) $socket->get('count');
            $step = max(1, (int) ($payload['step'] ?? 1));

            if ($event === 'inc') {
                $socket->assign('count', $count + $step);
                $this->applyLiveOps($socket, $event, $payload);
                return;
            }

            if ($event === 'dec') {
                $socket->assign('count', $count - $step);
                $this->applyLiveOps($socket, $event, $payload);
                return;
            }

            if ($event === 'reset') {
                $socket->assign('count', 0);
                $this->applyLiveOps($socket, $event, $payload);
                return;
            }

            if ($event === 'sync_inc') {
                $socket->assign('count', $count + $step);
                $payload['source'] = 'self';
                $payload['topic'] = $socket->get('room');
                $this->applyLiveOps($socket, $event, $payload);
                $socket->broadcast_info('counter-demo', 'counter_sync', [
                    'step' => $step,
                    'source' => $socket->id(),
                    'target' => $payload['target'] ?? 'counter:sync',
                ], false);
                return;
            }

            if ($event === 'sync_summary') {
                $room = (string) $socket->get('room');
                $syncedAt = date('H:i:s');
                $source = $socket->id() !== '' ? $socket->id() : 'self';
                $socket
                    ->assign_component_state('summary', 'count', (string) $socket->get('count'))
                    ->assign_component_state('summary', 'status', 'Summary synced by component info')
                    ->assign_component_state('summary', 'mode', 'info')
                    ->assign_component_state('summary', 'synced_at', $syncedAt)
                    ->assign_component_state('summary', 'last_source', $source)
                    ->assign_component_state('summary', 'room', $room)
                    ->assign('flash_info', 'Dispatching summary sync to room ' . $room . '.')
                    ->flash('info', 'Dispatching summary sync to room ' . $room . '.');
                $this->patchSummary($socket);
                $socket
                    ->broadcast_info($room, 'summary_sync', [
                        'target' => 'component:summary',
                        'count' => (int) $socket->get('count'),
                        'source' => $source,
                    ], true);
                return;
            }

            if ($event === 'celebrate') {
                $socket
                    ->assign('flash_info', 'Flash from the server at ' . date('H:i:s'))
                    ->flash('info', 'Flash from the server at ' . date('H:i:s'));
                $this->patchSummary($socket);
                return;
            }

            if ($event === 'show_history') {
                $socket
                    ->assign('path', '/?tab=history')
                    ->navigate('/?tab=history');
                return;
            }

            if ($event === 'add_badge') {
                $nextBadge = (int) $socket->get('badge_seq') + 1;
                $badgeId = 'badge-' . $nextBadge;
                $label = 'Badge #' . $nextBadge . ' at count ' . $count;
                $keys = $this->badgeKeys($socket);
                $keys[] = $badgeId;
                $socket
                    ->assign('badge_seq', $nextBadge)
                    ->assign('badge_keys', implode(',', $keys))
                    ->assign($this->badgeLabelKey($badgeId), $label)
                    ->assign('flash_info', 'Added keyed badge ' . $badgeId . '.')
                    ->set_text('counter-badge-count', (string) count($keys))
                    ->set_text('counter-badge-empty', 'Click remove on a badge to patch only that list item.')
                    ->flash('info', 'Added keyed badge ' . $badgeId . '.');
                $badge = $this->badgeComponent($badgeId, $socket);
                if ($badge instanceof VSlim\Live\Component) {
                    $badge->append_to_bound('counter-badges');
                }
                return;
            }

            if ($event === 'clear_profile') {
                $socket->form('profile')->reset([
                    'label' => '',
                    'notify_email' => '',
                ]);
                $socket
                    ->set_text('counter-label-error', '')
                    ->set_text('counter-email-error', '')
                    ->set_text('counter-label-value', '')
                    ->set_text('counter-email-value', '')
                    ->assign('flash_info', 'Cleared form inputs from the server.')
                    ->flash('info', 'Cleared form inputs from the server.');
                $this->setProfileState($socket, 'Draft', 'draft', 'Inputs were cleared on the server.', 'Not saved yet');
                return;
            }

            if ($event === 'rename' || $event === 'preview_label') {
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
                        ->set_text('counter-label-error', $form->error('label'))
                        ->set_text('counter-email-error', $form->error('notify_email'));
                    $this->setProfileState($socket, 'Invalid', 'invalid', 'Fix the highlighted fields before saving.');
                    return;
                }
                $socket
                    ->set_text('counter-label-error', '')
                    ->set_text('counter-email-error', '');
                if ($event === 'rename') {
                    $savedAt = date('H:i:s');
                    $socket
                        ->assign('flash_info', 'Profile saved for ' . $email . ' at ' . $savedAt)
                        ->flash('info', 'Profile saved for ' . $email . ' at ' . $savedAt);
                    $this->setProfileState($socket, 'Saved', 'saved', 'Server accepted the latest profile values.', $savedAt);
                } else {
                    $this->setProfileState($socket, 'Previewing', 'preview', 'Showing the latest debounced/throttled form values.');
                }
                $this->applyLiveOps($socket, $event, $payload);
            }
        }

        public function handleInfo(string $event, array $payload, VSlim\Live\Socket $socket): void
        {
            $this->log('handle_info', [
                'event' => $event,
                'payload' => $payload,
                'count' => $socket->get('count'),
            ]);
            if ($event !== 'counter_sync') {
                return;
            }
            $step = max(1, (int) ($payload['step'] ?? 1));
            $count = (int) $socket->get('count');
            $socket->assign('count', $count + $step);
            $payload['target'] = (string) ($payload['target'] ?? 'counter:room');
            $this->applyLiveOps($socket, 'remote_sync', $payload);
        }

        public function render(VSlim\Vhttpd\Request $req, VSlim\Live\Socket $socket): string
        {
            $socket
                ->assign('error_label', $socket->get('error_label'))
                ->assign('error_notify_email', $socket->get('error_notify_email'))
                ->assign('badge_items', $this->renderBadgeItems($socket))
                ->assign('badge_count', (string) count($this->badgeKeys($socket)))
                ->assign('badge_empty', count($this->badgeKeys($socket)) > 0 ? 'Click remove on a badge to patch only that list item.' : 'No keyed items yet.')
                ->assign('profile_state_component', $this->component('profile-state', $socket)->html())
                ->assign('summary_component', $this->component('summary', $socket)->html())
                ->assign('live_script', $this->runtime_script_tag())
                ->assign('live_attrs', $this->bootstrap_attrs($socket, '/live'));
            $this->log('render', [
                'path' => $req->path ?? '',
                'connected' => $socket->connected(),
                'count' => $socket->get('count'),
                'label' => $socket->get('label'),
            ]);
            if ($socket->connected()) {
                return $this->render_socket('live_counter_panel.html', $socket);
            }
            $this->set_template('live_counter_demo.html');
            return $this->html($socket);
        }
    }
}

function vslim_liveview_demo_app(): VSlim\App
{
    static $app = null;
    if ($app instanceof VSlim\App) {
        return $app;
    }

    $app = new VSlim\App();
    $app->set_error_response_json(true);
    $app->set_view_base_path(__DIR__ . '/views');
    $app->set_assets_prefix('/assets');

    $live = new ExampleCounterLiveView();
    $live->set_app($app)->set_root_id('counter-root')->set_template('live_counter_demo.html');

    $app->live('/', $live);
    $app->websocket('/live', $live);

    $app->get('/health', fn () => 'OK');

    $app->get('/meta', static function (): array {
        return [
            'status' => 200,
            'content_type' => 'application/json; charset=utf-8',
            'body' => json_encode([
                'name' => 'vslim-liveview-demo',
                'http' => '/',
                'websocket' => '/live',
                'runtime_asset' => '/assets/vphp_live.js',
                'attributes' => [
                    'click' => 'vphp-click',
                    'submit' => 'vphp-submit',
                    'change' => 'vphp-change',
                    'value' => 'vphp-value-*',
                ],
            ], JSON_UNESCAPED_UNICODE),
        ];
    });

    return $app;
}

return vslim_liveview_demo_app();
