//
//  UIImageView+Kingfisher.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 4.02.2023.
//

import UIKit
import Kingfisher

extension UIImageView {

    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func downloadedFrom(
        url: URL,
        downsampling: Bool = false,
        placeholder: Placeholder? = nil,
        completion: ((UIImage?) -> Void)? = nil
    ) {
        kf.cancelDownloadTask()

        var options: KingfisherOptionsInfo = []
        options.append(.transition(.fade(0.3)))

        if downsampling {
            options.append(contentsOf: [
                .processor(DownsamplingImageProcessor(size: frame.size)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage,
            ])
        }

        kf.setImage(
            with: url,
            placeholder: placeholder,
            options: options,
            progressBlock: nil,
            completionHandler: { result in
                switch result {
                case let .success(imageResult):
                    completion?(imageResult.image)
                case .failure:
                    completion?(nil)
                }
            })

        contentMode = .redraw
    }

}
