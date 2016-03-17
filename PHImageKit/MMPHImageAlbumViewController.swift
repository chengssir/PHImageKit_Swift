//
//  MMPHImageAlbumViewController.swift
//  PHImageKit
//
//  Created by 程国帅 on 16/3/11.
//  Copyright © 2016年 chengs. All rights reserved.
//

import UIKit
import Photos



class MMPHImageAlbumViewController: UIViewController , UITableViewDelegate ,UITableViewDataSource{
    var dataArray: NSMutableArray?
    var imagePickerController:MMPHImagePickerViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "相册"
        self.view.backgroundColor = UIColor.redColor()
        self.dataArray = NSMutableArray()
        /*
        enum PHAssetCollectionType : Int {
        case Album //从 iTunes 同步来的相册，以及用户在 Photos 中自己建立的相册
        case SmartAlbum //经由相机得来的相册
        case Moment //Photos 为我们自动生成的时间分组的相册
        }
        
        enum PHAssetCollectionSubtype : Int {
        case AlbumRegular //用户在 Photos 中创建的相册，也就是我所谓的逻辑相册
        case AlbumSyncedEvent //使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步过来的事件。然而，在iTunes 12 以及iOS 9.0 beta4上，选用该类型没法获取同步的事件相册，而必须使用AlbumSyncedAlbum。
        case AlbumSyncedFaces //使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步的人物相册。
        case AlbumSyncedAlbum //做了 AlbumSyncedEvent 应该做的事
        case AlbumImported //从相机或是外部存储导入的相册，完全没有这方面的使用经验，没法验证。
        case AlbumMyPhotoStream //用户的 iCloud 照片流
        case AlbumCloudShared //用户使用 iCloud 共享的相册
        case SmartAlbumGeneric //文档解释为非特殊类型的相册，主要包括从 iPhoto 同步过来的相册。由于本人的 iPhoto 已被 Photos 替代，无法验证。不过，在我的 iPad mini 上是无法获取的，而下面类型的相册，尽管没有包含照片或视频，但能够获取到。
        case SmartAlbumPanoramas //相机拍摄的全景照片
        case SmartAlbumVideos //相机拍摄的视频
        case SmartAlbumFavorites //收藏文件夹
        case SmartAlbumTimelapses //延时视频文件夹，同时也会出现在视频文件夹中
        case SmartAlbumAllHidden //包含隐藏照片或视频的文件夹
        case SmartAlbumRecentlyAdded //相机近期拍摄的照片或视频
        case SmartAlbumBursts //连拍模式拍摄的照片，在 iPad mini 上按住快门不放就可以了，但是照片依然没有存放在这个文件夹下，而是在相机相册里。
        case SmartAlbumSlomoVideos //Slomo 是 slow motion 的缩写，高速摄影慢动作解析，在该模式下，iOS 设备以120帧拍摄。不过我的 iPad mini 不支持，没法验证。
        case SmartAlbumUserLibrary //这个命名最神奇了，就是相机相册，所有相机拍摄的照片或视频都会出现在该相册中，而且使用其他应用保存的照片也会出现在这里。
        case Any //包含所有类型
        }
        
        */
        
