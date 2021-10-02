//
//  MainProtocols.swift
//  MovieApp
//
//  Created by Vladislav Nikolaychuk on 01.10.2021.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    func getFilms()
    func getGenres()
    var presenter: MainPresenterProtocol! { get set }
}

protocol MainPresenterProtocol: AnyObject {
    func getFilms(films: [Film])
    func getGenres(genres: [Genre])
    func viewDidLoad()
    var interactor: MainInteractorProtocol! { get set }
    var view: MainViewProtocol! { get set }
    func filterFilms(currentGenre: Genre)
    func addFilmToMyCategory(addedFilm: Film)
}

protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol! { get set }
    func reloadFilmCollectionView()
    func getFilmsForCollection(films: [Film])
    func getGenresForCollection(genres: [Genre])
    
}
