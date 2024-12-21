func fetchData(completion: @escaping (Result<[Data], Error>) -> Void) {
    let group = DispatchGroup()
    var results: [Result<Data, Error>] = []
    for url in urls {
        group.enter()
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { group.leave() }
            if let error = error {
                results.append(.failure(error))
            } else if let data = data {
                results.append(.success(data))
            }
        }.resume()
    }
    group.notify(queue: .main) { 
        let combinedResult: Result<[Data], Error> = results.reduce(.success([])) { combined, result in
            switch (combined, result) {
            case (.success(var data), .success(let newData):
                data.append(newData)
                return .success(data)
            case (.failure(let error), _):
                return .failure(error)
            case (_, .failure(let error)):
                return .failure(error)
            }
        }
        completion(combinedResult)
    }
}