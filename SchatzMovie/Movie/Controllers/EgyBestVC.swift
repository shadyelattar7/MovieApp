//
//  EgyBestVC.swift
//  Movie
//
//  Created by Elattar on 8/23/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import UIKit
import WebKit

class EgyBestVC: UIViewController {

    var name: String = ""
    var data: String = ""
    
    @IBOutlet weak var web: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://www.egy.best/movie/\( encodeUrl(name))-\(dateMovie(data))/")
        let request = URLRequest(url: url!)
        web.load(request)
    }
    

    func dateMovie(_ year: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"
        
        if let date = dateFormatterGet.date(from: year){
            return dateFormatterPrint.string(from: date)
        }
        return "nill"
    }
    
    func encodeUrl(_ movieName: String) -> String {
        //        let step1 = movieName.replacingOccurrences(of: "&", with: "and")
        //        let step2 = step1.replacingOccurrences(of: ":", with: "")
        //        let step3 = step2.replacingOccurrences(of: " ", with: "-")
        //        return step3
        let step1 = movieName.replacingOccurrences(of: "&", with: "and")
        let step2 = step1.replacingOccurrences(of: ":", with: "")
        let step3 = step2.replacingOccurrences(of: "– ", with: "")
        let step4 = step3.replacingOccurrences(of: ",", with: "")
        let step5 = step4.replacingOccurrences(of: " ", with: "-")
        return step5
    }
 

}
