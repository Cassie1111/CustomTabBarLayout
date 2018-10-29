//
//  SettingCell.swift
//  CustomNavBar
//
//  Created by 刘敏 on 2018/10/29.
//  Copyright © 2018 刘敏. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.gray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            
            if let imageName = setting?.imageName {
                // .alwaysTemplate allow to change the tint color
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                
                // set the default color, otherwise the color is blue
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(iconImageView)
        addSubview(nameLabel)
       
        activateConstrainsWithFormat(format: "H:|-16-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        activateConstrainsWithFormat(format: "V:|[v0]|", views: nameLabel)
        
        activateConstrainsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
