//
//  ViewController.swift
//  LXCyclePageView
//
//  Created by lixun on 2016/12/17.
//  Copyright © 2016年 sunshine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cycleScrollView = LXPageView.init(CGRect.init(x: 0.0, y: 0.0, width: self.view.lx_width, height: 300.0), webImages: [
            "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1466318/getaway.jpg",
            "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg",
            "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-2.jpg",
            "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-3.jpg",
            "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-4.jpg"
            ])
        
        cycleScrollView?.duration = 4.0
        cycleScrollView?.didSelected = { index  in
            print(index)
        }
        cycleScrollView?.delegate = self
        self.view.addSubview(cycleScrollView!)
    }
    
}


extension ViewController: LXPageViewDelegate{
    func didSelectedIndexPath(_ index: Int) {
        print(index)
    }
}



