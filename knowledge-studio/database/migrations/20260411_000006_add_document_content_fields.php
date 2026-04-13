<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        $this->tryAddColumn('knowledge_documents', 'summary text not null');
        $this->tryAddColumn('knowledge_documents', 'body text not null');
        $this->tryAddColumn('knowledge_documents', 'language varchar(16) not null');

        try {
            $this->execute("UPDATE `knowledge_documents` SET `summary` = `title` WHERE `summary` = '' OR `summary` IS NULL");
        } catch (\Throwable) {
        }
        try {
            $this->execute("UPDATE `knowledge_documents` SET `body` = `summary` WHERE `body` = '' OR `body` IS NULL");
        } catch (\Throwable) {
        }
        try {
            $this->execute("UPDATE `knowledge_documents` SET `language` = 'zh-CN' WHERE `language` = '' OR `language` IS NULL");
        } catch (\Throwable) {
        }

        return true;
    }

    public function down(): bool
    {
        $this->tryDropColumn('knowledge_documents', 'language');
        $this->tryDropColumn('knowledge_documents', 'body');
        $this->tryDropColumn('knowledge_documents', 'summary');

        return true;
    }

    private function tryAddColumn(string $table, string $definition): void
    {
        try {
            $this->addColumn($table, $definition);
        } catch (\Throwable) {
        }
    }

    private function tryDropColumn(string $table, string $column): void
    {
        try {
            $this->dropColumn($table, $column);
        } catch (\Throwable) {
        }
    }
};
