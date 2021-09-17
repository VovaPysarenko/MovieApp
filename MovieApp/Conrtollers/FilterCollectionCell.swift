//
//  FilterCollectionViewCollectionViewCell.swift
//  MovieApp
//
//  Created by Volodymyr Pysarenko on 07.09.2021.
//

import UIKit

class FilterCollectionCell: UICollectionViewCell {
    
    var tapCall: (() -> Void)?
    var filterFilmTapped: (() -> Void)?

    @IBOutlet weak var filterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapped() {
        tapCall?()
    }

}

