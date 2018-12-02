//
//  ExpandedEventViewController.swift
//  Canlendar
//
//  Created by KirtisOrendorff on 11/30/18.
//  Copyright © 2018 Ruicheng Peng. All rights reserved.
//

import UIKit
import EventKit

class ExpandedEventViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var notesTextField: UITextView!
    
    var event: EKEvent?
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = ("h:mm a")
        
        self.view.backgroundColor = UIColor(red:0.31, green:0.55, blue:0.89, alpha:1.0)
        
        titleLabel.text = event?.title
        titleLabel.textColor = UIColor.white
        
        startTimeLabel.text = dateFormatter.string(for: event?.startDate)
        startTimeLabel.textColor = UIColor.white
        
        endTimeLabel.text = dateFormatter.string(for: event?.endDate)
        endTimeLabel.textColor = UIColor.white
        
        notesTextField.text = event?.notes
        notesTextField.textColor = UIColor.white
        notesTextField.backgroundColor = UIColor(red:0.31, green:0.55, blue:0.89, alpha:1.0)
    }
}
