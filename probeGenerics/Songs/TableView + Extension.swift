//
//  TableView + Extension.swift
//  probeGenerics
//
//  Created by User on 15.12.2020.
//
import UIKit
import Foundation
extension TableViewController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard modelSong.count > 0 else {  return article.count }
        return modelSong.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell") as! NewTableViewCell
        guard modelSong.first?.name != nil else {
        cell.newsCellConfigure(array: article, indexPath: indexPath);return cell}
        let currentData = modelSong[indexPath.row]
        cell.configure(currentData: currentData)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard modelSong.count > 0 else {
        let currentData = article[indexPath.row]
        url = currentData.url
        performSegue(withIdentifier: "Go", sender: nil); return }
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
