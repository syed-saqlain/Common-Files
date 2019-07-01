//
//  Repository.swift
//  Sports Friends Hookup
//
//  Created by Saqlain Syed on 15/04/2019.
//  Copyright © 2019 Saqlain Syed. All rights reserved.
//

import Foundation
import Photos


class Repository
{
    
    lazy var mediaHelper = MediaHelper()
    lazy var api = API.shared
    
    func getNewsFeed(completion: @escaping ((_ status : Bool,_ newsfeeds : [NewsFeed]?,_ error : SFHError?)-> Void))
    {
        //Webservices will be implemented here...
        let dicFeeds : [String:Any] = ["id":1, "title":"Warm up", "description": "New drill for your toolbox.", "isVideo": true, "thumbnail" : "feed1.jpg" , "mediaUrlPath": "https://s3.amazonaws.com/evolvebasketballapp/2019_03_08_23_36_24_000000_77077755_50995303_41110034_video.mp4", "date" : "02-03-2019", "authorID" : 15, "authorName" : "John Allairdice", "authorProfile" : "profile1.jpg", "authorStatus": "Low pickup accountability", "isLiked":false, "likesCount" : 321, "commentsCount" : 893, "viewCount" : 909]

        
        if let newsFeed = NewsFeed(dictionary: dicFeeds) as? NewsFeed
        {
            completion(true, [newsFeed], nil)
        }else{
            completion(false, nil, SFHError(title: "Error", description: "Failed to convert dictionary in to data"))
        }
        
        
//        let jsonData = try? JSONSerialization.data(withJSONObject: dicFeeds, options: .prettyPrinted)
//
//
//        if (jsonData != nil) {
//
//                do {
//                    let decoder = JSONDecoder()
//                    let newsfeed = try decoder.decode(NewsFeed.self, from: jsonData!)
//
//                    completion(true, [newsfeed], nil)
//
//                } catch {
//                    print("Error! \(error.localizedDescription)")
//                    completion(false, nil, .jsonEncodingFailed)
//                }
//
//        }else{
//            completion(false, nil, .dictionaryToDataConversionFailed)
//        }
        
    }
    
    func getEventDetails(completion: @escaping ((_ status : Bool,_ newsfeeds : [NewsFeed]?,_ error : SFHError?)-> Void))
    {
        let dicFeed : [String:Any] = ["id":1, "title":"Warm up", "description": "New drill for your toolbox.", "isVideo": true, "thumbnail" : "feed1.jpg" , "mediaUrlPath": "https://s3.amazonaws.com/evolvebasketballapp/2019_03_08_23_36_24_000000_77077755_50995303_41110034_video.mp4", "date" : "02-03-2019", "authorID" : 15, "authorName" : "John Allairdice", "authorProfile" : "profile1.jpg", "authorStatus": "Low pickup accountability", "isLiked":false, "likesCount" : 321, "commentsCount" : 893, "viewCount" : 909]
        let dicFeed2 = NewsFeed()
        
        if let newsFeed : NewsFeed = NewsFeed(dictionary: dicFeed) as? NewsFeed
        {
            completion(true, [dicFeed2, newsFeed], nil)
        }else{
            completion(false, nil, SFHError(title: "Error", description: "Failed to convert dictionary in to data"))
        }
    }
    
