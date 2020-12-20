//
//  RuleViewController.swift
//  WhoIsSpy
//
//  Created by Tommy on 2020/12/6.
//

import UIKit

class RuleViewController: UIViewController {
    
    var player = [Player]()
    var playerName = [String]()
    var playerNumber: Int!
    var spyNumber: Int!
    var blankNumber: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBSegueAction func showVoteView(_ coder: NSCoder) -> VoteViewController? {
        let civilianNumber = playerNumber - spyNumber - blankNumber
        return VoteViewController(coder: coder, player: player, playerNumber: playerNumber, spyNumber: spyNumber, blankNumber: blankNumber, civilianNumber: civilianNumber, playerName: playerName)
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
