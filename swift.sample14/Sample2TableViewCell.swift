//
//  Sample2TableViewCell.swift
//  swift.sample14
//
//  Created by 水野祥子 on 2017/08/23.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

class Sample2TableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var abSample: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
