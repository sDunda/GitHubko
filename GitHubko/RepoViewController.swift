//
//  RepoViewController.swift
//  GitHubko
//
//  Created by D&M on 22.09.2017..
//  Copyright © 2017. Dunja Sasic. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {

    var myRepo: RepoInfo!

    @IBOutlet weak var watchers: UILabel!
    @IBOutlet weak var imageAuthor: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoAuthor: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var created: UILabel!
    @IBOutlet weak var updated: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var linkButton: UIButton!

    @IBAction func webLink(_ sender: UIButton) {
        if let url = self.myRepo?.repoURL {
            let webViewController = WebView(url: url)
            navigationController?.pushViewController(webViewController, animated: true)
            self.navigationItem.title = myRepo.name
        }
    }

    convenience init(myRepo: RepoInfo) {
        self.init()
        self.myRepo = myRepo
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = myRepo.name

        repoName.text = myRepo.name
        let imageURL = myRepo.thumbnailAuthor
        let data = try? Data(contentsOf: imageURL)
        imageAuthor.image = UIImage(data: data!)
        repoAuthor.text = myRepo.author
        language.text = myRepo.language
        created.text = myRepo.created
        updated.text = myRepo.updated
        watchers.text = String(myRepo.watchers)
        score.text = String(myRepo.score)

        linkButton.setTitle("Go to repository.", for: .normal)
        linkButton.isHidden = true
        self.setAlpha(value: 0)
        self.setFrame(size: UIScreen.main.bounds.width)

        UIView.animate(withDuration: 1.5, animations: {
            self.setAlpha(value: 1)
            self.setFrame(size: 0)
        }, completion: { _ in
            self.linkButton.isHidden = false
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setFrame(size: CGFloat) {
        self.updated.frame.origin.x = size
        self.created.frame.origin.x = size
        self.score.frame.origin.x = size
    }

    private func setAlpha(value: CGFloat) {
        self.updated.alpha = value
        self.created.alpha = value
        self.score.alpha = value
    }

}
