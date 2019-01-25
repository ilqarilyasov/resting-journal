//
//  EntryDetailViewController.swift
//  RestingJournal
//
//  Created by Ilgar Ilyasov on 1/24/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var entry: Entry? { didSet { updateViews() }}
    var entryController: EntryController?
    
    // MARK: - Outlets

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Actions
    
    @IBAction func saveBarButtonTapped(_ sender: Any)
    {
        guard let entryController = entryController,
            let text = titleTextField.text,
            let bodyText = bodyTextView.text else { return }
        
        if let entry = entry
        {
            entryController.updateEntry(entry: entry, title: text, bodyText: bodyText)
            { (error) in
                NSLog("EntryDetailViewController. 1 - Error updating the entry: \(String(describing: error))")
            }
        }
        else
        {
            entryController.createEntry(withTitle: text, bodyText: bodyText)
            { (error) in
                NSLog("EntryDetailViewController. 2 - Error creating an entry: \(String(describing: error))")
            }
        }
    }
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        updateViews()
        
    }
    
    // MARK: - Update views
    
    private func updateViews()
    {
        guard isViewLoaded else { return }
        
        if let entry = entry
        {
            title = entry.title
            titleTextField.text = entry.title
            bodyTextView.text = entry.bodyText
        }
        else
        {
            title = "Create an entry"
        }
    }
}
