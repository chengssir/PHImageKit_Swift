//
//  MMPHImagePickerViewController.swift
//  PHImageKit
//
//  Created by 程国帅 on 16/3/11.
//  Copyright © 2016年 chengs. All rights reserved.
//

import UIKit

//let FADE_ANIMATION_DURATION = 0.35

protocol MMPHImagePickerViewControllerDelegate: NSObjectProtocol{

    func MMPHImagePickerControllerDidFinish(imagePickerController: MMPHImagePickerViewController ,assets :NSArray)

}


class MMPHImagePickerViewController: UIViewController {
    var maximumNumberOfSelection        :Int?
    var numberOfColumnsInPortrait       :Int?
    var numberOfColumnsInLandscape      :Int?
    var assetCollectionSubtypes         :NSArray?
    var isFrist                         :ObjCBool?
    weak var delegate: MMPHImagePickerViewControllerDelegate!
    var selectedAssetURLs               :NSMutableOrderedSet?
    var albumsNavigationController      :UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.maximumNumberOfSelection = 9
        setUpAlbumsViewController()
        let albumsViewController = self.albumsNavigationController.topViewController as! MMPHImageAlbumViewController;
        albumsViewController.imagePickerController = self;

        
     }

    func setUpAlbumsViewController(){
        
        let albumsViewController = MMPHImageAlbumViewController()

        let navigationController = UINavigationController(rootViewController:albumsViewController);
        self.addChildViewController(navigationController)

        navigationController.view.frame  = self.view.bounds
        
        self.view.addSubview(navigationController.view)
        
        self.albumsNavigationController = navigationController;

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     }
 

}
