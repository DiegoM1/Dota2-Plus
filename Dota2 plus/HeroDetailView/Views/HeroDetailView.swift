//
//  HeroDetailView.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import SwiftUI
import WebKit

struct HeroDetailView: View {
    var name: String
    var body: some View {
        SwiftUIWebView(url: Constants.Urls.urlHeroLink(name))
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct HeroDetailsViewControlle_Previews: PreviewProvider {
    static var previews: some View {
        HeroDetailView(name: "Axe")
    }
}
