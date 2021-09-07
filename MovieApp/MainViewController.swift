//
//  MainViewController.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 06.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var filmCollectionView: FilmCollectionView!
    var films = ["1","1","1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        genreCollectionView.delegate =  self
//        genreCollectionView.dataSource = self
        filmCollectionView.delegate =  filmCollectionView
        filmCollectionView.dataSource = filmCollectionView
        
        let connectedDeviceNIB = UINib(nibName: "CustomCellCollectionViewCell", bundle: nil)
        filmCollectionView.register(connectedDeviceNIB, forCellWithReuseIdentifier: "CustomCellCollectionViewCell")
    }
}
