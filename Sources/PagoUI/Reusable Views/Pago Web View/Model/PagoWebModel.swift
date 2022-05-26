//
//  
//  PagoWebModel.swift
//  Pago
//
//  Created by Gabi Chiosa on 05.10.2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//
import UIKit
import Foundation

public struct PagoWebModel: Model {
    
    public let urlString: String
    
    public lazy var urlRequest: URLRequest? = {
        if let link = URL(string:urlString) {
            let request = URLRequest(url: link)
            return request
        }
        return nil
    }()
    
    public lazy var loaderModel: PagoAnimationModel = {
        let animationModel = PagoAnimationModel(animationType: .loading, loop: true, style: PagoAnimationStyle(size: CGSize(width: 60, height: 60)))
        return animationModel
    }()
    
    public init(urlString: String) {
        
        self.urlString = urlString
    }
}
