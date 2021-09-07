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
        return CGSize(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height - 100)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCellCollectionViewCell", for: indexPath) as? CustomCellCollectionViewCell {
            cell.backgroundColor = .gray
            let film = films[indexPath.row]
            cell.descriptionLabel.text = "vcvcv"
            return cell
        }
        return UICollectionViewCell()
    }
}