    func getBanners(completion: @escaping ((_ status : Bool,_ newsfeeds : [NewsFeed]?,_ error : SFHError?)-> Void))
    {
        //Webservices will be implemented here...
        
        var feeds = [NewsFeed]()
        
        let dicFeed : [String:Any] = ["id":1, "title":"Warm up", "description": "New drill for your toolbox.", "isVideo": true, "thumbnail" : "feed1.jpg" , "mediaUrlPath": "https://s3.amazonaws.com/evolvebasketballapp/2019_03_08_23_36_24_000000_77077755_50995303_41110034_video.mp4", "date" : "02-03-2019", "authorID" : 15, "authorName" : "John Allairdice", "authorProfile" : "profile1.jpg", "authorStatus": "Low pickup accountability", "isLiked":false, "likesCount" : 321, "commentsCount" : 893, "viewCount" : 909]
        
        let dic2Feed : [String:Any] = ["id":2, "title":"Warm up", "description": "New drill for your toolbox.", "isVideo": true, "thumbnail" : "feed2.jpg" , "mediaUrlPath": "https://s3.amazonaws.com/evolvebasketballapp/2019_03_08_23_36_24_000000_77077755_50995303_41110034_video.mp4", "date" : "02-03-2019", "authorID" : 15, "authorName" : "John Allairdice", "authorProfile" : "profile1.jpg", "authorStatus": "Low pickup accountability", "isLiked":false, "likesCount" : 321, "commentsCount" : 893, "viewCount" : 909]
        
        let dic3Feed : [String:Any] = ["id":2, "title":"Warm up", "description": "New drill for your toolbox.", "isVideo": true, "thumbnail" : "feed3.jpg" , "mediaUrlPath": "https://s3.amazonaws.com/evolvebasketballapp/2019_03_08_23_36_24_000000_77077755_50995303_41110034_video.mp4", "date" : "02-03-2019", "authorID" : 15, "authorName" : "John Allairdice", "authorProfile" : "profile1.jpg", "authorStatus": "Low pickup accountability", "isLiked":false, "likesCount" : 321, "commentsCount" : 893, "viewCount" : 909]
        
        feeds.append(NewsFeed(dictionary: dicFeed))
        feeds.append(NewsFeed(dictionary: dic2Feed))
        feeds.append(NewsFeed(dictionary: dic3Feed))
        
        if feeds.count > 0
        {
            completion(true, feeds, nil)
        }else{
            completion(false, nil, SFHError(title: "Sports Friends Hookup", description: "No banner found."))
        }
        
    }
    
    func getFeaturedUsers(completion: @escaping ((_ status : Bool,_ users : [User]?,_ error : SFHError?)-> Void))
    {
        //Webservices will be implemented here...
        
        var users = [User]()
        
        let dicUser1 : [String:Any] = ["id":1, "name":"Josh", "profile": "profile3.jpg"]
         let dicUser2 : [String:Any] = ["id":2, "name":"Hal More", "profile": "profile4.jpg"]
         let dicUser3 : [String:Any] = ["id":3, "name":"Alan", "profile": "profile2.jpg"]
        
        users.append(User(dictionary: dicUser1))
        users.append(User(dictionary: dicUser2))
        users.append(User(dictionary: dicUser3))
        
        if users.count > 0
        {
            completion(true, users, nil)
        }else{
            completion(false, nil, SFHError(title: "Sports Friends Hookup", description: "No featured user found."))
        }
        
    }
    
