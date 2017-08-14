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
//参考　http://qiita.com/tattn/items/bdce2a589912b489cceb
class sample1_1ViewController: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var pageControllergrop = [UIViewController]()
    let pagelist = ["PAGE1", "PAGE2", "PAGE3", "PAGE4", "PAGE5"]
    
    var collectionView:UICollectionView!
    
    //現在のページのために
    var current:Int? = 0
    
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
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.scrollDirection = .horizontal
        //-10で隙間あけてる
        flowLayout.itemSize = CGSize(width:viewframewidth / 3 ,  height:CGFloat(labeheight))
        let rec = CGRect(x: 0.0, y: navheight + 20 , width:viewframewidth , height: labeheight)
        collectionView = UICollectionView(frame: rec, collectionViewLayout: flowLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.backgroundColor = UIColor.blue
        // 水平スクロールバーの表示有無 今回表示させない、意図的に作成しているから
        collectionView.showsHorizontalScrollIndicator = false
        // 垂直スクロールバーの表示有無　今回表示させない、意図的に作成しているから
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delaysContentTouches = false
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
            let mylabe = UILabel()
            mylabe.text = "\(i)ViewController"
            mylabe.sizeToFit()
            mylabe.center = self.view.center
            viewController.view.addSubview(mylabe)
            let img = UIImage(named: "set.png")
            let imgView = UIImageView()
            let rec = CGRect(x: 30.0, y: 150.0, width:100.0 , height: 100.0)
            imgView.frame = rec
            imgView.image = img
            viewController.view.addSubview(imgView)
            self.pageControllergrop.append(viewController)
        }
    }
    
    // MARK: - pageViewController
    
    //右にスワイプした場合に表示したいviewControllerを返す
    func pageViewController(_ pageViewController:
        UIPageViewController, viewControllerBefore viewController:UIViewController) -> UIViewController? {
        self.collectionView.reloadData()
        let index:Int = pageControllergrop.index(of: viewController)!
        let ind:CGFloat = CGFloat(pageControllergrop.index(of: viewController)!)
        self.labeMove(ind:ind)
        current = pageControllergrop.index(of: viewController)!
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
            self.collectionView.reloadData()
            let index:Int = pageControllergrop.index(of: viewController)!
            let ind:CGFloat = CGFloat(pageControllergrop.index(of: viewController)!)
            self.labeMove(ind:ind)
            current = pageControllergrop.index(of: viewController)!
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
        for vi in collectionView.subviews {
            if let vi = vi as? UIScrollView {
                vi.delaysContentTouches = false
            }
        }
        collectionView.register(cellType: sample1_1CollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(with: sample1_1CollectionViewCell.self, for: indexPath)
        cell.backgroundColor = self.pageControllergrop[indexPath.row].view.backgroundColor
        cell.config(text: "\(indexPath.dropFirst())")
    
        
        return cell
    }
    
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //選択された所に遷移
        self.setViewControllers([pageControllergrop[indexPath.row]], direction: .forward, animated: false, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! sample1_1CollectionViewCell
        cell.backgroundColor = UIColor.darkGray
//        cell.config(text: "選択")
        
    }
//
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath as IndexPath)!
//        cell.backgroundColor = self.pageControllergrop[indexPath.row].view.backgroundColor //
//    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! sample1_1CollectionViewCell
        cell.backgroundColor = self.pageControllergrop[indexPath.row].view.backgroundColor
    }
    
    func labeMove(ind:CGFloat){
    
        switch ind {
            //0から1
        case 0..<2:
            collectionView.contentOffset = CGPoint(
                x: 0 ,
                y: 0
            )
        case 2:
            collectionView.contentOffset = CGPoint(
                x:  (viewframewidth / 3) * (ind - 1) ,
                y: 0
            )
            //3.4
        default:
            collectionView.contentOffset = CGPoint(
                x:  (viewframewidth / 3) * 2 ,
                y: 0
            )
            break
        }
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
