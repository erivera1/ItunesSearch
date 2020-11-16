//
//  DetailViewController.swift
//  ItunesSearch
//
//  Created by Eliric on 11/11/20.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var albumViewModel:AlbumViewModel?
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    var albumManager = AlbumManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        albumManager.delegate = self
        if let albumView = albumViewModel{
            // DELETE THE LAST ITEM IN CORE DATA
            albumManager.deleteData(entity: Constants.entityLastAccessedAlbum)
            //INSERT NEW ONE.
            albumManager.saveLastAccessedData(albumViewModel: albumView)
            configureView(albumView: albumView)
        }else{
            //fetch from core data on initial login
            albumManager.fetchLastAccessedData()
        }
    }

    func configureView(albumView:AlbumViewModel){
        textView.text = albumView.longDescription
        let image = UIImage(named: Constants.noImage)
        if(albumView.artworkUrl100 == Constants.noImage){
            albumImageView.image = image
        }else{
            let url = URL(string: albumView.artworkUrl100)!
            albumImageView.kf.indicatorType = .activity
            albumImageView.contentMode = .scaleAspectFit
            albumImageView.kf.setImage(with: url, placeholder: image)
        }
        
    }
}

//MARK: - AlbumManagerDelegate
extension DetailViewController:AlbumManagerDelegate{
    func didUpdateItems(_ albumManager: AlbumManager, albumsViewModel: [AlbumViewModel]?) {
        if let albums = albumsViewModel{
            DispatchQueue.main.async {
                if(albums.count > 0){
                    let album = albums[0]
                    self.configureView(albumView: album)
                    self.navigationItem.title = Date().intervalString(since: album.date)
                }
            }
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.presentAlert(message: error.localizedDescription)
        }
    }
}
