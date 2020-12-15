//
//  TableViewController.swift
//  probeGenerics
//
//  Created by User on 14.12.2020.
//
import UIKit
struct Sources {
    var top100AppleMusic = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json"
    var top100Hottracks = "https://rss.itunes.apple.com/api/v1/us/itunes-music/hot-tracks/all/100/explicit.json"
    var top100App = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/10/explicit.json"
    var top100Book = "https://rss.itunes.apple.com/api/v1/us/tv-shows/top-tv-episodes/all/10/explicit.json"
    var top100Movies = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/10/explicit.json"
    var urlNews = "http://newsapi.org/v2/top-headlines?language=ru&country=ru&apiKey=5ac4f91d38614945884b10d0bb1adfaa"
    var unknownAdress = "https://avatars.mds.yandex.net/get-zen_doc/1112006/pub_5b86796347174c00aab19fed_5b867969ecb00d00aa4a4701/scale_1200"
}

class TableViewController: UITableViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelLoading: UILabel!
    @IBOutlet weak var views: UIView!
    
    var networkManager = NetworkManager()
    var article = [Article]()
    var worldNews = WorldNews()
    var source = Sources()
    var modelSong = [Result]()
    var TVC = TableViewCell()
    var url = ""
    
    @IBAction func changeaction(_ sender: Any) {
        DispatchQueue.main.async { [self] in
            changeContent()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        getdata(url: source.top100App)
        
    }
    
    func getNews () {
        worldNews.dataRecive(model: ModelNews.self, url: source.urlNews) { (article) in
            DispatchQueue.main.async {
                self.article = article.articles
                self.tableView.reloadData()
            }
        }
    }
    
    func getdata(url: String) {
        labelLoading.isHidden = false
        activityIndicator.isHidden = false
        networkManager.dataRecive(model: ModelInfo.self, url: url) { [weak self] (responce) in
            guard let self = self else { return }
            DispatchQueue.main.sync {
                self.modelSong = responce.feed.results
                self.labelLoading.isHidden = true
                self.activityIndicator.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
    
    func changeContent() {
        modelSong = []
        tableView.reloadData()
        switch segmentedControl.selectedSegmentIndex {
        case 0 : article = []; getdata(url: source.top100App)
        case 1: article = []; getdata(url: source.top100AppleMusic)
        case 2: article = []; getdata(url: source.top100Book)
        case 3: article = []; getdata(url: source.top100Hottracks)
        case 4:  getNews()
        default : break
        }
    }
   
}
