//
//  settingViewController.swift
//  swift.sample14
//
//  Created by 水野祥子 on 2017/05/04.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

class settingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var addBtn: UIBarButtonItem!

    
    private let myItems: NSArray = ["個人情報の設定", "ログアウト", "退会","利用規約","お問い合わせ"]
    private var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.title = "設定"
        
    myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
    myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
    myTableView.dataSource = self
        
    myTableView.delegate = self
        
    addBtn = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(settingViewController.back))
        self.navigationItem.rightBarButtonItem = addBtn
        
    let viewA = UIView()
    myTableView.tableFooterView = viewA

    self.view.addSubview(myTableView)
   

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func back() {
        self.dismiss(animated: true, completion: nil)
    }
  
    
  
    
    /*
     Cellの総数を返すデータソースメソッド.
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myItems.count
    }
    
    //タップされた時に呼ばれる
    func tableView(_ table: UITableView, didSelectRowAt indexPath:IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        switch  indexPath.row{
        case 0:
            print("0")
        case 1:
            print("1")
        case 2:
            print("2")
        default:
            print("3")
        }
        

    }
    
    /*
     Cellに値を設定するデータソースメソッド.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(myItems[indexPath.row])"
        
        return cell
    }
    
}
