//
//  YFAPIManager.swift
//  YFRepSearchApp
//
//  Created by Yuta Fujii on 2022/02/22.
//

import Foundation
import UIKit

final class YFAPIManager{
    
    static let shared = YFAPIManager()
    let cache = NSCache<NSString, UIImage>()

    func fetchData(keyword:String,perpage:Int,complition:@escaping(Result<Root,YFError>)->Void){

        let baseURL = "https://api.github.com/search/repositories?q=\(keyword)&sort=stars&page=1&per_page=\(perpage)"
        
        guard let _ = URL(string: baseURL) else {
            complition(.failure(.unableToComplete))
            return
        }

        let task = URLSession.shared.dataTask(with: URL(string: baseURL)!) { (data, response, error) in
        
            print(baseURL.debugDescription)
            
            if error != nil{
                complition(.failure(.unableToComplete))
                return
            }
            
            guard let _ = response as? HTTPURLResponse else{
                complition(.failure(.invalidResponse))
                return
            }

            guard let _ = data else {
                complition(.failure(.invalidData))
                return
            }

            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(Root.self, from: data!)
                complition(.success(root))
            }catch{
                complition(.failure(.invalidData))
            }
            
        }
        task.resume()
        
    }
    
}
