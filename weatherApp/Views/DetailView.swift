//
//  DetailView.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class DetailView: UIView {

    public lazy var imageView: UIImageView = {
           let image = UIImageView()
           image.image = UIImage(systemName: "photo.fill")
           image.layer.borderWidth = 0.5
           image.layer.borderColor = UIColor.black.cgColor
           image.contentMode = .scaleAspectFill
           image.backgroundColor = .white
           image.layer.cornerRadius = 10
           image.clipsToBounds = true
           return image
       }()
    
    public lazy var descriptionLabel: UITextView = {
        let label = UITextView()
        label.font = UIFont(name: "Kohinoor Telugu", size: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.layer.cornerRadius = 10
//        label.layer.borderWidth = 1
//        label.layer.borderColor = UIColor.black.cgColor
        label.text = "Date Posted: , UserName: , Description:"
        label.sizeToFit()
        label.isEditable = false
        label.backgroundColor = .systemTeal
        return label
    }()
    
    override init(frame:CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .systemTeal
        imageViewConstraints()
        TextLabelConstraints()
    }
    
    private func imageViewConstraints() {
        addSubview(imageView)
        imageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10, height: 300)
    }
    
    private func TextLabelConstraints() {
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 10)
    }
}
