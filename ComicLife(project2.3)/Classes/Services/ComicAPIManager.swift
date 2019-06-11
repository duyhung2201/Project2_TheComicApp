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
    
    func getSearchBySlug(slug: String, completion: @escaping Completion) {
        guard let url = URL(string: "\(hostUrl)comics/\(slug)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!) else { return  }
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = HTTPMethods.get.rawValue
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let responseHTTP = response as? HTTPURLResponse {
                if responseHTTP.statusCode == 200 || responseHTTP.statusCode == 201 {
                    if (error != nil) {
                        DispatchQueue.main.async {
                            completion(false , nil)
                        }
                    } else {
                        let json = JSON(data!)
                        var data = [SearchModel]()
                        for item in json.arrayValue {
                            data.append(SearchModel(json: item))
                        }
                        DispatchQueue.main.async {
                            completion(true, data)
                        }
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false , nil)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func getComicById(id_comic: Int, completion: @escaping Completion) {
        let request = NSMutableURLRequest(url: URL(string: "\(hostUrl)comics?id=\(id_comic)")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = HTTPMethods.get.rawValue
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let responseHTTP = response as? HTTPURLResponse {
                if responseHTTP.statusCode == 200 || responseHTTP.statusCode == 201 {
                    if (error != nil) {
                        DispatchQueue.main.async {
                            completion(false , nil)
                        }
                    } else {
                        let json = JSON(data!)
                        let data = InfoComicModel(json: json)
                        DispatchQueue.main.async {
                            completion(true, data)
                        }
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false , nil)
                    }
                }
            }
        }
        dataTask.resume() 
    }
    
    func getIssueById(id: String, completion: @escaping Completion) {
        guard let url = URL(string: "\(hostUrl)comics/issue?id=\(id)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!) else { return  }
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = HTTPMethods.get.rawValue
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let responseHTTP = response as? HTTPURLResponse {
                if responseHTTP.statusCode == 200 || responseHTTP.statusCode == 201 {
                    if (error != nil) {
                        DispatchQueue.main.async {
                            completion(false , nil)
                        }
                    } else {
                        let json = JSON(data!)
                        let data = IssueModel(json: json)
                        
                        DispatchQueue.main.async {
                            completion(true, data)
                        }
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false , nil)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    //MARK: - Spin Code
    func getHomeComics(completion : @escaping CompletionDict) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(hostUrl)comics/home")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = HTTPMethods.get.rawValue
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let responseHTTP = response as? HTTPURLResponse {
                if responseHTTP.statusCode == 200 || responseHTTP.statusCode == 201 {
                    if (error != nil) {
                        completion(false , nil)
                    } else {
                        let json = JSON(data!)
                        var data = [String: [HomeModel]]()
                        
                        data["popular"] = [HomeModel]()
                        data["newest"] = [HomeModel]()
                        
                        for item in json["popular"].arrayValue {
                            let i = HomeModel(json: item)
                            data["popular"]?.append(i)
                        }
                        
                        for item in json["newest"].arrayValue {
                            let i = HomeModel(json: item)
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

    
    
    func login(id: String, password: String ,completion : @escaping Completion) {
        let request = NSMutableURLRequest(url: NSURL(string: "\(hostUrl)login")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10)
        request.httpMethod = HTTPMethods.post.rawValue
        
        let parameter : [String : Any] = ["email" : id, "password" : password]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: [])
        } catch let error {
            print(error.localizedDescription)
        }
        
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let responseHTTP = response as? HTTPURLResponse {
//                if responseHTTP.statusCode == 200 || responseHTTP.statusCode == 201 {
                guard error == nil else {
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                do {
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        print(json)
                        // handle json...
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
//                } else {
//                    completion(false, nil)
//                    print(error)
//                }
            }
//            if let response = response {
//                print(response)
//            }
//            if let data = data {
////                let json = try JSONSerialization.data(withJSONObject: data1, options: [])
////                print(json)
//                completion(true,nil)
//
//            }
        }.resume()
    }
    
    
    
}



