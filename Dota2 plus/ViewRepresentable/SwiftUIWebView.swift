//
//  SwiftUIWebView.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import SwiftUI
import WebKit

struct SwiftUIWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let webView: WKWebView
    let url: URL
    init(url: URL) {
        webView = WKWebView(frame: .zero)
        webView.load(URLRequest(url: url))
        webView.pauseAllMediaPlayback()
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