    func loadAssetsFromPhotos(completion: @escaping ((_ status : Bool,_  assets: [PHAsset]?,_ error : SFHError?) -> Void))
    {
        mediaHelper.fetchAssetsFromPhotos { (status, assets, error) in
            
            completion(true, assets, error)
            
        }
    }
    func getSportsTypes(completion:@escaping ((_ status : Bool,_ sports : [SportsType]?,_ error : SFHError?)-> Void))
    {
        var sports = [SportsType]()
        
        let dicSports :  [String:Any] = ["id":1, "sportsName":"Hockey", "sportsImage": "hockey_", "isSelected":true]
        let dicSports2 : [String:Any] = ["id":2, "sportsName":"Cricket", "sportsImage": "cricket_", "isSelected":false]
        let dicSports3 : [String:Any] = ["id":3, "sportsName":"Basketball", "sportsImage": "basketball_", "isSelected":false]
        let dicSports4 : [String:Any] = ["id":4, "sportsName":"Badminton", "sportsImage": "badminton_", "isSelected":false]
        let dicSports5 : [String:Any] = ["id":5, "sportsName":"Foot Ball", "sportsImage": "football_", "isSelected":false]
        let dicSports6 : [String:Any] = ["id":6, "sportsName":"Hockey", "sportsImage": "hockey_", "isSelected":false]
        
        sports.append(SportsType(dictionary: dicSports))
        sports.append(SportsType(dictionary: dicSports2))
        sports.append(SportsType(dictionary: dicSports3))
        sports.append(SportsType(dictionary: dicSports4))
        sports.append(SportsType(dictionary: dicSports5))
        sports.append(SportsType(dictionary: dicSports6))
        
        
        
        if sports.count > 0
        {
            completion(true, sports, nil)
        }else{
            completion(false, nil, SFHError(title: "Sports Friends Hookup", description: "No sports type found."))
        }
    }
    
    
    func getMoreFeatures(completion:@escaping ((_ status : Bool,_ Features: [MoreFeatures]?,_ error : SFHError?)-> Void))
    {
         var Features = [MoreFeatures]()
        
        let dicFeatures :  [String:Any] = ["id":1, "FeatureName":"Cities & Communities", "FeatureImage": "cities_communities"]
        let dicFeatures2 : [String:Any] = ["id":2, "FeatureName":"Chat", "FeatureImage": "chat"]
        let dicFeatures3 : [String:Any] = ["id":3, "FeatureName":"Featured User", "FeatureImage": "featured_users"]
        let dicFeatures4 : [String:Any] = ["id":4, "FeatureName":"Ticket Trading", "FeatureImage": "ticket"]
        let dicFeatures5 : [String:Any] = ["id":5, "FeatureName":"About Us", "FeatureImage": "about"]
        let dicFeatures6 : [String:Any] = ["id":6, "FeatureName":"Sign Out", "FeatureImage": "signout"]
        
        Features.append(MoreFeatures(dictionary: dicFeatures))
        Features.append(MoreFeatures(dictionary: dicFeatures2))
        Features.append(MoreFeatures(dictionary: dicFeatures3))
        Features.append(MoreFeatures(dictionary: dicFeatures4))
        Features.append(MoreFeatures(dictionary: dicFeatures5))
        Features.append(MoreFeatures(dictionary: dicFeatures6))
        
        if Features.count > 0
        {
            completion(true, Features, nil)
        }else{
            completion(false, nil, SFHError(title: "Sports Friends Hookup", description: "No featured user found."))
        }
        
    }

    
    
    
    func getFollowingsData(completion:@escaping ((_ status : Bool,_ Followings: [Followings]?,_ error : SFHError?)-> Void)) {
        var FollowingsData = [Followings]()
        
        let dicFollowings :  [String:Any] = ["id":1, "FollowingName":"John", "FollowingImage": "profile1","FollowersCount":10,"isFollowed":true]
        let dicFollowings2 : [String:Any] = ["id":2, "FollowingName":"Smith", "FollowingImage": "profile2","FollowersCount":34,"isFollowed":true]
        let dicFollowings3 : [String:Any] = ["id":3, "FollowingName":"Bill Gates", "FollowingImage": "profile3","FollowersCount":24,"isFollowed":false]
        let dicFollowings4 : [String:Any] = ["id":4, "FollowingName":"Steave Jobs", "FollowingImage": "profile4","FollowersCount":44,"isFollowed":true]
        let dicFollowings5 : [String:Any] = ["id":5, "FollowingName":"About Us", "FollowingImage": "profile1","FollowersCount":33,"isFollowed":false]
        
        FollowingsData.append(Followings(dictionary: dicFollowings))
        FollowingsData.append(Followings(dictionary: dicFollowings2))
        FollowingsData.append(Followings(dictionary: dicFollowings3))
        FollowingsData.append(Followings(dictionary: dicFollowings4))
        FollowingsData.append(Followings(dictionary: dicFollowings5))
        
        if FollowingsData.count > 0
        {
            completion(true, FollowingsData, nil)
        }else{
            completion(false, nil, SFHError(title: "Sports Friends Hookup", description: "No featured user found."))
        }
        
    }
    
    
    
}


















