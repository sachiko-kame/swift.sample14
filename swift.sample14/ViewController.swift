//
//  ViewController.swift
//  swift.sample14
//
//  Created by 水野祥子 on 2017/05/04.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var addBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBtn = UIBarButtonItem()
        addBtn.image = UIImage(named: "set1.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        addBtn.style = UIBarButtonItemStyle.plain
        addBtn.action = #selector(ViewController.onClick)
        addBtn.target = self
        
//        addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.onClick))
           self.navigationItem.leftBarButtonItem = addBtn

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onClick() {
//     let second = settingViewController()
//     self.present(second, animated: true, completion: nil)
        
        let second = settingViewController()
        let navi = UINavigationController(rootViewController: second)
        present(navi, animated: true, completion: nil)
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