        let studic: NSMutableArray = NSMutableArray()
        let smartAlbums = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .Any, options: nil)
        
        smartAlbums.enumerateObjectsUsingBlock { (assetCollection, index, stop) -> Void in
            let subtype = assetCollection.assetCollectionSubtype
            if .SmartAlbumUserLibrary == subtype {
                studic .addObject(assetCollection);
            }
        }
        self.dataArray = studic
        self.view.addSubview(self.tableView1111)
        self.tableView1111.tableHeaderView = UIView()
        self.tableView1111.tableFooterView = UIView()
        self.tableView1111.reloadData()

        print(self.imagePickerController!.maximumNumberOfSelection)
    }
    
    lazy var tableView1111: UITableView = {
        let tempTableView = UITableView (frame: self.view.bounds, style: UITableViewStyle.Plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        return tempTableView
    }()
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 86.0;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dataArray!.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{

        let cell: MMImagePickerGroupCell = MMImagePickerGroupCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MMImagePickerGroupCell")
        
        let assetCollection = self.dataArray!.objectAtIndex(indexPath.row) as! PHAssetCollection
        let fetchResult = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil) as PHFetchResult
   
        if fetchResult.count >= 3 {
            cell.imageView3.hidden = false;
            PHImageManager.defaultManager().requestImageForAsset(fetchResult[fetchResult.count-3] as! PHAsset, targetSize: CGSizeMake(120, 120), contentMode: .AspectFill, options: nil) { (image, info) -> Void in
                cell.imageView3?.image = image
            }
            
        }else {
            cell.imageView3.hidden = true;
        }
        
        if fetchResult.count >= 2 {
            cell.imageView2.hidden = false;
            PHImageManager.defaultManager().requestImageForAsset(fetchResult[fetchResult.count-2] as! PHAsset, targetSize: CGSizeMake(120, 120), contentMode: .AspectFill, options: nil) { (image, info) -> Void in
                cell.imageView2?.image = image
            }
            
        }else {
            cell.imageView2.hidden = true;
        }
        
        if fetchResult.count >= 1 {
            cell.imageView1.hidden = false;
            PHImageManager.defaultManager().requestImageForAsset(fetchResult[fetchResult.count-1] as! PHAsset, targetSize: CGSizeMake(120, 120), contentMode: .AspectFill, options: nil) { (image, info) -> Void in
                cell.imageView1?.image = image
            }
            
        }else {
            cell.imageView1.hidden = true;
        }
        
        if (fetchResult.count == 0) {
            cell.imageView3.hidden = false;
            cell.imageView2.hidden = false;
            cell.imageView1.hidden = false;
            // Set placeholder image
            let placeholderImage = self.placeholderImageWithSize(cell.imageView1.frame.size)
            cell.imageView1.image = placeholderImage;
            cell.imageView2.image = placeholderImage;
            cell.imageView3.image = placeholderImage;
        }
        
        cell.titleLabel?.text = assetCollection.localizedTitle
        cell.countLabel?.text = "\(fetchResult.count)张图片";
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let profileVC = MMPHImageAssetsViewController()
        profileVC.assetCollection = self.dataArray!.objectAtIndex(indexPath.row) as! PHAssetCollection
        profileVC.imagePickerController = self.imagePickerController
        self.navigationController?.pushViewController(profileVC, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     }
    
    
    func placeholderImageWithSize(size:CGSize)->UIImage{
        
        UIGraphicsBeginImageContext(size);
        let context = UIGraphicsGetCurrentContext()! as CGContextRef;
        
        let backgroundColor = UIColor.init(red: (239.0 / 255.0), green: (239.0 / 255.0), blue: (244.0 / 255.0), alpha: 1.0)
        
        let iconColor = UIColor.init(red:(179.0 / 255.0), green: (179.0 / 255.0), blue: (182.0 / 255.0), alpha: 1.0)
        
        // Background
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
        
        //    // Icon (back)
        let backIconRect = CGRectMake(size.width * (16.0 / 68.0),
            size.height * (20.0 / 68.0),
            size.width * (32.0 / 68.0),
            size.height * (24.0 / 68.0));
        
        CGContextSetFillColorWithColor(context, iconColor.CGColor);
        CGContextFillRect(context, backIconRect);
        
        CGContextSetFillColorWithColor(context,backgroundColor.CGColor);
        CGContextFillRect(context, CGRectInset(backIconRect, 1.0, 1.0));
        
        // Icon (front)
        let frontIconRect = CGRectMake(size.width * (20.0 / 68.0),
            size.height * (24.0 / 68.0),
            size.width * (32.0 / 68.0),
            size.height * (24.0 / 68.0));
        
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextFillRect(context, CGRectInset(frontIconRect, -1.0, -1.0));
        
        CGContextSetFillColorWithColor(context, iconColor.CGColor);
        CGContextFillRect(context,frontIconRect);
        
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextFillRect(context, CGRectInset(frontIconRect, 1.0, 1.0));
        
        let image = UIGraphicsGetImageFromCurrentImageContext() as UIImage;
        UIGraphicsEndImageContext();
        
        return image;
    }
   
}
