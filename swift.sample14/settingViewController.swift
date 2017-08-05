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
    private let SecItems: NSArray = ["設定1", "設定2"]
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
        
        switch indexPath.section {
        case 0:
            switch  indexPath.row{
            case 0:
                print("個人情報")
            case 1:
                print("ログアウト")
            case 2:
                print("退会")
            case 3:
                print("利用規約")
            default:
                print("お問い合わせ")
                let alert = UIAlertController(title: "お問い合わせ", message: "大変申し訳ございません。現在お問い合わせできません。", preferredStyle: .alert)
                let buttonOk = UIAlertAction(title: "了解", style: .default, handler: {
                    (action: UIAlertAction!) in
                    print("了解!")
                })
                let cancel = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: {
                    (action: UIAlertAction!) in
                    print("キャンセル!")
                })
                alert.addAction(cancel)
                alert.addAction(buttonOk)
                present(alert, animated: true, completion: nil)
                
            }
        default:
            print("未設定")
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
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(myItems[indexPath.row])"
        
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
    
    /*
    各セクションのフッタに表示する文字列を設定します．
    こちらはアルファベットの大文字変換はされないようです．
     */
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return "footer for section: \(section)"
//    }
    
    
//    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//        // アクセサリボタン（セルの右にあるボタン）がタップされた時の処理
//        print("タップされたアクセサリがあるセルのindex番号: \(indexPath.row)")
//    }
    
}
