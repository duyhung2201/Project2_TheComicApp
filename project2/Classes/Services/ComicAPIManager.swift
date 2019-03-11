//
//  ComicAPIManager.swift
//  project2
//
//  Created by HoaPQ on 3/11/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class ComicApiManage: NSObject {
    
    static let shared : ComicApiManage = ComicApiManage()
    
    //MARK: - Spin Code
    func getHomeComics(completion : @escaping CompletionDict) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(hostUrl)comics/home")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let responseHTTP = response as? HTTPURLResponse {
                if responseHTTP.statusCode == 200 || responseHTTP.statusCode == 201 {
                    if (error != nil) {
                        completion(false , nil)
                    } else {
                        let json = JSON(data!)
                        var data = [String: [ComicHomeModel]]()
                        
                        data["popular"] = [ComicHomeModel]()
                        data["newest"] = [ComicHomeModel]()
                        
                        for item in json["popular"].arrayValue {
                            let i = ComicHomeModel(json: item)
                            data["popular"]?.append(i)
                        }
                        
                        for item in json["newest"].arrayValue {
                            let i = ComicHomeModel(json: item)
                            data["newest"]?.append(i)
                        }
                        completion(true, data)
                    }
                } else {
                    completion(false , nil)
                }
            }
        })
        
        dataTask.resume()
    }
    
}



