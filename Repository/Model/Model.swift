//
//  NewsFeed.swift
//  Sports Friends Hookup
//
//  Created by Saqlain Syed on 15/04/2019.
//  Copyright © 2019 Saqlain Syed. All rights reserved.
//

import Foundation
import AVKit

class NewsFeed
{
    var id = 0
    var title = ""
    var thumbnail = ""
    var description = ""
    var isVideo = false
    var mediaUrlPath = ""
    var date = ""
    var authorID = 0
    var authorName = ""
    var authorProfile = ""
    var authorStatus = ""
    var isLiked = false
    var likesCount = 0
    var commentsCount = 0
    var viewCount = 0
    var avplayerViewController : AVPlayerViewController!
    var avplayerItem : AVPlayerItem!
    
    init(){}
    
    init(dictionary dict: [String : Any]) {
        
        id = dict["id"] as? Int ?? 0
         title = dict["title"] as? String ?? ""
         thumbnail = dict["thumbnail"] as? String ?? ""
         description = dict["description"] as? String ?? ""
         isVideo = dict["isVideo"] as? Bool ?? false
         mediaUrlPath = dict["mediaUrlPath"] as? String ?? ""
         date = dict["date"] as? String ?? ""
         authorID = dict["authorID"] as? Int ?? 0
         authorName = dict["authorName"] as? String ?? ""
         authorProfile = dict["authorProfile"] as? String ?? ""
         authorStatus = dict["authorStatus"] as? String ?? ""
         isLiked = dict["isLiked"] as? Bool ?? false
         likesCount = dict["likesCount"] as? Int ?? 0
         commentsCount = dict["commentsCount"] as? Int ?? 0
         viewCount = dict["viewCount"] as? Int ?? 0
        
        if isVideo
        {
            avplayerViewController = AVPlayerViewController()
            avplayerItem = AVPlayerItem(url: URL(string: mediaUrlPath)!)
            avplayerViewController.player = AVPlayer(playerItem: avplayerItem)
        }
    }
}

class User {
    var id = 0
    var name = ""
    var profile = ""
    
    init(dictionary dict : [String : Any]) {
        id = dict["id"] as? Int ?? 0
        name = dict["name"] as? String ?? ""
        profile = dict["profile"] as? String ?? ""
    }
    
}

class Comment {
    
    var id = 0
    var userID = 0
    var userName = ""
    var userProfile = ""
    
    init(dictionary dict : [String : Any]) {
    
        id = dict["id"] as? Int ?? 0
        userID = dict["userID"] as? Int ?? 0
        userName = dict["userName"] as? String ?? ""
        userProfile = dict["userProfile"] as? String ?? ""
    
    }
}

class SportsType {
    var id = 0
    var sportsName = ""
    var sportsImage = ""
    var isSelected = false
    
    init(dictionary dict : [String : Any]) {
        
        id = dict["id"] as? Int ?? 0
        sportsName = dict["sportsName"] as? String ?? ""
        sportsImage = dict["sportsImage"] as? String ?? ""
        isSelected = dict["isSelected"] as? Bool == true ? true : false
    }
}

class MoreFeatures {
    var id = 0
    var FeatureName = ""
    var FeatureImage = ""
    
    init(dictionary dict : [String:Any]) {
        id = dict["id"] as? Int ?? 0
        FeatureName = dict["FeatureName"] as? String ?? ""
        FeatureImage = dict["FeatureImage"] as? String ?? ""
    }
    
}

class Followings {
    var id = 0
    var FollowingName = ""
    var FollowingImage = ""
    var FollowersCount = 0
    var isFollowed = false
    
    init(dictionary dict : [String:Any]) {
        id = dict["id"] as? Int ?? 0
        FollowingName = dict["FollowingName"] as? String ?? ""
        FollowingImage = dict["FollowingImage"] as? String ?? ""
        FollowersCount = dict["FollowersCount"] as? Int ?? 0
        isFollowed = dict["isFollowed"] as? Bool ?? false
    }
}














