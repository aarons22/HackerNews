//
//  DataManager.swift
//  HackerNews
//
//  Created by Aaron Sapp on 2/13/19.
//  Copyright © 2019 Aaron Sapp. All rights reserved.
//

import Foundation
import RxSwift

class DataManager: NSObject {

    static let shared = DataManager()

    let items = Variable<Set<Item>>([])
}
