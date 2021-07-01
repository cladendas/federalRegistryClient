//
//  FSSPTableViewCell.swift
//  federalRegistryClient
//
//  Created by cladendas on 26.06.2021.
//

import UIKit

class FSSPTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var exeProduction: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var bailiff: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
