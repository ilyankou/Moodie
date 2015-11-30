//
//  MovieCell.swift
//  Moodie
//
//  Created by Anastasia Menshikova on 29/11/2015.
//  Copyright © 2015 Ilya Ilyankou. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func returnTitleLabel() -> UILabel {
        return titleLabel
    }
    
    func returnSubtitleLabel() -> UILabel {
        return subtitleLabel
    }
    
    func setTitle(txt: String) {
        titleLabel?.text = txt
    }
    
    func setSubtitle(txt: String) {
        subtitleLabel?.text = txt
    }

}
