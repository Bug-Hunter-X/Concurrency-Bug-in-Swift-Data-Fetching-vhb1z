func fetchData(completion: @escaping (Result<([Data], [Error]), Error>) -> Void) {
    let group = DispatchGroup()
    var successfulData: [Data] = []
    var errors: [Error] = []
    let urls = [URL(string: "https://www.example.com")!, URL(string: "https://www.google.com")!, URL(string: "invalid-url")]
    for url in urls {
        group.enter()
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { group.leave() }
            if let error = error {
                errors.append(error)
            } else if let data = data {
                successfulData.append(data)
            }
        }.resume()
    }
    group.notify(queue: .main) { 
        if errors.isEmpty {
            completion(.success((successfulData, [])))
        } else {
            completion(.success((successfulData, errors)))
        }
    }
}