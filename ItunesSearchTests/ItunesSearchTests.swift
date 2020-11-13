//
//  ItunesSearchTests.swift
//  ItunesSearchTests
//
//  Created by Eliric on 11/13/20.
//

import XCTest
@testable import ItunesSearch

class ItunesSearchTests: XCTestCase {

    func testAlbumViewModel(){
        let result = Results()
        result.trackName = "The Godfather"
        result.primaryGenreName  = "Action"
        result.artworkUrl100 = ""
        result.trackPrice = 100.0
        let albumViewModel = AlbumViewModel(result: result)
        XCTAssertEqual("Metallica", albumViewModel.trackName)
    }
    
    func testEmptyTitle(){
        let result = Results()
        result.trackName = ""
        result.primaryGenreName  = "Action"
        result.artworkUrl100 = ""
        result.trackPrice = 100.0
        let albumViewModel = AlbumViewModel(result: result)
        XCTAssertEqual("Unknown", albumViewModel.trackName)
    }
    
    func testEmptyIcon(){
        let result = Results()
        result.trackName = "The Godfather"
        result.primaryGenreName  = "Action"
        result.artworkUrl100 = ""
        result.trackPrice = 100.0
        let albumViewModel = AlbumViewModel(result: result)
        XCTAssertEqual(Constants.noImage, albumViewModel.artworkUrl100)
    }
}
