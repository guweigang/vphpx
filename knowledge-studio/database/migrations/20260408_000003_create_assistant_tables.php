<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        $this->createTable('assistant_profiles', [
            'id varchar(64) primary key',
            'workspace_id varchar(64) not null',
            'name varchar(160) not null',
            'visibility varchar(32) not null',
            'created_at datetime not null',
        ]);

        $this->createTable('subscriber_accounts', [
            'id varchar(64) primary key',
            'workspace_id varchar(64) not null',
            'email varchar(160) not null',
            'status varchar(32) not null',
            'created_at datetime not null',
        ]);

        $this->createTable('subscriptions', [
            'id varchar(64) primary key',
            'workspace_id varchar(64) not null',
            'subscriber_id varchar(64) not null',
            'plan varchar(32) not null',
            'status varchar(32) not null',
            'created_at datetime not null',
        ]);

        $this->createTable('chat_sessions', [
            'id varchar(64) primary key',
            'workspace_id varchar(64) not null',
            'subscriber_id varchar(64) not null',
            'title varchar(200) not null',
            'created_at datetime not null',
        ]);

        $this->createTable('chat_messages', [
            'id varchar(64) primary key',
            'session_id varchar(64) not null',
            'role varchar(32) not null',
            'body text not null',
            'created_at datetime not null',
        ]);

        return true;
    }

    public function down(): bool
    {
        $this->dropTable('chat_messages');
        $this->dropTable('chat_sessions');
        $this->dropTable('subscriptions');
        $this->dropTable('subscriber_accounts');
        $this->dropTable('assistant_profiles');

        return true;
    }
};
