CREATE TABLE `item_images` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(11) unsigned NOT NULL COMMENT 'アイテムID',
  `title` varchar(255) NOT NULL COMMENT 'アイテム画像のタイトル表記',
  `caption` text COMMENT 'アイテム画像のキャプション表記',
  `credit` text COMMENT 'アイテム画像のクレジット表記',
  `photo_url` text COMMENT 'アイテム画像URL',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'アイテム画像作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'アイテム画像更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- // 外部キー制約の付与: item & item_images テーブルに対して外部キー制約を付与する

ALTER TABLE `item_images` ADD FOREIGN KEY (`item_id`) REFERENCES items(`id`) ON DELETE CASCADE;
