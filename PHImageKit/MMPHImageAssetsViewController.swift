//
//  MMPHImageAssetsViewController.swift
//  PHImageKit
//
//  Created by 程国帅 on 16/3/16.
//  Copyright © 2016年 chengs. All rights reserved.
//



import UIKit
import Photos

let SCREEN_W = UIScreen.mainScreen().bounds.size.width
let CELL_W = (SCREEN_W-10)/4


class MMPHImageAssetsViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    var imagePickerController:MMPHImagePickerViewController!
    var assetCollection :PHAssetCollection!
    var fetchResult :PHFetchResult!
    var selectedAssetURLs:NSMutableSet?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "照片"
        selectedAssetURLs = NSMutableSet();
        if (self.assetCollection != nil) {
            self.fetchResult = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
        }else{
            self.fetchResult = PHAsset.fetchAssetsWithOptions(nil)
        }
        self.view.addSubview(self.collectionView1)
        
        let rightItem = UIBarButtonItem.init(title: "确定", style: .Plain, target: self, action: #selector(MMPHImageAssetsViewController.addApp(_:)))
        self.navigationItem.rightBarButtonItem = rightItem;
        self.navigationItem.rightBarButtonItem!.enabled = false

     }

    lazy var collectionView1: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(CELL_W, CELL_W);//cell的大小
        layout.minimumLineSpacing = 2;//每行的间距
        layout.minimumInteritemSpacing = 2;//每行cell内部的间距
        layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        
        let collectionView = UICollectionView.init(frame: CGRectMake(0, 0, SCREEN_W, self.view.bounds.size.height), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.showsVerticalScrollIndicator = false;
        collectionView.registerClass(MMAssetCollectionViewCell.self, forCellWithReuseIdentifier: "MMAssetCollectionViewCell")
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.allowsMultipleSelection = true;
        return collectionView
    }()
    
    func addApp(sender:UIBarButtonItem){
        
        print(selectedAssetURLs)
        
        let assets = NSMutableArray()
        
        for  selectedAssetURL in selectedAssetURLs! {
            PHCachingImageManager().requestImageDataForAsset(selectedAssetURL as! PHAsset, options: nil, resultHandler: { (imageData, dataUTI, orientation, info) -> Void in
                let uiima  = UIImage.init(data: imageData!)
                assets.addObject(uiima!)
                if assets.count == self.selectedAssetURLs!.count {
                    
                    self.imagePickerController.delegate?.MMPHImagePickerControllerDidFinish(self.imagePickerController, assets:assets)
                }
                
            })
            
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResult.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MMAssetCollectionViewCell", forIndexPath: indexPath) as! MMAssetCollectionViewCell
        cell.tag = indexPath.item;
        let asset = self.fetchResult[indexPath.item] as! PHAsset;
        
        PHCachingImageManager().requestImageForAsset(asset, targetSize: CGSizeMake(154, 142), contentMode: .AspectFill, options: nil) { (result, info) -> Void in
            if result != nil {
                cell.imageView1.image = result;
            }
        }
    
        if self.selectedAssetURLs!.containsObject(asset) {
            cell.selected = true
            collectionView.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .None)
        }
        return cell;

    }
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if self.validateNumberOfSelections(self.selectedAssetURLs!.count+1) {
            return true;
        }
        
        let alert = UIAlertView.init(title: "你最多只能选择\(self.imagePickerController.maximumNumberOfSelection!)张图片", message: nil, delegate: self, cancelButtonTitle: "确定")
        alert.show()
        return false
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let asset = self.fetchResult[indexPath.item] as! PHAsset;
        self.selectedAssetURLs!.addObject(asset)
        self.navigationItem.rightBarButtonItem!.enabled = self.validateNumberOfSelections(self.selectedAssetURLs!.count)
    }
    
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let asset = self.fetchResult[indexPath.item] as! PHAsset;
        self.selectedAssetURLs!.removeObject(asset)
        self.navigationItem.rightBarButtonItem!.enabled = self.validateNumberOfSelections(self.selectedAssetURLs!.count)

        

    }
    
    func validateNumberOfSelections(numberOfSelections :NSInteger)->Bool{
        let qualifiesMinimumNumberOfSelection = (numberOfSelections >= 1);
        let qualifiesMaximumNumberOfSelection = (numberOfSelections <= imagePickerController.maximumNumberOfSelection!);
        return (qualifiesMinimumNumberOfSelection && qualifiesMaximumNumberOfSelection)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     }
    
 

}
