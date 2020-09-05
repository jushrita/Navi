//
//  PRCell.swift
//  Navi
//
//  Created by Jushrita on 05/09/20.
//  Copyright © 2020 Jushrita. All rights reserved.
//

import UIKit

class PRCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var creationData: UILabel!
    @IBOutlet weak var closeDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(data: PRData) {
        title.text = data.title
        userName.text = data.userName
        creationData.text = data.firstDate
        closeDate.text = data.secondDate
    }
    
}
