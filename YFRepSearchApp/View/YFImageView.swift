//
//  YFImageView.swift
//  YFRepSearchApp
//
//  Created by Yuta Fujii on 2022/02/22.
//

import UIKit

class YFImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    let cache = YFAPIManager.shared.cache
    
    override init(frame:CGRect){
        
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame:CGRect,image:UIImage) {
        
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.image = image
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func configure(){
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from urlString:String){
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){
            self.image = image
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil{
                print(error.debugDescription)
                return
            }
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self.image = image
            }

        }
        
        task.resume()
        
    }

}
