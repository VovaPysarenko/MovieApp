//
//  SinglePageViewController.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 09.09.2021.
//

import UIKit
import Kingfisher

class SinglePageViewController: UIViewController {
    
    @IBOutlet weak var singleImg: UIImageView!
    @IBOutlet weak var singlDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var film: Film
    init(film: Film) {
        self.film = film
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(film.posterPath)")
        singleImg.kf.setImage(with: url)
        singlDescriptionLabel.text = film.title
        descriptionTextView.text = film.overview  
        
    }

}
