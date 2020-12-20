//
//  ViewController.swift
//  WhoIsSpy
//
//  Created by MAC on 2020/12/1.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
//    let player = AVPlayer()
    
    @IBOutlet weak var playerPickerTextField: UITextField!
    @IBOutlet weak var spyPickerTextField: UITextField!
    @IBOutlet weak var setBlankSwitch: UISwitch!
    
    // 建立pickerView物件, 人數資料陣列
    var playerPicker = UIPickerView()
    var spyPicker = UIPickerView()
    var playerName = ["","","","","","","","","",""]
    let playerNumberForSelect = [4, 5, 6, 7, 8, 9, 10]
    let spyNumberForSelect = [1, 2, 3]
    
    
    // 預設人數
    var playerNumber = 4
    var spyNumber = 1
    var blankNumber = 0
    
    var question = [IdentityQuestion]()
    var loadingActivityIndicator: UIActivityIndicatorView!
    let id = "1xFqqMnqUFRNTnj_su5cW0hCgnj7Fw-kCaIJOO-NEApM"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let fileUrl = Bundle.main.url(forResource: "music", withExtension: "mp3")!
//        let playerItem = AVPlayerItem(url: fileUrl)
//        player.replaceCurrentItem(with: playerItem)
//        player.play()
        
        // 設定採用淺色模式
        overrideUserInterfaceStyle = .light
        // 設定delegate, dataSource來源
        playerPicker.dataSource = self
        playerPicker.delegate = self
        spyPicker.dataSource = self
        spyPicker.delegate = self
        
        // 設定textField inputView為pickerView
        playerPickerTextField.inputView = playerPicker
        spyPickerTextField.inputView = spyPicker
        
        // 設定手勢(endEditing)
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        // 將手勢加入view
        view.addGestureRecognizer(tap)
        
        // 將switch預設關閉
        setBlankSwitch.isOn = false
        
        // 設定loadingActivityIndicatorView
        loadingActivityIndicator = UIActivityIndicatorView(style: .medium)
        loadingActivityIndicator.center = view.center
        view.addSubview(loadingActivityIndicator)
        
        // fetchQuestion
        let urlStr = "https://spreadsheets.google.com/feeds/list/\(id)/od6/public/values?alt=json"
        fetchQuestion(urlStr: urlStr) {(identityQuestion) in
            if let identityQuestion = identityQuestion {
                self.question = identityQuestion
                DispatchQueue.main.async {
                    self.loadingActivityIndicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                }
            }
        }
        
    }
    
    // 手勢關閉編輯呼叫之方法
    @objc func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    // 設定輪軸區塊數量
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 設定每個區塊有幾列
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //print(pickerView)
        if pickerView == playerPicker {
            return playerNumberForSelect.count
        } else {
            return spyNumberForSelect.count
        }
        
    }
    
    // 列被選到時觸發
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == playerPicker {
            // 選擇玩家人數
            playerPickerTextField.text = String(playerNumberForSelect[row])+"人"
            playerNumber = playerNumberForSelect[row]
            
            // 限制臥底人數
            if playerNumber < 6 {
                spyPicker.selectRow(0, inComponent: 0, animated: true)
            } else if playerNumber >= 6 && playerNumber < 10 {
                if spyPicker.selectedRow(inComponent: 0) == 2 {
                    spyPicker.selectRow(1, inComponent: 0, animated: true)
                }
            }
            let spySelectedIndex = spyPicker.selectedRow(inComponent: 0)
            spyPickerTextField.text = String(spyNumberForSelect[spySelectedIndex])+"人"
            spyNumber = spyNumberForSelect[spySelectedIndex]
        } else {
            // 選擇臥底人數 (6人以下能選擇1人為臥底,6-10最多可2人為臥底,10以上最多可有3個臥底)
            if playerNumber < 6 {
                pickerView.selectRow(0, inComponent: 0, animated: true)
            } else if playerNumber >= 6 && playerNumber < 10 {
                if pickerView.selectedRow(inComponent: 0) == 2 {
                    pickerView.selectRow(1, inComponent: 0, animated: true)
                }
            }
            let spySelectedIndex = pickerView.selectedRow(inComponent: 0)
            spyPickerTextField.text = String(spyNumberForSelect[spySelectedIndex])+"人"
            spyNumber = spyNumberForSelect[spySelectedIndex]
        }
    }
    
    // 設定每列pickerView的顯示內容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       if pickerView == playerPicker {
            return String(playerNumberForSelect[row])+"人"
        } else {
            return String(spyNumberForSelect[row])+"人"
        }
    }
    

    
    @IBAction func setBlank(_ sender: Any) {
        if setBlankSwitch.isOn {
            blankNumber = 1
        } else {
            blankNumber = 0
        }
    }
    
    
    @IBAction func customPlayerName(_ sender: Any) {
        let controller = UIAlertController(title: "自訂暱稱", message: "", preferredStyle: .alert)
        print(playerName)
        for _ in 1...playerNumber {
            controller.addTextField { (textField) in
                textField.placeholder = "請輸入暱稱"
                textField.keyboardType = .namePhonePad
            }
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            
            for index in 0...self.playerNumber-1 {
                guard let name = controller.textFields?[index].text else { return }
                self.playerName[index] = name
            }
            print(self.playerName)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(okAction)
        controller.addAction(cancelAction)
        
        present(controller, animated: true, completion: nil)
    }
    
    @IBSegueAction func showQuestion(_ coder: NSCoder) -> QuestionViewController? {
        // 程式只有一行時可省略return
        QuestionViewController(coder: coder, playerNumber: playerNumber, spyNumber: spyNumber, blankNumber: blankNumber, playerName: playerName, question: question)
    }
        
    func fetchQuestion(urlStr: String, completionHandler: @escaping ([IdentityQuestion]?) -> Void) {
        if let url = URL(string: urlStr) {
            // 啟動loadingAnimating
            loadingActivityIndicator.startAnimating()
            view.isUserInteractionEnabled = false
            // Data Download
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let question = try decoder.decode(SearchResponse.self, from: data)
                        completionHandler(question.feed.entry)
                    } catch {
                        completionHandler(nil)
                    }
                }
            }.resume()
        }
    }
    
    @IBAction func unwindToHomePage(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
    }
    
}

