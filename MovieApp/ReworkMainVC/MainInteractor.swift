//
//  MainInteractor.swift
//  MovieApp
//
//  Created by Vladislav Nikolaychuk on 28.09.2021.
//

import Foundation

class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol!
    let fbProvider = FBProvider()
    
    func getFilms() {
        fbProvider.getFBFilms() { films in
//            print("films \(films)")
            self.presenter.getFilms(films: films)
        }
    }
    
    func getGenres() {
        fbProvider.getFBGenre() { genres in
            self.presenter.getGenres(genres: genres)
        }
    }
}
