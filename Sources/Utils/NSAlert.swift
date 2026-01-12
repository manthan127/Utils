//
//  NSAlert.swift
//  Utils
//
//  Created by Home on 06/09/25.
//


#if os(macOS)
import AppKit

func presentAlert(message: String) {
    DispatchQueue.main.async {
        let alert = NSAlert()
        alert.messageText = message
        alert.addButton(withTitle: "Ok")
        
        alert.runModal()
    }
}

func presentAlert(error: Error) {
    DispatchQueue.main.async {
        let alert = NSAlert(error: error)
        alert.addButton(withTitle: "Ok")
        
        alert.runModal()
    }
}

#endif
