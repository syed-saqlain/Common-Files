//
//  MediaHelper.swift
//  Sports Friends Hookup
//
//  Created by Saqlain Syed on 19/04/2019.
//  Copyright © 2019 Saqlain Syed. All rights reserved.
//

import Foundation
import Photos


class MediaHelper
{
    func fetchAssetsFromPhotos(completion: @escaping ((_ status : Bool,_  assets: [PHAsset]?,_ error : SFHError?) -> Void))
    {
        var assets = [PHAsset]()
        
        let cameraAsset = PHAsset()
        assets.append(cameraAsset)
        
        let galleryAsset = PHAsset()
        assets.append(galleryAsset)
        
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch status {
            case .authorized:
                
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                fetchOptions.predicate = NSPredicate(format: "duration <= 60")
                
                let fetchAssets = PHAsset.fetchAssets(with: fetchOptions)
                
                fetchAssets.enumerateObjects({ (asset, index, stop) in
                    
                    if (asset.mediaType == .image || asset.mediaType == .video) && (asset.mediaSubtypes != .photoLive && asset.mediaSubtypes != .photoPanorama)
                    {
                        assets.append(asset)
                    }
                    
                })
                
                completion(true, assets, nil)
                
                break
            case .notDetermined:
                completion(true, assets, SFHError(title: "Sports Friends Hookup", description: "Authorization not determined."))
                break
            case .restricted:
                completion(true, assets,  SFHError(title: "Sports Friends Hookup", description: "Authorization restricted."))
                break
            case .denied:
                completion(true, assets,  SFHError(title: "Sports Friends Hookup", description: "Authorization denied."))
                break
            @unknown default:
                completion(true, assets,  SFHError(title: "Sports Friends Hookup", description: "Authorization is unknown."))

            }
            
        }
    }
    
    
    
    
    
    
    
    
    
    
}
