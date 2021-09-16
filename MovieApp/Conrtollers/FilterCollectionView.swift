//
//  FilterCollectionView.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 07.09.2021.
//

import UIKit

class FilterCollectionView: UICollectionView {
    
    
    var generes: [Genre] = []
    var tapCallback: ((Genre) -> Void)?
    weak var fiterDelegate: FilterManagerProtocol?
    

    
}
extension FilterCollectionView:  UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 30)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("fastPrint \(generes)")
        return generes.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionCell", for: indexPath) as? FilterCollectionCell {
            cell.backgroundColor = .blue
            cell.layer.cornerRadius = 10
            let genre = generes[indexPath.row]
            cell.filterLabel.text = genre.name
            
            cell.tapCall = {
                self.tapCallback?(genre)
            }
            
            cell.filterFilmTapped = {
                self.fiterDelegate?.filterFilm(filteredFilm: genre.name)
                self.reloadData()
            }
            return cell
        }
        return UICollectionViewCell()
    }
    

}
protocol FilterManagerProtocol: AnyObject {
    func filterFilm(filteredFilm: String)
}
