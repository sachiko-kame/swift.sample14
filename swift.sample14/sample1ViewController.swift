//
//  sample1ViewController.swift
//  swift.sample14
//
//  Created by 水野祥子 on 2017/08/05.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

class sample1ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        self.title = "sample1の画面"

        let mainViewController = FirstTabViewController()
        let secondViewController = SecondTabViewController()
        
        mainViewController.title = "first"
        secondViewController.title = "second"
        
        mainViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.favorites, tag: 1)
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.bookmarks, tag: 2)
        
        let navigationController1 = UINavigationController(rootViewController: mainViewController)
        let navigationController2 = UINavigationController(rootViewController: secondViewController)
        
        //2つのViewControllerをArrayでまとめます
        let tabs = [navigationController1, navigationController2]
        
        self.viewControllers = tabs
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
