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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var delegate:AlbumManagerDelegate?

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
                    fetchRecords()
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
            deleteData(entity: Constants.entityNameRecords)
            albumModels = decodedData.results.map(
                {
                    let albumViewModel = AlbumViewModel(result: $0)
                    saveRecords(albumViewModel: albumViewModel)
                    return albumViewModel
                })
            return albumModels
        } catch {
            print(error)
            delegate?.didFailWithError(error: error)
            return []
        }
    }
    
    //MARK: - Core Data
    func deleteData(entity:String){
        let coreDataManager = CoreDataManager(managedObjectContext: context)
        let result = coreDataManager.delete(entity: entity)
        switch result {
        case .success( _): break

        case .failure(let error):
            delegate?.didFailWithError(error: error)
        }
    }
    
    //LastAccessedAlbum
    func fetchLastAccessedData(){
        let coreDataManager = CoreDataManager(managedObjectContext: context)
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
    
    func saveLastAccessedData(albumViewModel:AlbumViewModel){

        let repository = CoreDataManager<LastAccessedAlbum>(managedObjectContext: context)
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
    
    //Records
    func saveRecords(albumViewModel:AlbumViewModel){
        let repository = CoreDataManager<Records>(managedObjectContext: context)
        let result = repository.create()
        switch result {
        case .success(let records):
            records.trackName = albumViewModel.trackName
            records.trackPrice = albumViewModel.trackPrice
            records.primaryGenreName = albumViewModel.primaryGenreName
            records.artworkUrl100 = albumViewModel.artworkUrl100
            records.longDescription =  albumViewModel.longDescription
            records.date = Date()
        case .failure(let error):
            delegate?.didFailWithError(error: error)
        }
        do{
            try self.context.save()
        }catch {
            delegate?.didFailWithError(error: error)
        }
    }
    
    func fetchRecords(){
        let coreDataManager = CoreDataManager(managedObjectContext: context)
        let data = coreDataManager.fetchData(entity: Records.self)
        if(data.count > 0){
            var albumsViewModels = [AlbumViewModel]()
            for record in data as [Records]{
                let albumViewModel = AlbumViewModel(record: record)
                albumsViewModels.append(albumViewModel)
            }
            self.delegate?.didUpdateItems(self, albumsViewModel: albumsViewModels)
        }
    }
}


