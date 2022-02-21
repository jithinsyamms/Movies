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
    private var movies:[Movie]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setTableView()
        movieViewModel.delegate = self
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

}

extension MovieListController: MovieProtocol {
    func moviesDownloaded(movies: [Movie]) {
        self.movies = movies
        moviesTableView.reloadData()
    }
}

extension MovieListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moviesTableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetailController = storyboard.instantiateViewController(identifier:
                                       "MovieDetailController") as? MovieDetailController {
            movieDetailController.movie = movies?[indexPath.row]
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
