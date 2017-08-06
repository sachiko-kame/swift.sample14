//
//  sample1_0ViewController.swift
//  swift.sample14
//
//  Created by 水野祥子 on 2017/08/06.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit
// http://qiita.com/fumiyasac@github/items/1244abc8e3286c47ef50#_reference-e955e0f2dd71dd3b292c
//テーブルビューに関係する定数
struct PageSettings {
    
    //ScrollViewのサイズに関するセッテイング
    static let menuScrollViewY : Int = 20
    static let menuScrollViewH : Int = 40
    static let slidingLabelY : Int = 34
    static let slidingLabelH : Int = 1
    
    //ScrollViewに表示するボタン名称
    static let pageScrollNavigationList: [String] = [
        "🔖1番目",
        "🔖2番目",
        "🔖3番目",
        "🔖4番目",
        "🔖5番目",
        "🔖6番目"
    ]
    
    //UIPageViewControllerに配置するUIViewControllerクラスの名称
    static let pageControllerIdentifierList : [String] = [
        "StorySam0",
        "StorySam1",
        "StorySam0",
        "StorySam1",
        "StorySam0",
        "StorySam1"
    ]
    
    //UIPageViewControllerに追加するViewControllerのリストを生成する
    static func generateViewControllerList() -> [UIViewController] {
        
        var viewControllers : [UIViewController] = []
        self.pageControllerIdentifierList.forEach { viewControllerName in
            
            //ViewControllerのIdentifierからViewControllerを作る
            let viewController = UIStoryboard(name: "\(viewControllerName)", bundle: nil) .
                instantiateViewController(withIdentifier: "\(viewControllerName)ViewController")
            
            viewControllers.append(viewController)
        }
        return viewControllers
    }
    
}


class sample1_0ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate  {
    
    var navHeight : CGFloat!
    
    //子のViewControllerのindex　この数値で現在どこにいるかを判断するためこの数値に処理を入れている。
    var viewControllerIndex : Int = 0
    
    //動くラベルの設定
    var slidingLabel : UILabel!
    
    //ページ管理用のコントローラー
    var pageViewController : UIPageViewController!
    
    //メニュー用のスクロールビュー
    var menuScrollView : UIScrollView!
    
    //メニュー用スクロールビューのX座標のOffset値
    var scrollButtonOffsetX : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navHeight = self.navigationController?.navigationBar.frame.size.height
        
        menuScrollView = UIScrollView()

        //UIScrollViewのデリゲート
        menuScrollView.delegate = self
        
        //UIScrollViewを配置
        self.view.addSubview(menuScrollView)
        
        //動くラベルの初期化
        slidingLabel = UILabel()
        
//        第1引数：ページ送りする際のスタイル設定（.PageCurl：ページめくり / .Scroll：スクロール）
//        第2引数：ページ送りの方向設定（.Horizontal：水平方向 / .Vertical：垂直方向）
//        第3引数：その他オプション設定
        //UIPageViewControllerの設定
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        //UIPageViewControllerのデリゲート
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        //作成したViewControlloerの配列をpageViewControllerに設定、その際に動作も少し設定をする。
        self.pageViewController.setViewControllers([PageSettings.generateViewControllerList().first!], direction: .forward, animated: false, completion: nil)
        
        //UIPageViewControllerを子のViewControllerとして登録
        self.addChildViewController(self.pageViewController)
        
