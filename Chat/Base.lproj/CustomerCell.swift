//
//  CustomerCell.swift
//  Chat
//
//  Created by hanho on 10/15/18.
//  Copyright © 2018 hanho. All rights reserved.
//

import UIKit

class CustomerCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var senderUsername: UILabel!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var messageBackground: UIView!
}
