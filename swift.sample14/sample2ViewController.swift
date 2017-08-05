//
//  sample2ViewController.swift
//  swift.sample14
//
//  Created by 水野祥子 on 2017/08/05.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

class sample2ViewController: UIViewController, UIToolbarDelegate{
    private var myToolbar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "sample2の画面"
                
        // ToolBarの背景色とボタンなどの色を設定
        self.navigationController?.toolbar.barStyle = .blackTranslucent
        self.navigationController?.toolbar.tintColor = UIColor.white
        self.navigationController?.toolbar.barTintColor = UIColor.black
        
        // 各ボタンを生成
        let leftButton = UIBarButtonItem(title: "戻る",
                                         style: UIBarButtonItemStyle.plain,
                                         target: self,
                                         action: #selector(self.onClickBarButton(sender:)))
        
        let centerButton = UIBarButtonItem(title: "初期",
                                           style: UIBarButtonItemStyle.plain,
                                           target: self,
                                           action: #selector(self.onClickBarButton(sender:)))
        
        let rightButton = UIBarButtonItem(title: "進む",
                                          style: UIBarButtonItemStyle.plain,
                                          target: self,
                                          action: #selector(self.onClickBarButton(sender:)))
        // ボタンイベント判別用のTagを設定
        leftButton.tag = 1
        centerButton.tag = 2
        rightButton.tag = 3
        
        // ボタン同士の空白を生成
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        // ボタンの配列を生成
        let items = [leftButton, flexibleItem, centerButton, flexibleItem, rightButton]
        
        // Toolbarにボタンを配置
        self.toolbarItems = items
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.setToolbarHidden(false, animated: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(true)
        self.navigationController?.setToolbarHidden(true, animated: true)

        
    }

    /*
     UIBarButtonItemが押された際に呼ばれる.
     */
    internal func onClickBarButton(sender: UIBarButtonItem) {
        
        switch sender.tag {
        case 1:
            self.view.backgroundColor = UIColor.green
        case 2:
            self.view.backgroundColor = UIColor.blue
        case 3:
            self.view.backgroundColor = UIColor.red
        default:
            print("ERROR!!")
        }
    }
    
    
    
}
