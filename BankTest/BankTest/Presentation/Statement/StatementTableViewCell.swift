
import UIKit

class StatementTableViewCell : UITableViewCell {
    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var dateTextField: UILabel!
    @IBOutlet weak var valueTextField: UILabel!
    @IBOutlet weak var descTextField: UILabel!

    func update(statementItem: StatementItemModel) {

        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        titleTextField.text = statementItem.title
        valueTextField.text = fabs(statementItem.value).formattedCurrency(locale: Locale(identifier: "pt_BR"))
        descTextField.text = statementItem.desc
        dateTextField.text = formatter.string(from: statementItem.date)
    }


    
}
