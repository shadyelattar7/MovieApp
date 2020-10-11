//
//  ReminderVC.swift
//  Movie
//
//  Created by Elattar on 8/23/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import UIKit
import UserNotifications

class ReminderVC: UIViewController {

    var titleMovie: String = ""
    var poster: String = ""
    
    @IBOutlet weak var date_tf: UITextField!
    @IBOutlet weak var remind: UIButton!
    private var datePicker: UIDatePicker?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("poster\(poster)")
        
        remind.layer.cornerRadius = 15
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        datePicker?.addTarget(self, action: #selector(self.dateChanged(datePicker:)), for: .valueChanged)
        date_tf.inputView = datePicker
        
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        date_tf.text = dateFormatter.string(from: datePicker.date)
    }

    @IBAction func remind_btn(_ sender: Any) {
         notification()
    }
    
    
    func notification()  {
        
        let content  = UNMutableNotificationContent()
        content.title = titleMovie
        content.body = "Just a reminder to watch movie."
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "movieCatgery"
        
        let fileURL = ("https://image.tmdb.org/t/p/w342/\(poster)")
        let data = try? Data(contentsOf: URL(string: fileURL)!)
        guard let myImage = UIImage(data: data!) else { return }
        if let attachment = UNNotificationAttachment.create(identifier: "identifier", image: myImage, options: nil) {
            content.attachments = [attachment]
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let dateNow = dateFormatter.string(from: datePicker!.date)
        print(" Date: \(dateNow)")
        
        let date = datePicker!.date
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: "movieNotifaction", content: content, trigger: trigger)
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error\(error.localizedDescription)")
            }
        }
    }
}
