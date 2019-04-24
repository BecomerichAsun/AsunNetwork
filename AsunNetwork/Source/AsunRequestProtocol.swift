//
//  AsunRequestProtocol.swift
//
//  Created by Asun on 2019/4/24.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation
import HandyJSON


public struct API {
    var path: String
    var header: [String:String]
    var method: RequestMethod
    init(path: String, method: RequestMethod = .post, header: [String:String] = ["Content-Type":"application/x-www-form-urlencoded"]) {
        self.path = path
        self.method = method
        self.header = header
    }
}

/// 模型必须遵守这个协议
public protocol AsunRequestProtocol: HandyJSON {
    static func request(api: API, params: [String: Any]?, result: ((ResponseResult<Self>)->())?)
}

public extension AsunRequestProtocol where Self: HandyJSON {
    static func request(api: API, params: [String: Any]?, result: ((ResponseResult<Self>)->())?) {
        let completionHandle: ((Result<Data,Error>)->()) = { res in
            switch res {
            case .success(let data):
                let jsonStr = String(data: data, encoding: .utf8)
                #if DEBUG
                print("url: \(api.path)")
                print("response:")
                print(jsonStr ?? "")
                #endif
                guard let jsonObj = self.self.deserialize(from: jsonStr) else {
                    result?(.failure(.deserializeFailed))
                    return
                }
                result?(.success(jsonObj))
            case .failure(_):
                result?(.failure(.requestFailed))
            }
        }
        if api.method == .post {
            AsunNetWorkManager.shared.post(path: api.path, header: api.header, params: params, result: completionHandle)
        }else{
            AsunNetWorkManager.shared.get(path: api.path, header: api.header, params: params, result: completionHandle)
        }
    }
}

