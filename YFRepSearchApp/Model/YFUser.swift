//
//  YFUser.swift
//  YFRepSearchApp
//
//  Created by Yuta Fujii on 2022/02/22.
//

import Foundation

struct Root:Decodable{
    
    let items:[Repository]?

}

struct Repository:Decodable{
    
    let name:String?
    let owner:Owner?
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case owner = "owner"
    }
}

struct Owner:Decodable{
    
    let avatar_url:String?
    
    enum CodingKeys: String, CodingKey {
        case avatar_url = "avatar_url"
    }
}




