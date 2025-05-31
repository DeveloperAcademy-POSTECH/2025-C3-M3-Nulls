//
//  TermDto.swift
//  Projects
//
//  Created by 양시준 on 5/31/25.
//

struct TermDto: Codable {
    let termKey: String
    let spelling: String
    let abbreviation: String?
    let meaning: String
    let explanation: String?
}
