//
//  extensions.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0, paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop ?? 0).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft ?? 0).isActive = true
        }
        
        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant:  -paddingBottom).isActive = true
            }
        }
        
        if let right = right {
            if let paddingRight = paddingRight {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func animateButtonView(_ view: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            view.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
}

extension UIViewController {
    public func showAlert(title: String?, message: String?) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
      alertController.addAction(okAction)
      present(alertController, animated: true)
    }
}

extension Double {
    func convertToDate(dateFormat: String) -> String {
           let date = Date(timeIntervalSince1970: self)
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = dateFormat
           dateFormatter.timeZone = .current
           let localDate = dateFormatter.string(from: date)
           return localDate
       }
    
    func temperatureFormater() -> String {
    let formatter = MeasurementFormatter()
    let measurement = Measurement(value: self, unit: UnitTemperature.fahrenheit)
    return formatter.string(from: measurement)
    }
    
    func speedFormater() -> String {
        let formatter = MeasurementFormatter()
        let measurement = Measurement(value: self, unit: UnitSpeed.milesPerHour)
        return formatter.string(from: measurement)
    }
}
