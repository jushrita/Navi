//
//  UIImage+Extension.swift
//  Navi
//
//  Created by Jushrita on 06/09/20.
//  Copyright © 2020 Jushrita. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func imageFromURL(url: String) {
        AvatarNetworkService(url: url).getAvatar { [weak self](response) in
            DispatchQueue.main.async {
                self?.image = UIImage(data: response.response ?? Data(), scale:1)
            }
        }
    }
}
