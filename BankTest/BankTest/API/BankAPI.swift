import Foundation

protocol BankAPI {
    var urlBase: String { get }

    func login(user: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void)
    func getStatement(userID: Int, completion: @escaping (Result<StatementResponse, Error>) -> Void)

}

class BankHTTP: BankAPI {
    var urlBase = "https://bank-app-test.herokuapp.com/api"
    func login(user: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {

        var requestQueryBodyComponents = URLComponents()
        requestQueryBodyComponents.queryItems = [URLQueryItem(name: "user", value: user),
                                                 URLQueryItem(name: "password", value: password)]
        guard let bodyData = requestQueryBodyComponents.query?.data(using: .utf8) else {

            print("no data is present ")

            return

        }

        let urlLogin = URL(string: "\(urlBase)/login")!
        post(url: urlLogin, body: bodyData, completion: completion)
    }




    private func post(url: URL, body: Data, completion: @escaping (Result<LoginResponse, Error>) -> Void) {

        var request = URLRequest(url: url)

        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")

        request.httpMethod = "POST"

        request.httpBody = body

        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {

                completion(.failure(error))

                return

            }

            if let response = response as? HTTPURLResponse {

                if response.statusCode == 200 {

                    do {

                        guard let data = data else {return}

                        let jsonDecoder = JSONDecoder()

                        jsonDecoder.dateDecodingStrategy = .iso8601
                        jsonDecoder.keyDecodingStrategy = .useDefaultKeys

                        let decodedModel = try jsonDecoder.decode(LoginResponse.self, from: data)

                        completion(.success(decodedModel))

                    } catch let error {

                        print(error)

                        completion(.failure(HttpError.badRequest))

                    }

                } else {

                    completion(.failure(HttpError.badRequest))

                }

            }



        }.resume()

    }

    func getStatement(userID: Int, completion: @escaping (Result<StatementResponse, Error>) -> Void) {
        let urlStatement = URL(string: "\(urlBase)/statements/\(userID)")!
        var request = URLRequest(url: urlStatement)

        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "GET"



        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {

                completion(.failure(error))

                return

            }

            if let response = response as? HTTPURLResponse {

                if response.statusCode == 200 {

                    do {

                        guard let data = data else {return}

                        let json = String(data: data, encoding: .utf8)!

                        print(json)

                        let jsonDecoder = JSONDecoder()

                        jsonDecoder.dateDecodingStrategy = .iso8601

                        let decodedModel = try jsonDecoder.decode(StatementResponse.self, from: data)

                        completion(.success(decodedModel))

                    } catch let error {

                        print(error)

                        completion(.failure(HttpError.badRequest))

                    }

                } else {

                    completion(.failure(HttpError.badRequest))

                }

            }



        }.resume()
    }

}




enum HttpError: Error {

    case badRequest


}
