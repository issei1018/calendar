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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func save() {
        
        let kadai: String = kadaiTextField.text!
        let notificationDate: Date = notificationDatePicker.date
        let deadlineDate: Date = deadlineDatePicker.date
        let content: UNMutableNotificationContent = UNMutableNotificationContent()
        content.title = kadai + "をやりましょう"
        content.body = kadai + "の提出期限は" + String(describing: deadlineDate) + "です"
        let timeInterval: TimeInterval = notificationDate.timeIntervalSinceNow
        
        
        if timeInterval > 0 {
            let trigger: UNTimeIntervalNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            
            
            
            let formatter: DateFormatter = DateFormatter()
            
            formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM HH:mm:ss", options: 0, locale: Locale(identifier: "ja_JP"))
            let dateString: String = formatter.string(from: Date())
            
            let request: UNNotificationRequest = UNNotificationRequest(identifier: kadai + dateString, content: content, trigger: trigger)
            
            if  !kadai.isEmpty {
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                self.navigationController?.popViewController(animated: true)
            }
         
        }
        
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

