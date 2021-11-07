//
//  TableViewCustomCell.swift
//  RakuBookAPILessonApp
//
//  Created by UrataHiroki on 2021/11/06.
//

import UIKit

class TableViewCustomCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bookImageView.image = UIImage(named: "")
        bookTitleLabel.text = ""
        authorLabel.text = ""
        itemPriceLabel.text = ""
        
    }
}
