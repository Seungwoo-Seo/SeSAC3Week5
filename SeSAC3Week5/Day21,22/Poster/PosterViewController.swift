//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by 서승우 on 2023/08/16.
//

import Alamofire
import Kingfisher
import UIKit

protocol CollectionViewAttributeProtocol {
    func configureCollectionView()
    func configureCollectionViewLayout()
}

class PosterViewController: UIViewController {

    @IBOutlet weak var posterCollectionView: UICollectionView!

    var list = RecommendationsContainer(page: 0, results: [], totalPages: 0, totalResults: 0)
    var secondList = RecommendationsContainer(page: 0, results: [], totalPages: 0, totalResults: 0)
    var thirdList = RecommendationsContainer(page: 0, results: [], totalPages: 0, totalResults: 0)
    var fouthList = RecommendationsContainer(page: 0, results: [], totalPages: 0, totalResults: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureCollectionViewLayout()

        networkingFlow()
    }

}

extension PosterViewController: UICollectionViewDataSource {

    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        return 4
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if section == 0 {
            return list.results.count
        } else if section == 1 {
            return secondList.results.count
        } else if section == 2 {
            return thirdList.results.count
        } else if section == 3 {
            return fouthList.results.count
        } else {
            return 9
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PosterCollectionViewCell.identifier,
            for: indexPath
        ) as? PosterCollectionViewCell

        if indexPath.section == 0 {
            let url = URL(string: "https://www.themoviedb.org/t/p/original\(list.results[indexPath.item].posterPath ?? "")")
            cell?.posterImageView.kf.setImage(
                with: url
            )
        } else if indexPath.section == 1 {
            let url = URL(string: "https://www.themoviedb.org/t/p/original\(secondList.results[indexPath.item].posterPath ?? "")")
            cell?.posterImageView.kf.setImage(
                with: url
            )
        } else if indexPath.section == 2 {
            let url = URL(string: "https://www.themoviedb.org/t/p/original\(thirdList.results[indexPath.item].posterPath ?? "")")
            cell?.posterImageView.kf.setImage(
                with: url
            )
        } else if indexPath.section == 3 {
            let url = URL(string: "https://www.themoviedb.org/t/p/original\(fouthList.results[indexPath.item].posterPath ?? "")")
            cell?.posterImageView.kf.setImage(
                with: url
            )
        }

        cell?.posterImageView.backgroundColor = UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1
        )

        return cell ?? UICollectionViewCell()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderPosterCollectionReusableView.identifier,
                for: indexPath
            ) as? HeaderPosterCollectionReusableView

            header?.titleLabel.text = "테스트 섹션"

            return header ?? UICollectionReusableView()
        default:
            return UICollectionReusableView()
        }
    }

}

extension PosterViewController: UICollectionViewDelegate {

}

extension PosterViewController: CollectionViewAttributeProtocol {

    func configureCollectionView() {
        posterCollectionView.dataSource = self
        posterCollectionView.delegate = self

        let cellNib = UINib(
            nibName: PosterCollectionViewCell.identifier,
            bundle: nil
        )
        posterCollectionView.register(
            cellNib,
            forCellWithReuseIdentifier: PosterCollectionViewCell.identifier
        )
        let supplementaryNib = UINib(
            nibName: HeaderPosterCollectionReusableView.identifier,
            bundle: nil
        )
        posterCollectionView.register(
            supplementaryNib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderPosterCollectionReusableView.identifier
        )
    }

    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        posterCollectionView.collectionViewLayout = layout
    }

}

// MARK: - Networking
private extension PosterViewController {

    func fetchRecommendations(
        id: Int,
        success: @escaping (RecommendationsContainer) -> (),
        failure: @escaping (Error) -> ()
    ) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(Key.tmdb)&language=ko-KR")!

        AF
            .request(url, method: .get)
            .validate(statusCode: 200...500)
            .responseDecodable(
                of: RecommendationsContainer.self
            ) { response in
                switch response.result {
                case .success(let value):
                    success(value)
                case .failure(let error):
                    failure(error)
                }
            }
    }

    func networkingFlow() {
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .background)

        for dic in [0: 479718, 1: 313369, 2: 872585, 3: 157336] {
            group.enter()
            queue.async(group: group) { [weak self] in
                self?.fetchRecommendations(
                    id: dic.value,
                    success: { container in
                        switch dic.key {
                        case 0: self?.list = container
                        case 1: self?.secondList = container
                        case 2: self?.thirdList = container
                        case 3: self?.fouthList = container
                        default: fatalError("")
                        }
                        group.leave()
                    },
                    failure: { _ in
                        group.leave()
                    }
                )
            }
        }

        group.notify(queue: queue) { [weak self] in
            DispatchQueue.main.async {
                self?.posterCollectionView.reloadData()
            }
        }
    }

}
