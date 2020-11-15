//
//  AlbumManager.swift
//  ItunesSearch
//
//  Created by Eliric on 11/11/20.
//

import Foundation


import CoreLocation
import UIKit
import CoreData

protocol AlbumManagerDelegate {
    func didUpdateItems(_ albumManager:AlbumManager, albumsViewModel:[AlbumViewModel]?)
    func didFailWithError(error:Error)
}

struct AlbumManager {
    var coreDataManager = CoreDataManager()
    var delegate:AlbumManagerDelegate?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    func fetchAlbums(){
        let urlString = "\(Constants.baseURL)term=star&country=au&media=movie&all"
        performRequest(with: urlString)
    }
    func searchAlbums(searchText:String){
        let urlString = "\(Constants.baseURL)term=\(searchText)&country=au&media=movie&all"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString:String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if(error != nil){
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let albumsViewModel = self.parseJSON(safeData){
                        self.delegate?.didUpdateItems(self, albumsViewModel: albumsViewModel)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ placeData:Data) ->[AlbumViewModel]?{
        let decoder =  JSONDecoder()
        do {
            let decodedData = try decoder.decode(AlbumData.self, from: placeData)
            var albumModels:[AlbumViewModel]?
            albumModels = decodedData.results.map(
                {
                    
                    return AlbumViewModel(result: $0)
                })
            return albumModels
        } catch {
            print(error)
            delegate?.didFailWithError(error: error)
            return []
        }
    }
    
    //MARK: - Core Data

    func fetchLastAccessedData(){
        let data = coreDataManager.fetchData(entity: LastAccessedAlbum.self)
        if(data.count > 0){
            var albumsViewModels = [AlbumViewModel]()
            for album in data as [LastAccessedAlbum]{
                let albumViewModel = AlbumViewModel(album: album)
                albumsViewModels.append(albumViewModel)
            }
            self.delegate?.didUpdateItems(self, albumsViewModel: albumsViewModels)
        }
    }
    
    func deleteLastAccessedData(){
        let repository = CoreDataRepository<LastAccessedAlbum>(managedObjectContext: context)
        let result = repository.deleteFromCoreData(entity: Constants.entityLastAccessedAlbum)
        switch result {
        case .success( _): break
            
        case .failure(let error):
//            fatalError("Failed to create book: \(error)")
            delegate?.didFailWithError(error: error)
        }
    }
    
    func saveLastAccessedData(albumViewModel:AlbumViewModel){
        let repository = CoreDataRepository<LastAccessedAlbum>(managedObjectContext: context)

        let result = repository.create()
        switch result {
        case .success(let lastAccessedAlbum):
            lastAccessedAlbum.trackName = albumViewModel.trackName
            lastAccessedAlbum.trackPrice = albumViewModel.trackPrice
            lastAccessedAlbum.primaryGenreName = albumViewModel.primaryGenreName
            lastAccessedAlbum.artworkUrl100 = albumViewModel.artworkUrl100
            lastAccessedAlbum.longDescription =  albumViewModel.longDescription
            lastAccessedAlbum.date = Date()
        case .failure(let error):
            delegate?.didFailWithError(error: error)
        }
        do{
            try self.context.save()
        }catch {
            delegate?.didFailWithError(error: error)
        }
    }
    
    func saveAlbum(albumViewModel:AlbumViewModel){
    let repository = CoreDataRepository<Albums>(managedObjectContext: context)
        
    }
}


