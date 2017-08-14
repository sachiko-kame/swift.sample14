//
//  sample1_1CollectionViewCell.swift
//  swift.sample14
//
//  Created by 水野祥子 on 2017/08/14.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

class sample1_1CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var celllabe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(text:String){
        self.celllabe.text = "🐢\(text)"
//        self.cellbutton.setTitle("🐢\(text)", for: .highlighted)
//        self.cellbutton.setTitleColor(UIColor.green, for: UIControlState.highlighted)
    }

}
