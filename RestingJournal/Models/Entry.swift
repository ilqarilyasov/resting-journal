//
//  Entry.swift
//  RestingJournal
//
//  Created by Ilgar Ilyasov on 1/24/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Entry: Equatable, Codable
{
    var title: String
    var bodyText: String
    let timestamp: Date
    let identifier: String
    
    init(title: String, bodyText: String)
    {
        self.title = title
        self.bodyText = bodyText
        self.timestamp = Date()
        self.identifier = UUID().uuidString
    }
}
