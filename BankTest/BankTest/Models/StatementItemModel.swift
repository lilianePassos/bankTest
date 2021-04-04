import Foundation

struct StatementItemModel: Codable, Hashable {
    let title: String
    let desc: String
    let date: Date
    let value: Double

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case desc = "desc"
        case date = "date"
        case value = "value"

    }



    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        desc = try values.decode(String.self, forKey: .desc)
        let dateString = try values.decode(String.self, forKey: .date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        date = formatter.date(from: dateString)!
        value = try values.decode(Double.self, forKey: .value)
    }
}

struct StatementResponse: Codable {
    let statementList: [StatementItemModel]?
    let error: ErrorApi?


    enum CodingKeys: String, CodingKey {
        case statementList = "statementList"
        case error = "error"
    }



    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statementList = try? values.decode([StatementItemModel].self, forKey: .statementList)
        error = try? values.decode(ErrorApi.self, forKey: .error)
    }
}

struct ErrorApi: Codable {
    let code: Int
    let message: String
}
