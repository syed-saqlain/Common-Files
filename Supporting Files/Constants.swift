//
//  Constants.swift
//  Quick1Fix1
//
//  Created by Saqlain on 06/06/2018.
//  Copyright © 2018 Saqlain. All rights reserved.
//

import Foundation

//MARK:- Storyboard Names
enum StoryboardName : String {
    case Main = "Main"
    case UserAuthentication = "UserAuthentication"
    case Sports = "Sports"
}


//MARK:- ViewController Storyboard Identifiers
enum SFHControllersStoryboardID : String {
    case SFHSplash = "SFHSplash"
    case SFHTabBarController = "SFHTabBarController"
    case SFHNewsFeed = "SFHNewsFeed"
    case SFHSignIn = "SFHSignIn"
    case SFHSignUp = "SFHSignUp"
    case SFHCreateProfile = "SFHCreateProfile"
    case SFHForgetPassword = "SFHForgetPassword"
    case SFHAddPost = "SFHAddPost"
    case SFHComment = "SFHComment"
    case SFHEvents = "SFHEvents"
    case SFHCreateEvent = "SFHCreateEvent"
    case SFHSports = "SFHSports"
    case SFHUserProfile = "SFHUserProfile"
    case SFHMore = "SFHMore"
    case SFHFollowers = "SFHFollowers"
    case SFHCitiesCommunities = "SFHCitiesCommunities"
    case SFHAbout = "SFHAbout"
    case SFHFeaturedUser = "SFHFeaturedUser"
    case SFHChat = "SFHChat"
    case SFHTicketTrading = "SFHTicketTrading"
    case SFHEventDetails = "SFHEventDetails"
    case SFHFilter = "SFHFilter"
    case SFHSettings = "SFHSettings"
    case SFHUpdatePassword = "SFHUpdatePassword"
    case SFHCitiesCommunitiesDetails = "SFHCitiesCommunitiesDetails"
    case SFHCreateGroup = "SFHCreateGroup"
    case SFHChatMessages = "SFHChatMessages"
    case SFHPrivacySelection = "SFHPrivacySelection"
}


//MARK:- UserDefaults

var udIsRememberEmail : Bool {
    get {
            return UserDefaults.standard.bool(forKey: "udIsRememberEmail")
    }
    set(newValue){
        UserDefaults.standard.set(newValue, forKey: "udIsRememberEmail")
    }
    
}

var udRememberedEmail : String {
    get {
        if let flag = UserDefaults.standard.string(forKey: "udRememberedEmail"){
            return flag
        }
        return ""
    }
    set(newValue){
        UserDefaults.standard.set(newValue, forKey: "udRememberedEmail")
    }
    
}

var udIsLogin : Bool {
    get {
            return UserDefaults.standard.bool(forKey: "udIsLogin")
    }
    set(newValue){
        UserDefaults.standard.set(newValue, forKey: "udIsLogin")
    }
    
}

//Google API Keys
let kGooglePlacesClientAPIKey = "AIzaSyB7SO9o5AQhrqD3mzngdBkhzcRVkg9ptv0"


















