//
//  EventDetailTableViewCell.swift
//  Canlendar
//
//  Created by KirtisOrendorff on 11/27/18.
//  Copyright © 2018 Ruicheng Peng. All rights reserved.
//

import UIKit

class EventDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var EventDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
