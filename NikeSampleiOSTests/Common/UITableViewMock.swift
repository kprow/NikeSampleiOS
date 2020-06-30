//
//  UITableViewMock.swift
//  NikeSampleiOSTests
//
//  Created by Andrew Koprowski on 6/30/20.
//  Copyright © 2020 Andrew Koprowski. All rights reserved.
//

import UIKit
class UITableViewSpy: UITableView {
    var hasReloadDataBeenCalled = false
    override func reloadData() {
        hasReloadDataBeenCalled = true
    }
    var hasRegisterBeenCalled = false
    var observerRegisterCellReuseId: String?
    override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        hasRegisterBeenCalled = true
        observerRegisterCellReuseId = identifier
    }
    var hasDequeueBeenCalled = false
    var observeDequeuIdentifier: String?
    var injectableDequeueTableViewCellReturn = UITableViewCell()
    override func dequeueReusableCell(withIdentifier identifier: String,
                                      for indexPath: IndexPath) -> UITableViewCell {
        hasDequeueBeenCalled = true
        observeDequeuIdentifier = identifier
        return injectableDequeueTableViewCellReturn
    }
}
