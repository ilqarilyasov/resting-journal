//
//  EntryController.swift
//  RestingJournal
//
//  Created by Ilgar Ilyasov on 1/24/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class EntryController
{
    
    // MARK: - Properties
    
    private(set) var entries = [Entry]()
    private let baseURL = URL(string: "https://journal-b5918.firebaseio.com/")!
    
    // MARK: - REST functions
    
    func put(entry: Entry, completion: @escaping (Error?) -> Void)
    {
        
        let entryURL = baseURL.appendingPathComponent(entry.identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: entryURL)
        request.httpMethod = "PUT"
        
        do
        {
            let encoder = JSONEncoder()
            let encodedEntry = try encoder.encode(entry)
            request.httpBody = encodedEntry
        }
        catch
        {
            NSLog("EntryController. 1 - Error encoding entry: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request)
        { (_, _, error) in
            if let error = error {
                NSLog("EntryController. 2 - Error performing data task: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
}
