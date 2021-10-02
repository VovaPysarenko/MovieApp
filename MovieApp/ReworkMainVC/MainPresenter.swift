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
    var films: [Film] = []
    var allGenres: [Genre] = []
    
    func viewDidLoad() {
        interactor.getFilms()
        interactor.getGenres()
    }

    func getFilms(films: [Film]) {
        self.films = films
        view.getFilmsForCollection(films: self.films)
//        print("films2222viewviewviewviewviewviewviewviewviewview \(films)")
    }
    
    func getGenres(genres: [Genre]) {
        allGenres = genres
        allGenres.insert(Genre(id: -1, name: "Favorites"), at: 0)
        allGenres.insert(Genre(id: -2, name: "All films"), at: 0)
        view.getGenresForCollection(genres: allGenres)
//        print("genres \(genres)")
    }
    
    func addFilmToMyCategory(addedFilm: Film) {
        self.films.append(addedFilm)
    }
    
    func filterFilms(currentGenre: Genre) {
        var sortFilms = [Film]()
        if currentGenre.id == -2 {
            sortFilms = self.films
        } else {
            for currentFilm in self.films {
                for genreItem in currentFilm.genreIds {
                    if currentGenre.id == genreItem {
                        sortFilms.append(currentFilm)
                    }
                }
            }
        }
        view.getFilmsForCollection(films: sortFilms)
    }
}
