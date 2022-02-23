//
//  YFError.swift
//  YFRepSearchApp
//
//  Created by Yuta Fujii on 2022/02/22.
//

import Foundation

enum YFError:String,Error{
    
    case unableToComplete = "リクエストが完了しませんでした。"
    case invalidResponse = "サーバーからのレスポンスが無効です。"
    case invalidData = "サーバーからのデータが無効です。"
    
}
