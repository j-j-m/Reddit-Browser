//
//  PostCell.swift
//  Reddit
//
//  Created by Jacob Martin on 5/12/18.
//  Copyright © 2018 jjm. All rights reserved.
//

import UIKit

let defaultImage = UIImage(named: "alien", in: Bundle(for: PostCell.self), compatibleWith: nil)

public class PostCell: UITableViewCell {
    
    public lazy var imgView: GradientImageView = {
        let i = GradientImageView()
        i |> background(color: .lightGray)
        
        i.image = defaultImage
        
        i.autolayoutMode()
        i.clipsToBounds = true
        i.contentMode = .scaleAspectFill
        i.randomizeColors()
        
        return i
    }()
    
    public lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.autolayoutMode()
        l.numberOfLines = 0
        return l
    }()
    
    public lazy var subredditLabel: UILabel = {
        let l = UILabel()
        l.autolayoutMode()
        l.adjustsFontSizeToFitWidth = true
        l.textAlignment = .right
        return l
    }()
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(titleLabel)
        addSubview(subredditLabel)
        addSubview(imgView)
        
        contentView |> background(color: .clear)
//            <> border(color: .lightGray, width: 1.0)
        
        
        let marginGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            imgView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 10.0),
            imgView.widthAnchor.constraint(equalTo:  imgView.heightAnchor),
            imgView.heightAnchor.constraint(equalToConstant:150),
            imgView.topAnchor.constraint(greaterThanOrEqualTo: marginGuide.topAnchor, constant: 10.0),
            imgView.bottomAnchor.constraint(lessThanOrEqualTo: marginGuide.bottomAnchor, constant: 10.0),
            imgView.centerYAnchor.constraint(equalTo: marginGuide.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 10.0),
            titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -10.0),
            titleLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10.0),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: subredditLabel.topAnchor),
            
            subredditLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -10.0),
            subredditLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10.0),
            subredditLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -10.0)
            
            ])
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = defaultImage
        imgView.randomizeColors()
        
    }
    
    override public func layoutSubviews() {
        let height = imgView.bounds.height
        imgView |> corner(radius: height / 5)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
