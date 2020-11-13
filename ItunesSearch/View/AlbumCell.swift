//
//  AlbumCell.swift
//  ItunesSearch
//
//  Created by Eliric on 11/11/20.
//

import Foundation
import UIKit
import Kingfisher

class AlbumCell:UITableViewCell{
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var lblTrackName: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    var albumViewModel: AlbumViewModel! {
        didSet {
            lblTrackName?.text = albumViewModel.trackName
            lblGenre?.text =  albumViewModel.primaryGenreName
            lblPrice?.text =  "Price: \(albumViewModel.trackPrice)"
        }
    }
    override func prepareForReuse() {
        albumImage.kf.cancelDownloadTask()
    }
    
//    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//        super.setHighlighted(highlighted, animated: animated)
//        self.backgroundColor = isHighlighted ? .highlightColor : .yellow
//    }
    
    func setUpCells(albumViewModel:AlbumViewModel){
        let url = URL(string: albumViewModel.artworkUrl100)!
        let image = UIImage(named: Constants.unknownString)
        albumImage.contentMode = .scaleAspectFit
        albumImage.kf.setImage(with: url, placeholder: image)
        lblTrackName?.text = albumViewModel.trackName 
        lblGenre?.text =  albumViewModel.primaryGenreName
        lblPrice?.text =  "Price: \(albumViewModel.trackPrice)"
        self.backgroundColor = .highlightColor//isHighlighted ? .highlightColor : .white
    }

}
