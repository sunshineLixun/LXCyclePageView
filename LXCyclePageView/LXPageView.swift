//
//  LXPageView.swift
//  LXCyclePageView
//
//  Created by lixun on 2016/12/17.
//  Copyright © 2016年 sunshine. All rights reserved.
//

import UIKit

@objc protocol LXPageViewDelegate: class {
   @objc optional func didSelectedIndexPath(_ index : Int)
}

public typealias DidSelectedIndexPathItem = ((_ index : Int) -> Void)?


public enum LxPageControllPosition{
    case center
    case left
    case right
}


final class LXPageView: UIView{

    fileprivate  struct CellIndentifier {
        static  let cellID = "cellID"
        //最大section
        static let MaxSetions = 100
    }
    
    
   fileprivate lazy var lxPageControll: UIPageControl = {
        var pageControll = UIPageControl.init()
        return pageControll
    }()
    
    
    //MARK: - fileprivate API
    fileprivate var webImages : Array<String>!
    
    fileprivate var collectionView: UICollectionView!
    
    fileprivate var flowLayout: UICollectionViewFlowLayout!
    
    fileprivate var timer: Timer!
    
    
    //MARK: - Public API
    weak var delegate: LXPageViewDelegate?
    
    public var didSelected: DidSelectedIndexPathItem?
    
    public var duration: TimeInterval! {
        didSet{
                invalidateTimer()
                makeTimer()
            }
    }
    
    public var position: LxPageControllPosition = .right

    //MARK: init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    convenience init?(_ frame: CGRect , webImages images: Array<String>?){
        guard let images = images, !(images.isEmpty) else {
           return nil
        }
        self.init(frame:frame)
        webImages = images;
        makeTimer()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeUI()
    }
    
    
    //MARK: - func
    fileprivate func makeUI(){
        flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = self.bounds.size
        collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(LXPageViewCell.self, forCellWithReuseIdentifier: CellIndentifier.cellID)
        self.addSubview(collectionView)
    }
    
    
    fileprivate func makeTimer(){
        if webImages.count == 1 {
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: (duration != nil) ? duration! : 2.0, target: self, selector: #selector(timerStart), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
    
    fileprivate func makePageControll(){
        let height: CGFloat = 30
        var frameX: CGFloat = 0.0
        let frameY: CGFloat = self.lx_height - height
        let width: CGFloat = 100
        
        switch position {
        case .center:
            frameX = self.lx_centerX - width / 2
        case .left:
            frameX = 10.0
        case .right:
            frameX = self.lx_width - width - 10.0
        }
        
        lxPageControll.frame = CGRect.init(x: frameX, y: frameY, width: width, height: height)
        lxPageControll.numberOfPages = webImages.count
        lxPageControll.currentPageIndicatorTintColor = UIColor.red
        lxPageControll.pageIndicatorTintColor = UIColor.white
        self.addSubview(lxPageControll)
    }
   
    
    @objc private func timerStart(){
        let indexPath = collectionView.indexPathsForVisibleItems.last! as IndexPath
        var resetIndexPath = IndexPath.init(item: indexPath.item, section: CellIndentifier.MaxSetions / 2)
        collectionView.scrollToItem(at: resetIndexPath, at: .left, animated: false)
        
        var nextIndexPathItem = resetIndexPath.item + 1
        var nextIndexPathSection = resetIndexPath.section
        
        if nextIndexPathItem == webImages.count{
            nextIndexPathSection += 1
            nextIndexPathItem = 0
        }
        
        collectionView.scrollToItem(at: IndexPath.init(item: nextIndexPathItem, section: nextIndexPathSection), at: .left, animated: true)
        
    }
    
    //MARK: clear Timer
    fileprivate func invalidateTimer(){
        if (timer != nil) {
            timer.invalidate()
            timer = nil
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        makePageControll()
        
        if webImages.count == 1 {
            collectionView.isScrollEnabled = false
        }else{
            collectionView.isScrollEnabled = true
        }
        
        collectionView.scrollToItem(at: IndexPath.init(item: 0, section: CellIndentifier.MaxSetions / 2), at: .left, animated: false)
    }
    
}

extension LXPageView: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CellIndentifier.MaxSetions
    }
    
    public func collectionView(_ collectionView: UICollectionView,  numberOfItemsInSection section: Int) -> Int {
        return self.webImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIndentifier.cellID, for: indexPath) as! LXPageViewCell
        cell.loadImageView(self.webImages[indexPath.item])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let blcok = didSelected {
            blcok!(indexPath.item)
        }
        
        if self.delegate != nil{
            self.delegate!.didSelectedIndexPath!(indexPath.item)
        }
    }
    
}


extension LXPageView: UIScrollViewDelegate{

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        invalidateTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        makeTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        lxPageControll.currentPage = Int (collectionView.contentOffset.x / flowLayout.itemSize.width + 0.5) % webImages.count
    }
}





