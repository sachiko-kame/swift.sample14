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
        switch  indexPath.row{
        case 0:
            print("0")
        case 1:
            print("1")
        case 2:
            print("2")
        default:
            print("3")
            let alert = UIAlertController(title: "タイトル", message: "sampleです。", preferredStyle: .alert)
            let buttonOk = UIAlertAction(title: "了解", style: .default, handler: nil)
            alert.addAction(buttonOk)
            present(alert, animated: true, completion: nil)

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
