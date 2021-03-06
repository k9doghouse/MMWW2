//
//  Alerts.swift
//  MMWW2
//
//  Created by murph on 8/23/18.
//  Copyright © 2018 k9doghouse. All rights reserved.
//

import UIKit


struct Alert
{
    private static func showSolvedAlert(on vc : UIViewController,
                                        with title : String,
                                        message : String)
    {
        let alert = UIAlertController(title : title,
                                      message : message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title : "OK",
                                      style: .default,
                                      handler : nil))
        
        DispatchQueue.main.async
            { vc.present(alert, animated : true) }
    }

    static func showSolvedAlert(on vc : UIViewController)
    {
        showSolvedAlert(on : vc,
                        with : "You solved the puzzle!\nin \(daCount + 1) tries. \nyour word: \(game.gameWord)\n",
                     message : "Tap the 'OK Button' to play again.")
    }

    static func showUnableToRetrieveDataAlert(on vc : UIViewController)
    {
        showSolvedAlert(on : vc,
                        with : "Unable to Retrieve Data",
                        message : "Network Error")
    }
} // end struct Alert...
