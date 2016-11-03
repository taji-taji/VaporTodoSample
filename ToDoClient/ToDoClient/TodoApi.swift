//
//  TodoApi.swift
//  ToDoClient
//
//  Created by tajika on 2016/11/02.
//  Copyright © 2016年 Tajika. All rights reserved.
//

import Foundation
import Siesta
import SwiftyJSON

let TodoApi = _TodoApi()

class _TodoApi: Service {
    
    fileprivate init() {
        super.init(baseURL: "http://0.0.0.0:8080")
        
        // 設定
        self.configure {
            $0.pipeline[.parsing].add(SwiftyJSONTransformer, contentTypes: ["*/json"])
            $0.expirationTime = 3600
        }

        // responseを任意の形に変える
        self.configureTransformer("/todos") {
            ($0.content as JSON).arrayValue
        }
    }
    
    // Resourceを登録
    var todos: Resource { return resource("/todos") }
}

let SwiftyJSONTransformer = ResponseContentTransformer { JSON($0.content as AnyObject) }
