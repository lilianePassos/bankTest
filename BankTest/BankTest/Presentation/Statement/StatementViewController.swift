
import UIKit

class StatementViewController : UIViewController, StatementViewDelegate, UITableViewDelegate {
    func update(models: [StatementItemModel]?, animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, StatementItemModel>()
        guard let models = models else { return }
        snapshot.appendSections([1])
        snapshot.appendItems(models, toSection: 1)
        dataSource.apply(snapshot, animatingDifferences: animate)

    }


    private var presenter: StatementPresenter?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    private lazy var dataSource = makeDataSource()
    var userModel: UserModel?


    override func viewDidLoad() {
        
        super.viewDidLoad()
        presenter = StatementPresenter(bankAPI: BankHTTP())
        presenter?.setViewDelegate(viewDelegate: self)

    }

    override func viewWillAppear(_ animated: Bool) {
        setupHeader()
        setupTableView()
    }

    private func setupHeader() {
        nameLabel.text = userModel?.name
        branchLabel.text = userModel?.agency
        accountLabel.text = userModel?.bankAccount
        balanceLabel.text = userModel?.balance.formattedCurrency(locale: Locale(identifier: "pt_BR"))

    }

    private func setupTableView() {
        self.tableView?.register(StatementTableViewCell.nib(),
                                 forCellReuseIdentifier: StatementTableViewCell.reuseIdentifier())
        tableView.delegate = self
        tableView.dataSource = dataSource
        if let user = userModel {
            presenter?.loadStatement(userID: user.userId)
        }
    }
}

extension StatementViewController {
    func makeDataSource() -> StatementDataSource {
        let reuseIdentifier = StatementTableViewCell.reuseIdentifier()
        return StatementDataSource(tableView: self.tableView, presenter: presenter, cellProvider:  {
            tableView, indexPath, row in
            let cell =  self.tableView .dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? StatementTableViewCell
            cell?.update(statementItem: row)
            return cell
        })
    }
}
