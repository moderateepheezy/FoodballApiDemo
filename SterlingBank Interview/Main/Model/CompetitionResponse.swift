//
//  CompetitionResponse.swift
//  SterlingBank Interview
//
//  Created by Afees Lawal on 6/26/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import Foundation

// MARK: - CompetitionResponse
struct CompetitionResponse: Codable {
    let count: Int
    let competitions: [CompetitionObject]
}

// MARK: - Competition
struct CompetitionObject: Codable {
    let id: Int
    let name: String
    let code: String?
    let emblemURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, code
        case emblemURL = "emblemUrl"
    }
}
