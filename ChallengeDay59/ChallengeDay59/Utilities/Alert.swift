//
//  Alert.swift
//  ChallengeDay59
//
//  Created by Claudio Noberto on 05/06/22.
//

import Foundation
import UIKit

class Alert {
    static func showBasic(title: String?, message: String?, vc: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(alertController, animated: true)
    }
}
