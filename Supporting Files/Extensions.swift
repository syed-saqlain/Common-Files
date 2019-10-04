//
//  Extensions.swift
//  Quick1Fix1
//
//  Created by Saqlain on 06/06/2018.
//  Copyright © 2018 Saqlain. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import Photos
import MobileCoreServices
import JDStatusBarNotification
import DeviceKit

//To Check Fonts Family Names Use This Code
//
//for family: String in UIFont.familyNames
//{
//    print("\(family)")
//    for names: String in UIFont.fontNames(forFamilyName: family)
//    {
//        print("== \(names)")
//    }
//}

let kAnimationDuration = 0.3

enum ImagePickerType {
    case camera
    case gallery
    case bothCameraAndGallery
}

enum MediaType {
    case photo
    case video
    case bothPhotoAndVideo
}

enum AlertType {
    case actionSheet
    case alert
    case none
}

enum StatusBarAlertType{
    case success
    case failed
}


enum AppFontFamily : String {
    
    case regular = "HelveticaNeue"
    case medium = "HelveticaNeue-Medium"
    case light = "HelveticaNeue-Light"
    case thin = "HelveticaNeue-Thin"
    case bold = "HelveticaNeue-Bold"
    
}

extension UIFont {
    
    
    class func setFont(withFontFamily font: AppFontFamily, withSize size: CGFloat) -> UIFont
    {
        let modifiedSize = UIDevice.current.userInterfaceIdiom == .pad ? size * 1.9 : size * (UIScreen.main.bounds.width/320)
        return UIFont(name: font.rawValue, size: modifiedSize)!
    }

}


extension UIColor {
    
    struct AppColorScheme
    {
        static let gray = UIColor.init(red: 194/255, green: 194/255, blue: 194/255, alpha: 1)
        static let green = UIColor.init(red: 64/255, green: 169/255, blue: 135/255, alpha: 1)
        static let white = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        static let black = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        static let purple = UIColor.init(red: 70/255, green: 39/255, blue: 117/255, alpha: 1)
        static let orange = UIColor.init(red: 195/255, green: 90/255, blue: 48/255, alpha: 1)
    }
    
}


extension UIViewController {
    
