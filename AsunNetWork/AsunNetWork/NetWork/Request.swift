//
//  Request.swift
//
//  Created by Asun on 2019/4/24.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation

/// Request - Method
///
/// - post: Post
/// - get: Get
enum RequestMethod {
    case post
    case get
}


/// The necessary information of Request
struct Request {

    /// Request init
    ///
    /// - Parameters:
    ///   - method: Request - Method
    ///   - baseURL: URL
    ///   - path: URL - Path
    ///   - header: Request - Header
    ///   - parameters: Request - Parameter
    init(method: RequestMethod = .post, baseURL: String = "", path: String = "", header: [String:String]?, parameters: [String:Any]?) {
        self.method = method
        self.baseURL = baseURL
        self.path = path
        self.header = header ?? ["Content-Type":"application/x-www-form-urlencoded"]
        self.parameters = parameters ?? [:]
    }

    var method: RequestMethod
    var baseURL: String
    var path: String
    var header: [String : String]
    var parameters:[String: Any]
}
