//
//  ViewController.swift
//  PHImageKit
//
//  Created by 程国帅 on 16/3/11.
//  Copyright © 2016年 chengs. All rights reserved.
//

import UIKit
import Photos


class ViewController: UIViewController ,MMPHImagePickerViewControllerDelegate {

    var KScreenWith : Int?

    @IBOutlet weak var showImageView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        KScreenWith = Int(UIScreen .mainScreen().bounds.width/4)

        PHPhotoLibrary.requestAuthorization { (statuss : PHAuthorizationStatus) in
        };


        //创建一个Contact,,Add类型的按钮
        let button:UIButton = UIButton(type:.System)
        //设置按钮位置和大小
        button.frame=CGRectMake(10, 150, 100, 30)
        //设置按钮文字
        button.setTitle("按钮", forState:UIControlState.Normal)
        //设置点击事件
        button.addTarget(self, action: #selector(ViewController.tapped(_:)), forControlEvents: .TouchUpInside);
        //添加背景颜色
        button.backgroundColor = UIColor.lightGrayColor()
        //设置tag
        button.tag = 111;
        //设置按钮文字颜色
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        //设置文字高亮颜色
        button.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        //设置图标
        button.setImage(UIImage(named:"icon1"),forState:.Normal)
        self.view.addSubview(button);
     }

    func tapped(button:UIButton){
        if button.tag == 111{
            let imagePickerController = MMPHImagePickerViewController()
            imagePickerController.maximumNumberOfSelection = 9
            imagePickerController.delegate = self
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func MMPHImagePickerControllerDidFinish(imagePickerController: MMPHImagePickerViewController, assets: NSArray) {
        imagePickerController.dismissViewControllerAnimated(true, completion: nil)

        for index in 0...assets.count - 1 {
            let remainder  = index % 4;
            let intege  = index / 4;
            print("\(remainder*KScreenWith!)+\(intege*KScreenWith!)")

            let imageView = UIImageView.init(frame: CGRect.init(x: remainder*KScreenWith!, y: intege*KScreenWith!, width: KScreenWith!, height: KScreenWith!))
            imageView.image = assets.objectAtIndex(index) as? UIImage
            self.showImageView.addSubview(imageView)

        }
        print(assets)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

