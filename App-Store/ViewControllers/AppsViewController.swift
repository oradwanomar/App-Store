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
        
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }


}

