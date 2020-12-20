//
//  QuestionViewController.swift
//  WhoIsSpy
//
//  Created by Tommy on 2020/12/3.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var question = [IdentityQuestion]()
    var playerName: [String]!
    var player = [Player]()
    var identity = [Identity]()
    var playerNumber: Int!
    var spyNumber: Int!
    var blankNumber: Int!
    var playerIndex = 0
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var showQuestionButton: UIButton!
    
    // 透過程式跑到此畫面初始時傳值
    init?(coder: NSCoder, playerNumber: Int, spyNumber: Int, blankNumber: Int, playerName: [String], question: [IdentityQuestion]) {
        self.playerNumber = playerNumber
        self.spyNumber = spyNumber
        self.blankNumber = blankNumber
        self.playerName = playerName
        self.question = question
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPlayer(number: playerNumber)
        nameLabel.text = player[0].name
        questionLabel.isHidden = true
        print("playNumber:\(String(describing: playerNumber)), spyNumber:\(String(describing: spyNumber)), blankNumber:\(String(describing: blankNumber))")
    }
    
    @IBAction func showQuestion(_ sender: UIButton) {
        if sender.currentTitle == "點擊查看題目" {
            questionLabel.isHidden = false
            if playerIndex < (playerNumber-1) {
                nameLabel.text = player[playerIndex].name
                questionLabel.text = player[playerIndex].question
                playerIndex += 1
                showQuestionButton.setTitle("下一位", for: .normal)
            } else if playerIndex == (playerNumber-1) {
                nameLabel.text = player[playerIndex].name
                questionLabel.text = player[playerIndex].question
                showQuestionButton.setTitle("傳閱完畢", for: .normal)
            }
        } else if sender.currentTitle == "傳閱完畢" {
            guard let ruleViewController = storyboard?.instantiateViewController(identifier: "RulePage") as? RuleViewController else { return }
            ruleViewController.modalPresentationStyle = .fullScreen
            ruleViewController.player = player
            ruleViewController.playerNumber = playerNumber
            ruleViewController.spyNumber = spyNumber
            ruleViewController.blankNumber = blankNumber
            ruleViewController.playerName = playerName
            present(ruleViewController, animated: true, completion: nil)
        } else {
                nameLabel.text = player[playerIndex].name
                questionLabel.isHidden = true
                showQuestionButton.setTitle("點擊查看題目", for: .normal)
            }
        }
    
    // 建立玩家
    func createPlayer(number: Int) {
        
        createIdentity(number)
        identity.shuffle()
        print(identity)
        question.shuffle()
        print(question)
        
        for i in 0...(playerNumber-1) {
        
            // 玩家無自訂暱稱
            if playerName.isEmpty {
                for index in 0...playerNumber-1 {
                    playerName.append("玩家\(index+1)")
                    print(playerName)
                }
            }
            
            if identity[i].rawValue == Identity.平民.rawValue {
                    player.append(Player(name: playerName[i], identity: identity[i].rawValue, question: question[0].civilianQuestion.question))
            } else if identity[i].rawValue == Identity.白板.rawValue {
                    player.append(Player(name: playerName[i], identity: identity[i].rawValue, question: "你是白板"))
            } else {
                player.append(Player(name: playerName[i], identity: identity[i].rawValue, question: question[0].spyQuestion.question))
            }
        }
        print(player)
    }

    // 建立玩家身份
    func createIdentity(_ number: Int) {
        let civilian = playerNumber - spyNumber - blankNumber
        
        if blankNumber == 1 {
            identity.append(.白板)
        }
        
        for _ in 1...civilian {
            identity.append(.平民)
        }
        
        for _ in 1...spyNumber {
            identity.append(.臥底)
        }
        
        print(identity)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? ViewController
        controller?.playerName = playerName
    }
    
//    func fetchQuestion(urlStr: String, completionHandler: @escaping ([IdentityQuestion]?) -> Void) {
//
//        if let url = URL(string: urlStr) {
//            print("Fetching")
//            URLSession.shared.dataTask(with: url) { (data, response, error) in
//                if let data = data {
//                    let decoder = JSONDecoder()
//                    do {
//                        let question = try decoder.decode(SearchResponse.self, from: data)
//                        completionHandler(question.feed.entry)
//                    } catch {
//                        completionHandler([])
//                    }
//                }
//            }.resume()
//            print("Fetch Done!")
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
