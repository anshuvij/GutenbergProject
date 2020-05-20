//
//  BookMangerDelegate.swift
//  Gutenberg Project
//
//  Created by Anshu Vij on 5/19/20.
//  Copyright © 2020 Anshu Vij. All rights reserved.
//

import Foundation
protocol BookMangerDelegate {
    func didUpdateBook(_ bookManager : BookManager, _ books: [Books], _ nextUrl : BookModel)
    func didFailWithError(error : Error)
}
