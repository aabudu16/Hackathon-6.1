import Foundation
import UIKit
class Utilities {
    static func createTextfield(placeholderMsg: String, isSecureEntry: Bool) -> UITextField {
          let textField = UITextField()
              textField.attributedPlaceholder = NSAttributedString(string: placeholderMsg,
              attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.borderStyle = .none
        textField.textColor = .white
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: .white, width: 0.5)
        textField.backgroundColor = .clear
        textField.keyboardAppearance = .dark
        if isSecureEntry == true {
            textField.isSecureTextEntry = true
        }
              return textField
    }
    static func showAlert(vc: UIViewController, message: String) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alertVC, animated: true, completion: nil)
    }
}
enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}
extension UIView {
    func addLine(position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineView)
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        switch position {
        case .LINE_POSITION_TOP:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}



