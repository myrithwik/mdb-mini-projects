//
//  SymbolCollectionCell.swift
//  SFSymbolCollection
//
<<<<<<< HEAD
//  Created by Rithwik Mylavarapu on 2/22/21.
=======
//  Created by Michael Lin on 2/22/21.
>>>>>>> 3b0b5b6a0078fb39ff030eff8b83bdb0b04116c7
//

import UIKit

class SymbolCollectionCell: UICollectionViewCell {
    static let reuseIdentifier: String = String(describing: SymbolCollectionCell.self)
    
<<<<<<< HEAD
    var symbol: SFSymbol? {
=======
    var symbol: SFSymbol? = nil {
>>>>>>> 3b0b5b6a0078fb39ff030eff8b83bdb0b04116c7
        didSet {
            imageView.image = symbol?.image
            titleView.text = symbol?.name
        }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
<<<<<<< HEAD
        iv.translatesAutoresizingMaskIntoConstraints = false
        
=======
        
        iv.translatesAutoresizingMaskIntoConstraints = false
>>>>>>> 3b0b5b6a0078fb39ff030eff8b83bdb0b04116c7
        return iv
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
<<<<<<< HEAD
        contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
=======
        
        backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.1058823529, blue: 0.1098039216, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.1058823529, blue: 0.1098039216, alpha: 1)
>>>>>>> 3b0b5b6a0078fb39ff030eff8b83bdb0b04116c7
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
<<<<<<< HEAD
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 88)
            
=======
            imageView.bottomAnchor.constraint(equalTo: titleView.topAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
>>>>>>> 3b0b5b6a0078fb39ff030eff8b83bdb0b04116c7
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
