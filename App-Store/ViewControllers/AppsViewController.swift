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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.register(FeaturedCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedCollectionViewCell.reuseIdentifier)
        collectionView.register(MediumTableCell.self, forCellWithReuseIdentifier: MediumTableCell.reuseIdentifier)
    }
    
    func configure<T:SelfConfiguringCell>(_ cellType: T.Type,with app: App,for indexPath: IndexPath)-> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else { fatalError("Unable to deque \(cellType)") }
        
        cell.configure(with: app)
        
        return cell
    }
    
    func createDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,App>(collectionView: collectionView, cellProvider: { collectionView, indexPath, app in
            switch self.sections[indexPath.section].type {
            case "mediumTable" :
                return self.configure(MediumTableCell.self, with: app, for: indexPath)
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
    
    func createCompositionalLayout()-> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex,layoutEnviroment in
            let section = self.sections[sectionIndex]
            switch section.type {
            case "mediumTable" :
                return self.createMediumSection(with: section)
            default:
                return self.createFeaturedSection(with: section)
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    
    func createFeaturedSection(with section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(350))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [itemLayout])
        
        let layoutSection = NSCollectionLayoutSection(group: groupLayout)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        return layoutSection
    }
    
    func createMediumSection(with section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.55))
        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [itemLayout])
        
        let layoutSection = NSCollectionLayoutSection(group: groupLayout)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        return layoutSection
    }


}

