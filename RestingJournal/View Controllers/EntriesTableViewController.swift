//
//  EntriesTableViewController.swift
//  RestingJournal
//
//  Created by Ilgar Ilyasov on 1/24/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController
{
    
    // MARK: - Properties
    
    let entryController = EntryController()
    
    // MARK: - Lifecycle functions

    override func viewDidLoad()
    {
        super.viewDidLoad()
        entryController.fetchEntries
            { (error) in
                if let error = error
                {
                    NSLog("EntriesTableViewController. 1 - Error fetching entries: \(error)")
                }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return entryController.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath)
        guard let entryCell = cell as? EntryTableViewCell else { fatalError() }
        let entry = entryController.entries[indexPath.row]
        entryCell.entry = entry
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let entry = entryController.entries[indexPath.row]
            entryController.deleteEntry(entry: entry) { (error) in
                if let error = error
                {
                    NSLog("EntriesTableViewController. 2 - Error deleting entry: \(error)")
                    return
                }
                DispatchQueue.main.async
                    {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
        else if editingStyle == .insert
        {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "AddSegue"
        {
            let destionationVC = segue.destination as! EntryDetailViewController
            destionationVC.entryController = entryController
        }
        else if segue.identifier == "CellSegue"
        {
            let destinationVC = segue.destination as! EntryDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.entry = entryController.entries[indexPath.row]
            destinationVC.entryController = entryController
        }
    }
}
