//
//  ProductCell.swift
//  JLDishwashers
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    
    var urlString = ""
    let defaultColor = UIColor.white
    var shouldTintBackgroundWhenSelected = true // You can change default value
    var specialHighlightedArea: UIView?
    
    //MARK: Subviews
    
    let coverImgView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let descriptionLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .black
        l.lineBreakMode = .byWordWrapping
        l.numberOfLines = 0
        return l
    }()
    
    let bottomLine: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0.7, alpha: 0.3)
        return v
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = defaultColor
        setupViews()
    }
    
    func setupViews() {
        
        self.addSubview(coverImgView)
        self.addSubview(descriptionLabel)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[img(==200)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["img" : coverImgView]))
        
        self.addConstraint(NSLayoutConstraint(item: coverImgView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[img(==200)]-10-[title(==80)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["img" : coverImgView, "title" : descriptionLabel]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[tl(==200)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["tl" : descriptionLabel]))
        
        self.addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        self.addSubview(bottomLine)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bl]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["bl" : bottomLine]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bl(==1)]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["bl" : bottomLine]))
        
    }
}

//MARK: - Cell highlight

extension ProductCell {
    
    override var isHighlighted: Bool { // make lightgray background show immediately
        willSet {
            onSelected(newValue)
        }
    }
    
    override var isSelected: Bool { // keep lightGray background until unselected
        willSet {
            onSelected(newValue)
        }
    }
    
    func onSelected(_ newValue: Bool) {
        guard selectedBackgroundView == nil else { return }
        if shouldTintBackgroundWhenSelected {
            contentView.backgroundColor = newValue ? UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0) : defaultColor
        }
        if let sa = specialHighlightedArea {
            sa.backgroundColor = newValue ? UIColor.black.withAlphaComponent(0.4) : defaultColor
        }
    }
}

