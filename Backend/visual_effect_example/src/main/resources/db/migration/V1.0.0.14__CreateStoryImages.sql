CREATE TABLE `story_images` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `story_id` int(11) unsigned NOT NULL COMMENT 'ストーリーID',
  `photo_url` text COMMENT 'ストーリー画像URL',
  `title` varchar(255) NOT NULL COMMENT 'ストーリー画像のタイトル表記',
  `caption` text COMMENT 'ストーリー画像のキャプション表記',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ストーリー画像作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ストーリー画像更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- // 外部キー制約の付与: stories & story_images テーブルに対して外部キー制約を付与する

ALTER TABLE `story_images` ADD FOREIGN KEY (`story_id`) REFERENCES stories(`id`) ON DELETE CASCADE;
