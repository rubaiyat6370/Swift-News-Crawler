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
    private let urlString = "https://www.reddit.com/r/swift/.json"

    var swiftPosts = [ChildPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swift News"
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 130
        requestForNews()

    }

    func requestForNews() {
        Network.loadJSONData(urlString: urlString, type: JSONData.self) { (data, error) in
            if let jsonData = data {
                DispatchQueue.main.async {
                    self.swiftPosts = jsonData.data.children
                    self.tableView.reloadData()
                }
            }
        }
    }


}

//
// MARK: - Table View Data Source
//

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swiftPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? TableViewCell
        let news = swiftPosts[indexPath.row].data
        if news.thumbnail != nil {
            print(news.thumbnail!)
        }
        cell?.setupCell(news: news)
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailAVC = DetailArticleViewController(nibName: "DetailArticleViewController", bundle: nil)
        let article = swiftPosts[indexPath.row].data
        detailAVC.article = article
        self.navigationController?.pushViewController(detailAVC, animated: true)
    }

}

//
// MARK: - Table View Delegate
//
extension MainViewController: UITableViewDelegate {

}
