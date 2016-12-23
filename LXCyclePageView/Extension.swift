//
//  Extension.swift
//  LXCyclePageView
//
//  Created by lixun on 2016/12/23.
//  Copyright © 2016年 sunshine. All rights reserved.
//

import UIKit

extension UIView{
    
    public var lx_left: CGFloat{
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get{
            return self.frame.origin.x
        }
    }
    
    
    public var lx_top: CGFloat{
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get{
            return self.frame.origin.y
        }
    }
    
    
    public var lx_right: CGFloat{
        set{
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        get{
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    
    public var lx_bottom: CGFloat{
        set{
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
        get{
            return self.frame.origin.y + self.frame.size.width
        }
    }
    
    public var lx_width: CGFloat{
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get{
            return self.frame.size.width
        }
    }
    
    public var lx_height: CGFloat{
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get{
            return self.frame.size.height
        }
    }
    
    public var lx_center: CGPoint{
        set{
            var frame = self.frame
            frame.origin.x = newValue.x - frame.size.width * 0.5
            frame.origin.y = newValue.y - frame.size.width * 0.5
            self.frame = frame
        }
        get{
            return CGPoint.init(x: self.frame.origin.x + self.frame.size.width * 0.5,
                                y: self.frame.origin.y + self.frame.size.height * 0.5)
        }
    }
    
    public var lx_centerX: CGFloat{
        set{
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width * 0.5;
            self.frame = frame;
        }
        get{
            return self.frame.origin.x + self.frame.size.width * 0.5
        }
    }
    
    public var lx_centerY: CGFloat{
        set{
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height * 0.5;
            self.frame = frame;
        }
        get{
            return self.frame.origin.y + self.frame.size.height * 0.5
        }
    }
    
    public var lx_origin: CGPoint{
        set{
            var frame = self.frame
            frame.origin = newValue;
            self.frame = frame;
        }
        get{
            return self.frame.origin
        }
    }
    
    public var lx_frameSize: CGSize{
        set{
            var frame = self.frame
            frame.size = newValue;
            self.frame = frame;
        }
        get{
            return self.frame.size
        }
    }
}
