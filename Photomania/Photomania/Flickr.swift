//
//  Flickr.swift
//  Photomania
//
//  Created by John Welch on 6/12/15.
//  Copyright (c) 2015 Essan Parto. All rights reserved.
//

import UIKit
import Alamofire

class Flickr: NSObject {
    enum Router :  URLRequestConvertible {
        static let baseURLString = "https://api.flickr.com"
        static let apiKey = "c290a2e07eff171ec087edc362c96744"
        static let userID = "99711454@N02"
        
        case AllPhotos(Int)
        case Comments(Int, Int)
        
        var URLRequest: NSURLRequest {
            let (path: String, parameters: [String: AnyObject]) = {
                switch self {
                case .AllPhotos(let page):
                    let params = [
                        "format": "json",
                        "nojsoncallback": "1",
                        "api_key" : Router.apiKey,
                        "method": "flickr.photos.search",
                        "user_id": Router.userID,
                        "per_page": "99",
                        "page": "\(page)"
                    ]
                    return ("/services/rest", params)
                case .Comments(let photoID, let commentsPage):
                    var params = ["a":"b"]
                    return ("comments", params)
                }
                }()
            
            let URL = NSURL(string: Router.baseURLString)
            let URLRequest = NSURLRequest(URL: URL!.URLByAppendingPathComponent(path))
            let encoding = Alamofire.ParameterEncoding.URL
            
            return encoding.encode(URLRequest, parameters: parameters).0
        }
    }
   
}

final class FlickrPhoto: NSObject, ResponseObjectSerializable, ResponseCollectionSerializable {
    
    @objc static func collection(#response: NSHTTPURLResponse, representation: AnyObject) -> [FlickrPhoto] {
        var photos = [FlickrPhoto]()
        
        let page = representation.valueForKeyPath("photos") as! NSDictionary
        
        for info in page.valueForKeyPath("photo") as! [NSDictionary] {
            photos.append(FlickrPhoto(JSON: info))
        }
        
        return photos
    }
    
    let id: String
    var title: String?
    
    var ownerID: String?
    var server: Int?
    var serverID: String?
    var secret: String?
    
    var imageURL: String? {
        if server != nil && serverID != nil && secret != nil {
            let url = "http://farm\(server!).staticflickr.com/\(serverID!)/\(id)_\(secret!)_b.jpg"
            return url
        }
        
        return nil
    }
    
    var thumbnailURL: String? {
        if server != nil && serverID != nil && secret != nil {
            return "http://farm\(server!).staticflickr.com/\(serverID!)/\(id)_\(secret!)_q.jpg"
        }
        
        return nil
    }
    
    required init(response: NSHTTPURLResponse, representation: AnyObject) {
        self.id = representation.valueForKeyPath("photo.id") as! String
        
        self.secret = representation.valueForKeyPath("photo.secret") as? String
        self.title = representation.valueForKeyPath("photo.title") as? String
        self.ownerID = representation.valueForKeyPath("photo.owner") as? String
        self.server = representation.valueForKeyPath("photo.farm") as? Int
        self.serverID = representation.valueForKeyPath("photo.server") as? String
    }
    
    required init(JSON: AnyObject) {
        
        self.id = JSON.valueForKeyPath("id") as! String
        
        self.secret = JSON.valueForKeyPath("secret") as? String
        self.title = JSON.valueForKeyPath("title") as? String
        self.ownerID = JSON.valueForKeyPath("owner") as? String
        self.server = JSON.valueForKeyPath("farm") as? Int
        self.serverID = JSON.valueForKeyPath("server") as? String        
    }
    
    override func isEqual(object: AnyObject!) -> Bool {
        return (object as! FlickrPhoto).id == self.id
    }
    
    override var hash: Int {
        return (self as FlickrPhoto).id.hash
    }
}
