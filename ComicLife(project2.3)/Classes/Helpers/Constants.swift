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
enum RealmComicTypeData: String {
    case fvrState = "fvrState"
    case fvrCount = "fvrCount"
    case reviewCount = "reviewCount"
    case ratingCount = "ratingCount"
    case ratingPoint = "ratingPoint"
    case ratings = "ratings"
    case reviews = "reviews"
}

typealias CompletionDict = (_ succes: Bool, _ data: [String : Any]?) -> ()

typealias Completion = (_ succes: Bool, _ data: Any?) -> ()

// MARK: Appdelegate
let appdelegate = (UIApplication.shared.delegate as! AppDelegate)

let USER_KEY = "user_key"

let BLUE_COLOR = #colorLiteral(red: 0, green: 0.446343429, blue: 0.9253648477, alpha: 1)
let GRAY_COLOR = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
let LIGHT_GRAY_COLOR = #colorLiteral(red: 0.9270701142, green: 0.9270701142, blue: 0.9270701142, alpha: 1)

// define request
public let kTimeOut = 10

// Some Constant
public let SCREEN_WIDTH = UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
public let OS_VERSION = UIDevice.current.systemVersion

public let COL_CELL_WIDTH = 140
public let COL_CELL_HEIGHT = 180
public let COL_CELL_HEIGHT2 = 150

public let MARGIN20: CGFloat = 20
public let MARGIN15: CGFloat = 15
public let MARGIN7: CGFloat = 7
public let MARGIN10: CGFloat = 10

public let hostUrl = "https://mbcomic-app.herokuapp.com/"

public let modifier = AnyModifier { request in
    var r = request
    // replace "Access-Token" with the field name you need, it's just an example
    r.setValue("https://readcomicsonline.me", forHTTPHeaderField: "comicpunch.net")
    return r
}
