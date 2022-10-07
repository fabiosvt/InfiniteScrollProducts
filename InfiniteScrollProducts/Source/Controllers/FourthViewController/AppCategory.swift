//
//  AppCategory.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 10/10/22.
//  Copyright © 2022 fabiosvt, Inc. All rights reserved.
//

import Foundation


class AppCategory: NSObject {
    var name: String?
    var apps: [App]?

    static func sampleAppCategories() -> [AppCategory] {

        // Chapter 1
        let chapter1 = AppCategory()
        chapter1.name = NSLocalizedString("CHAPTER 1: ", comment: "1") + NSLocalizedString("19 Sections", comment: "title")

        var apps1 = [App]()

        let chapter1App = App()
        chapter1App.imageName = "IMG_2487"

        let chapter11App = App()
        chapter11App.imageName = "IMG_2502"

        let chapter12App = App()
        chapter12App.imageName = "IMG_2507"

        apps1.append(chapter1App)
        apps1.append(chapter11App)
         apps1.append(chapter12App)

        chapter1.apps = apps1

      // Chapter 2

        let chapter2 = AppCategory()
        chapter2.name = NSLocalizedString("CHAPTER 2: ", comment: "2") + NSLocalizedString("19 Sections", comment: "title")

        var apps2 = [App]()

        let chapter2App = App()
        chapter2App.imageName = "IMG_2508"


        apps2.append(chapter2App)

        chapter2.apps = apps2

        // Chapter 3

        let chapter3 = AppCategory()
        chapter3.name = NSLocalizedString("CHAPTER 3: ", comment: "title") + NSLocalizedString("19 Sections", comment: "title")


        var apps3 = [App]()

        let chapter3App = App()
        chapter3App.imageName = "IMG_2510"

        apps3.append(chapter3App)

        chapter3.apps = apps3

        // Chapter 4

        let chapter4 = AppCategory()
        chapter4.name = NSLocalizedString("CHAPTER 4: ", comment: "title") + NSLocalizedString("19 Sections", comment: "title")

        var apps4 = [App]()

        let chapter4App = App()
        chapter4App.imageName = "IMG_2511"

        apps4.append(chapter4App)

        chapter4.apps = apps4


        return [chapter1, chapter2, chapter3, chapter4]
    }

}


class App: NSObject {
    var imageName: String?
}
