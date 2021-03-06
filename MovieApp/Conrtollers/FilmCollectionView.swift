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
    var wishesFilm: [Film] = []  //-------------------------------
    var tapCallback: ((Film) -> Void)?
    weak var filmDelegate: FilmManagerProtocol?
    
}

extension FilmCollectionView:  UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height - 100)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let i = IndexPath(item: 0, section: 0)
//        collectionView.reloadData()
//          collectionView.scrollToItem(at: i, at: .top, animated: true)
//          print("Selected")
//      }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCellCollectionViewCell", for: indexPath) as? CustomCellCollectionViewCell {
            cell.backgroundColor = .gray
            var film = films[indexPath.row]
            cell.descriptionLabel.text = film.title
            cell.textView.text = film.overview
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(film.posterPath)")
            cell.img.kf.setImage(with: url)
            
            cell.tapCall = {
                self.tapCallback?(film)
            }
  
            cell.addFilmTapped = {
                self.filmDelegate?.addFilm(addedFilm: film)
//                self.films.append(film)
//                self.films.append(film.genreIds(1))
                film.genreIds.append(-2)
                self.wishesFilm.append(film)
                print("fastPrint filmfilmfilmfilmfilmfilmfilmfilmfilmfilm\(film)")
                print("fastPrintwishesFilmwishesFilmwishesFilmwishesFilmwishesFilmwishesFilm \(self.wishesFilm)")
                self.reloadData()
            }
            cell.deleteFilmTapped = {
                self.filmDelegate?.deleteFilm(deletedFilm: film)
                self.films.remove(at: indexPath.row)
                self.reloadData()
            }
            
            return cell
        }
   return UICollectionViewCell()
    }
}

protocol FilmManagerProtocol: AnyObject {
    func addFilm(addedFilm: Film)
    func deleteFilm(deletedFilm: Film)    
}

