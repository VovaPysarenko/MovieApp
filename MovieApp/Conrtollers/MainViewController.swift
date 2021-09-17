//
//  MainViewController.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 06.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var filmCollectionView: FilmCollectionView!
    @IBOutlet weak var filterCollectionView: FilterCollectionView!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        filmCollectionView.delegate =  filmCollectionView
        filmCollectionView.dataSource = filmCollectionView
        filterCollectionView.delegate =  filterCollectionView
        filterCollectionView.dataSource = filterCollectionView
        filmCollectionView.filmDelegate = self
        setupLayout()
        registerCell()
        getJSONFilms()
        getJSONGenere()
                
        filmCollectionView.tapCallback = { [weak self] currentFilm in
            self?.navigationController?.pushViewController(SinglePageViewController(film: currentFilm), animated: true)
            }
        
        filterCollectionView.tapCallback = { currentGenre in
            var sortedFilm = [Film]()
            for currentFilm in self.filterCollectionView.sortedFilms {
                for genreItem in currentFilm.genreIds {
                    if currentGenre.id == genreItem {
                        sortedFilm.append(currentFilm)
                    }
                }
            }
            self.filmCollectionView.films = sortedFilm
            self.filmCollectionView.reloadData()
        }
    }

    func setupLayout() {
//        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Movies"
    }
    
    func registerCell() {
        let connectedFilmNIB = UINib(nibName: "CustomCellCollectionViewCell", bundle: nil)
        filmCollectionView.register(connectedFilmNIB, forCellWithReuseIdentifier: "CustomCellCollectionViewCell")

        let connectedFilterNIB = UINib(nibName: "FilterCollectionCell", bundle: nil)
        filterCollectionView.register(connectedFilterNIB, forCellWithReuseIdentifier: "FilterCollectionCell")
    }
    
    func getJSONFilms() {
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=42ebca47d17dba363b4bf75d08a1a301"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let  error = error {
                    print(error)
                    return
                }
                guard let data = data else {return}
//                let someString = String(data: data, encoding: .utf8)
                if let filmResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    self.filmCollectionView.films = filmResponse.results
                    self.filmCollectionView.reloadData()
                                        
                    self.filterCollectionView.sortedFilms = filmResponse.results
                    self.filterCollectionView.reloadData()

                } else {
                    print("FAILED")
                }
            }
        }.resume()
    }
    
    func getJSONGenere() {
        let urlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=42ebca47d17dba363b4bf75d08a1a301"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let  error = error {
                    print(error)
                    return
                }
                guard let data = data else {return}
//                let genereJSON = String(data: data, encoding: .utf8)
                if let filterResponse = try? JSONDecoder().decode(ResponseGenre.self, from: data) {
                    self.filterCollectionView.generes = filterResponse.genres
                    self.filterCollectionView.reloadData()
                } else {
                    print("FAILED")
                }
            }
        }.resume()
    }
}

extension MainViewController: FilmManagerProtocol {
    func addFilm(addedFilm: Film) {
        print("addedFilmaddedFilm \(addedFilm)")
    }
    func deleteFilm(deletedFilm: Film) {
        print("fastPrint \(deletedFilm)")
    }
}



