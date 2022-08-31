//
//  ViewController.swift
//  ExitekTestTask
//
//  Created by Alexandr Mefisto on 31.08.2022.
//

import UIKit

final class ViewController: UIViewController {
    private var movies: [Movie] = []

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var movieTitleTextField: UITextField!
    @IBOutlet private var movieYearTextField: UITextField!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    @IBAction func addButtonDidTab() {
        let movieTitle: String
        let movieYear: UInt
        
        if let title = movieTitleTextField.text, let yearText = movieYearTextField.text {
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
        } else {
            showError("Enter movie title and year")
            return
        }
        
        let movie = Movie(title: movieTitle, year: movieYear)
        if movies.contains(movie) {
            showError("Movies can't be duplicated")
        } else {
            movies += [movie]
            tableView.reloadData()
        }
        refreshTextFields()
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

// MARK: Delegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: Data Source

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        cell.textLabel?.text = movies[indexPath.row].description
        return cell
    }
}