        //UIPageViewControllerを配置
        self.view.addSubview(self.pageViewController.view)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //レイアウト処理が完了した際の処理
    override func viewDidLayoutSubviews() {
        
        //UIScrollViewのサイズを変更する
        menuScrollView.frame = CGRect(
            x: CGFloat(0),
            y: CGFloat(PageSettings.menuScrollViewY) + navHeight,
            width: CGFloat(self.view.frame.width),
            height: CGFloat(PageSettings.menuScrollViewH)
        )
        
        //UIPageViewControllerのサイズを変更する
        //サイズの想定 →（X座標：0, Y座標：[UIScrollViewのY座標＋高さ], 幅：[おおもとのViewの幅], 高さ：[おおもとのViewの高さ] - [UIScrollViewのY座標＋高さ]）
        pageViewController.view.frame = CGRect(
            x: CGFloat(0),
            y: CGFloat(self.menuScrollView.frame.origin.y + self.menuScrollView.frame.height),
            width: CGFloat(self.view.frame.width),
            height: CGFloat(self.view.frame.height - (self.menuScrollView.frame.origin.y + self.menuScrollView.frame.height))
        )
        pageViewController.view.backgroundColor = UIColor.gray
        menuScrollView.backgroundColor = UIColor.lightGray
        
        //UIScrollViewの初期設定
        initContentsScrollViewSettings()
        
        //UIScrollViewへのボタンの配置 リスト配列が0なのでカウントを-1にして調整
        for i in 0...(PageSettings.pageScrollNavigationList.count - 1){
            self.addButtonToButtonScrollView(i)
        }
        
        //動くラベルの配置 下の細いバー、スクロールバー見せないでViewを見せる、最初は末端にあるのでこの計算値、後で動かす。
        slidingLabel.frame = CGRect(
            x: CGFloat(0),
            y: CGFloat(PageSettings.slidingLabelY) + navHeight,
            width: CGFloat(self.view.frame.width / 3),
            height: CGFloat(PageSettings.slidingLabelH)
        )
        //スクロールするメニューに配置
        menuScrollView.addSubview(slidingLabel)
        //最前面にくるように
        menuScrollView.bringSubview(toFront: slidingLabel)
        //ラベルに色をつける
        slidingLabel.backgroundColor = UIColor.darkGray

    }
    
    /**
     *
     * UIPageViewControllerDelegateのメソッドを活用
     *
     */
    //開始の繊維が終了すると送信。つまり実行finishedはアニメーションが終了したかを表す。completedはトランジションが完了したかをあらわす。
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        //スワイプアニメーションが完了していない時には処理をさせなくする
        if !completed {
            return
        }
        
