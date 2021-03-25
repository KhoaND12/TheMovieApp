//
//  LibsManager.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 17/03/2021.
//

import Kingfisher

class LibsManager: NSObject {
    /// The default singleton instance.
    static let shared = LibsManager()
    
    func setupLibs(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        // Add more setup lib at here if need
        setupKingfisher()
    }
    
    fileprivate func setupKingfisher() {
        ImageCache.default.memoryStorage.config.totalCostLimit = 200 * 1024 * 1024
        
        // Set maximum disk cache size for default cache. Default value is 0, which means no limit.
        ImageCache.default.diskStorage.config.sizeLimit = UInt(1000 * 1024 * 1024) // 500 MB

        // Set longest time duration of the cache being stored in disk. Default value is 1 week
        ImageCache.default.diskStorage.config.expiration = .days(7) // 1 week

        // Set timeout duration for default image downloader. Default value is 15 sec.
        ImageDownloader.default.downloadTimeout = 15.0 // 15 sec
    }
}
