//
//    ShowAlbumsInteractor.swift
//    NikeSampleiOS
//
//    Created by Andrew Koprowski on 6/28/20.
//    Copyright (c) 2020 Andrew Koprowski. All rights reserved.
//
//    This file was generated by the Clean Swift Xcode Templates so
//    you can apply clean architecture to your iOS and Mac projects,
//    see http://clean-swift.com
//

protocol ShowAlbumsBusinessLogic {
    func fetchAlbums(request: ShowAlbums.Fetch.Request)
}

protocol ShowAlbumsDataStore {
}

class ShowAlbumsInteractor: ShowAlbumsBusinessLogic, ShowAlbumsDataStore {
    /// Dependency - To pass along entity models to be converted into a presentation(view models) object for the view.
    var presenter: ShowAlbumsPresentationLogic?
    /// Dependency - A worker object to handle the calling of the api to fetch data that will become albums
    var worker: ShowAlbumsWorkerProtocol? = ShowAlbumsWorker()

    // MARK: Fetch Albums

    func fetchAlbums(request: ShowAlbums.Fetch.Request) {
        let response = ShowAlbums.Fetch.Response()
        presenter?.presentAlbums(response: response)
    }
}
