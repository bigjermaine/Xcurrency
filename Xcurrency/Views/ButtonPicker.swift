//
//  ButtonPicker.swift
//  Xcurrency
//
//  Created by MacBook AIR on 16/07/2023.
//

import UIKit

class ButtonPicker: UIView {
  
        let flagImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        let countryLabel: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 20)
            label.textColor = UIColor.black.withAlphaComponent(0.5)
            return label
        }()
        
        let chevronImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .black.withAlphaComponent(0.3)
            return imageView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupSubviews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupSubviews()
        
        }
        
        private func setupSubviews() {
            addSubview(flagImageView)
            addSubview(countryLabel)
            addSubview(chevronImageView)
            
            flagImageView.translatesAutoresizingMaskIntoConstraints = false
            countryLabel.translatesAutoresizingMaskIntoConstraints = false
            chevronImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                flagImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
                flagImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                flagImageView.widthAnchor.constraint(equalToConstant: 24),
                flagImageView.heightAnchor.constraint(equalToConstant: 24),
                
                countryLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 5),
                countryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                
                chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -5),
                chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                chevronImageView.widthAnchor.constraint(equalToConstant: 20),
                chevronImageView.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
   
   
    }
