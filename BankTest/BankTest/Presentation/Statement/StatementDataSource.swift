
import UIKit

class StatementDataSource : UITableViewDiffableDataSource<Int, StatementItemModel> {
    weak var presenter: StatementPresenter?

    required init(tableView: UITableView,
                           presenter: StatementPresenter?,
                           cellProvider: @escaping UITableViewDiffableDataSource<Int, StatementItemModel>.CellProvider) {
        self.presenter = presenter
        super.init(tableView: tableView, cellProvider: cellProvider)
    }
}
