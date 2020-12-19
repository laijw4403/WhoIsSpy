//
//  ForgetQuestionViewController.swift
//  WhoIsSpy
//
//  Created by Tommy on 2020/12/18.
//

import UIKit

class ForgetQuestionViewController: UIViewController {
    
    var playerNumber: Int!
    var player = [Player]()
    @IBOutlet var playerForgetQuestionButton: [UIButton]!
    
    init?(corder: NSCoder, player: [Player], playerNumber: Int){
        self.player = player
        self.playerNumber = playerNumber
        super.init(coder: corder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initButton()
    }
    
    
    func initButton() {
        // 初始玩家暱稱
        for i in 0...playerNumber-1 {
            playerForgetQuestionButton[i].setTitle(player[i].name, for: .normal)
        }
        // 初始按鈕數量
        var index = playerForgetQuestionButton.count
        print(index)
        while index > player.count {
            print(player.count)
            //playerVoteButton[index-1].isHidden = true
            playerForgetQuestionButton[index-1].alpha = 0
            index -= 1
        }
    }

    @IBAction func showQuestion(_ sender: UIButton) {
        switch sender {
        case playerForgetQuestionButton[0]:
            confirmQuestion(index: 0)
        case playerForgetQuestionButton[1]:
            confirmQuestion(index: 1)
        case playerForgetQuestionButton[2]:
            confirmQuestion(index: 2)
        case playerForgetQuestionButton[3]:
            confirmQuestion(index: 3)
        case playerForgetQuestionButton[4]:
            confirmQuestion(index: 4)
        case playerForgetQuestionButton[5]:
            confirmQuestion(index: 5)
        case playerForgetQuestionButton[6]:
            confirmQuestion(index: 6)
        case playerForgetQuestionButton[7]:
            confirmQuestion(index: 7)
        case playerForgetQuestionButton[8]:
            confirmQuestion(index: 8)
        case playerForgetQuestionButton[9]:
            confirmQuestion(index: 9)
        default:
            break
        }
    }
    
    func confirmQuestion(index: Int) {
        if playerForgetQuestionButton[index].currentTitle == player[index].name {
            playerForgetQuestionButton[index].setTitle(player[index].question, for: .normal)
        } else {
            playerForgetQuestionButton[index].setTitle(player[index].name, for: .normal)
        }
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
