//
//  VoteViewController.swift
//  WhoIsSpy
//
//  Created by Tommy on 2020/12/3.
//

import UIKit

class VoteViewController: UIViewController {
    
    var player = [Player]()
    var playerNumber: Int!
    var spyNumber: Int!
    var blankNumber: Int!
    var civilianNumber: Int!
    
    @IBOutlet var playerVoteButton: [UIButton]!
    @IBOutlet var identityLabel: [UILabel]!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    init?(coder: NSCoder, player: [Player], playerNumber: Int, spyNumber: Int, blankNumber: Int, civilianNumber: Int) {
        self.player = player
        self.blankNumber = blankNumber
        self.playerNumber = playerNumber
        self.spyNumber = spyNumber
        self.civilianNumber = civilianNumber
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initButton()
        initIdentityLabel()
    }
    
    @IBAction func votePlayer(_ sender: UIButton) {
        switch sender {
        case playerVoteButton[0]:
            confirmVote(name: player[0].name, index: 0)
        case playerVoteButton[1]:
            confirmVote(name: player[1].name, index: 1)
        case playerVoteButton[2]:
            confirmVote(name: player[2].name, index: 2)
        case playerVoteButton[3]:
            confirmVote(name: player[3].name, index: 3)
        case playerVoteButton[4]:
            confirmVote(name: player[4].name, index: 4)
        case playerVoteButton[5]:
            confirmVote(name: player[5].name, index: 5)
        case playerVoteButton[6]:
            confirmVote(name: player[6].name, index: 6)
        case playerVoteButton[7]:
            confirmVote(name: player[7].name, index: 7)
        case playerVoteButton[8]:
            confirmVote(name: player[8].name, index: 8)
        case playerVoteButton[9]:
            confirmVote(name: player[9].name, index: 9)
        default:
            break
        }
    }
    
    func initButton() {
        // 初始玩家暱稱
        for i in 0...playerNumber-1 {
            playerVoteButton[i].setTitle(player[i].name, for: .normal)
        }
        // 初始按鈕數量
        var index = playerVoteButton.count
        print(index)
        while index > player.count {
            print(player.count)
            //playerVoteButton[index-1].isHidden = true
            playerVoteButton[index-1].alpha = 0
            index -= 1
        }
    }
    
    func initIdentityLabel() {
        for i in 0...9 {
            identityLabel[i].text = ""
        }
    }
    
    func votedPlayer(index: Int) {
        print("按下玩家\(index+1)")
        let identity = player[index].identity
        if identity == Identity.臥底.rawValue {
            playerVoteButton[index].backgroundColor = UIColor(cgColor: CGColor(srgbRed: 176/255, green: 62/255, blue: 44/255, alpha: 1))
            identityLabel[index].textColor = UIColor(cgColor: CGColor(srgbRed: 176/255, green: 62/255, blue: 44/255, alpha: 1))
            spyNumber -= 1
            print("剩餘臥底數量:\(spyNumber)")
        } else {
            playerVoteButton[index].backgroundColor = UIColor(cgColor: CGColor(srgbRed: 44/255, green: 92/255, blue: 176/255, alpha: 1))
            identityLabel[index].textColor = UIColor(cgColor: CGColor(srgbRed: 44/255, green: 92/255, blue: 176/255, alpha: 1))
            if identity == Identity.平民.rawValue {
                civilianNumber -= 1
                print("剩餘平民數量:\(civilianNumber)")
            } else {
                blankNumber -= 1
            }
        }
        identityLabel[index].text = identity
        identityLabel[index].isHidden = false
        
        // 遊戲結束條件
        if spyNumber == 0 && blankNumber == 1 {
            resultLabel.text = "遊戲結束！白板獲勝"
            resultLabel.textColor = .black
        } else if spyNumber + civilianNumber + blankNumber == 3 && spyNumber >= 1 {
            resultLabel.text = "遊戲結束！臥底獲勝"
            resultLabel.textColor = UIColor(cgColor: CGColor(srgbRed: 176/255, green: 62/255, blue: 44/255, alpha: 1))
        } else if spyNumber == 0 {
            resultLabel.text = "遊戲結束！平民獲勝"
            resultLabel.textColor = UIColor(cgColor: CGColor(srgbRed: 44/255, green: 92/255, blue: 176/255, alpha: 1))
        }
    }
    
    func confirmVote(name: String,index: Int) {
        let controller = UIAlertController(title: "", message: "確定要讓\(name)出局嗎?", preferredStyle: .alert)
        let comfirmAction = UIAlertAction(title: "滾吧！", style: .default) { (_) in
            self.votedPlayer(index: index)
        }
        controller.addAction(comfirmAction)
        let cancelAction = UIAlertAction(title: "先放過他", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
        
        //if player
    }

    @IBSegueAction func showForgetQuestionView(_ coder: NSCoder) -> ForgetQuestionViewController? {
        return ForgetQuestionViewController(corder: coder, player: player, playerNumber: playerNumber)
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
