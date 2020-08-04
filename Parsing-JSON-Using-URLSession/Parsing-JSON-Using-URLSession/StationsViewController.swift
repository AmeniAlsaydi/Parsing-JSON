//
//  ViewController.swift
//  Parsing-JSON-Using-URLSession
//
//  Created by Amy Alsaydi on 8/4/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class StationsViewController: UIViewController {
    
    enum Section {
        case primary
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: DataSource! //UITableViewDiffableDataSource<Section, Station>!
    
    let apiClient = APIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        fetchData() 
        // Do any additional setup after loading the view.
    }

    private func fetchData() {
        apiClient.fetchData { [weak self] (result) in // result type has two values .failure() or .success()
            
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let stations):
                DispatchQueue.main.async {
                    self?.updateSnapshot(with: stations)
                }
            }
        }
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, station) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = station.name
            cell.detailTextLabel?.text =  "Bike Capacity: \(station.capacity)"
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Station>()
        snapshot.appendSections([.primary])
        dataSource.apply(snapshot, animatingDifferences:  false)
    }

    private func updateSnapshot(with stations: [Station]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(stations, toSection: .primary)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// place in its own file
// TODO: implement in order to show the section header titles
// subclass UITableViewDiffableSource
class DataSource: UITableViewDiffableDataSource<StationsViewController.Section, Station> {
    // implement protocol
}
