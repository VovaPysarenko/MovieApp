//
//  FilmCollectionView.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 07.09.2021.
//

import UIKit
import Kingfisher

class FilmCollectionView: UICollectionView  {
    var films: [Film] = []

    
}

extension FilmCollectionView:  UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
            cell.descriptionLabel.text = film.title
            cell.textView.text = film.overview
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(film.posterPath)")
            cell.img.kf.setImage(with: url)
            
            return cell
        }
   return UICollectionViewCell()
    }
}
