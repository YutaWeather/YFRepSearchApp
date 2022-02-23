//
//  YFTitleLabel.swift
//  YFRepSearchApp
//
//  Created by Yuta Fujii on 2022/02/22.
//

import UIKit

class YFTitleLabel: UILabel {

    
    override init(frame:CGRect){
        
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment:NSTextAlignment,fontSize:CGFloat){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.boldSystemFont(ofSize: fontSize)
        configure()
        
    }
    
    private func configure(){
        textColor = .label
        numberOfLines = 0
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}
