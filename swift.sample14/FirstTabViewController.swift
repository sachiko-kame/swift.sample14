//
//  FirstTabViewController.swift
//  swift.sample14
//
//  Created by 水野祥子 on 2017/08/05.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit
//参考 https://fussan-blog.com/uikit-uipagecontrol/
class FirstTabViewController: UIViewController, UIScrollViewDelegate {

    private var pageControl: UIPageControl!
    private var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //ページ数
        let page = 3
        
        //Viewの縦横のサイズ
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height

        //UIScrollViewの設定
        scrollView = UIScrollView()
        scrollView.frame = UIScreen.main.bounds
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        
        //scrollViewのサイズ。4ページなので、画面幅 × 3をしている。
        scrollView.contentSize = CGSize(width: CGFloat(page) * width, height: 0)
        
        self.view.addSubview(scrollView)
        
        //ページごとのlabelを生成
        for i in 0 ..< page {
            let label:UILabel = UILabel()
            label.frame = CGRect(x: CGFloat(i) * width + width/2 - 60, y: height/2 - 40, width: 120, height: 80)
            label.textAlignment = NSTextAlignment.center
            label.text = "\(i+1)つ目のページ"
            scrollView.addSubview(label)
        }
        
        //UIPageControlのインスタンス作成
        pageControl = UIPageControl()
        
        //pageControlの位置とサイズを設定
        pageControl.frame = CGRect(x:0, y:height - (self.tabBarController?.tabBar.frame.size.height)! - 50, width:width, height:50)
        
        //背景色の設定
        pageControl.backgroundColor = UIColor.lightGray
        
        //ページ数の設定
        pageControl.numberOfPages = page
        
        //現在ページの設定
        pageControl.currentPage = 0
        
        self.view.addSubview(pageControl)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("スクロールスタート")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("スクロール中")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView,willDecelerate decelerate: Bool){
        print("スクロールで指が離れたところ")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        //スクロール距離 = 1ページ(画面幅)
        if fmod(scrollView.contentOffset.x, scrollView.frame.width) == 0 {
            //ページの切り替え
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        }
        print("スクロールストップ")
    }


   }
