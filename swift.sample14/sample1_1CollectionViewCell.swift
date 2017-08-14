//
//  sample1_1CollectionViewCell.swift
//  swift.sample14
//
//  Created by 水野祥子 on 2017/08/14.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

class sample1_1CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellbutton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(text:String){
        self.cellbutton.setTitle("🐤\(text)", for: .normal)
    }

}
