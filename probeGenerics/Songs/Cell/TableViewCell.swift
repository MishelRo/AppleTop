//
//  TableViewCell.swift
//  probeGenerics
//
//  Created by User on 14.12.2020.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var album: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var newImage: UIImageView!
    
    func configure(currentData: Result) {
        album.text = currentData.name
        author.text = currentData.artistName
        newImage.sd_setImage(with: URL(string: currentData.artworkUrl100 ?? ""), completed: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newImage.image = nil
    }
}
