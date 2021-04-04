import Foundation

extension Double {
    func formattedCurrency(locale:Locale) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = locale
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
