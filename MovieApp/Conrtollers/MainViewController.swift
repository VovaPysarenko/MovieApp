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
    var films = ["1","1","1"]
    var respons: [Response] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmCollectionView.delegate =  filmCollectionView
        filmCollectionView.dataSource = filmCollectionView
        filterCollectionView.delegate =  filterCollectionView
        filterCollectionView.dataSource = filterCollectionView
        
        let connectedFilmNIB = UINib(nibName: "CustomCellCollectionViewCell", bundle: nil)
        filmCollectionView.register(connectedFilmNIB, forCellWithReuseIdentifier: "CustomCellCollectionViewCell")

        let connectedFilterNIB = UINib(nibName: "FilterCollectionCell", bundle: nil) 
        filterCollectionView.register(connectedFilterNIB, forCellWithReuseIdentifier: "FilterCollectionCell")
        
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=42ebca47d17dba363b4bf75d08a1a301"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let  error = error {
                 
                    return
                }
                guard let data = data else {return}
         
                print("responseresponse")
                let someString = String(data: data, encoding: .utf8)
                let film = try? JSONDecoder().decode(Film.self, from: data)
                
                print("film \(film)")
                print(someString ?? "no data")
            }
        }.resume()
       
    }
}
