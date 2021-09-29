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
    
    private var ref = Database.database().reference()
    var fBProvider = FBProvider()
//    let sourse = JSONService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(dismissSelf))
        filmCollectionView.delegate =  filmCollectionView
        filmCollectionView.dataSource = filmCollectionView
        filterCollectionView.delegate =  filterCollectionView
        filterCollectionView.dataSource = filterCollectionView
        filmCollectionView.filmDelegate = self
        setupLayout()
        registerCell()
        fBProvider.getJSONFilms()
        fBProvider.getJSONGenere()
            
        filmCollectionView.tapCallback = { [weak self] currentFilm in
            self?.navigationController?.pushViewController(SinglePageViewController(film: currentFilm), animated: true)
            }
        
        filterCollectionView.tapCallback = {  currentGenre in
            var sortFilms = [Film]()
            if currentGenre.id == -2 {
                sortFilms = self.filterCollectionView.sortedFilms
//                self.filmCollectionView.reloadData()
            } else if currentGenre.id == -1 {
               sortFilms = self.filmCollectionView.wishesFilm
//                self.filmCollectionView.reloadData()
            } else {
                for currentFilm in self.filterCollectionView.sortedFilms {
                    for genreItem in currentFilm.genreIds {
                        if currentGenre.id == genreItem {
                            sortFilms.append(currentFilm)
                        }
                    }
                }
            }
            self.filmCollectionView.films = sortFilms
            self.filmCollectionView.reloadData()
            self.filmCollectionView.scrollToItem(at: IndexPath(index: 0), at: .top , animated: true)
        }
        
        fBProvider.getFBFilms() { [weak self] films in
            self?.filmCollectionView.films = films
            self?.filmCollectionView.reloadData()
            self?.filterCollectionView.sortedFilms = films
            self?.filterCollectionView.reloadData()
        }
        
        fBProvider.getFBGenre() { [weak self] currentGenre in
            self?.filterCollectionView.generes = currentGenre
            self?.filterCollectionView.generes.append(Genre(id: -2, name: "All"))
            self?.filterCollectionView.generes.append(Genre(id: -1, name: "Favorites"))
            self?.filterCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        getFBFilms() { [weak self] films in
//            self?.filmCollectionView.films = films
////            self?.filmCollectionView.reloadData()
//            self?.filterCollectionView.sortedFilms = films
//            self?.filterCollectionView.reloadData()
//        }
//
//        getFBGenre() { [weak self] currentGenre in
//            self?.filterCollectionView.generes = currentGenre
//            self?.filterCollectionView.generes.append(Genre(id: -2, name: "All"))
//            self?.filterCollectionView.generes.append(Genre(id: -1, name: "Favorites"))
//            self?.filterCollectionView.reloadData()
//        }
    }
    
    func setupLayout() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        navigationItem.setHidesBackButton(true, animated: false)
//        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Movies"
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
    
//    private func getFBFilms(completion: @escaping (([Film]) -> Void)) {
//        self.ref.child("results").observeSingleEvent(of: .value, with: { snapshot in
//            if snapshot.exists() {
//            guard let data = try? JSONSerialization
//                    .data(withJSONObject: snapshot.value as Any, options: []),
//                  let film = try? JSONDecoder().decode([Film].self, from: data) else {
//                completion([])
//                return
//            }
//                let list = film.map { $0 }
//            completion(list)
////                print("list  ----  \(list)")
//            } else {
//                completion([])
//            }
//        })
//    }
//
//    private func getFBGenre(completion: @escaping (([Genre]) -> Void)) {
//        self.ref.child("genres").observeSingleEvent(of: .value, with: { snapshot in
//            if snapshot.exists() {
////                print("fastPrintsnapshotsnapshot \(snapshot)")
//            guard let data = try? JSONSerialization
//                    .data(withJSONObject: snapshot.value as Any, options: []),
//                  let genre = try? JSONDecoder().decode([Genre].self, from: data) else {
//                completion([])
//                return
//            }
//                let list = genre.map { $0 }
//            completion(list)
////                print("list  ----  \(list)")
//            } else {
//                completion([])
//            }
//        })
//    }
    
//    func getJSONFilms() {
//        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=42ebca47d17dba363b4bf75d08a1a301"
//        guard let url = URL(string: urlString) else {return}
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            DispatchQueue.main.async {
//                if let  error = error {
//                    print(error)
//                    return
//                }
//                guard let data = data else {return}
////                let someString = String(data: data, encoding: .utf8)
//                if let filmResponse = try? JSONDecoder().decode(Response.self, from: data) {
////                    self.filmCollectionView.films = filmResponse.results
////                    self.filmCollectionView.reloadData()
////                    self.filterCollectionView.sortedFilms = filmResponse.results
////                    self.filterCollectionView.reloadData()
//
//                    let rawFilms = try? FirebaseEncoder().encode(filmResponse.results)
//                    let childUpdates = ["results" : rawFilms]
//                    self.ref.updateChildValues(childUpdates as [AnyHashable : Any])
//                } else {
//                    print("FAILED")
//                }
//            }
//        }.resume()
//    }
    
//    func getJSONGenere() {
//        let urlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=42ebca47d17dba363b4bf75d08a1a301"
//        guard let url = URL(string: urlString) else {return}
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            DispatchQueue.main.async {
//                if let  error = error {
//                    print(error)
//                    return
//                }
//                guard let data = data else {return}
////                let genereJSON = String(data: data, encoding: .utf8)
//                if let filterResponse = try? JSONDecoder().decode(ResponseGenre.self, from: data) {
////                    self.filterCollectionView.generes = filterResponse.genres
////                    self.filterCollectionView.reloadData()
//
//                    let rawGeres = try? FirebaseEncoder().encode(filterResponse.genres)
//                    let childUpdates = ["genres" : rawGeres]
//                    self.ref.updateChildValues(childUpdates as [AnyHashable : Any])
//                } else {
//                    print("FAILED")
//                }
//            }
//        }.resume()
//    }
}

extension MainViewController: FilmManagerProtocol {
    func addFilm(addedFilm: Film) {
        print("addedFilmaddedFilm \(addedFilm)")
    }
    func deleteFilm(deletedFilm: Film) {
        print("fastPrint \(deletedFilm)")
    }
}



