//
//    ShowAlbumsViewController.swift
//    NikeSampleiOS
//
//    Created by Andrew Koprowski on 6/28/20.
//    Copyright (c) 2020 Andrew Koprowski. All rights reserved.
//
//    This file was generated by the Clean Swift Xcode Templates so
//    you can apply clean architecture to your iOS and Mac projects,
//    see http://clean-swift.com
//

import UIKit

protocol ShowAlbumsDisplayLogic: class {
    func displayAlbums(viewModel: ShowAlbums.Fetch.ViewModel)
}

class ShowAlbumsViewController: UITableViewController, ShowAlbumsDisplayLogic {
    var interactor: ShowAlbumsBusinessLogic?
    var router: (ShowAlbumsRoutingLogic & ShowAlbumsDataPassing)?

    // MARK: Object lifecycle

    override init(style: UITableView.Style) {
        super.init(style: style)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = ShowAlbumsInteractor()
        let presenter = ShowAlbumsPresenter()
        let router = ShowAlbumsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.showAlbmusVCTitle
        fetchAlbums()
    }

    // MARK: Fetch Albums

    func fetchAlbums() {
        let request = ShowAlbums.Fetch.Request()
        interactor?.fetchAlbums(request: request)
    }

    func displayAlbums(viewModel: ShowAlbums.Fetch.ViewModel) {
    }
}
