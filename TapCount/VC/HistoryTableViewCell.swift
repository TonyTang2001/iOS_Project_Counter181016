//
//  HistoryTableViewCell.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/10/14.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var CountNumLb: UILabel!
    @IBOutlet weak var TimeLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
