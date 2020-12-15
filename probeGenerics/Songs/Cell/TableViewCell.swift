//
//  TableViewCell.swift
//  probeGenerics
//
//  Created by User on 14.12.2020.
//

import UIKit
import SDWebImage
struct Origin {
    var resetAddress = "https://kitairu.net/images/noimage.png"
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var album: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var newImage: UIImageView!
    
    var origin = Origin()
    
    func configure(currentData: Result) {
        album.text = currentData.name
        author.text = currentData.artistName
        newImage.sd_setImage(with: URL(string: currentData.artworkUrl100 ?? origin.resetAddress), completed: nil)
    }
    
    func newsCellConfigure(array: [Article], indexPath: IndexPath) {
        guard array.isEmpty == false else {return}
        let current = array[indexPath.row]
        album.text = current.title
        author.text = "Author \(current.source?.name ?? "")"
        newImage.sd_setImage(with: URL(string: current.urlToImage ?? origin.resetAddress), completed: nil)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newImage.image = nil
    }
}

