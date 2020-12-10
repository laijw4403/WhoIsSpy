import UIKit


var name = [String]()

name.append("玩家1")
name
print(name)
struct Player {
    let name: String
    let identity: String
    let question: String
}

enum Identity: String {
    case civilian, spy
}

struct Question {
    let civilianQuestion: String
    let spyQuestion: String
}

let civilianQuestion = ["中華電信", "西瓜"]
let spyQuestion = ["遠傳電信", "香瓜"]
//let name = ["Player1", "Player2", "Player3"]
var identity: [Identity]
identity = [.civilian, .civilian, .spy]

var question = [Question]()
var players = [Player]()


var count = civilianQuestion.count-1

for i in 0...count {
    question.append(Question(civilianQuestion: civilianQuestion[i], spyQuestion: spyQuestion[i]))
}

question.shuffle()
identity.shuffle()

for i in 0...(name.count-1) {
    if identity[i].rawValue == Identity.civilian.rawValue {
        players.append(Player(name: name[i], identity: identity[i].rawValue, question: question[0].civilianQuestion))
    } else {
        players.append(Player(name: name[i], identity: identity[i].rawValue, question: question[0].spyQuestion))
    }
    print(players[i])
}



