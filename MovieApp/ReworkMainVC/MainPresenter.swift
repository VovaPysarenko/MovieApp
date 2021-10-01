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
    var films: [Film] =  []
    var genres: [Genre] = []
    var favoritesList: [Film] = []
    
    func viewDidLoad() {
        interactor.getFilms()
        interactor.getGenres()
    }

    func getFilms(films: [Film]) {
        self.films = films
        view.getFilmsForCollection(films: self.films)
    }
    
    func getGenres(genres: [Genre]) {
        self.genres = genres
        self.genres.append(Genre(id: -1, name: "Favorites"))
        self.genres.append(Genre(id: -2, name: "All"))
        view.getGenresForCollection(genres: self.genres)
    }
    
    func sortedFilms(currentGenre: Genre) {
        var sortFilms = [Film]()
        if currentGenre.id == -1 {
            sortFilms = self.favoritesList
        }
        view.getFilmsForCollection(films: sortFilms)
        
        if currentGenre.id == -2 {
            sortFilms = self.films
        }  else {
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
    
    func addFilmToFavoritesList(currentfilm: Film) {
        self.favoritesList.append(currentfilm)
    }
}
