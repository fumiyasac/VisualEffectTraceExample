//
//  APIRequestManager.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/02/18.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Enum

// MEMO: APIリクエストに関するEnum定義
enum HTTPMethod {
    case GET
    case POST
    case PUT
    case DELETE
}

// MEMO: APIエラーメッセージに関するEnum定義
enum APIError: Error {
    case error(String)
}

// MEMO: APIリクエストの状態に関するEnum定義
enum APIRequestState {
    case none
    case requesting
    case success
    case error
}

final class APIRequestManager {
    
    // MEMO: API Mock ServerへのURLに関する情報
    static let host = "http://localhost:8080/api"
    static let version = "v1"

    private let session = URLSession.shared

    // MARK: - Singleton Instance

    static let shared = APIRequestManager()

    private init() {}

    // MARK: - Function

    func executeAPIRequest<T: Decodable>(endpointUrl: String, withParameters: [String : Any] = [:], httpMethod: HTTPMethod = .GET, responseFormat: T.Type) -> Single<T> {

        var urlRequest: URLRequest
        switch httpMethod {
        case .GET:
            urlRequest = makeGetRequest(endpointUrl)
        case .POST:
            urlRequest = makePostRequest(endpointUrl, withParameters: withParameters)
        default:
            fatalError()
        }
        return handleDataTask(T.self, request: urlRequest)
    }

    // MARK: - Private Function

    private func handleDataTask<T: Decodable>(_ dataType: T.Type, request: URLRequest) -> Single<T> {

        return Single<T>.create(subscribe: { singleEvent in

            // MEMO: API通信結果のハンドリング処理では、成功または失敗かのいずれかのイベントを1度だけ流すことを保証する形にする
            let task = self.session.dataTask(with: request) { data, response, error in
                // MEMO: 通信状態等に起因するエラー発生時のエラーハンドリング
                if let error = error {
                    singleEvent(.failure(error))
                    return
                }
                // MEMO: Debug用にエラー発生時のJSONを出力する
                //self.displayErrorForDebug(targetResponse: response, targetData: data)
                // MEMO: ステータスコードの精査及びエラーハンドリング
                if let response = response as? HTTPURLResponse, case 400...500 = response.statusCode {

                    // MEMO: ステータスコードが403(Access Denied)の場合にはサインイン画面へ強制的に表示させるようにする
                    if response.statusCode == 403 {
                        // MEMO: ここにCoodinatorの処理を強制的に加えるのは果たして良いのかは迷うところです。
                        // → しかもこの中で無理やりDispatchQueueで処理するような処理だから強引っちゃ強引な感じがある
                        print("403 Error Occurs in", request)
                        DispatchQueue.main.async {
                            let signinCoodinator = SigninScreenCoordinator()
                            signinCoodinator.start()
                        }
                        singleEvent(.failure(APIError.error("Error: StatusCodeが403です。")))
                    } else {
                        singleEvent(.failure(APIError.error("Error: StatusCodeが200~399以外です。")))
                    }
                    return
                }

                // MEMO: 取得データの内容の精査及びエラーハンドリング
                guard let data = data else {
                    singleEvent(.failure(APIError.error("Error: レスポンスが空でした。")))
                    return
                }
                // MEMO: 取得できたレスポンスを引数で指定した型の配列に変換して受け取る
                do {
                    let hashableObjects = try JSONDecoder().decode(T.self, from: data)
                    singleEvent(.success(hashableObjects))
                } catch {
                    singleEvent(.failure(APIError.error("Error: JSONからのマッピングに失敗しました。")))
                }
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        })
    }

    // API Mock ServerへのGETリクエストを作成する
    private func makeGetRequest(_ urlString: String) -> URLRequest {
        guard let url = URL(string: urlString) else {
            fatalError()
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let authraizationHeader = KeychainAccessManager.shared.getAuthenticationHeader()
        if !authraizationHeader.isEmpty {
            urlRequest.addValue(authraizationHeader , forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }

    // API Mock ServerへのPOSTリクエストを作成する
    private func makePostRequest(_ urlString: String, withParameters: [String : Any] = [:]) -> URLRequest {
        guard let url = URL(string: urlString) else {
            fatalError()
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        // MEMO: Dictionaryで取得したリクエストパラメータをJSONに変換している
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: withParameters, options: [])
            urlRequest.httpBody = requestBody
        } catch {
            fatalError("Invalid request body parameters.")
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let authraizationHeader = KeychainAccessManager.shared.getAuthenticationHeader()
        if !authraizationHeader.isEmpty {
            urlRequest.addValue(authraizationHeader , forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }

    // MEMO: デバッグ用にエラー時に出力されるJSONを表示する
    private func displayErrorForDebug(targetResponse: URLResponse?, targetData: Data?) {
        if let debugResponse = targetResponse as? HTTPURLResponse {
            print("StatusCode:", debugResponse.statusCode)
            if let debugData = targetData {
                let debugJson = String(data: debugData, encoding: String.Encoding.utf8) ?? "No Response found."
                print("ErrorResponse:", debugJson)
            }
        }
    }
}
