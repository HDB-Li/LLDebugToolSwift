//
//  MyService.swift
//  LLDebugToolSwiftDemo
//
//  Created by Li on 2018/9/16.
//

import Foundation
import Alamofire
import Moya

enum MyService {
    case zen
}


extension MyService : TargetType {
    var baseURL: URL {
        return URL(string:"http://baike.baidu.com/api/openapi/BaikeLemmaCardApi?&format=json&appid=379020&bk_key=%E6%B5%B7%E8%B4%BC%E7%8E%8B&bk_length=600")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
