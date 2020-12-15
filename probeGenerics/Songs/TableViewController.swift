//
//  TableViewController.swift
//  probeGenerics
//
//  Created by User on 14.12.2020.
//
import UIKit
struct Source {
    var top100AppleMusic = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json"
    var top100Hottracks = "https://rss.itunes.apple.com/api/v1/us/itunes-music/hot-tracks/all/100/explicit.json"
    var top100App = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/10/explicit.json"
    var top100Book = "https://rss.itunes.apple.com/api/v1/us/tv-shows/top-tv-episodes/all/10/explicit.json"
    var top100Movies = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/10/explicit.json"
    var unknownAdress = "https://avatars.mds.yandex.net/get-zen_doc/1112006/pub_5b86796347174c00aab19fed_5b867969ecb00d00aa4a4701/scale_1200"
}

class TableViewController: UITableViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelLoading: UILabel!
    @IBOutlet weak var views: UIView!
    
    var networkManager = NetworkManager()
    var source = Source()
    var modelSong = [Result]()
    var TVC = TableViewCell()
    var url = ""
    
    @IBAction func changeaction(_ sender: Any) {
        DispatchQueue.main.async { [self] in
        changecontent()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        getdata(url: source.top100App)
    }
    
    func getdata(url: String) {
        labelLoading.isHidden = false
        activityIndicator.isHidden = false
        networkManager.dataRecive(url: url) { [weak self] (responce) in
            guard let self = self else { return }
            DispatchQueue.main.sync {
                self.modelSong = responce.feed.results
                self.labelLoading.isHidden = true
                self.activityIndicator.isHidden = true
                self.tableView.reloadData()
            }
        }
       
    }
    func changecontent() {
        modelSong = []
        tableView.reloadData()
        switch segmentedControl.selectedSegmentIndex {
        case 0 : getdata(url: source.top100App)
        case 1: getdata(url: source.top100AppleMusic)
        case 2: getdata(url: source.top100Book)
        case 3: getdata(url: source.top100Hottracks)
        case 4: getdata(url: source.top100Movies)
        default : break
        
        }
       
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelSong.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentData = modelSong[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.configure(currentData: currentData)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentData = modelSong[indexPath.row]
            url = currentData.artistURL ?? source.unknownAdress
        performSegue(withIdentifier: "Go", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Go" else {return}
        let WV = segue.destination as! WebViewController
        WV.url = self.url
    }
}
