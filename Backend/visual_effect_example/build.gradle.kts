import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
	id("org.springframework.boot") version "2.2.4.RELEASE"
	id("io.spring.dependency-management") version "1.0.9.RELEASE"
	kotlin("jvm") version "1.3.61"
	kotlin("plugin.spring") version "1.3.61"
	kotlin("plugin.jpa") version "1.3.61"
	id("org.flywaydb.flyway") version "5.2.4"
}

group = "net.just1factory"
version = "0.0.1-SNAPSHOT"
java.sourceCompatibility = JavaVersion.VERSION_1_8

repositories {
	mavenCentral()
}

dependencies {
	implementation("org.springframework.boot:spring-boot-starter-data-jpa")
	implementation("org.springframework.boot:spring-boot-starter-web")
	implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
	implementation("org.jetbrains.kotlin:kotlin-reflect")
	implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
	// MEMO: 自分で追加したプラグインは以下
	implementation("mysql:mysql-connector-java")
	implementation("org.flywaydb:flyway-core")
	implementation("org.springframework.boot:spring-boot-starter-security")
	implementation("io.jsonwebtoken:jjwt:0.9.1")
	// MEMO: Swaggerの導入（このサンプルではSwaggerUIを利用する）
	compile ("io.springfox:springfox-swagger2:2.9.2")
	compile ("io.springfox:springfox-swagger-ui:2.9.2")
	testImplementation("org.springframework.boot:spring-boot-starter-test") {
		exclude(group = "org.junit.vintage", module = "junit-vintage-engine")
	}
}

// 参考: トラブルシューティング集
// (1) IntelliJでkotlin not configuredが出たときの対処法
// https://qiita.com/alashino/items/9de2dc6353324a3cd084
// (2) tasks.testの記載を追記したらなぜか直った & UnitTestも通る様になった（理由は正直わからない...）
// https://kotlinlang.org/docs/jvm-test-using-junit.html#add-the-code-to-test-it
tasks.test {
	useJUnitPlatform()
}

tasks.withType<Test> {
	useJUnitPlatform()
}

tasks.withType<KotlinCompile> {
	kotlinOptions {
		freeCompilerArgs = listOf("-Xjsr305=strict")
		jvmTarget = "1.8"
	}
}
