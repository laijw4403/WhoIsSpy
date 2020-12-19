import UIKit

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
var question = [IdentityQuestion]()
let id = "1xFqqMnqUFRNTnj_su5cW0hCgnj7Fw-kCaIJOO-NEApM"
let urlStr = "https://spreadsheets.google.com/feeds/list/\(id)/od6/public/values?alt=json"

func fetchQuestion(urlStr: String) {
    if let url = URL(string: urlStr) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let question = try decoder.decode(SearchResponse.self, from: data)
                    print(question.feed.entry[0].civilianQuestion.question)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

fetchQuestion(urlStr: urlStr)



