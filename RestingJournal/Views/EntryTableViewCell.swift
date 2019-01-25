//
//  EntryTableViewCell.swift
//  RestingJournal
//
//  Created by Ilgar Ilyasov on 1/24/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell
{

    // MARK: - Properties
    
    var entry: Entry? { didSet { updateViews() }}
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bodyTextView: UILabel!
    
    // MARK: - Update views
    
    private func updateViews()
    {
        guard let entry = entry else { return }
        titleLabel.text = entry.title
        timeLabel.text = formatter.string(from: entry.timestamp)
        bodyTextView.text = entry.bodyText
    }
    
    // MARK: - Date formatter
    
    var formatter: DateFormatter
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}
