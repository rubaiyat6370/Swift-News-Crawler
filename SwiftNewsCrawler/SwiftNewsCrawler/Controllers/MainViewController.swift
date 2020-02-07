//
//  ViewController.swift
//  SwiftNewsCrawler
//
//  Created by Rubaiyat Jahan Mumu on 2020-02-05.
//  Copyright © 2020 Rubaiyat Jahan Mumu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var tableView: UITableView!

    //
    // MARK: - Constants
    //
    private let urlString = "https://www.reddit.com/r/swift/.json"
    private let tableViewHeightConstant: CGFloat = 200
    private let navBarTitleFont: CGFloat = {
        if AppUtils.deviceType == "iPhone" {
            return 14
        } else {
            return 21
        }
    }()
    var activityView: UIActivityIndicatorView?
    var posts = [SwiftNews]()
    var provider: DataProviderService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swift News"

        provider = DataProviderService(fetcher: DataFetcher.shared)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: navBarTitleFont * Constants.widthConstant)]
        setupTableView()
        requestForNews()

    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = tableViewHeightConstant
    }

    func requestForNews() {
        provider.decodeDataFrom(urlString: urlString, type: JSONData.self) { (data, error) in
            if let redditData = data {
                let swiftPosts = redditData.data.children
                self.posts = swiftPosts.map({ (child) -> SwiftNews in
                    child.data
                })
                self.posts.sort { (lhs, rhs) -> Bool in
                    lhs.upVote > rhs.upVote
                }
                DispatchQueue.main.async {
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
        print("Count: \(posts.count)")
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? TableViewCell
        let news = posts[indexPath.row]
        cell?.setupCell(news: news)
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailAVC = DetailArticleViewController(nibName: "DetailArticleViewController", bundle: nil)
        let article = posts[indexPath.row]
        detailAVC.article = article
        self.navigationController?.pushViewController(detailAVC, animated: true)
    }

}

//
// MARK: - Table View Delegate
//
extension MainViewController: UITableViewDelegate {

}
