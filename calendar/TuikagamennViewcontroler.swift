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
        let trigger: UNTimeIntervalNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
        
        let request: UNNotificationRequest = UNNotificationRequest(identifier: kadai, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
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



