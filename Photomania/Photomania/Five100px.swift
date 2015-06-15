//
//  Five100px.swift
//  Photomania
//
//  Created by Essan Parto on 2014-09-25.
//  Copyright (c) 2014 Essan Parto. All rights reserved.
//

import UIKit
import Alamofire

struct Five100px {
  enum Router :  URLRequestConvertible {
    static let baseURLString = "https:/api.500px.com/v1"
    static let consumerKey = "i8G4GX4HNXiVIAkgYLaj46k7jZsoBbIz3Sc1mQUT"
    
    case AllPhotos(Int)
    case PopularPhotos(Int)
    case PhotoInfo(Int, ImageSize)
    case Comments(Int, Int)
    
    var URLRequest: NSURLRequest {
        let (path: String, parameters: [String: AnyObject]) = {
            switch self {
            case .AllPhotos(let page):
                let params = ["consumer_key": Router.consumerKey, "page": "\(page)", "rpp": "50", "include_store": "store_download", "include_states": "votes"]
                return ("/photos", params)
            case .PopularPhotos(let page):
                let params = ["consumer_key": Router.consumerKey, "page": "\(page)", "feature": "popular",
                "rpp": "50", "include_store": "store_download", "include_states": "votes"]
                return ("/photos", params)
            case .PhotoInfo(let photoID, let imageSize):
                var params = ["consumer_key": Router.consumerKey, "image_size": "\(imageSize.rawValue)"]
                return ("/photos/\(photoID)", params)
            case .Comments(let photoID, let commentsPage):
                var params = ["consumer_key": Router.consumerKey, "comments": "1",  "comments_page": "\(commentsPage)"]
                return ("/photos/\(photoID)/comments", params)
            }
        }()
        
        let URL = NSURL(string: Router.baseURLString)
        let URLRequest = NSURLRequest(URL: URL!.URLByAppendingPathComponent(path))
        let encoding = Alamofire.ParameterEncoding.URL
        
        return encoding.encode(URLRequest, parameters: parameters).0
    }
  }
    
  enum ImageSize: Int {
    case Tiny = 1
    case Small = 2
    case Medium = 3
    case Large = 4
    case XLarge = 5
  }
}

final class PhotoInfo: NSObject, ResponseObjectSerializable, ResponseCollectionSerializable {
    
    @objc static func collection(#response: NSHTTPURLResponse, representation: AnyObject) -> [PhotoInfo] {
        var infos = [PhotoInfo]()
        
        for info in representation.valueForKeyPath("photos") as! [NSDictionary] {
            infos.append(PhotoInfo(JSON: info))
        }
        
        return infos
    }
    
  let id: Int
  let url: String
  
  var name: String?
  
  var favoritesCount: Int?
  var votesCount: Int?
  var commentsCount: Int?
  
  var highest: Float?
  var pulse: Float?
  var views: Int?
  var camera: String?
  var desc: String?
  
  init(id: Int, url: String) {
    self.id = id
    self.url = url
  }
  
  required init(response: NSHTTPURLResponse, representation: AnyObject) {
    self.id = representation.valueForKeyPath("photo.id") as! Int
    self.url = representation.valueForKeyPath("photo.image_url") as! String
    
    self.favoritesCount = representation.valueForKeyPath("photo.favorites_count") as? Int
    self.votesCount = representation.valueForKeyPath("photo.votes_count") as? Int
    self.commentsCount = representation.valueForKeyPath("photo.comments_count") as? Int
    self.highest = representation.valueForKeyPath("photo.highest_rating") as? Float
    self.pulse = representation.valueForKeyPath("photo.rating") as? Float
    self.views = representation.valueForKeyPath("photo.times_viewed") as? Int
    self.camera = representation.valueForKeyPath("photo.camera") as? String
    self.desc = representation.valueForKeyPath("photo.description") as? String
    self.name = representation.valueForKeyPath("photo.name") as? String
  }
 
    required init(JSON: AnyObject) {
        
        self.id = JSON.valueForKeyPath("id") as! Int
        self.url = JSON.valueForKeyPath("image_url") as! String
        
        self.favoritesCount = JSON.valueForKeyPath("favorites_count") as? Int
        self.votesCount = JSON.valueForKeyPath("votes_count") as? Int
        self.commentsCount = JSON.valueForKeyPath("comments_count") as? Int
        self.highest = JSON.valueForKeyPath("highest_rating") as? Float
        self.pulse = JSON.valueForKeyPath("rating") as? Float
        self.views = JSON.valueForKeyPath("times_viewed") as? Int
        self.camera = JSON.valueForKeyPath("camera") as? String
        self.desc = JSON.valueForKeyPath("description") as? String
        self.name = JSON.valueForKeyPath("name") as? String
    }

  override func isEqual(object: AnyObject!) -> Bool {
    return (object as! PhotoInfo).id == self.id
  }
  
  override var hash: Int {
    return (self as PhotoInfo).id
  }
}

final class Comment: ResponseCollectionSerializable {
    @objc static func collection(#response: NSHTTPURLResponse, representation: AnyObject) -> [Comment] {
        var comments = [Comment]()
        
        for comment in representation.valueForKeyPath("comments") as! [NSDictionary] {
            comments.append(Comment(JSON: comment))
        }
        
        return comments
    }
    
  let userFullname: String
  let userPictureURL: String
  let commentBody: String
  
  init(JSON: AnyObject) {
    userFullname = JSON.valueForKeyPath("user.fullname") as! String
    userPictureURL = JSON.valueForKeyPath("user.userpic_url") as! String
    commentBody = JSON.valueForKeyPath("body") as! String
  }
}