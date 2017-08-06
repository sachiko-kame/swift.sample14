//
//  StorySam1ViewController.swift
//  swift.sample14
//
//  Created by 水野祥子 on 2017/08/06.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

class StorySam1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let img = UIImage(named: "set.png")
        let imgView = UIImageView()
        let rec = CGRect(x: 10.0, y: 10.0 + 100.0, width:200.0 , height: 200.0)
        imgView.frame = rec
        imgView.image = img
        self.view.addSubview(imgView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
