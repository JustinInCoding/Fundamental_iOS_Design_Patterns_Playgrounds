/*:
 [Previous](@previous)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next](@next)
 
 # Strategy
 - - - - - - - - - -
 ![Strategy Diagram](Strategy_Diagram.png)
 
 The strategy pattern defines a family of interchangeable objects.
 
 This pattern makes apps more flexible and adaptable to changes at runtime, instead of requiring compile-time changes.
 
 ## Code Example
 */
import UIKit

public protocol MovieRatingStrategy {
	var ratingServiceName: String { get }
	
	func fetchRating(for movieTitle: String,
									 success: (_ rating: String, _ review: String) -> Void)
}

public class RottenTomatoesClient: MovieRatingStrategy {
	public let ratingServiceName = "Rotten Tomatoes"
	
	public func fetchRating(for movieTitle: String, success: (String, String) -> Void) {
		let rating = "95%"
		let review = "It rocked!"
		success(rating, review)
	}
}

public class IMDbClient: MovieRatingStrategy {
	public let ratingServiceName = "IMDb"
	
	public func fetchRating(for movieTitle: String, success: (String, String) -> Void) {
		let rating = "3/10"
		let review = "It was terrible! The audience was throwing rotten tomatoes!"
		success(rating, review)
	}
}

public class MovieRatingViewController: UIViewController {
	// MARK: - Properties
	public var movieRatingClient: MovieRatingStrategy!
	
	// MARK: - Outlets
	@IBOutlet public var movieTitleTextField: UITextField!
	@IBOutlet public var  ratingServiceNameLabel: UILabel!
	@IBOutlet public var  ratingLabel: UILabel!
	@IBOutlet public var  reviewLabel: UILabel!
	
	// MARK: - View Lifecycle
	public override func viewDidLoad() {
		super.viewDidLoad()
		ratingServiceNameLabel.text = movieRatingClient.ratingServiceName
	}
	
	// MARK: - Actions
	@IBAction public func searchButtonPressed(_ sender: Any) {
		guard let movieTitle = movieTitleTextField.text, movieTitle.count > 0 else {
			return
		}
		
		movieRatingClient.fetchRating(for: movieTitle) { rating, review in
			self.ratingLabel.text = rating
			self.reviewLabel.text = review
		}
	}
}
