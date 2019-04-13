//
//  TopEntries.swift
//  RedditTest
//
//  Created by Pavlo Naumenko on 4/11/19.
//  Copyright © 2019 Pavlo Naumenko. All rights reserved.
//

import Foundation

struct TopEntries: Codable {
    let kind: String
    let data: TopEntriesData
}

struct TopEntriesData: Codable {
    let modhash: String
    let dist: Int
    let children: [TopEntriesDataChildren]
    let after: String?
    let before: String?
}

struct TopEntriesDataChildren: Codable {
    let kind: String
    let data: TopEntriesChildrenData
}

struct TopEntriesChildrenData: Codable {
    let author_fullname: String
    let title: String
    let num_comments: UInt
    let thumbnail: String
    //let preview:
}

//struct ImagesPreview {
//    <#fields#>
//}
