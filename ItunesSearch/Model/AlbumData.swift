//
//  Album.swift
//  ItunesSearch
//
//  Created by Eliric on 11/11/20.
//

import Foundation

class AlbumData: Codable {
    var resultCount = 0
    var results = [Results]()
}

class Results:Codable {
  var artistName: String? = ""
  var trackName: String? = ""
  var artworkUrl100:String? = ""
  var artworkUrl512:String? = ""
  var trackPrice:Double? = 0
  var primaryGenreName: String? = ""
  var longDescription: String? = ""
  var name:String {
    return trackName ?? ""
  }
}
