CREATE TABLE `tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'タグ名の表記',
  `publish_flag` int(1) NOT NULL DEFAULT '0' COMMENT 'タグ用公開フラグ（0:公開 1:非公開）',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'タグ作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'タグ更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `tag` WRITE;

INSERT INTO `tag` (`id`, `name`, `publish_flag`, `created_at`, `updated_at`)
VALUES
	(1,'石川県',0,'2020-03-12 00:00:00','2020-03-12 00:00:00'),
	(2,'富山県',0,'2020-03-12 00:00:00','2020-03-12 00:00:00'),
	(3,'福井県',0,'2020-03-12 00:00:00','2020-03-12 00:00:00'),
	(4,'新潟県',0,'2020-03-12 00:00:00','2020-03-12 00:00:00'),
	(5,'長野県',0,'2020-03-12 00:00:00','2020-03-12 00:00:00'),
	(6,'私のお気に入り',0,'2020-03-12 00:00:00','2020-03-12 00:00:00'),
	(7,'人気スポット',0,'2020-03-12 00:00:00','2020-03-12 00:00:00'),
	(8,'旅行での1コマ',0,'2020-03-12 00:00:00','2020-03-12 00:00:00'),
	(9,'若き日の思い出',0,'2020-03-12 00:00:00','2020-03-12 00:00:00'),
	(10,'故郷を思い出す',0,'2020-03-12 00:00:00','2020-03-12 00:00:00'),
	(11,'つい買ってしまう',0,'2020-03-12 00:00:00','2020-03-12 00:00:00'),
	(12,'実はあまり知られていない',0,'2020-03-12 00:00:00','2020-03-12 00:00:00');

UNLOCK TABLES;