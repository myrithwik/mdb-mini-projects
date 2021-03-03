//
//  SymbolCollectionCell.swift
//  SFSymbolCollection
//
//  Created by Rithwik Mylavarapu on 2/22/21.
//

import UIKit

class SymbolCollectionCell: UICollectionViewCell {
    static let reuseIdentifier: String = String(describing: SymbolCollectionCell.self)
    
    var symbol: SFSymbol? {
        didSet {
            imageView.image = symbol?.image
            titleView.text = symbol?.name
        }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        
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
        contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 88)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
