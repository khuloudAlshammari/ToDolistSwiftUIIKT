//
//  TodosCell.swift
//  اول تطبيق لخوخة الحلوه
//
//  Created by khuloud alshammari on 24/04/1443 AH.
//

import UIKit

class TodosCell: UITableViewCell {

    
    @IBOutlet weak var todoTitelLabel: UILabel!
    
    @IBOutlet weak var todoCreationDateLebel: UILabel!
    
    @IBOutlet weak var todoImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
