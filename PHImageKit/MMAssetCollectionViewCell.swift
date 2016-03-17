//
//  MMAssetCollectionViewCell.swift
//  PHImageKit
//
//  Created by 程国帅 on 16/3/16.
//  Copyright © 2016年 chengs. All rights reserved.
//

import UIKit

class MMAssetCollectionViewCell: UICollectionViewCell {
    var imageView1: UIImageView!
    var overlayView: MMAssetOverlayView!
 
    override init(frame: CGRect) {
        super.init(frame: frame)
         
        setupViews()
    }
    
    func setupViews() {
        
        imageView1 = UIImageView(frame: self.contentView.bounds) as  UIImageView
        imageView1?.autoresizingMask = .FlexibleWidth
        imageView1?.autoresizingMask = .FlexibleHeight
        imageView1.contentMode =  .ScaleAspectFill;
        imageView1.clipsToBounds = true;
        self.contentView .addSubview(imageView1)
        self.getoverlayView()
 
    }
    
    override var selected: Bool {
        get {
            return super.selected
        }
        set {
            super.selected = newValue
            overlayView.hidden = !newValue;
        }
        
    }
    
    func getoverlayView() {
        overlayView = MMAssetOverlayView(frame: self.contentView.bounds)
        overlayView?.autoresizingMask = .FlexibleWidth
        overlayView?.autoresizingMask = .FlexibleHeight
        overlayView.hidden = true;
        self.contentView.addSubview(overlayView)

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
