import Foundation

protocol StatementViewDelegate : class {
    func update(models: [StatementItemModel]?, animate: Bool)
}

class StatementPresenter {
    weak var viewDelegate: StatementViewDelegate?
    private let bankAPI : BankAPI

    var modelList: [StatementItemModel]? {
        didSet {
            self.viewDelegate?.update(models: modelList, animate: true)
        }
    }

    func setViewDelegate(viewDelegate: StatementViewDelegate) {
        self.viewDelegate = viewDelegate
    }

    init(bankAPI: BankAPI) {
        self.bankAPI = bankAPI
    }

    func loadStatement(userID: Int) {
        self.bankAPI.getStatement(userID: userID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let statementResponse):
                    self?.viewDelegate?
                        .update(models: statementResponse.statementList, animate: true)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
