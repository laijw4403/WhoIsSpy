//
//  Player.swift
//  WhoIsSpy
//
//  Created by Tommy on 2020/12/3.
//

import Foundation

struct Player {
    let name: String
    let identity: String
    let question: String
}

enum Identity: String {
    case 平民, 臥底, 白板
}

struct SearchResponse: Codable {
    let feed: QuestionData
    
    struct QuestionData: Codable {
        let entry: [IdentityQuestion]
    }
}

struct IdentityQuestion: Codable {
    let civilianQuestion: Question
    let spyQuestion: Question
    
    enum CodingKeys: String, CodingKey {
        case civilianQuestion = "gsx$civilianquestion"
        case spyQuestion = "gsx$spyquestion"
    }
}

struct Question: Codable {
    let question: String
    
    enum CodingKeys: String, CodingKey {
        case question = "$t"
    }
}
