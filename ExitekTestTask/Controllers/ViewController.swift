//
//  ViewController.swift
//  ExitekTestTask
//
//  Created by Alexandr Mefisto on 31.08.2022.
//

import OrderedCollections
import UIKit
let cellIdentifier = "MovieCell"
final class ViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var movieTitleTextField: UITextField!
    @IBOutlet private var movieYearTextField: UITextField!

    private var movies = OrderedSet<Movie>()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    @IBAction func addButtonDidTab() {
        let movieTitle: String
        let movieYear: UInt

        guard let title = movieTitleTextField.text,
              let yearText = movieYearTextField.text else {
            showError("Enter movie title and year")
            return
        }

        if !title.isEmpty {
            movieTitle = title
        } else {
            showError("Enter title")
            return
        }

        if !yearText.isEmpty {
            if let year = UInt(yearText) {
                movieYear = year
            } else {
                showError("Enter correct year. It must be Digit")
                return
            }
        } else {
            showError("Enter year")
            return
        }

        let movie = Movie(title: movieTitle, year: movieYear)
        let result = movies.append(movie)
        if result.inserted {
            tableView.insertRows(at: [IndexPath(row: movies.count - 1, section: 0)], with: .automatic)
            refreshTextFields()
            view.endEditing(true)
        } else {
            showError("Movies can't be duplicated")
        }
    }

    // MARK: Privates

    private func refreshTextFields() {
        movieYearTextField.text = nil
        movieTitleTextField.text = nil
    }

    private func showError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: Data Source

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = movies[indexPath.row].description
        return cell
    }
}
