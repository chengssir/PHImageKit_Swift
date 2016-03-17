//
//  MMImagePickerGroupCell.swift
//  PHImageKit
//
//  Created by 程国帅 on 16/3/16.
//  Copyright © 2016年 chengs. All rights reserved.
//

import UIKit

class MMImagePickerGroupCell: UITableViewCell {

    var imageView1: UIImageView!
    var imageView2: UIImageView!
    var imageView3: UIImageView!
    var titleLabel: UILabel!
    var countLabel: UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    func setupViews() {
        self.accessoryType = .DisclosureIndicator
        self.selectionStyle = .None
        
       let view = UIView(frame: CGRectMake(16, 7, 68, 72)) as  UIView
       self.contentView .addSubview(view)
        
        imageView3 = UIImageView(frame: CGRectMake(4, 0, 60, 60))
        view.addSubview(imageView3)
        imageView3.contentMode = .ScaleAspectFill
        imageView3.clipsToBounds = true
      
        
        
        imageView2 = UIImageView(frame: CGRectMake(2, 2, 64, 64))
        view.addSubview(imageView2)
        imageView2.contentMode = .ScaleAspectFill
        imageView2.clipsToBounds = true
        
        imageView1 = UIImageView(frame: CGRectMake(0, 4, 68, 68))
        view.addSubview(imageView1)
        imageView1.contentMode = .ScaleAspectFill
        imageView1.clipsToBounds = true
      
        titleLabel = UILabel(frame: CGRectMake(102, 22, 220, 21))
        titleLabel.font = UIFont.systemFontOfSize(17.0)
        self.contentView.addSubview(titleLabel)
        
        countLabel = UILabel(frame: CGRectMake(102, 46, 220, 21))
        countLabel.font = UIFont.systemFontOfSize(12.0)
        self.contentView.addSubview(countLabel)
        
        imageView1.layer.shadowOpacity = 1.8
        imageView1.layer.shadowColor = UIColor.redColor().CGColor
        imageView1.layer.shadowOffset = CGSize(width: 1, height: 1)
        imageView2.layer.shadowOpacity = 1.8
        imageView2.layer.shadowColor = UIColor.redColor().CGColor
        imageView2.layer.shadowOffset = CGSize(width: 1, height: 1)
        imageView3.layer.shadowOpacity = 1.8
        imageView3.layer.shadowColor = UIColor.redColor().CGColor
        imageView3.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

 