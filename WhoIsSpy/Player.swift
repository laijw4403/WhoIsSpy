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

struct Question {
    let civilianQuestion: String
    let spyQuestion: String
    let blankQuestion: String
}
