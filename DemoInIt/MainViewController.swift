import RxSwift
import UIKit

class MainViewController: UIViewController {
    var disposeBag: DisposeBag!
    let titleLabel = UILabel()
    let reloadButton = UIButton(type: .system)

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        view.backgroundColor = .white

        titleLabel.text = "Empty"
        reloadButton.setTitle("Reload", for: .normal)

        [titleLabel, reloadButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            reloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reloadButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
        ])
    }

    func apply(viewModel: MainViewModelProtocol) {
        disposeBag = DisposeBag()

        viewModel.titleText
            .subscribe(to: titleLabel.rx.scheduledText)
            .disposed(by: disposeBag)

        reloadButton.rx.scheduledTap
            .subscribe(to: viewModel.reloadTap)
            .disposed(by: disposeBag)
    }
}
