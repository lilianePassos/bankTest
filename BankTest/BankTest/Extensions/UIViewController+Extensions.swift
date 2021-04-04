import UIKit

extension UIViewController {

    public static var nibName: String {
        return String(NSStringFromClass(self).split(separator: ".").last!)
    }

    public class func nib(bundle: Bundle? = nil) -> UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }

    public class func fromNib(bundle: Bundle? = nil,
                              owner: Any? = nil,
                              options: [UINib.OptionsKey: Any]? = nil) -> Self? {
        return nib(bundle: bundle).instantiate(withOwner: owner, options: options).first as? Self
    }
}
