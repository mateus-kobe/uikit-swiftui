//
//  TableViewController.swift
//  UIKit SwiftUI
//
//  Created by Mateus Kamoei on 22/07/20.
//  Copyright © 2020 Kobe. All rights reserved.
//

import UIKit
import SwiftUI

protocol TableViewControllerDelegate {
    func didSetFavorite(name: String, isFavorite: Bool)
}

class TableViewController: UITableViewController {

    struct Constants {
        static let dataFile = "movies"
        static let cellIdentifier = "Cell"
        static let title = "Movies"
    }
    
    var data: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constants.title
        
        loadMovieData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.cellIdentifier)
        }
        
        let movie = data[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = "\(movie.year)"
        
        if movie.isFavorite {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = data[indexPath.row]
        let movieDetail = MovieDetail(delegate: self).environmentObject(movie)
        let detail = UIHostingController(rootView: movieDetail)
        detail.modalPresentationStyle = .popover
        navigationController?.present(detail, animated: true, completion: nil)
    }
}

private extension TableViewController {
    
    func loadMovieData() {
        if let jsonData = Utils.readLocalFile(forName: Constants.dataFile) {
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] {
                    for dict in jsonArray {
                        let movie = Movie(dict: dict)
                        data.append(movie)
                    }
                }
                tableView.reloadData()
            } catch {
                print("decode error")
            }
        }
    }
}

extension TableViewController: TableViewControllerDelegate {
    
    func didSetFavorite(name: String, isFavorite: Bool) {
        for i in 0..<data.count {
            if data[i].title == name {
                data[i].isFavorite = isFavorite
                tableView.reloadRows(at: [IndexPath(row: i, section: 0)], with: .automatic)
                break
            }
        }
    }
}
