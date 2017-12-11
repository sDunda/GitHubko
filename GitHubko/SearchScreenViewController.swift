//
//  SearchScreenViewController.swift
//  GitHubko
//
//  Created by D&M on 21.09.2017..
//  Copyright © 2017. Dunja Sasic. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Dispatch
import Foundation

class SearchScreenViewController: UITableViewController, UITextFieldDelegate {

    var searchURL = String()
    var repositories = [RepoInfo]()
    var query = String()
    var searchTimer: Timer?

    lazy var searchText: UITextField = {
        let searchText = UITextField(frame: CGRect(x: 10, y: 0, width: self.view.frame.width, height: 40))

        searchText.backgroundColor = .white
        searchText.placeholder = "Search for repository here."
        searchText.addTarget(self, action: #selector(SearchScreenViewController.checkText(_:)), for: .editingChanged)

        return searchText
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"
        tableView.register(
            UINib(nibName: "TableViewCell", bundle: nil),
            forCellReuseIdentifier: "Cell")

        let header = UIView(frame: CGRect(x: 10, y: 0, width: tableView.frame.width, height: 30))
        header.backgroundColor = .white
        tableView.tableHeaderView = header

        header.addSubview(searchText)

        searchText.delegate = self
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let newView = UIView()
        newView.backgroundColor = .white
        let segmentedControl = UISegmentedControl(frame: CGRect(x: 5, y: 2,
                                                                width: tableView.frame.width - 20, height: 25))
        segmentedControl.insertSegment(withTitle: "Stars", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Forks", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Updated", at: 2, animated: false)
        segmentedControl.addTarget(self, action: #selector(SearchScreenViewController.searchTo(_:)), for: .valueChanged)
        newView.addSubview(segmentedControl)
        return newView
    }

    func checkText(_ sender: UITextField!) {
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }

        searchTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self,
                                           selector: #selector(SearchScreenViewController.searchForQuery(_:)),
                                           userInfo: searchText.text!, repeats: false)
    }

    func searchForQuery(_ timer: Timer) {
                self.findQuery()
                self.searchURL = "https://api.github.com/search/repositories?q=\(self.query)"
                self.performQuery(url: self.searchURL)
    }

    func searchTo(_ sender: UISegmentedControl!) {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")

       switch sender.selectedSegmentIndex {
        case 0:
            findQuery()
            searchURL = "https://api.github.com/search/repositories?q=\(query)&sort=stars&order=desc"
            performQuery(url: searchURL)

        case 1:
            findQuery()
            searchURL = "https://api.github.com/search/repositories?q=\(query)&sort=forks&order=desc"
            performQuery(url: searchURL)

        case 2:
            findQuery()
            searchURL = "https://api.github.com/search/repositories?q=\(query)&sort=updated&order=desc"
            performQuery(url: searchURL)

        default:
            findQuery()
            searchURL = "https://api.github.com/search/repositories?q=\(query)"
            performQuery(url: searchURL)
        }
    }

    func findQuery() {
        if let keywords = searchText.text {
            query = keywords.replacingOccurrences(of: " ", with: "+")
        }

    }

    func performQuery(url: String) {
        Alamofire
            .request(url)
            .responseJSON(
                completionHandler: { [weak self] response in
                    guard let strongSelf = self else {
                        return
                    }

                    guard response.result.isSuccess else {
                        print("Error while fetching tags: \(response.result.error!)")
                        return
                    }

                    strongSelf.repositories.removeAll()

                    if  let responseJSON = response.result.value as? [String: Any],
                        let results = responseJSON["items"] as? [[String: Any]] {
                        for i in 0..<results.count {
                            if let newRepo = RepoInfo(json:  results[i]) {
                                strongSelf.repositories.append(newRepo)
                            }
                        }
                    }
                 strongSelf.tableView.reloadData()
            })
    }
}

// MARK: UITableViewDataSoure

extension SearchScreenViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let cell = cell as? TableViewCell {
            cell.thumbnailAuthor.af_setImage(withURL: repositories[indexPath.row].thumbnailAuthor)
            cell.repositoryName?.text = repositories[indexPath.row].name
            cell.author?.text = repositories[indexPath.row].author
            cell.forkLabel?.text = String(repositories[indexPath.row].forks)
            cell.starLabel?.text = String(repositories[indexPath.row].stars)
            cell.issueLabel?.text = String(repositories[indexPath.row].issues)
            cell.watchersLabel?.text = String(repositories[indexPath.row].watchers)
            return cell
        } else {
            fatalError("Cell not registered.")
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoViewController = RepoViewController()
        repoViewController.myRepo = repositories[indexPath.row]

        navigationController?.pushViewController(repoViewController, animated: true)
    }
}
