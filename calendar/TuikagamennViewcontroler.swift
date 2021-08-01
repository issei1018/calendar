//
//  TuikagamennViewcontroler.swift
//  calendar
//
//  Created by Issei Fukumura on 2020/12/20.
//

import UIKit
import UserNotifications

class TuikagamennViewcontroler: UIViewController {
    
    @IBOutlet var deadlineDatePicker: UIDatePicker!
    @IBOutlet var notificationDatePicker: UIDatePicker!
    @IBOutlet var kadaiTextField: UITextField!
    
    var saveData: UserDefaults = UserDefaults.standard
    
    var historyArray: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllHistory()
    }
    
    @IBAction func save() {
        
        let notificationRequest = 通知の作成()
        
        if notificationRequest == nil {
            return
        }
        
        通知の登録(request: notificationRequest!)
        履歴に通知を追加()
        
        // 前の画面に戻るコード
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func 通知の作成() -> UNNotificationRequest? {
        
        // ①
        var kadai: String = kadaiTextField.text!
        var notificationDate: Date = notificationDatePicker.date
        var deadlineDate: Date = deadlineDatePicker.date
        
        // ②
        var content: UNMutableNotificationContent = UNMutableNotificationContent()
        content.title = kadai + "をやりましょう"
        content.body = kadai + "の提出期限は" + String(describing: deadlineDate) + "です"
        
        // ③
        let timeInterval: TimeInterval = notificationDate.timeIntervalSinceNow
        
        if timeInterval > 0 {
            
            let trigger: UNTimeIntervalNotificationTrigger = UNTimeIntervalNotificationTrigger(
                timeInterval: timeInterval,
                repeats: false
            )
            
            // ④
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = DateFormatter.dateFormat(
                fromTemplate: "ydMMM HH:mm:ss",
                options: 0,
                locale: Locale(identifier: "ja_JP")
            )
            let dateString: String = formatter.string(from: Date())
            
            let request: UNNotificationRequest = UNNotificationRequest(identifier: kadai + dateString, content: content, trigger: trigger)
            
            return request
            
        } else {
            return nil
        }
    }
    
    func 通知の登録(request: UNNotificationRequest) {
        
        if request.content.title.isEmpty {
            return
        }
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func 履歴に通知を追加() {
        
        let kadai: String = kadaiTextField.text!
        let notificationDate: Date = notificationDatePicker.date
        let deadlineDate: Date = deadlineDatePicker.date
        
        let newData: [String: Any] = [
            "kadai": kadai,
            "deadline": deadlineDate.timeIntervalSince1970,
            "notification": notificationDate.timeIntervalSince1970
        ]
        historyArray.append(newData)
        
        saveData.set(historyArray, forKey: "history")
    }
    
    func getAllHistory() {
        historyArray = saveData.object(forKey: "history") as? [[String: Any]] ?? []
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

