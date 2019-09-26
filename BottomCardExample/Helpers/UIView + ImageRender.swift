//
//  UIView + ImageRender.swift
//  BottomCardExample
//
//  Created by Станислав Шияновский on 9/26/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image(actions: { rendererContext in
            layer.render(in: rendererContext.cgContext)
        })
    }
}
