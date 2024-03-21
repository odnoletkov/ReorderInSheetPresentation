import UIKit

@main
class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = .init()
        window!.makeKeyAndVisible()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.window!.rootViewController?.present(
                UINavigationController(rootViewController: Controller()),
                animated: true
            )
        }

        return true
    }
}

class Controller: UITableViewController {
    lazy var dataSource = DataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.contentConfiguration = {
            var configuration = UIListContentConfiguration.cell()
            configuration.text = String(describing: indexPath)
            return configuration
        }()
        return cell
    }

    override func viewDidLoad() {
        tableView.isEditing = true

//        tableView.delegate = self

        dataSource.apply(
            {
                var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
                snapshot.appendSections([0])
                snapshot.appendItems(.init(0..<5))
                return snapshot
            }(),
            animatingDifferences: false
        )
    }

    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        proposedDestinationIndexPath
    }

    class DataSource: UITableViewDiffableDataSource<Int, Int> {

        override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            print(1)
        }
    }
}
