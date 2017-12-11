//
//  ViewController.swift
//  GitHubko
//
//  Created by D&M on 21.09.2017..
//  Copyright © 2017. Dunja Sasic. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainTextView: UITextView!
    @IBOutlet weak var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        mainTextView.isEditable = false
        startButton.setTitle("Start", for: .normal)
        mainLabel.text = "GitHubko"
        mainTextView.text = "Welcome! Meet our search engine GitHubko and quickly find the repository you need!"
    }

    @IBAction func didTapStart(_ sender: UIButton) {
        let searchScreenViewController = SearchScreenViewController(nibName: "SearchScreenViewController", bundle: nil)

        navigationController?.pushViewController(searchScreenViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
