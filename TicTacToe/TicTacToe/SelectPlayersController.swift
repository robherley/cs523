//
//  ViewController.swift
//  TicTacToe
//
//  Created by Robert Herley on 3/15/19.
//  Copyright © 2019 Robert Herley. All rights reserved.
//

import UIKit

// Src: https://stackoverflow.com/questions/28854469/change-uibutton-bordercolor-in-storyboard
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

// Src: https://stackoverflow.com/a/53735711/10090356
extension UITextField{
    @IBInspectable var placeholderColor: UIColor {
        get {
            return self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .lightText
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [.foregroundColor: newValue])
        }
    }
}

class SelectPlayersController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var playerOne: UITextField!
    @IBOutlet weak var playerTwo: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.isHidden = true
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if(playerOne.text! != "" && playerTwo.text! != ""){
            return true
        } else {
            errorMessage.isHidden = false
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let gameController = segue.destination as! GameController
        gameController.playerOne = playerOne.text!
        gameController.playerTwo = playerTwo.text!
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

