//
//  EntryTableViewCell.swift
//  RedditTest
//
//  Created by Pavlo Naumenko on 4/11/19.
//  Copyright © 2019 Pavlo Naumenko. All rights reserved.
//

import UIKit
import SDWebImage

class EntryTableViewCell: UITableViewCell {
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var numberOfComments: UILabel!
    
    func configure(withEntry entry: TopEntriesDataChildren) {
        title.text = entry.data.title
        author.text = entry.data.author_fullname
        numberOfComments.text = "Comments:\(entry.data.num_comments)"
        picture.sd_setImage(with: URL(string: entry.data.thumbnail), placeholderImage: UIImage(named: "placeholder-image"), options: .highPriority, context: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
