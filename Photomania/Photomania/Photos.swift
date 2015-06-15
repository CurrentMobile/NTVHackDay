//
//  Photos.swift
//  Photomania
//
//  Created by John Welch on 6/14/15.
//  Copyright (c) 2015 Essan Parto. All rights reserved.
//

import Foundation
import Alamofire

/**
*  A first attempt at refactoring two photo services into a common code base.
*/

enum PhotoSize: Int {
    case Tiny = 1
    case Small = 2
    case Medium = 3
    case Large = 4
    case XLarge = 5
}

/**
*  A photo resource that can be serialized.
*/
protocol Photo: ResponseObjectSerializable, ResponseCollectionSerializable {
    
    var id: AnyObject { get }
    
    var title: String { get }
    
    func isAvailable(size: PhotoSize) -> Bool
    
    func imageURL(size: PhotoSize) -> NSURL
}

protocol Router: URLRequestConvertible {
    init(pageSize: UInt, pageIndex: UInt)
}

class Photos<P: Photo, R: Router> {
    
    func fetchPhotos(photosPerPage: UInt, page: UInt, completion: (photos: [P]) -> Void) -> Void {
        let router = R(pageSize: photosPerPage, pageIndex:page)
        
        Alamofire.request(router).responseCollection() {
            (_, _, photos: [P]?, error) in
            
            if error == nil && photos != nil {
                completion(photos:photos!)
            }
        }
    }
}

