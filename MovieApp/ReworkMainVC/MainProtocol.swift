//
//  MainProtocol.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 01.10.2021.
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
    func sortedFilms(currentGenre: Genre)
    func addFilmToFavoritesList(currentfilm: Film)
}

protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol! { get set }
    func reloadFilmCollectionView()
    func getFilmsForCollection(films: [Film])
    func getGenresForCollection(genres: [Genre])
}
