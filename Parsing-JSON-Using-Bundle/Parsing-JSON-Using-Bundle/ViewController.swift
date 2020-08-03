//
//  ViewController.swift
//  Parsing-JSON-Using-Bundle
//
//  Created by Amy Alsaydi on 8/3/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum Section {
        case main // table view has only one section
    }

    @IBOutlet weak var tableView: UITableView!
    
    typealias DataSource = UITableViewDiffableDataSource<Section, President>
    
    // both the SectionItemID and the itemIdentifier have to conform to hashable protocol
    private var dataSource: DataSource!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        configureDataSource()
        fetchPresidents()
    }


    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableview, indexpath, president) -> UITableViewCell? in
            // configure cell
            let cell = tableview.dequeueReusableCell(withIdentifier: "presidentCell", for: indexpath)
            cell.textLabel?.text = president.name
            cell.detailTextLabel?.text = "\(president.number)"
            return cell
        })
        
        // setup intial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, President>()
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: false)
         
    }
    
    private func fetchPresidents() {
        var presidents: [President] = []
        do {
            presidents = try Bundle.main.parseJSON(with: "presidents")
        } catch {
            print("error: \(error)")
            // TODO: present alert
        }
        
        // update the snapshot
        var snapshot = dataSource.snapshot() // quary dataSource the current snapshot
        snapshot.appendItems(presidents, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

