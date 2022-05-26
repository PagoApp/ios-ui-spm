//
//  PagoRepeater.swift
//  Pago
//
//  Created by Gabi Chiosa on 22/01/2021.
//  Copyright © 2021 cleversoft. All rights reserved.
//

import Foundation

open class PagoRepeater {
    
    var timer : Timer?
    
    func startTimer(time: Int, update: @escaping (Int)->(), completion: @escaping ()->()) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard time > 0 else {
                completion()
                return
            }
            
            var runCount = time
            self?.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                if runCount == 0 {
                    timer.invalidate()
                    completion()
                } else {
                    update(runCount)
                }
                runCount -= 1
            }
        }
    }
    
    func stopTimer() {
        
        timer?.invalidate()
        timer = nil
    }
}
