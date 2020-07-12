CREATE TABLE `event_introductions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `event_introduction_id` int(11) unsigned NOT NULL COMMENT '販売イベントコンテンツID',
  `thumbnail_url` text COMMENT '販売イベント画像URL',
  `title` varchar(255) NOT NULL COMMENT '販売イベントのタイトル表記',
  `caption` text COMMENT '販売イベントのキャプション表記',
  `statement` text COMMENT '販売イベントの本文表記',
  `announcement_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '販売イベント公開日',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '販売イベント作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '販売イベント更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `event_introductions` WRITE;

INSERT INTO `event_introductions` (`id`, `event_introduction_id`, `thumbnail_url`, `title`, `caption`, `statement`, `announcement_at`, `created_at`, `updated_at`)
VALUES
	(1, 1, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/event_introduction/event_introduction_sample1.jpg', 'イベントタイトル(仮)1', 'イベント見出し(仮)1', 'イベントの本文(仮)1を表示しています。こちらの文章はサンプルアプリ用のものになります。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(2, 2, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/event_introduction/event_introduction_sample2.jpg', 'イベントタイトル(仮)2', 'イベント見出し(仮)2', 'イベントの本文(仮)2を表示しています。こちらの文章はサンプルアプリ用のものになります。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(3, 3, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/event_introduction/event_introduction_sample3.jpg', 'イベントタイトル(仮)3', 'イベント見出し(仮)3', 'イベントの本文(仮)3を表示しています。こちらの文章はサンプルアプリ用のものになります。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(4, 4, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/event_introduction/event_introduction_sample4.jpg', 'イベントタイトル(仮)4', 'イベント見出し(仮)4', 'イベントの本文(仮)4を表示しています。こちらの文章はサンプルアプリ用のものになります。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(5, 5, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/event_introduction/event_introduction_sample5.jpg', 'イベントタイトル(仮)5', 'イベント見出し(仮)5', 'イベントの本文(仮)5を表示しています。こちらの文章はサンプルアプリ用のものになります。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(6, 6, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/event_introduction/event_introduction_sample6.jpg', 'イベントタイトル(仮)6', 'イベント見出し(仮)6', 'イベントの本文(仮)6を表示しています。こちらの文章はサンプルアプリ用のものになります。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(7, 7, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/event_introduction/event_introduction_sample7.jpg', 'イベントタイトル(仮)7', 'イベント見出し(仮)7', 'イベントの本文(仮)7を表示しています。こちらの文章はサンプルアプリ用のものになります。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(8, 8, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/event_introduction/event_introduction_sample8.jpg', 'イベントタイトル(仮)8', 'イベント見出し(仮)8', 'イベントの本文(仮)8を表示しています。こちらの文章はサンプルアプリ用のものになります。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(9, 9, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/event_introduction/event_introduction_sample9.jpg', 'イベントタイトル(仮)9', 'イベント見出し(仮)9', 'イベントの本文(仮)9を表示しています。こちらの文章はサンプルアプリ用のものになります。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(10, 10, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/event_introduction/event_introduction_sample10.jpg', 'イベントタイトル(仮)10', 'イベント見出し(仮)10', 'イベントの本文(仮)10を表示しています。こちらの文章はサンプルアプリ用のものになります。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(11, 11, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/event_introduction/event_introduction_sample11.jpg', 'イベントタイトル(仮)11', 'イベント見出し(仮)11', 'イベントの本文(仮)11を表示しています。こちらの文章はサンプルアプリ用のものになります。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(12, 12, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/event_introduction/event_introduction_sample12.jpg', 'イベントタイトル(仮)12', 'イベント見出し(仮)12', 'イベントの本文(仮)12を表示しています。こちらの文章はサンプルアプリ用のものになります。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(13, 13, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/event_introduction/event_introduction_sample13.jpg', 'イベントタイトル(仮)13', 'イベント見出し(仮)13', 'イベントの本文(仮)13を表示しています。こちらの文章はサンプルアプリ用のものになります。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(14, 14, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/event_introduction/event_introduction_sample14.jpg', 'イベントタイトル(仮)14', 'イベント見出し(仮)14', 'イベントの本文(仮)14を表示しています。こちらの文章はサンプルアプリ用のものになります。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(15, 15, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/event_introduction/event_introduction_sample15.jpg', 'イベントタイトル(仮)15', 'イベント見出し(仮)15', 'イベントの本文(仮)15を表示しています。こちらの文章はサンプルアプリ用のものになります。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00');

UNLOCK TABLES;
