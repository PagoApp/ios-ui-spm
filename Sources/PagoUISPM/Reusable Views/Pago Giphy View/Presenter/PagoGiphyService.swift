//
//  PagoGiphyService.swift
//  Pago
//
//  Created by Gabi Chiosa on 16.03.2022.
//  Copyright © 2022 cleversoft. All rights reserved.
//

import Foundation
import GiphyUISDK

@available(iOS 13.0, *)
class PagoGiphyService: Service {
    
    
    func getGif(mediaId: String, completion: @escaping (Any)->()) {
        GiphyCore.shared.gifByID(mediaId) { (response, error) in
            if let media = response?.data {
                DispatchQueue.main.sync {
                    completion(media)
                }
            }
        }
    }
}
