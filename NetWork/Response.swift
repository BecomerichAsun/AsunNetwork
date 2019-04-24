//
//  Response.swift
//  UURequest
//
//  Created by Asun on 2019/4/24.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation
import HandyJSON

public struct DataResponse<T>: AsunRequestProtocol where T: HandyJSON {
    public init (){}
    public var code: Int = -1
    public var msg: String = ""
    public var data: T?
}

public struct ListResponse<T>: AsunRequestProtocol where T: HandyJSON {
    public init (){}
    public var code: Int = -1
    public var msg: String = ""
    public var data: [T] = []
}


public struct MsgResponse:  AsunRequestProtocol {
    public init (){}
    public var code: Int = -1
    public var msg: String = ""
    public var data: String?
}
