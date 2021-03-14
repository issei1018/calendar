//
//  Calendar-Viewcontroller.swift
//  calendar
//
//  Created by Issei Fukumura on 2020/12/20.
//

import UIKit
import  UserNotifications
import FSCalendar

class Calendar_Viewcontroller: UIViewController ,  UITableViewDelegate,FSCalendarDelegate, UITableViewDataSource {
    @IBOutlet var tableView  : UITableView!
    var array :[UNNotificationRequest] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier:
                                                                    "table view cell",for:indexPath)
        
        cell .textLabel!.text = array[indexPath.row].content.title
        return cell
    }
    
    let dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonPendingListTouchUpInside(sender :UIBarButtonItem) {
        print("<Pendhing repust identifers>")
        
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            self.array = requests
            for request in requests {
                print ("identifier:\(request.identifier)")
                print ("  title:\(request.content.title)")
                
                if request.trigger is UNCalendarNotificationTrigger {
                    let trigger = request.trigger as! UNCalendarNotificationTrigger
                    print("<CalendarNotification>")
                    let components = DateComponents(calendar: Calendar.current, year: trigger.dateComponents.year, month: trigger.dateComponents.month, day: trigger.dateComponents.day, hour: trigger.dateComponents.hour,minute: trigger.dateComponents.minute)
                    print(" Scheduled Date:\(self.dateFormatter.string(from: components.date!))")
                    print(" Reperts:\(trigger.repeats)")
                } else if request.trigger is UNTimeIntervalNotificationTrigger {
                    let trigger = request.trigger as! UNTimeIntervalNotificationTrigger
                    print(" <TimeIntervalNotification>")
                    print(" TimeInterval:\(trigger.timeInterval)")
                    print(" Reperts:\(trigger.repeats)")
                }
                print("----------------")
                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
     
    }
   
}







// Do any additional setup after loading the view.




/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 */




