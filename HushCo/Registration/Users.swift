//
//  Users.swift
//  HushCo
//
//  Created by Danilo Gervasoni on 26/06/24.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let password: String
    let phone: String
    let job: String
    let linkedin: String
    let github: String
}
