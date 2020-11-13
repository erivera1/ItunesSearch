//
//  AlbumViewModel.swift
//  ItunesSearch
//
//  Created by Eliric on 11/11/20.
//

import Foundation

struct AlbumViewModel {
    let trackName:String
    let artworkUrl100:String
    let trackPrice:Double
    let primaryGenreName: String
    let longDescription: String
    let date:Date?
    
    init(result:Results?) {
        self.trackPrice = result?.trackPrice ?? 0.0
        var trackName = result?.trackName
        if(trackName == ""){
            trackName = Constants.unknownString
        }
        
        var artworkUrl100 = result?.artworkUrl100
        if(artworkUrl100 == ""){
            artworkUrl100 = Constants.noImage
        }
        
        self.trackName = trackName ?? "No  Name"
        self.artworkUrl100 = artworkUrl100 ?? Constants.noImage
        self.longDescription = result?.longDescription ?? "No  description"
        self.primaryGenreName = result?.primaryGenreName ?? "No Primary genre"
        self.date = Date()
    }
    
    init(album:LastAccessedAlbum?) {
        self.trackPrice = album?.trackPrice ?? 0.0
        var trackName = album?.trackName
        if(trackName == ""){
            trackName = Constants.unknownString
        }
        var artworkUrl100 = album?.artworkUrl100
        if(artworkUrl100 == ""){
            artworkUrl100 = Constants.noImage
        }
        self.trackName = trackName ?? "No  Name"
        self.artworkUrl100 = artworkUrl100 ?? Constants.noImage
        self.longDescription = album?.longDescription ?? "No  description"
        self.primaryGenreName = album?.primaryGenreName ?? "No Primary genre"
        self.date = album?.date
    }
}
