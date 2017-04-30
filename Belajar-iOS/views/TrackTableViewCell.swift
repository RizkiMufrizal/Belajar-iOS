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

    @IBOutlet weak var albumNameLabel: MarqueeLabel!
    @IBOutlet weak var artistNameLabel: MarqueeLabel!
    @IBOutlet weak var trackNameLabel: MarqueeLabel!
    @IBOutlet weak var gambarAlbumImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.trackNameLabel.type = .continuous
        self.trackNameLabel.speed = .duration(15)
        self.trackNameLabel.animationCurve = .easeInOut
        
        self.artistNameLabel.type = .continuous
        self.artistNameLabel.speed = .duration(15)
        self.artistNameLabel.animationCurve = .easeInOut
        
        self.albumNameLabel.type = .continuous
        self.albumNameLabel.speed = .duration(15)
        self.albumNameLabel.animationCurve = .easeInOut
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
