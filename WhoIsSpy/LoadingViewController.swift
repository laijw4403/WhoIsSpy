//
//  LoadingViewController.swift
//  WhoIsSpy
//
//  Created by Tommy on 2020/12/19.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var fetchingDataActivityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loading View")
        fetchingDataActivityIndicator.startAnimating()
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
