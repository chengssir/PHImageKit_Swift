//
//  MMAssetOverlayView.swift
//  PHImageKit
//
//  Created by 程国帅 on 16/3/17.
//  Copyright © 2016年 chengs. All rights reserved.
//

import UIKit

class MMAssetOverlayView: UIView {
    
//    var checkmarkView :MMAssetCheckMarkView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 1, alpha: 0.4)
        
        let checkmarkView = MMAssetCheckMarkView(frame:CGRectMake(self.bounds.size.width - (4.0 + 24.0), self.bounds.size.height - (4.0 + 24.0), 24.0, 24.0))
        checkmarkView.autoresizingMask = .None;
        checkmarkView.layer.shadowOffset = CGSizeMake(0, 0);
        checkmarkView.layer.shadowOpacity = 0.6;
        checkmarkView.layer.shadowRadius = 2.0;
        checkmarkView.layer.shadowColor = UIColor.grayColor().CGColor;
        
        self.addSubview(checkmarkView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 

}
