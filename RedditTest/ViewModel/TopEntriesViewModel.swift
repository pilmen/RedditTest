//
//  TopEntriesViewModel.swift
//  RedditTest
//
//  Created by Pavlo Naumenko on 4/11/19.
//  Copyright © 2019 Pavlo Naumenko. All rights reserved.
//

import Foundation

class TopEntriesViewModel {
    private var topEntries: TopEntries?
    var topEntriesList: [TopEntriesDataChildren] = []
    var loading: Bool = false
    
    func getListOfTopEntries(completion: @escaping (Result<TopEntries, Error>) -> Void) {
        loading = true
        var parameters: Parameters = [:]
        if let after = topEntries?.data.after {
            parameters["after"] = after
        }
        APIRequest.request(HTTPRequest.getListOfTopItems(parameters), decodeTo: TopEntries.self) {[unowned self] (result) in
            self.loading = false
            switch result {
            case .success(let itemsContainer):
                self.topEntries = itemsContainer
                self.topEntriesList.append(contentsOf: itemsContainer.data.children)
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func clear() {
        topEntries = nil
        topEntriesList.removeAll()
    }
    
    func hasAfter() -> Bool {
        return topEntries?.data.after == nil ? false:true
    }
    
    func entryForIndexPath(indexPath: IndexPath) -> TopEntriesDataChildren {
        return topEntriesList[indexPath.row]
    }
    
    var numberOfItems: Int {
        return topEntriesList.count
    }
}
