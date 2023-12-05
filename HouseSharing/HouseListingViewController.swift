//
//  ViewController.swift
//  HouseSharing
//
//  Created by 金融研發一部-謝宜軒 on 2023/9/23.
//

import UIKit
import Alamofire
import SwiftSoup

class HouseListingViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HouseListingTableViewCell.self, forCellReuseIdentifier: "HouseListingTableViewCell")

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    var houseListings: [HouseListing] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        sendGETRequestWithUserAgent()
    }

    func sendGETRequestWithUserAgent() {
        // 您提供的網址
        let url = "https://buy.houseprice.tw/list/%E6%96%B0%E5%8C%97%E5%B8%82_city/%E6%B0%B8%E5%92%8C%E5%8D%80_zip/%E4%BD%8F%E5%AE%85_use/%E9%9B%BB%E6%A2%AF%E5%A4%A7%E6%A8%93_type/25-_area/2-_room/3-_floor/-3200_price/-15_age/"
        
        // 定義 User-Agent 標頭
        let headers: HTTPHeaders = [
            "User-Agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1"
        ]
        
        // 使用 Alamofire 來發送 GET 請求，並添加 User-Agent 標頭
        AF.request(url, headers: headers).responseString { response in
            switch response.result {
            case .success(let html):
                // 請求成功，處理返回的 HTML 內容
                do {
                    let doc = try SwiftSoup.parse(html)
                    let bItems = try doc.select("section.b-item")

                    for bItem in bItems {
                        let title = try bItem.select("h3.b-name").text()
                        let photoCount = try Int(bItem.select("div.b-photocount span").text()) ?? 0
                        let price = try bItem.select("div.b-title-price span.b-cnt-large").text()
                        let address = try bItem.select("address").text()
                        let info = try bItem.select("div.b-info span")
                        let size = try info[0].text()
                        let rooms = try info[1].text()
                        let floor = try info[2].text()
                        let age = try info[3].text()
                        let tags = try bItem.select("div.m-tags ul.b-tags li em.b-tag").map { try $0.text() }

                        // 提取 <a> 元素中的 href 屬性
                        let linkElement = try bItem.select("a")
                        let linkURL = try linkElement.attr("href")

                        let listing = HouseListing(title: title, photoCount: photoCount, price: price, address: address, size: size, rooms: rooms, floor: floor, age: age, tags: tags, linkURL: linkURL)
                        self.houseListings.append(listing)
                        self.tableView.reloadData()
                        
                    }

                    // 現在，houseListings 數組包含了所有解析的 b-item 內容
                    for listing in self.houseListings {
                        print("Title: \(listing.title)")
                        print("Photo Count: \(listing.photoCount)")
                        print("Price: \(listing.price)")
                        print("Address: \(listing.address)")
                        print("Size: \(listing.size)")
                        print("Rooms: \(listing.rooms)")
                        print("Floor: \(listing.floor)")
                        print("Age: \(listing.age)")
                        print("Tags: \(listing.tags)")
                        print("linkURL: \(listing.linkURL)")
                        print("---------")
                    }
                } catch {
                    print("解析 HTML 錯誤：\(error)")
                }
                
            case .failure(let error):
                // 請求失敗，處理錯誤（在這個示例中，我們簡單地打印錯誤信息）
                print(error.localizedDescription)
            }
        }
    }
}
extension HouseListingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedListing = houseListings[indexPath.row]
        
        // 創建下一個視圖控制器，並將 linkURL 帶入
        let detailViewController = DetailViewController()
        detailViewController.linkURL = selectedListing.linkURL
        
        // 在導航控制器中顯示下一個視圖控制器
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension HouseListingViewController: UITableViewDataSource {
    // 實現 UITableViewDataSource 的方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseListings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseListingTableViewCell", for: indexPath) as! HouseListingTableViewCell
        let listing = houseListings[indexPath.row]

        // 使用 configure 方法設定自定義單元格的內容
        cell.configure(with: listing)

        return cell
    }

}

struct HouseListing {
    let title: String
    let photoCount: Int
    let price: String
    let address: String
    let size: String
    let rooms: String
    let floor: String
    let age: String
    let tags: [String]
    let linkURL: String // 新增 linkURL 屬性
}