    func showAlert(withTitle title : String, message : String, completion: ((_ status: Bool) -> Void)? = nil)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            completion?(true)
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func showAlert(withTitle title : String, message: String, leftButtonTitle: String, rightButtonTitle: String, leftCompletion:((_ status: Bool) -> Void)? = nil, rightCompletion: ((_ status: Bool) -> Void)? = nil)
    {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let leftAction = UIAlertAction(title: leftButtonTitle, style: .default) { (action) in
            leftCompletion!(true)
        }
        
        let rightAction = UIAlertAction(title: rightButtonTitle, style: .default) { (action) in
            rightCompletion!(true)
        }
        
        alertController.addAction(leftAction)
        alertController.addAction(rightAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func showStatusBarAlert(message: String, alertType: StatusBarAlertType)
    {
        
        self.statusBarAlertStylesNames()
        switch alertType {
        case .success:
            JDStatusBarNotification.show(withStatus: message, dismissAfter: 3.0, styleName: "success")
            break
            
        case .failed:
            JDStatusBarNotification.show(withStatus: message, dismissAfter: 3.0, styleName: "failed")
            break
        @unknown default:
            print("Unknown alertype.")
        }
    }
    
    private func statusBarAlertStylesNames()
    {
        JDStatusBarNotification.addStyleNamed("success") { (style) -> JDStatusBarStyle? in
            
            style.barColor = UIColor.SFHColorScheme.gray
            style.textColor = UIColor.SFHColorScheme.white
            style.font = UIFont.appFontRegular(ofSize: 10)
            style.heightForIPhoneX = JDStatusBarHeightForIPhoneX.half
            
            
            return style
        }
        
        JDStatusBarNotification.addStyleNamed("failed") { (style) -> JDStatusBarStyle? in
            
            style.barColor = UIColor.SFHColorScheme.orange
            style.textColor = UIColor.SFHColorScheme.white
            style.font = UIFont.appFontRegular(ofSize: 10)
            style.heightForIPhoneX = JDStatusBarHeightForIPhoneX.half
            return style
        }
    }
    
    
    
    func getViewController(withViewControllerStoryboardID viewControllerStoryboardID:SFHControllersStoryboardID , andStoryboardName storyboard:StoryboardName) -> UIViewController {
        
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        
        let vc = (storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardID.rawValue)) as UIViewController
        return vc
        
    }
    
    func chooseMedia(withImagePickerController picker: UIImagePickerController, ImagePickerType imagePickerType:ImagePickerType, MediaType mediaType:MediaType, alertType: AlertType, shouldAllowEditing : Bool, sender: UIView)
    {
        //If alertType is .none but imagePickerType is .bothCameraAndGallery then only Gallery will be open because .none will not allow to open an alert or action sheet to show both options. So, make sure to not to select .none in case you want to show both camera and gallery options to the user
        if alertType == .none {
            
            if imagePickerType == .camera
            {
                switch AVCaptureDevice.authorizationStatus(for: .video) {
                case .authorized:
                    self.openCamera(picker: picker, mediaType: mediaType, sender: sender)
                    
                case .notDetermined: // The user has not yet been asked for camera access.
                    AVCaptureDevice.requestAccess(for: .video) { granted in
                        if granted {
                            self.openCamera(picker: picker, mediaType: mediaType, sender: sender)
                        }
                    }
                    
                case .denied: // The user has previously denied access.
                    self.showAlert(withTitle: "Warning!", message: "Accessing Camera permission is denied.")
                case .restricted: // The user can't grant access due to restrictions
                    self.showAlert(withTitle: "Warning!", message: "Accessing Camera permission is restricted.")
                @unknown default:
                    print("Warning! No AVCaptureDevice.authorizationStatus.")
                }
            }else{
                let status = PHPhotoLibrary.authorizationStatus()
                
                switch status {
                case .authorized:
                    self.openGallery(picker: picker, mediaType: mediaType, sender: sender)
                    
                case .notDetermined: // The user has not yet been asked for camera access.
                    
                    PHPhotoLibrary.requestAuthorization({ (newStatus) in
                        
                        if (newStatus == PHAuthorizationStatus.authorized) {
                            self.openGallery(picker: picker, mediaType: mediaType, sender: sender)
                        }
                    })
                    
                case .denied: // The user has previously denied access.
                    self.showAlert(withTitle: "Warning!", message: "Accessing Photo Library permission is denied.")
                    
                case .restricted: // The user can't grant access due to restrictions
                    self.showAlert(withTitle: "Warning!", message: "Accessing Camera permission is restricted.")
                @unknown default:
                    print("Warning! No AVCaptureDevice.authorizationStatus.")
                }
            }
            
        }else{
            
            let alert:UIAlertController = UIAlertController(title:
                "Choose media from:", message: nil, preferredStyle: alertType == .actionSheet ? UIAlertController.Style.actionSheet : UIAlertController.Style.alert)
            let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
            {
                UIAlertAction in
                
                switch AVCaptureDevice.authorizationStatus(for: .video) {
                case .authorized:
                    self.openCamera(picker: picker, mediaType: mediaType, sender: sender)
                    
                case .notDetermined: // The user has not yet been asked for camera access.
                    AVCaptureDevice.requestAccess(for: .video) { granted in
                        if granted {
                            self.openCamera(picker: picker, mediaType: mediaType, sender: sender)
                        }
                    }
                    
                case .denied: // The user has previously denied access.
                    self.showAlert(withTitle: "Warning!", message: "Accessing Camera permission is denied.")
                case .restricted: // The user can't grant access due to restrictions
                    self.showAlert(withTitle: "Warning!", message: "Accessing Camera permission is restricted.")
                @unknown default:
                    print("Warning! No AVCaptureDevice.authorizationStatus.")
                }
                
            }
            let galleryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default)
            {
                UIAlertAction in
                
                // Get the current authorization state.
                let status = PHPhotoLibrary.authorizationStatus()
                
                switch status {
                case .authorized:
                    self.openGallery(picker: picker, mediaType: mediaType, sender: sender)
                    
                case .notDetermined: // The user has not yet been asked for camera access.
                    
                    PHPhotoLibrary.requestAuthorization({ (newStatus) in
                        
                        if (newStatus == PHAuthorizationStatus.authorized) {
                            self.openGallery(picker: picker, mediaType: mediaType, sender: sender)
                        }
                    })
                    
                case .denied: // The user has previously denied access.
                    self.showAlert(withTitle: "Warning!", message: "Accessing Photo Library permission is denied.")
                    
                case .restricted: // The user can't grant access due to restrictions
                    self.showAlert(withTitle: "Warning!", message: "Accessing Camera permission is restricted.")
                @unknown default:
                    print("Warning! No AVCaptureDevice.authorizationStatus.")
                }
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            {
                UIAlertAction in
            }
            
            // Add the actions
            
            if imagePickerType == ImagePickerType.camera
            {
                alert.addAction(cameraAction)
            }
            
            if imagePickerType == ImagePickerType.gallery
            {
                alert.addAction(galleryAction)
            }
            
            if imagePickerType == ImagePickerType.bothCameraAndGallery
            {
                alert.addAction(galleryAction)
                alert.addAction(cameraAction)
            }
            
            if shouldAllowEditing {
                picker.allowsEditing = true
            }else{
                picker.allowsEditing = false
            }
            
            alert.addAction(cancelAction)
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = sender
                popoverController.sourceRect = sender.frame
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openCamera(picker : UIImagePickerController, mediaType : MediaType, sender: UIView)
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            //            picker.sourceType = UIImagePickerControllerSourceType.camera
            //            picker.sourceType = .camera
            //
            //            self .present(picker, animated: true, completion: nil)
            
            picker.sourceType = .camera
            
            if mediaType == .photo {
                picker.mediaTypes = [kUTTypeImage as String]
            }else if mediaType == .video{
                picker.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String]
            }
            
            if let popoverController = picker.popoverPresentationController {
                popoverController.sourceView = sender
                popoverController.sourceRect = sender.frame
            }
            self .present(picker, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Warning!", message: "You don't have camera", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okAction)
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = sender
                popoverController.sourceRect = sender.frame
            }
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func openGallery(picker : UIImagePickerController, mediaType : MediaType, sender: UIView)
    {
        //        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //        picker.sourceType = .photoLibrary
        //
        //        self.present(picker, animated: true, completion: nil)
        
        
        picker.sourceType = .photoLibrary
        
        if mediaType == .photo {
            picker.mediaTypes = [kUTTypeImage as String]
        }else if mediaType == .video{
            picker.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String]
        }
        
        if let popoverController = picker.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.frame
        }
        self.present(picker, animated: true, completion: nil)
        
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
}

extension UIView {
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.SFHColorScheme.black.cgColor
        layer.shadowOpacity = 0.5
        layer.cornerRadius = 10.0
        
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.frame = CGRect(x: 1, y: 3, width: self.frame.width, height: self.frame.height)
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        
    }
    
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.5
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
}


struct SFHError
{
    var title = ""
    var description = ""
}


enum UIUserInterfaceIdiom : Int {
    case phone
    case pad
    case unspecified
    case tv
    case carPlay
    
}
extension String {
    func isValidEmail(email: String?) -> Bool {
        let mail = email == nil ? "" : email
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: mail)
        return result
    }
}


private var actionKey: Void?
extension UIBarButtonItem {
    
    private var _action: () -> () {
        get {
            return objc_getAssociatedObject(self, &actionKey) as! () -> ()
        }
        set {
            objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    convenience init(image: UIImage?, style: UIBarButtonItem.Style, action: @escaping () -> ()) {
        self.init(image: image, style: style, target: nil, action: #selector(pressed))
        self.target = self
        self._action = action
    }
    
    convenience init(title: String?, style: UIBarButtonItem.Style, action: @escaping () -> ()) {
        self.init(title: title, style: style, target: nil, action: #selector(pressed))
        self.target = self
        self._action = action
    }
    
    @objc private func pressed(sender: UIBarButtonItem) {
        _action()
    }
    
}




















