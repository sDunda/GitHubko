//
//  TableViewCell.swift
//  GitHubko
//
//  Created by D&M on 22.09.2017..
//  Copyright © 2017. Dunja Sasic. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var thumbnailAuthor: UIImageView!

    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
