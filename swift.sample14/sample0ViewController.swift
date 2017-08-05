//
//  sample0ViewController.swift
//  swift.sample14
//
//  Created by 水野祥子 on 2017/08/05.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

class sample0ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let myItems: NSArray = ["sample0🐰", "sampl1🐰", "sampl2🐰"]
    private let myItems2: NSArray = ["Sample0🐢", "Sample1🐢", "Sample2🐢", "Sample3🐢"]
    private let SecItems: NSArray = ["セクション1", "セクション2"]
    private var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "初期画面"
        myTableView = UITableView()
        myTableView.frame = UIScreen.main.bounds
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        myTableView.dataSource = self
        
        myTableView.delegate = self
        
        let viewA = UIView()
        myTableView.tableFooterView = viewA
        
        self.view.addSubview(myTableView)
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        switch indexPath.section {
        case 0:
            switch  indexPath.row{
            case 0:
                print("sample0🐰")
            case 1:
                print("sample1🐰")
            default:
                print("その他🐰")
            }
        default:
            switch  indexPath.row{
            case 0:
                print("sample0🐢")
            case 1:
                print("sample1🐢")
            case 2:
                print("sample2🐢")
            default:
                print("その他🐢")
            }

        }
        
        
    }
    
    /*
     Cellに値を設定するデータソースメソッド.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        // 文字色変更
        cell.textLabel?.textColor = UIColor.darkGray
        // 文字サイズ変更
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        
        //セルのアクセサリを設定
        cell.accessoryType = .disclosureIndicator
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(myItems[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "\(myItems2[indexPath.row])"
        }
        
        return cell
    }
    
    /*
     セルの高さを設定
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    /*
     * セクションの数を指定します．
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return SecItems.count
    }
    
    /*
     各セクションのヘッダに表示する文字列を設定します．
     アルファベットは全て大文字に変換されるようです．
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(SecItems[section])"
    }
    


}
