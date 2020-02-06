//
//  ViewController.swift
//  SwiftNewsCrawler
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-05.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let urlString = "https://www.reddit.com/r/swift/.json"

    var swiftPosts: [ChildPost]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swift News"
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        requestForNews()

    }

    func requestForNews() {
        Network.loadJSONData(urlString: urlString, type: JSONData.self) { (data, error) in
            if let jsonData = data {
                self.swiftPosts = jsonData.data.children
            }
        }
    }


}

//
// MARK: - Table View Data Source
//

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? TableViewCell
        cell?.headlineLabel.text = "This is a big head line testing label width sdmbs, vn,j"
        //cell?.imageView?.image = UIImage(systemName: "star")
        cell?.thumbnailHeightConstraint.constant = 0
        cell?.thumbnailBottomConstraint.constant = 0
        return cell!
    }


}

//
// MARK: - Table View Delegate
//
extension MainViewController: UITableViewDelegate {

}
