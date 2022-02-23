//
//  YFContentCell.swift
//  YFRepSearchApp
//
//  Created by Yuta Fujii on 2022/02/24.
//

import UIKit

class YFContentCell: UITableViewCell {

    var contentTitleLabel = YFTitleLabel(textAlignment: .left, fontSize: 12)
    var avatorImageView = YFImageView(frame: .zero, image: UIImage(named: "avatar-placeholder")!)
    static let identifier = "YFContentCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configure(repository:Repository){
        contentTitleLabel.text = repository.name
        avatorImageView.downloadImage(from: (repository.owner?.avatar_url!)!)
        
        layoutUI()
    }
    
    func layoutUI(){
        self.addSubview(avatorImageView)
        self.addSubview(contentTitleLabel)
        
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            avatorImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding),
            avatorImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: padding),
            avatorImageView.widthAnchor.constraint(equalToConstant: 30),
            avatorImageView.heightAnchor.constraint(equalToConstant: 30),
            
            contentTitleLabel.leadingAnchor.constraint(equalTo: avatorImageView.trailingAnchor,constant: padding),
            contentTitleLabel.topAnchor.constraint(equalTo: avatorImageView.topAnchor),
            contentTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -padding),
            contentTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -padding)
            
        ])
        
    }
    
    
}
