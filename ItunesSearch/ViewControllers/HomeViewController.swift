//
//  ViewController.swift
//  ItunesSearch
//
//  Created by Eliric on 11/11/20.
//

import UIKit

class HomeViewController: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private let refreshControl = UIRefreshControl()
    let cellIdentifier = "CellId"
    var albumManager = AlbumManager()
    var albums = [AlbumViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialConfiguration()
    }
    
    func initialConfiguration(){
        searchTextField.delegate = self
        albumManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.255, green:0.0, blue:0.0, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data ...", attributes: nil)
        refreshData(self)
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        refreshControl.beginRefreshing()
        searchTextField.endEditing(true)
    }
    
    @objc private func refreshData(_ sender: Any) {
        // Fetch Data
        albumManager.searchAlbums(searchText: "star")
    }
    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let album = albums[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.albumViewModel = album
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AlbumCell
        let album = albums[indexPath.row]
        cell.setUpCells(albumViewModel: album)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
}

//MARK: - UITextfieldDelegate

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //DO VALIDATIONS HERE
        if(textField.text != ""){
            return true
        }else{
            textField.placeholder = "Enter Search"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let searchString = searchTextField.text{
            refreshControl.beginRefreshing()
            albumManager.searchAlbums(searchText: searchString)
        }
        searchTextField.text = ""
    }
}
//MARK: - AlbumManagerDelegate

extension HomeViewController:AlbumManagerDelegate{
    func didUpdateItems(_ albumManager: AlbumManager, albumsViewModel: [AlbumViewModel]?) {
        if let albums = albumsViewModel{
            self.albums = albums
            //reload table in main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
        self.presentAlert(message: error.localizedDescription)
    }
}

