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

//protocol MainInteractorProtocol: AnyObject {
//    func getFilms()
//    func getGenres()
//    var presenter: MainPresenterProtocol! { get set }
//}
//
//protocol MainPresenterProtocol: AnyObject {
//    func getFilms(films: [Film])
//    func getGenres(genres: [Genre])
//    func viewDidLoad()
//    var interactor: MainInteractorProtocol! { get set }
//    var view: MainViewProtocol! { get set }
//}
//
//protocol MainViewProtocol: AnyObject {
//    var presenter: MainPresenterProtocol! { get set }
//    func reloadFilmCollectionView()
//    func getFilmsForCollection(films: [Film])
//    func getGenresForCollection(genres: [Genre])
//}
