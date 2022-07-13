//
//  MFMError.swift
//  MyFavoriteMakes
//
//  Created by Emilio Genesio on 12/07/22.
//

import Foundation

/// `MFMError` entity that represent error of different types
enum MFMError: Error {
    case unavailable
    case notFound
    case invalidData
}

extension MFMError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unavailable: return "The service seems unavailable"
        case .notFound: return "The item was not found"
        case .invalidData: return "The data is not valid for the current context"
        }
    }
}
