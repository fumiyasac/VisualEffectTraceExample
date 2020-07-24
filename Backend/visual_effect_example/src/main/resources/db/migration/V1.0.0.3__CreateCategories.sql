CREATE TABLE `categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'カテゴリー名の表記',
  `caption` varchar(255) DEFAULT NULL COMMENT 'カテゴリーキャプションの表記',
  `publish_flag` int(1) NOT NULL DEFAULT '0' COMMENT 'カテゴリー用公開フラグ（0:公開 1:非公開）',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'カテゴリー作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'カテゴリー更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `categories` WRITE;

INSERT INTO `categories` (`id`, `name`, `caption`, `publish_flag`, `created_at`, `updated_at`)
VALUES
	(1,'グルメ・お食事',NULL,0,'2020-07-24 16:30:00','2020-07-24 16:30:00'),
	(2,'観光・街めぐり',NULL,0,'2020-07-24 16:30:00','2020-07-24 16:30:00'),
	(3,'ショッピング・お買い物',NULL,0,'2020-07-24 16:30:00','2020-07-24 16:30:00'),
	(4,'風景・自然',NULL,0,'2020-07-24 16:30:00','2020-07-24 16:30:00'),
	(5,'宿泊・イベント',NULL,0,'2020-07-24 16:30:00','2020-07-24 16:30:00');

UNLOCK TABLES;
