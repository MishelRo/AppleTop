//
//  NewTableViewCell.swift
//  probeGenerics
//
//  Created by User on 17.12.2020.
//
import SDWebImage
import UIKit
struct CacheImage {
    var resetAddress = "https://kitairu.net/images/noimage.png"
}
class NewTableViewCell: UITableViewCell {
    var cacheImage = CacheImage()
    
    @IBOutlet weak var album: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var newImage: UIImageView!
    
    func configure(currentData: Interface) {
        album.text = currentData.name
        author.text = currentData.artistName
        newImage.sd_setImage(with: URL(string: currentData.artworkUrl100 ?? cacheImage.resetAddress), completed: nil)
    }
    
    func newsCellConfigure(array: [InterfaceNews], indexPath: IndexPath) {
        guard array.isEmpty == false else {return}
        let current = array[indexPath.row]
        album.text = current.title
        author.text = "Author \(current.source?.name ?? "")"
        newImage.sd_setImage(with: URL(string: current.urlToImage ?? cacheImage.resetAddress), completed: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newImage.image = nil
    }
    
}
