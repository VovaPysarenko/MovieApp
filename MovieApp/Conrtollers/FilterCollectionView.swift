//
//  FilterCollectionView.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 07.09.2021.
//

import UIKit

class FilterCollectionView: UICollectionView {
    
    var films = [1,1,1,1,1,1,1]
    
}
extension FilterCollectionView:  UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 30)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionCell", for: indexPath) as? FilterCollectionCell {
            cell.backgroundColor = .blue
            cell.layer.cornerRadius = 10
            let film = films[indexPath.row]
            cell.filterLabel.text = "bbb"
            return cell
        }
        return UICollectionViewCell()
    }
}
