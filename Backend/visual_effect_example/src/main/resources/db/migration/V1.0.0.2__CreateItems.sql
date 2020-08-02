CREATE TABLE `items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT 'アイテムのタイトル表記',
  `statement` text COMMENT 'アイテムの概要本文表記',
  `thumbnail_url` text COMMENT 'アイテムのメイン画像サムネイルURL',
  `publish_flag` int(1) NOT NULL DEFAULT '0' COMMENT 'アイテム用公開フラグ（0:公開 1:非公開）',
  `announcement_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'アイテム公開日',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'アイテム作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'アイテム更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `items` WRITE;

INSERT INTO `items` (`id`, `title`, `statement`, `thumbnail_url`, `publish_flag`, `announcement_at`, `created_at`, `updated_at`)
VALUES
	(1, 'Item No.1', 'Item Example No.1', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample1.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(2, 'Item No.2', 'Item Example No.2', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample2.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(3, 'Item No.3', 'Item Example No.3', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample3.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(4, 'Item No.4', 'Item Example No.4', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample4.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(5, 'Item No.5', 'Item Example No.5', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample5.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(6, 'Item No.6', 'Item Example No.6', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample6.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(7, 'Item No.7', 'Item Example No.7', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample7.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(8, 'Item No.8', 'Item Example No.8', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample8.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(9, 'Item No.9', 'Item Example No.9', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample9.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(10, 'Item No.10', 'Item Example No.10', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample10.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(11, 'Item No.11', 'Item Example No.11', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample11.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(12, 'Item No.12', 'Item Example No.12', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample12.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(13, 'Item No.13', 'Item Example No.13', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample13.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(14, 'Item No.14', 'Item Example No.14', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample14.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(15, 'Item No.15', 'Item Example No.15', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample15.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(16, 'Item No.16', 'Item Example No.16', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample16.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(17, 'Item No.17', 'Item Example No.17', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample17.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(18, 'Item No.18', 'Item Example No.18', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample18.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(19, 'Item No.19', 'Item Example No.19', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample19.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(20, 'Item No.20', 'Item Example No.20', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample20.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(21, 'Item No.21', 'Item Example No.21', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample21.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(22, 'Item No.22', 'Item Example No.22', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample22.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(23, 'Item No.23', 'Item Example No.23', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample23.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(24, 'Item No.24', 'Item Example No.24', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample24.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(25, 'Item No.25', 'Item Example No.25', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample25.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(26, 'Item No.26', 'Item Example No.26', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample26.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(27, 'Item No.27', 'Item Example No.27', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/item/item_sample27.jpg', 0, '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00');

UNLOCK TABLES;
