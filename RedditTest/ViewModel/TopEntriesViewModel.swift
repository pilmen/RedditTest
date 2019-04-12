//
//  TopEntriesViewModel.swift
//  RedditTest
//
//  Created by Pavlo Naumenko on 4/11/19.
//  Copyright © 2019 Pavlo Naumenko. All rights reserved.
//

import Foundation

class TopEntriesViewModel {
    var topEntriesList: [TopEntriesDataChildren]?
    
    func getListOfTopEntries(completion: (Result<TopEntries, Error>) -> Void) {
        APIRequest.request(HTTPRequest.getListOfTopItems, decodeTo: TopEntries.self) {[unowned self] (result) in
            switch result {
            case .success(let items):
                self.topEntriesList = items.data.children
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var numberOfItems: Int {
        return topEntriesList?.count ?? 0
    }
}