        //スクロールビューとボタンを押されたボタンに応じて移動する
        moveToCurrentButtonScrollView(viewControllerIndex)
        moveToCurrentButtonLabel(viewControllerIndex)
    }
    
    /**
     *
     * UIPageViewControllerDataSourceのメソッドを活用
     *
     */
    
    //ページを次にめくった際に実行される処理
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let targetViewControllers : [UIViewController] = PageSettings.generateViewControllerList()
        if viewControllerIndex >= targetViewControllers.count - 1 {
            return nil
        }
        viewControllerIndex = viewControllerIndex + 1
        return targetViewControllers[viewControllerIndex]
    }
    
    //ページを前にめくった際に実行される処理
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let targetViewControllers : [UIViewController] = PageSettings.generateViewControllerList()
        if viewControllerIndex <= 0 {
            return nil
        }
        viewControllerIndex = viewControllerIndex - 1
        return targetViewControllers[viewControllerIndex]
    }
    
    /**
     *
     * UIScrollViewに関するセッティング
     *
     */
    
    //コンテンツ配置用Scrollviewの初期セッティング
    func initContentsScrollViewSettings() {
        
        // ページ単位でスクロールするかの設定
        menuScrollView.isPagingEnabled = false
        //スクロールできるようにする？ドラッグオフ？
        menuScrollView.isScrollEnabled = true
        //ドラッグ時のたて、横スクロールをロックしない
        menuScrollView.isDirectionalLockEnabled = false
        // 水平スクロールバーの表示有無 今回表示させない、意図的に作成しているから
        menuScrollView.showsHorizontalScrollIndicator = false
        // 垂直スクロールバーの表示有無　今回表示させない、意図的に作成しているから
        menuScrollView.showsVerticalScrollIndicator = false
        // スクロールをバウンドさせる、させないの設定 うーぴょんってやつ
        menuScrollView.bounces = false
        // 画面上部をタップ時にスクロールを一番上へ移動するかの設定
        menuScrollView.scrollsToTop = false
        
        //コンテンツサイズの決定　//一つの幅に3つ入れるから/3
        self.menuScrollView.contentSize = CGSize(
            width: CGFloat(Int(self.view.frame.width) * PageSettings.pageScrollNavigationList.count / 3),
            height: CGFloat(PageSettings.menuScrollViewH)
        )
    }
    
    //ボタンの初期配置を行う　スクロールの幅の最初から幅とって順々に入れていく。
    func addButtonToButtonScrollView(_ i: Int) {
        
        let buttonElement: UIButton! = UIButton()
        
        let pX: CGFloat = CGFloat(Int(self.view.frame.width) / 3 * i)
        let pY: CGFloat = CGFloat(0) + navHeight
        let pW: CGFloat = CGFloat(Int(self.view.frame.width) / 3)
        let pH: CGFloat = CGFloat(menuScrollView.frame.height)
        
        buttonElement.frame = CGRect(x: pX, y: pY, width: pW, height: pH)
        buttonElement.backgroundColor = UIColor.black
        buttonElement.setTitle(PageSettings.pageScrollNavigationList[i], for: UIControlState())
        buttonElement.titleLabel!.font = UIFont(name: "Bold", size: CGFloat(16))
        buttonElement.tag = i
        buttonElement.addTarget(self, action: #selector(sample1_0ViewController.buttonTapped(_:)), for: .touchUpInside)
        
        menuScrollView.addSubview(buttonElement)
    }
    
    //ボタンをタップした際に行われる処理
    func buttonTapped(_ button: UIButton){
        
        //押されたボタンのタグを取得
        let page: Int = button.tag
        
        //遷移の方向用の変数を用意する
        var targetDirection: UIPageViewControllerNavigationDirection? = nil
        
        //現在位置と遷移先のインデックスの差分から動く方向を設定する
        if viewControllerIndex - page == 0 {
            return
        } else if viewControllerIndex - page > 0 {
            targetDirection = .reverse
        } else if viewControllerIndex - page < 0 {
            targetDirection = .forward
        }
        
        viewControllerIndex = page
        
        pageViewController.setViewControllers([PageSettings.generateViewControllerList()[page]], direction: targetDirection!, animated: true, completion: nil)
        
        //スクロールビューとボタンを押されたボタンに応じて移動する
        moveToCurrentButtonScrollView(viewControllerIndex)
        moveToCurrentButtonLabel(viewControllerIndex)
    }
    
    //ボタンのスクロールビューをスライドさせる
    func moveToCurrentButtonScrollView(_ page: Int) {
        
        //Case1. ボタンを内包しているスクロールビューの位置変更をする
        if page > 0 && page < (PageSettings.pageScrollNavigationList.count - 1) {
            
            scrollButtonOffsetX = Int(self.view.frame.size.width) / 3 * (page - 1)
            
            //Case2. 一番最初のpage番号のときの移動量
        } else if page == 0 {
            
            scrollButtonOffsetX = 0
            
            //Case3. 一番最後のpage番号のときの移動量
        } else if page == (PageSettings.pageScrollNavigationList.count - 1) {
            
            scrollButtonOffsetX = Int(self.view.frame.size.width)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.menuScrollView.contentOffset = CGPoint(
                x: CGFloat(self.scrollButtonOffsetX),
                y: CGFloat(0) + self.navHeight
            )
        }, completion: nil)
        
    }
    
    //動くラベルをスライドさせる
    func moveToCurrentButtonLabel(_ page: Int) {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            
            self.slidingLabel.frame = CGRect(
                x: CGFloat(Int(self.view.frame.width) / 3 * page),
                y: CGFloat(PageSettings.slidingLabelY) + self.navHeight,
                width: CGFloat(Int(self.view.frame.width) / 3),
                height: CGFloat(PageSettings.slidingLabelH)
            )
            
        }, completion: nil)
    }
    

   

}
