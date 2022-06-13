//
//  ViewController.swift
//  App-Store
//
//  Created by Omar Ahmed on 12/06/2022.
//

import UIKit

class AppsViewController: UIViewController {
    
    let sections = Bundle.main.decode([Section].self, from: "appstore.json")
    
    var collectionView : UICollectionView!
    
    var dataSource : UICollectionViewDiffableDataSource<Section,App>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        createDataSource()
        reloadData()
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.register(FeaturedCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedCollectionViewCell.reuseIdentifier)
    }
    
    func configure<T:SelfConfiguringCell>(_ cellType: T.Type,with app: App,for indexPath: IndexPath)-> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else { fatalError("Unable to deque \(cellType)") }
        
        cell.configure(with: app)
        
        return cell
    }
    
    func createDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,App>(collectionView: collectionView, cellProvider: { collectionView, indexPath, app in
            switch self.sections[indexPath.section].type {
            default:
                return self.configure(FeaturedCollectionViewCell.self, with: app, for: indexPath)
            }
        })
    }
    
    func reloadData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,App>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
    
    func createFeaturedSection(with section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(350))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [itemLayout])
        
        let layoutSection = NSCollectionLayoutSection(group: groupLayout)
        
        return layoutSection
    }


}

