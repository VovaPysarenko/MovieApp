//
//  MainPresenter.swift
//  MovieApp
//
//  Created by Vladislav Nikolaychuk on 28.09.2021.
//

import Foundation

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    
    func viewDidLoad() {
        interactor.getFilms()
        interactor.getGenres()
    }

    func getFilms(films: [Film]) {
        view.getFilmsForCollection(films: films)
//        print("films2222viewviewviewviewviewviewviewviewviewview \(films)")
    }
    
    func getGenres(genres: [Genre]) {
        view.getGenresForCollection(genres: genres)
//        print("genres \(genres)")
    }

}
