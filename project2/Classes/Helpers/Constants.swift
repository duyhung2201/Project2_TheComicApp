//
//  Constants.swift
//  project2
//
//  Created by HoaPQ on 3/11/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

enum HTTPMethods : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

let sharedLoadView : LoadView = LoadView()

typealias CompletionDict = (_ succes: Bool, _ data: [String : Any]?) -> ()

typealias Completion = (_ succes: Bool, _ data: Any?) -> ()

// MARK: Appdelegate
let appdelegate = (UIApplication.shared.delegate as! AppDelegate)


// define request
public let kTimeOut = 10

// Some Constant
public let SCREEN_WIDTH = UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
public let OS_VERSION = UIDevice.current.systemVersion

public let COL_CELL_WIDTH = 140
public let COL_CELL_HEIGHT = 180

public let hostUrl = "https://mbcomic-app.herokuapp.com/"

public let modifier = AnyModifier { request in
    var r = request
    // replace "Access-Token" with the field name you need, it's just an example
    r.setValue("https://readcomicsonline.me", forHTTPHeaderField: "comicpunch.net")
    return r
}
