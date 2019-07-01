//
//  API.swift
//  Sports Friends Hookup
//
//  Created by Saqlain Syed on 19/04/2019.
//  Copyright © 2019 Saqlain Syed. All rights reserved.
//

import Foundation
import Alamofire

enum RequestType: String {
    case get, post;
}

//returning APIResponse as call back as it has status, msg and decoded data
typealias APICompletion<T: Codable> = (_ result: APIResponse<T>?) -> Void


fileprivate let baseURL = "https://cayzen2-uat.sdsol.com/api/v1/"

class API {
    
    public static let shared = API()
    private init() {}
    
    //MARK: - Headers
    private var httpHeaders: HTTPHeaders {
        return ["Authorization":"Basic Y2F5emVuOnNkc29sOTkh",
                "Content-Type":"application/json"]
    }
    
    //MARK: - Network Functions
    internal func sendData<T: Codable>(url: String, requestType: RequestType, params: [String: Any], objectType: T.Type, showLoader: Bool = true, completion: @escaping APICompletion<T>) {
        
        let myURL = baseURL + url
        print(myURL)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if showLoader {}
        
        let request: HTTPMethod = requestType == RequestType.get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URL(string: myURL)!, method: request, parameters: params, headers: self.httpHeaders).responseData { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if showLoader {}
            
            switch response.result{
            case .success(_):
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(APIResponse<T>.self, from: data)
                    completion(decodedData)
                } catch let err {
                    print("Err", err)
                    APIError.shared.handleNetworkErrors(error: err)
                }
            case .failure(let error):
                print("Err", error)
                APIError.shared.handleNetworkErrors(error: error)
                break;
            }
        }
    }
    
    func uploadImage<T: Codable>(url: String, images: [UIImage]?, params: [String:Any], objectType: T.Type, showLoader: Bool = true, completion: @escaping APICompletion<T>) {
        let myURL = baseURL + url
        print(myURL)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if showLoader {}
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            //uploading images
            if let imgs = images {
                for i in 0..<imgs.count {
                    guard let imgData = imgs[i].jpegData(compressionQuality: 0.3) else {continue}
                    multipartFormData.append(imgData, withName: "image_\(i)", fileName: "image_\(i).png", mimeType: "image/jpeg")
                }
            }
            //uploading params
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        },to: myURL, method: .post, headers: httpHeaders)
        { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if showLoader {}
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    print(response.result.value!)
                    switch response.result {
                    case .success(_):
                        guard let data = response.data else { return }
                        do {
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode(APIResponse<T>.self, from: data)
                            completion(decodedData)
                        } catch let err {
                            print("Err", err)
                            APIError.shared.handleNetworkErrors(error: err)
                        }
                    case .failure(let error):
                        print("Err", error)
                        APIError.shared.handleNetworkErrors(error: error)
                        break;
                    }
                }
            case .failure(let error):
                print("Err", error)
                APIError.shared.handleNetworkErrors(error: error)
                break;
            }
        }
    }
}

