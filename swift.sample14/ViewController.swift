//
//  ViewController.swift
//  swift.sample14
//
//  Created by 水野祥子 on 2017/05/04.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var addBtn: UIBarButtonItem!
    
    private let myItems: NSArray = ["sample0🐩", "sampl1🐩", "sampl2🐩"]
    private let myItems2: NSArray = ["Sample0🐱", "Sample1🐱", "Sample2🐱", "Sample3🐱"]
    private let SecItems: NSArray = ["セクション1", "セクション2"]
    private var myTableView: UITableView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "初期画面"
        
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        myTableView.dataSource = self
        
        myTableView.delegate = self
        
        let viewA = UIView()
        myTableView.tableFooterView = viewA
        
        self.view.addSubview(myTableView)
        

        
        addBtn = UIBarButtonItem()
        addBtn.image = UIImage(named: "set1.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        addBtn.style = UIBarButtonItemStyle.plain
        addBtn.action = #selector(ViewController.onClick)
        addBtn.target = self
        
        self.navigationItem.leftBarButtonItem = addBtn

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onClick() {
        let second = settingViewController()
        let navi = UINavigationController(rootViewController: second)
        present(navi, animated: true, completion: nil)
    }
    
    /*
     Cellの総数を返すデータソースメソッド.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return myItems.count
        default:
            return myItems2.count
        }
    }
    
    //タップされた時に呼ばれる
    func tableView(_ table: UITableView, didSelectRowAt indexPath:IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            switch  indexPath.row{
            case 0:
                print("0🐩")
                let Sample0ViewController = sample0ViewController()
                self.navigationController?.pushViewController(Sample0ViewController, animated: true)
            case 1:
                print("1🐩")
                let Sample1ViewController = sample1ViewController()
                self.navigationController?.pushViewController(Sample1ViewController, animated: true)
            default:
                let Sample2ViewController = sample2ViewController()
                self.navigationController?.pushViewController(Sample2ViewController, animated: true)
            }
        default:
            switch  indexPath.row{
            case 0:
                let Sample1_0ViewController = sample1_0ViewController()
                self.navigationController?.pushViewController(Sample1_0ViewController, animated: true)
                print("0🐱")
            case 1:
                let Sample1_1ViewController = sample1_1ViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
                self.navigationController?.pushViewController(Sample1_1ViewController, animated: true)
                print("1🐱")
            case 2:
                let Sample1_2ViewController = sample1_2ViewController()
                self.navigationController?.pushViewController(Sample1_2ViewController, animated: true)
                print("2🐱")
            default:
                print("3🐱")
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
