//
//  MMAssetCheckMarkView.swift
//  PHImageKit
//
//  Created by 程国帅 on 16/3/17.
//  Copyright © 2016年 chengs. All rights reserved.
//

import UIKit

class MMAssetCheckMarkView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func drawRect(rect: CGRect) {

        let context = UIGraphicsGetCurrentContext()! as CGContextRef;
        // Border
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
        CGContextFillEllipseInRect(context, self.bounds);
        
        // Body
        CGContextSetRGBFillColor(context, 20.0/255.0, 111.0/255.0, 223.0/255.0, 1.0);
        CGContextFillEllipseInRect(context, CGRectInset(self.bounds, 1.0, 1.0));
        
        // Checkmark
        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
        CGContextSetLineWidth(context, 1.2);
        
        CGContextMoveToPoint(context, 6.0, 12.0);
        CGContextAddLineToPoint(context, 10.0, 16.0);
        CGContextAddLineToPoint(context, 18.0, 8.0);
        
        CGContextStrokePath(context);
    
    }

}
