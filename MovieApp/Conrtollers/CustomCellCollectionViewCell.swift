//
//  CustomCellCollectionViewCell.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 07.09.2021.
//

import UIKit

class CustomCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    var tapCall: (() -> Void)?
    var addFilmTapped: (() -> Void)?
    var deleteFilmTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    @IBAction func addFilmAction(_ sender: Any) {
        addFilmTapped?()
    }
    
    @IBAction func deleteFilm(_ sender: Any) {
        deleteFilmTapped?()
    }
    
    @objc func tapped() {
        tapCall?()
    }
}
