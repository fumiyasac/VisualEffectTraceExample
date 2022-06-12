# [ING] - UICollectionViewを活用した表現とバックエンド側との連携実装に関するサンプル

UICollectionViewを利用した複雑なレイアウトや挙動を表現と合わせて、Server Side Kotlinでバックエンド側のAPI実装（ユーザー登録・ログイン及び表示データ取得処理）と繋ぎ合わせる処理をレイヤーに分割したアーキテクチャを用いて実現しているサンプルになります。

### 1. このサンプルについて

#### 【実装環境】

- macOS Big Monterey 12.3
- Xcode 13.4.1
- Swift 5.5
- CocoaPods 1.11.3

#### 【サンプル画面のデザイン】

（1）ログイン前画面:

こちらはMVVM + RxSwiftを利用して画面の状態管理をしています。

![ログイン前画面](https://github.com/fumiyasac/VisualEffectTraceExample/blob/master/images/sample_thumbnail1.jpg)

（2）アイテム一覧表示画面:

全体構成についてはUICollectionViewCompositionalLayout & DiffableDataSourceを利用した形にしています。
例外として、少し工夫が必要であったバナー表示部分とバウンドがかかる横スクロール部分についてはRxSwiftでの実装やライブラリを活用し、それぞれの画面をContainerViewを利用して表示する形をとりました。

![アイテム一覧表示画面](https://github.com/fumiyasac/VisualEffectTraceExample/blob/master/images/sample_thumbnail2.jpg)

（3）UICollectionViewを利用して変わったレイアウトを実装する:

![UICollectionViewを利用して変わったレイアウトを実装する](https://github.com/fumiyasac/VisualEffectTraceExample/blob/master/images/sample_thumbnail3.jpg)

#### 【ログイン後の表示画面に関するAPI通信処理部分のレイヤー分け】

![ログイン後の表示画面に関するAPI通信処理部分のレイヤー分け](https://github.com/fumiyasac/VisualEffectTraceExample/blob/master/images/architecture_layer.png)

#### 【iOS側利用しているライブラリ一覧】

利用しているライブラリは下記になります。

```
target 'VisualEffectTraceExample' do
  use_frameworks!

  # Pods for VisualEffectTraceExample

  # 1. アーキテクチャに関するライブラリ
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RealmSwift'
  pod 'KeychainAccess'
  pod 'Kingfisher'

  # 2. UI実装に関するライブラリ
  pod 'BouncyLayout'
  pod 'FontAwesome.swift'
  pod 'PKHUD', '~> 5.0'
  pod 'AnimatedCollectionViewLayout'

  # 3. UIデバッグ用のライブラリ
  pod 'Gedatsu', configuration: %w(Debug)
end
```

※ 今回の実装では、APIから取得した表示データを画面に表示させるための処理の基本形についてはRxSwiftを利用したMVVMパターン（ViewController - ViewModel - Model）をベースに実現していますが、この部分はCombineに置き換えて処理する形でも実装できると思います。

### 2. iOS13からの新機能を利用している部分に関する解説

#### 【UICollectionViewCompositionalLayout & DiffableDataSource】

- [UICollectionViewCompositionalLayout & DiffableDataSourceを利用したUIとCombineを利用したMVVMパターンでのAPI通信関連処理との組み合わせた実装の紹介とまとめ](https://qiita.com/fumiyasac@github/items/12165641c6569fde52ba)

#### 【Dependency Injection Of Propery Wrappers】

- [【実装MEMO】PropertyWrappersの機能を利用したDependency Injectionのコードに触れた際の備忘録](https://medium.com/@fumiyasakai/%E5%AE%9F%E8%A3%85memo-propertywrappers%E3%81%AE%E6%A9%9F%E8%83%BD%E3%82%92%E5%88%A9%E7%94%A8%E3%81%97%E3%81%9Fdependency-injection%E3%81%AE%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E8%A7%A6%E3%82%8C%E3%81%9F%E9%9A%9B%E3%81%AE%E5%82%99%E5%BF%98%E9%8C%B2-b269bc914b7a)

### 3. バックエンド側のAPI実装

#### 【動作構築】

- Docker: Docker for Mac
- エディタ: IntelliJ IDEA

__Dockerの操作に関する参考資料:__

```
# MySQLのデータベースを作成する
$ sh ./make_database.sh

# SpringBootで利用するMySQLを起動する
$ cd Backend/
$ docker-compose up -d
```

https://docs.docker.jp/compose/reference/up.html

#### 【API定義書】

![SwggerUIによるAPI定義](https://github.com/fumiyasac/VisualEffectTraceExample/blob/master/images/swagger_definition.png)

このリポジトリの「Backend」ディレクトリ内に格納している、Kotlin(SpringBoot)プロジェクトをビルドすると下記のURLでアプリサンプル内で利用しているエンドポイント一覧が記載されています（SwaggerUI）。

http://localhost:8080/swagger-ui.html

#### 【SpringBootで利用しているライブラリ一覧】

自分が元々長く親しんでいたPHPやRubyのフレームワークでお目にかかった様な構成と近しいものにできれば良いかなという感じで、下記の様なライブラリを導入した形にしています。Model層は3層（Entity/Repository/Service）に分離した形をとっています。iOSアプリとの認証処理部分はJWT（JSON Web Token）を利用することを想定しており、またDatabase（MySQL）とのやり取りをする部分ではJPAを利用することを想定に作っています。

```
dependencies {
    ...（以下自分で導入したもの）...

	// MySQL接続
	implementation("mysql:mysql-connector-java")

	// DatabaseのMigration処理
	implementation("org.flywaydb:flyway-core")

	// アクセス制御とJWT(JSON Web Token)の利用
	implementation("org.springframework.boot:spring-boot-starter-security")
	implementation("io.jsonwebtoken:jjwt:0.9.1")

	// Swaggerの導入（※このサンプルではSwaggerUIを利用するため）
	compile ("io.springfox:springfox-swagger2:2.9.2")
	compile ("io.springfox:springfox-swagger-ui:2.9.2")
}
```

#### 【Kotlin & SpringBootに関する参考書籍】

Java + Springには少し馴染みがあったことや、以前はサーバーサイド側の開発経験もあったので、Kotlin + Spring + MySQLの構成でLocal環境で簡単なAPIサーバーを構築する練習を通じて、Kotlinに慣れる機会を持つ意味合いも込めて [入門!実践!サーバーサイドKotlin](https://booth.pm/ja/items/1560389) ＆ [もっと実践!サーバーサイドKotlin](https://booth.pm/ja/items/1887668) で学習しています。

### 4. その他参考資料

色々と試しながら実装していることもあり、本来の使われ方とは若干外れてしまうような形にもなっているかもしれませんが、今回のサンプル開発を通じて参考にしたものを紹介しています。基本的には [iOSアプリ設計パターン入門](https://peaks.cc/books/iOS_architecture) を読み進めることに加えて下記の記事も参考にしています。

__Clean Architectureを理解する:__

- [iOS: RxSwift + clean architecture](https://medium.com/tiendeo-tech/ios-rxswift-clean-architecture-d7e9eaa60ba)
- [Clean Architecture and MVVM on iOS](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3)
- [iOS: MVP clean architecture in Tiendeo app](https://medium.com/tiendeo-tech/ios-mvp-clean-architecture-in-tiendeo-app-a8a597c49bb9)

どうしてもファイル数が多くなってしますこともあり、今後余力があれば自動コード生成に関する部分についても利用をしてみることも考えていければと思います。

- [emrcftci/CleanSwiftArchitectureGenerator](https://github.com/emrcftci/CleanSwiftArchitectureGenerator)
- [bannzai/Kuri](https://github.com/bannzai/Kuri)
- [strongself/Generamba](https://github.com/strongself/Generamba)

__Coodinatorパターンを試してみる:__

- [Leverage the Coordinator Design Pattern in Swift 5](https://medium.com/better-programming/leverage-the-coordinator-design-pattern-in-swift-5-cd5bb9e78e12)
- [How to use the coordinator pattern in iOS apps](https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps)
- [How to make custom transitions using flow coordinator pattern](https://medium.com/@pavlepesic/coordinator-custom-transitions-b08cce1da8fd)
- [Coordinators Essential tutorial. Part I](https://medium.com/blacklane-engineering/coordinators-essential-tutorial-part-i-376c836e9ba7)

