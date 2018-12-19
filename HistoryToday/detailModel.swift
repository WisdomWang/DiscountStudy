//
//  detailModel.swift
//  HistoryToday
//
//  Created by Cary on 2018/6/20.
//  Copyright © 2018年 Cary. All rights reserved.
//

import UIKit
import ObjectMapper

class detailModel: NSObject,Mappable {
    var title : String?
    var content : String?
    var url:String?
    
    required init?(map: Map) {
       
    }
    
    func mapping(map: Map) {
        
        title<-map["title"]
        content<-map["content"]
        url<-map["picUrl.0.url"]
    }
}
