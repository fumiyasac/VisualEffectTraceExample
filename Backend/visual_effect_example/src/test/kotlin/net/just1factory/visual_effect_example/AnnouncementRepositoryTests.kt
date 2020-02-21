package net.just1factory.visual_effect_example

// Test: JPAを利用したテーブル(announcement)からデータを全件取得する処理のテスト

// MEMO: テスト対象のリポジトリファイルのインポート
import net.just1factory.visual_effect_example.domain.entity.AnnouncementEntity
import net.just1factory.visual_effect_example.domain.repository.AnnouncementRepository

// MEMO: JUnit5で提供されているアノテーション（JUnit4とは異なる点に注意）
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

// MEMO: JUnitで利用できる検証のためのアサーション
import org.assertj.core.api.Assertions.assertThat

// MEMO: Setter Injectionを利用するためのアノテーション
import org.springframework.beans.factory.annotation.Autowired;

// MEMO: EntityとRepositoryのテストを実施するにあたりAutoConfigurationを利用するためのアノテーション
// 参考: https://qiita.com/fanfanta/items/05d7d0ac2b5a43935ee3
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;

// MEMO: Spring TestContext Frameworkを利用可能にする
// 参考: https://qiita.com/kazuki43zoo/items/4a9ead225a9a9897af4a
import org.springframework.test.context.junit.jupiter.SpringExtension

// MEMO: JUnit5からはSpringExtensionになる点に注意
@ExtendWith(SpringExtension::class)

// MEMO: JPAを利用した処理をテストする
@DataJpaTest

// MEMO: テスト用のデータベースを選択してマイグレーションを実施する
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
class AnnouncementRepositoryTests {

    // MEMO: Spring 管理下のオブジェクトの中から適切なものを変数に追加する (Setter Injection)
    @Autowired
    private lateinit var announcementRepository: AnnouncementRepository

    // MEMO: AnnouncementRepositoryから取得したデータを格納する場所
    private lateinit var announcements: List<AnnouncementEntity>

    // MEMO: 各種テストコードの実行前にする処理
    @BeforeEach
    fun beforeEach() {
        println("----- 自動テストを開始します -----")

        // テーブル(announcement)に格納されているデータを全件取得する
        announcements = announcementRepository.findAll()
    }

    // MEMO: 実行するテストコード（※ここでは初期値の内容が正しいかの検証をしている）
    @Test
    fun findAllTest() {

        // MEMO: 具体的にテストしたい内容を記載する
        assertThat(announcements.size).isEqualTo(3)
        assertThat(announcements.first().title).isEqualTo("新しいiOSアプリのUI実装サンプルを追加しました。")
        val randomIndex = (announcements.indices).shuffled().first()
        assertThat(announcements[randomIndex].publishFlag).isEqualTo(0)
    }
}