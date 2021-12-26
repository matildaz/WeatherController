//
//  MainViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 26.12.2021.
//

import Foundation
import UIKit

class RoomsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension RoomsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewCell()
        return cell
    }
    
    
}
