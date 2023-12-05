//
//  DetailViewController.swift
//  HouseSharing
//
//  Created by 金融研發一部-謝宜軒 on 2023/9/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    var linkURL: String?
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 創建 WKWebView
        webView = WKWebView()
        webView.navigationDelegate = self
        view.addSubview(webView)

        // 添加約束，使 WKWebView 充滿整個畫面
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // 檢查是否有有效的 linkURL，然後載入它
        if let urlStr = linkURL, let url = URL(string: urlStr) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    // MARK: - WKNavigationDelegate

    // 在此實作 WKNavigationDelegate 的方法，以處理網頁載入事件
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 網頁載入完成時的處理
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // 網頁載入失敗時的處理
    }
}
