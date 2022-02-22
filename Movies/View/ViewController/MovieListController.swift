//
//  MovieListController.swift
//  Movies
//
//  Created by Jithin on 21/02/22.
//

import UIKit

class MovieListController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!

    private var movieViewModel = MovieViewModel()
    private var movies: [Movie]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setTableView()
        movieViewModel.movieDelegate = self
        movieViewModel.fetchMovies()

    }

    func setNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.systemBlue
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    func setTableView() {
        moviesTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        moviesTableView.rowHeight = UITableView.automaticDimension
        moviesTableView.estimatedRowHeight = 120
        moviesTableView.separatorStyle = .none
        moviesTableView.tableFooterView = UIView()
    }

    func getErrorView() -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: moviesTableView.bounds.size.width,
                                          height: 150))

        label.text = "No data.. Click to refresh"
        label.textColor = UIColor.purple
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        label.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(reload))
        tap.numberOfTouchesRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }

    @objc func reload() {
        moviesTableView.backgroundView = nil
        movieViewModel.fetchMovies()
    }

}

extension MovieListController: MovieProtocol {
    func errorOccured() {
        if movies == nil || movies?.count == 0 {
            moviesTableView.backgroundView = getErrorView()
        } else {
            moviesTableView.backgroundView = nil
        }
    }

    func moviesDownloaded(movies: [Movie]) {
        self.movies = movies
        moviesTableView.reloadData()
    }

}

extension MovieListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moviesTableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetailController = storyboard.instantiateViewController(identifier: "MovieDetailController")
                                       as? MovieDetailController {
            movieDetailController.movieId = movies?[indexPath.row].id
            movieDetailController.movieViewModel = movieViewModel
            movieDetailController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(movieDetailController, animated: true)
        }
    }
}

extension MovieListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell",
                                                    for: indexPath) as? MovieCell {
            cell.setMovie(movie: movies?[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
