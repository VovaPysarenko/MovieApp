//
//  FBProvider.swift
//  MovieApp
//
//  Created by Vladislav Nikolaychuk on 28.09.2021.
//

import Foundation
import Firebase
import CodableFirebase

//protocol FBProviderProtocol {
//    func getJSONGenere() -> Void
//    func getJSONFilms() -> Void
//}

class FBProvider {
    
    private var ref = Database.database().reference()

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
//                    self.filterCollectionView.generes = filterResponse.genres
//                    self.filterCollectionView.reloadData()

                    let rawGeres = try? FirebaseEncoder().encode(filterResponse.genres)
                    let childUpdates = ["genres" : rawGeres]
                    self.ref.updateChildValues(childUpdates as [AnyHashable : Any])
                } else {
                    print("FAILED")
                }
            }
        }.resume()
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
//                    self.filmCollectionView.films = filmResponse.results
//                    self.filmCollectionView.reloadData()
//                    self.filterCollectionView.sortedFilms = filmResponse.results
//                    self.filterCollectionView.reloadData()

                    let rawFilms = try? FirebaseEncoder().encode(filmResponse.results)
                    let childUpdates = ["results" : rawFilms]
                    self.ref.updateChildValues(childUpdates as [AnyHashable : Any])
                } else {
                    print("FAILED")
                }
            }
        }.resume()
    }
    
    func getFBFilms(completion: @escaping (([Film]) -> Void)) {
        self.ref.child("results").observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
            guard let data = try? JSONSerialization
                    .data(withJSONObject: snapshot.value as Any, options: []),
                  let film = try? JSONDecoder().decode([Film].self, from: data) else {
                completion([])
                return
            }
                let list = film.map { $0 }
            completion(list)
//                print("list  ----  \(list)")
            } else {
                completion([])
            }
        })
    }
    
    func getFBGenre(completion: @escaping (([Genre]) -> Void)) {
        self.ref.child("genres").observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
//                print("fastPrintsnapshotsnapshot \(snapshot)")
            guard let data = try? JSONSerialization
                    .data(withJSONObject: snapshot.value as Any, options: []),
                  let genre = try? JSONDecoder().decode([Genre].self, from: data) else {
                completion([])
                return
            }
                let list = genre.map { $0 }
            completion(list)
//                print("list  ----  \(list)")
            } else {
                completion([])
            }
        })
    }
}
