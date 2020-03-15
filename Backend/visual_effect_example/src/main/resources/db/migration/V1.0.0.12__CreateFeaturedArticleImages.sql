CREATE TABLE `featured_article_images` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `featured_article_id` int(11) unsigned NOT NULL COMMENT '特集ID',
  `photo_url` text COMMENT '特集画像URL',
  `title` varchar(255) NOT NULL COMMENT '特集画像のタイトル表記',
  `caption` text COMMENT '特集画像のキャプション表記',
  `statement` text COMMENT '特集画像の本文表記',
  `credit` text COMMENT '特集画像のクレジット表記',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '特集画像作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '特集画像更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- // 外部キー制約の付与: featured_articles & featured_article_images テーブルに対して外部キー制約を付与する

ALTER TABLE `featured_article_images` ADD FOREIGN KEY (`featured_article_id`) REFERENCES featured_articles(`id`) ON DELETE CASCADE;
