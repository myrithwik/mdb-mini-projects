//
//  ViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2/18/21.
//

import UIKit

class PokedexVC: UIViewController, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var numPerRow: CGFloat = 0.33
    
    let pokemons = PokemonGenerator.shared.getPokemonArray()
    
    var filteredPokemons: [Pokemon]?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(PokemonCollectionCell.self, forCellWithReuseIdentifier: PokemonCollectionCell.reuseIdentifier)
        return collectionView
    }()
    
    let filterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.setTitle("Filter", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleFilter), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleFilter(sender: UIButton) {
        //create a new vc, add it to navigationController, and send it to that screen
        //in that vc take the buttons array of booleans and display buttons
        //based on what buttons are clicked return booleans
        //take booleans and set filter criteria along with search criteria
    }
    
    lazy var toggleBT: UIButton = {

        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.isSelected = false
        button.setTitle("Grid", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleToggleBT), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc func handleToggleBT(sender: UIButton) {

        sender.isSelected = !sender.isSelected

        if sender.isSelected {

            numPerRow = 0.8
            sender.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            sender.setTitleColor(.black, for: .normal)
            toggleBT.setTitle("Rows", for: .normal)
        }

        else {

            numPerRow = 0.33
            sender.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            sender.setTitleColor(.white, for: .normal)
            toggleBT.setTitle("Grid", for: .normal)
        }
        
        self.collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateSearchResults(for: searchController)
//
//        filteredPokemons = pokemons
//        searchController.searchResultsUpdater = self
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.dimsBackgroundDuringPresentation = false
//        tableView.tableHeaderView = searchController.searchBar
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        view.backgroundColor = .white
        
        view.addSubview(toggleBT)
        view.addSubview(collectionView)
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 200, left: 30, bottom: 0, right: 30))
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            toggleBT.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            toggleBT.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateSearchResults(for: searchController)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredPokemons = pokemons.filter { pokemon in
                return pokemon.name.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            filteredPokemons = pokemons
        }
        collectionView.reloadData()
    }
    
}

extension PokedexVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let pokeLeft = filteredPokemons else {
            return 0
        }
        return pokeLeft.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionCell.reuseIdentifier, for: indexPath) as! PokemonCollectionCell
        if let pokeLeft = filteredPokemons {
            let pokemonName = pokeLeft[indexPath.item]
            cell.pokemonName = pokemonName
        }
        
        return cell
    }
}

extension PokedexVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(UIScreen.main.bounds.width * numPerRow), height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let pokemonName = filteredPokemons![indexPath.item]
        
        return UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: {
            return PokemonPreviewVC(pokemonName: pokemonName)
        }) {_ in
            let previewItem = UIAction(title: "Preview", image: UIImage(systemName: "arrow.down.right.and.arrow.up.left")) {_ in}
            return UIMenu(title: "", image: nil, identifier: nil, children: [previewItem])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemonName = filteredPokemons![indexPath.item]
        let VC = PokemonPreviewVC(pokemonName: pokemonName)
        
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

