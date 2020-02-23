//
//  APIRequestManager.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/02/18.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Protocol

protocol APIRequestManagerProtocol {

    // MEMO: 認証済みユーザーのAPIリクエスト

    // MEMO: 公開部分のAPIリクエスト
    func getAnnoucements() -> Single<AnnouncementListResponse>
}

class APIRequestManager {
    
    // MEMO: API Mock ServerへのURLに関する情報
    private static let host = "http://localhost:8080/api"
    private static let version = "v1"

    private let session = URLSession.shared

    // MARK: - Singleton Instance

    static let shared = APIRequestManager()

    private init() {}

    // MARK: - Enum

    // MEMO: APIエラーメッセージに関するEnum定義
    // ※ API Mock Serverで返却される以外のエラー発生時における考慮のための処理
    private enum APIError: Error {
        case error(String)
    }

    // MEMO: サンプルで利用するエンドポイント定義
    private enum EndPoint: String {

        case announcements = "announcement"

        func getBaseUrl() -> String {
            return [host, version, self.rawValue].joined(separator: "/")
        }
    }
}

// MARK: - APIRequestManagerProtocol

extension APIRequestManager: APIRequestManagerProtocol {

    // MARK: - Function

    func getAnnoucements() -> Single<AnnouncementListResponse> {
        let endpointUrl = EndPoint.announcements.getBaseUrl()
        let urlRequest = makeGetRequest(endpointUrl)
        return handleDataTask(AnnouncementListResponse.self, request: urlRequest)
    }

    // MARK: - Private Function

    private func handleDataTask<T: Decodable>(_ dataType: T.Type, request: URLRequest) -> Single<T> {

        return Single<T>.create(subscribe: { singleEvent in

            // MEMO: API通信結果のハンドリング処理では、成功または失敗かのいずれかのイベントを1度だけ流すことを保証する形にする
            let task = self.session.dataTask(with: request) { data, response, error in
                // MEMO: レスポンス形式やステータスコードを元にしたエラーハンドリングをする
                if let error = error {
                    singleEvent(.error(error))
                    return
                }
                guard let response = response as? HTTPURLResponse, case 200..<400 = response.statusCode else {
                    singleEvent(.error(APIError.error("Error: StatusCodeが200~399以外です。")))
                    return
                }
                guard let data = data else {
                    singleEvent(.error(APIError.error("Error: レスポンスが空でした。")))
                    return
                }
                // MEMO: 取得できたレスポンスを引数で指定した型の配列に変換して受け取る
                do {
                    let hashableObjects = try JSONDecoder().decode(T.self, from: data)
                    singleEvent(.success(hashableObjects))
                } catch {
                    singleEvent(.error(APIError.error("Error: JSONからのマッピングに失敗しました。")))
                }
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        })
    }

    // API Mock ServerへのGETリクエストを作成する
    private func makeGetRequest(_ urlString: String, shouldAuthorize: Bool = false) -> URLRequest {
        guard let url = URL(string: urlString) else {
            fatalError()
        }

        // TODO: 認可の有無についての設定処理が必要
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}
