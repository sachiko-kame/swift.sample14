//
//  sample0ViewController.swift
//  swift.sample14
//
//  Created by 水野祥子 on 2017/08/05.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

class sample0ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    private let myItems: NSArray = ["sample0🐰", "sampl1🐰", "sampl2🐰"]
    private let myItems2: NSArray = ["Sample0🐢 \nSample0🐢", "Sample1🐢 \nSample1🐢", "Sample2🐢\nSample2🐢", "Sample3🐢 \nSample3🐢"]
    private let SecItems: NSArray = ["セクション1", "セクション2"]
    
    /// 画像のファイル名
    let imageNames = ["set.png", "set.png", "set.png"]
    
    /// 画像のタイトル
    let imageTitles = ["sample0🐰", "sample1🐰", "sample2🐰"]
    
    /// 画像の説明
    let imageDescriptions = [
        "設定します0",
        "設定します1",
        "設定します2"
    ]
    private var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "sample0の画面"
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
        switch section {
        case 0:
            return imageNames.count
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
        
        switch indexPath.section {
        case 0:
            tableView.register(cellType: SampleTableViewCell.self)
            tableView.register(cellTypes: [SampleTableViewCell.self, SampleTableViewCell.self])
            
            let cell = tableView.dequeueReusableCell(with: SampleTableViewCell.self, for: indexPath)
            cell.setCell(imageName: imageNames[indexPath.row], titleText: imageTitles[indexPath.row], descriptionText: imageDescriptions[indexPath.row])
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
            cell.textLabel?.text = "\(myItems2[indexPath.row])"
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont(name:"HiraKakuProN-W3", size:18)
            cell.textLabel?.sizeToFit()
            cell.textLabel?.frame.size.height += ceil(abs((cell.textLabel?.font.descender)! * 2))
//            cell.textLabel?.font = UIFont.systemFont(ofSize: 32)
            cell.textLabel?.shadowColor = UIColor.gray
            return cell
        }
    }
    
    /*
     セルの高さを設定
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        default:
            return 50
        }
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

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}



extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func register<T: UITableViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}
