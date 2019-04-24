//
//  ResponseResult.swift
//
//  Created by Asun on 2019/4/24.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation

/// Error Enum
///
/// - deserializeFailed: Parsing Error
/// - requestFailed: RequestE Error
public enum ResponseError: Error {
    case deserializeFailed
    case requestFailed
}

/// Request Enum
///
/// - success: Success Return Data
/// - failure: Failure<Error Enum>
public enum ResponseResult<Value> {
    case success(Value)
    case failure(ResponseError)


    /// The success of Request
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }

    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }

    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: ResponseError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }

}


