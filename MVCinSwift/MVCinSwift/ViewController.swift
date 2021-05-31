//
//  ViewController.swift
//  MVCinSwift
//
//  Created by SHUBHAM AGARWAL on 31/05/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
    }
    
    var responseArray = [DataModel]()
    
    func callAPI() {
        Alamofire.request(URL(string: "https://jsonplaceholder.typicode.com/comments")!,
                          method: .post,
                          parameters: nil,
                          headers: nil)
            .responseJSON { response in
                if let responseData = response.data {
                    print(responseData)
                    do {
                        let decodeJson = JSONDecoder()
                        decodeJson.keyDecodingStrategy = .convertFromSnakeCase
                        self.responseArray =  try decodeJson.decode([DataModel].self, from: responseData)
                        self.tableView.reloadData()
                    } catch {
                        // Catch the error and handle it.
                        print(error.localizedDescription)
                    }
                }
            }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(responseArray[indexPath.row].id ?? 0)
        cell.detailTextLabel?.text = responseArray[indexPath.row].title
        return cell
    }
}
