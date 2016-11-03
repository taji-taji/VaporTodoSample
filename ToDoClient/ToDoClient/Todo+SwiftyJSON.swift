//
//  Todo+SwiftyJSON.swift
//  ToDoClient
//
//  Created by tajika on 2016/11/02.
//  Copyright © 2016年 Tajika. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Todo {
    
    init(json: JSON) throws {
        id = json["id"].intValue
        title = json["title"].stringValue
        created = Date(timeIntervalSince1970: json["created"].doubleValue)
    }

}
