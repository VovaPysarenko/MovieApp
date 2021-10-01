//
//  MainViewController.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 06.09.2021.
//

import UIKit
import Firebase
import CodableFirebase

class MainViewController: UIViewController {

    @IBOutlet weak var filmCollectionView: FilmCollectionView!
    @IBOutlet weak var filterCollectionView: FilterCollectionView!
    var presenter: MainPresenterProtocol!
    private var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(dismissSelf))
        filmCollectionView.delegate =  filmCollectionView
        filmCollectionView.dataSource = filmCollectionView
        filterCollectionView.delegate =  filterCollectionView
        filterCollectionView.dataSource = filterCollectionView
        filmCollectionView.filmDelegate = self
        setupLayout()
        

        filmCollectionView.tapCallback = { [weak self] currentFilm in
            self?.navigationController?.pushViewController(SinglePageViewController(film: currentFilm), animated: true)
            }
        
        filterCollectionView.tapCallback = { [weak self] currentGenre in
            self?.presenter.sortedFilms(currentGenre: currentGenre)
            self?.filmCollectionView.scrollToItem(at: IndexPath(index: 0), at: .top , animated: true)
        }
    }
    
    func setupLayout() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        navigationItem.setHidesBackButton(true, animated: false)
//        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Movies"
        registerCell()
    }
    @objc func logOut() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        do {
            try Auth.auth().signOut()
        } catch let err {
            print(err)
        }
    }
    
    func registerCell() {
        let connectedFilmNIB = UINib(nibName: "CustomCellCollectionViewCell", bundle: nil)
        filmCollectionView.register(connectedFilmNIB, forCellWithReuseIdentifier: "CustomCellCollectionViewCell")

        let connectedFilterNIB = UINib(nibName: "FilterCollectionCell", bundle: nil)
        filterCollectionView.register(connectedFilterNIB, forCellWithReuseIdentifier: "FilterCollectionCell")
    }
}

extension MainViewController: FilmManagerProtocol {
    func addFilm(addedFilm: Film) {
        self.presenter.addFilmToFavoritesList(currentfilm: addedFilm)

    }
    func deleteFilm(deletedFilm: Film) {
        print("fastPrint \(deletedFilm)")
    }
}

extension MainViewController: MainViewProtocol {
    func getFilmsForCollection(films: [Film]) {
        self.filmCollectionView.films = films
        self.filmCollectionView.reloadData()
    }
    
    func getGenresForCollection(genres: [Genre]) {
        self.filterCollectionView.generes = genres
        self.filterCollectionView.reloadData()
    }
    func reloadFilmCollectionView() {}

}
