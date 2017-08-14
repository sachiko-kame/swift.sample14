//
//  sample1_1ViewController.swift
//  swift.sample14
//
//  Created by 水野祥子 on 2017/08/06.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit
//参考http://mypace1981.doorblog.jp/archives/49614586.html
//参考 http://swift-studying.com/blog/swift/?p=304 コレクションビュー
class sample1_1ViewController: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var pageControllergrop = [UIViewController]()
    let pagelist = ["PAGE1", "PAGE2", "PAGE3", "PAGE4", "PAGE5"]
    
    var collectionView:UICollectionView!
    
    //ラベルの高さ
    let labeheight:CGFloat = 60
    //ライン分
    let labeline:CGFloat = 10
    
    let viewframewidth:CGFloat = UIScreen.main.bounds.width
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil){
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navheight:CGFloat = (self.navigationController?.navigationBar.frame.size.height)!
        
        self.title = "pageViewContollolresample"
        self.view.backgroundColor = UIColor.darkGray
        self.makeViewcontoller()
        self.setViewControllers([pageControllergrop.first!], direction: .forward, animated: false, completion: nil)
        dataSource = self
        delegate = self
        
        
        // レイアウト作成
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width:viewframewidth / 3 - 10,  height:CGFloat(labeheight))
        
        let rec = CGRect(x: 0.0, y: navheight + 30 , width:viewframewidth , height: labeheight + labeline)
        collectionView = UICollectionView(frame: rec, collectionViewLayout: flowLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func makeViewcontoller(){
        for i in 0...(pagelist.count - 1){
            let viewController = UIStoryboard(name: "PAGE", bundle: nil).instantiateViewController(withIdentifier: "\(pagelist[i])ViewController")
            self.pageControllergrop.append(viewController)
        }
    }
    
    // MARK: - pageViewController
    
    //右にスワイプした場合に表示したいviewControllerを返す
    func pageViewController(_ pageViewController:
        UIPageViewController, viewControllerBefore viewController:UIViewController) -> UIViewController? {
        let index:Int = pageControllergrop.index(of: viewController)!
        //1ページ何もしない
        switch index {
        case 0:
            return nil
        default:
            //2だったら1に、　3だったら2に
            return pageControllergrop[index-1]
        }
    
    }
    
    //左にスワイプした場合に表示したいviewControllerを返す
    func pageViewController(_ pageViewController:
        UIPageViewController, viewControllerAfter viewController: UIViewController) ->
        UIViewController? {
            let index:Int = pageControllergrop.index(of: viewController)!
            switch index {
            //最終ページ何もしない
            case pageControllergrop.count-1:
                return nil
            default:
                //最終ページでない場合進める
                return pageControllergrop[index+1]
            }
            
    }
    
    // MARK: - collectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pagelist.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        collectionView.register(cellType: sample1_1CollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(with: sample1_1CollectionViewCell.self, for: indexPath)
        cell.backgroundColor = UIColor.orange
        cell.config(text: "\(indexPath.dropFirst())")
    
        
        return cell
    }

}


extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func register<T: UICollectionViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }
    
    func register<T: UICollectionReusableView>(reusableViewType: T.Type, of kind: String = UICollectionElementKindSectionHeader) {
        let className = reusableViewType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    func register<T: UICollectionReusableView>(reusableViewTypes: [T.Type], kind: String = UICollectionElementKindSectionHeader) {
        reusableViewTypes.forEach { register(reusableViewType: $0, of: kind) }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type, for indexPath: IndexPath, of kind: String = UICollectionElementKindSectionHeader) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.className, for: indexPath) as! T
    }
}
