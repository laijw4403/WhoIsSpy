//
//  QuestionViewController.swift
//  WhoIsSpy
//
//  Created by Tommy on 2020/12/3.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var question = [Question(civilianQuestion: "KKBOX", spyQuestion: "Spotify", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "Apple", spyQuestion: "SAMSUNG", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "GAI", spyQuestion: "吳亦凡", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "周杰倫", spyQuestion: "費玉清", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "太監", spyQuestion: "人妖", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "牛奶", spyQuestion: "豆漿", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "新年", spyQuestion: "跨年", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "淘寶", spyQuestion: "蝦皮", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "雙胞胎", spyQuestion: "龍鳳胎", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "川普", spyQuestion: "習近平", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "鈔票", spyQuestion: "銅板", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "包青天", spyQuestion: "狄仁杰", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "蜜蜂", spyQuestion: "蝴蝶", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "颱風", spyQuestion: "龍捲風", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "橘子", spyQuestion: "柳丁", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "IG", spyQuestion: "FB", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "手扶梯", spyQuestion: "電梯", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "伏特加", spyQuestion: "高粱酒", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "原住民", spyQuestion: "新住民", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "正宮", spyQuestion: "小三", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "工具人", spyQuestion: "跑腿小弟", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "楓康", spyQuestion: "全聯", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "麥當勞", spyQuestion: "肯德基", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "三媽臭臭鍋", spyQuestion: "大呼過癮", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "多拉Ａ夢", spyQuestion: "蠟筆小新", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "狼人殺", spyQuestion: "阿瓦隆", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "愛奇藝", spyQuestion: "Netflix", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "山貓", spyQuestion: "石虎", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "重機", spyQuestion: "檔車", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "西瓜刀", spyQuestion: "開山刀", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "一卡通", spyQuestion: "悠遊卡", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "7-11", spyQuestion: "全家", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "統一獅", spyQuestion: "兄弟象", blankQuestion:"你是白板"),
                    Question(civilianQuestion: "好樂迪", spyQuestion: "錢櫃", blankQuestion:"你是白板"),]
    var name = [String]()
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
    init?(coder: NSCoder, playerNumber: Int, spyNumber: Int, blankNumber: Int) {
        self.playerNumber = playerNumber
        self.spyNumber = spyNumber
        self.blankNumber = blankNumber
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.isHidden = true
        print("playNumber:\(String(describing: playerNumber)), spyNumber:\(String(describing: spyNumber)), blankNumber:\(String(describing: blankNumber))")
        createPlayer(number: playerNumber)
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
                name.append("玩家\(i+1)")
                print(name)
            if identity[i].rawValue == Identity.平民.rawValue {
                    player.append(Player(name: name[i], identity: identity[i].rawValue, question: question[0].civilianQuestion))
            } else if identity[i].rawValue == Identity.白板.rawValue {
                    player.append(Player(name: name[i], identity: identity[i].rawValue, question: question[0].blankQuestion))
            } else {
                    player.append(Player(name: name[i], identity: identity[i].rawValue, question: question[0].spyQuestion))
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
