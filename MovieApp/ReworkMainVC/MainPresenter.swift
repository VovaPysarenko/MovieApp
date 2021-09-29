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
        print("films2222 \(films)")
    }
    
    func getGenres(genres: [Genre]) {
        
        print("genres \(genres)")
    }
}
