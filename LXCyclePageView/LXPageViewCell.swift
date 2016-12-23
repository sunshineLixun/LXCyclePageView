//
//  LXPageViewCell.swift
//  LXCyclePageView
//
//  Created by lixun on 2016/12/18.
//  Copyright © 2016年 sunshine. All rights reserved.
//

import UIKit
import Kingfisher

class LXPageViewCell: UICollectionViewCell {
    
    fileprivate var imageView : UIImageView!
    fileprivate var progressLayer: CAShapeLayer!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: init
   override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
     //MARK: UI
    fileprivate func makeUI(){
        imageView = UIImageView.init(frame: self.bounds)
        imageView.contentMode = .scaleToFill
        self.addSubview(imageView)
        
        
        let lineHeight: CGFloat = 4.0
        progressLayer = CAShapeLayer.init()
        progressLayer.frame.size = CGSize.init(width: imageView.lx_width, height: lineHeight)
        let path =  UIBezierPath.init()
        path.move(to: CGPoint.init(x: 0.0, y: progressLayer.frame.size.height / 2))
        path.addLine(to: CGPoint.init(x: imageView.lx_width, y: progressLayer.frame.size.height / 2))
        progressLayer.lineWidth = lineHeight
        progressLayer.path = path.cgPath
        progressLayer.strokeColor = UIColor.lightGray.cgColor
        progressLayer.lineCap = kCALineCapButt
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 0.0
        imageView.layer.addSublayer(progressLayer)
    }

     //MARK: loadURL
    public func loadImageView(_ webUrl: String){
        imageView.kf.setImage(with: URL.init(string: webUrl), placeholder: nil, options: nil, progressBlock: { [weak self] (_ receivedSize: Int64, _ totalSize: Int64) in
            if receivedSize > 0 && totalSize > 0 {
                var progress: CGFloat = CGFloat(receivedSize) / CGFloat(totalSize)
                progress = progress < 0 ? 0 : progress > 1 ? 1 : progress
                    self?.progressLayer.isHidden = false
                    self?.progressLayer.strokeEnd = progress
            }
        }, completionHandler: { [weak self] (_ image: Image?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) in
            if let fatalError = error{
                print(fatalError)
            }
            self?.progressLayer.isHidden = true
        })
    }
    
}
