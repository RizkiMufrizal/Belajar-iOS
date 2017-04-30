//
//  TrackTableViewCell.swift
//  Belajar-iOS
//
//  Created by rizki mufrizal on 4/30/17.
//  Copyright © 2017 rizki mufrizal. All rights reserved.
//

import UIKit
import MarqueeLabel

class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var gambarAlbumImage: UIImageView!
    
    @IBOutlet weak var trackNameLabel: MarqueeLabel!
    @IBOutlet weak var albumNameLabel: MarqueeLabel!
    @IBOutlet weak var artistNameLabel: MarqueeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
