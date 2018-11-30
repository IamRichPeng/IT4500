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
    @IBOutlet weak var notesLabel: UILabel!
    
    var event: EKEvent?
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .short
        
        titleLabel.text = event?.title
        startTimeLabel.text = dateFormatter.string(for: event?.startDate)
        endTimeLabel.text = dateFormatter.string(for: event?.endDate)
        notesLabel.text = event?.notes
    }
}
