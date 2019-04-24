//
//  NetWorkManager.swift
//
//  Created by Asun on 2019/4/24.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation
import UIKit
import Moya

// 超时时间
let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<Api>.RequestResultClosure) -> Void in
    if var urlRequest = try? endpoint.urlRequest() {
        ///超时时间为15s
        urlRequest.timeoutInterval = 15
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}


private struct Api: TargetType {
    init(request: Request) {
        self.request = request
    }
    var request: Request

    var baseURL: URL {
        return URL(string: request.baseURL)!
    }
    var path: String {
        return request.path
    }

    var method: Moya.Method {
        return request.method == .post ? .post : .get
    }

    var sampleData: Data = "".data(using: .utf8)!

    var task: Task {
        return .requestParameters(parameters: request.parameters, encoding: URLEncoding.default)
    }
    var headers: [String : String]? {
        return request.header
    }
}


class AsunNetWorkManager {

    static let shared = AsunNetWorkManager("")

    private let ApiProvider = MoyaProvider<Api>(requestClosure: timeoutClosure)

        init(_ baseURL: String = "") {
            self.baseUrl = baseURL
        }

        var baseUrl = ""

        func post(path: String,header:[String:String]?,params: [String: Any]?,result: @escaping ((Result<Data,Error>)->())){
            let request = Request(baseURL:baseUrl, path: path, header: header, parameters: params)
            let target = Api(request: request)
            self.request(target: target, result: result)
        }

        func get(path: String,header:[String:String]?,params: [String: Any]?,result: @escaping ((Result<Data,Error>)->())){
            let request = Request(baseURL:baseUrl, path: path, header: header, parameters: params)
            let target = Api(request: request)
            self.request(target: target, result: result)
        }

    private func request(target: Api,result: @escaping ((Result<Data,Error>)->())) {
            ApiProvider.request(target) { (res) in
                switch res {
                case .success(let a):
                    result(.success(a.data))
                case .failure:
                    result(.failure(res.error!))
                }
            }
        }
}
