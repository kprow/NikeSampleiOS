//
//    ShowAlbumsRouter.swift
//    NikeSampleiOS
//
//    Created by Andrew Koprowski on 6/28/20.
//    Copyright (c) 2020 Andrew Koprowski. All rights reserved.
//
//    This file was generated by the Clean Swift Xcode Templates so
//    you can apply clean architecture to your iOS and Mac projects,
//    see http://clean-swift.com
//

protocol ShowAlbumsRoutingLogic {
    func routeToAlbumDetails()
}

protocol ShowAlbumsDataPassing {
    var dataStore: ShowAlbumsDataStore? { get }
}

class ShowAlbumsRouter: ShowAlbumsRoutingLogic, ShowAlbumsDataPassing {
    weak var viewController: ShowAlbumsViewController?
    var dataStore: ShowAlbumsDataStore?

    // MARK: Routing

    func routeToAlbumDetails() {
        let detailsVC = AlbumDetailsViewController()
        guard var destination = detailsVC.interactor as? AlbumDetailsDataStore,
            let source = dataStore else {
            return
        }
        let row = viewController?.tableView.indexPathForSelectedRow?.row ?? 0
        guard source.albums.indices.contains(row) else {
            return
        }
        destination.album = source.albums[row]
        viewController?.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
