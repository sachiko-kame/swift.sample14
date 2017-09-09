//
//  sample0ViewController.swift
//  swift.sample14
//
//  Created by 水野祥子 on 2017/08/05.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit
//文字装飾参考: http://blog.ch3cooh.jp/entry/20150716/1437017097
class sample0ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    private let myItems: NSArray = ["sample0🐰", "sampl1🐰", "sampl2🐰"]
    private let myItems2: NSArray = ["Sample0🐢Sample0🐢", "Sample1🐢 \nSample1🐢", "Sample2🐢\nSample2🐢", "Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢Sample0🐢"]
    
    private let SecItems: NSArray = ["セクション1", "セクション2"]
    
    /// 画像のファイル名
    let imageNames = ["set.png", "set.png", "set.png"]
    
    /// 画像のタイトル
    let imageTitles = ["sample0🐰\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaSample0🐢", "sample1🐰\nSample0🐢", "sample2🐰\nSample0🐢"]
    
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
            cell.myTitleLabel.numberOfLines = 0
//            cell.myTitleLabel.attributedText = self.attribute1(text:cell.myTitleLabel.text!)
            return cell
        default:
            
            //下にぎょうはどっちか書けば大丈夫
//            tableView.register(cellType: Sample2TableViewCell.self)
            tableView.register(cellTypes: [Sample2TableViewCell.self, Sample2TableViewCell.self])
            
            let cell = tableView.dequeueReusableCell(with: Sample2TableViewCell.self, for: indexPath)
            cell.abSample.text = (myItems2[indexPath.row] as! String)
            cell.abSample.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.layoutIfNeeded()

            return cell
        }
    }
    
    /*
     セルの高さを設定
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            myTableView.estimatedRowHeight = 80
            return UITableViewAutomaticDimension
        default:
            myTableView.estimatedRowHeight = 80
//            myTableView.rowHeight = UITableViewAutomaticDimension
            return UITableViewAutomaticDimension
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
    
    private func attribute1(text:String) -> NSAttributedString? {
        let font = UIFont(name: "HiraKakuProN-W3", size: 10) ?? UIFont.systemFont(ofSize: 10)
        
        let style = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        style.alignment = NSTextAlignment.center
        style.lineSpacing = 1.5 //行と行に間
        
        let attr = [
            NSForegroundColorAttributeName: UIColor.cyan,
            NSFontAttributeName: font,
            NSParagraphStyleAttributeName: style, 
            NSKernAttributeName: 10  //文字間隔増える横と横の文字間隔
            ] as [String : Any]
        
        return NSAttributedString(string: "\(text)", attributes: attr)
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
