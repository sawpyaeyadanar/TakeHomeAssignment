//
//  ListVC.swift
//  CodeTestNinetyNine
//
//  Created by sawpyae on 10/18/22.
//

import UIKit

class ListVC: BaseVC {
    private let vm  = ListViewModel()
    private lazy var listAry = [ListData]()
    private let reuseIdentifier = "cell"

    @IBOutlet weak var listTblView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        vm.beforeApiCall = {
            DispatchQueue.main.async {
                OverlayLoadingView.shared.show()
            }
        }

        vm.afterApiCall = {
            DispatchQueue.main.async {
                OverlayLoadingView.shared.hide()
            }
        }

        self.listTblView.register(UINib(nibName: "ListViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.getList()

    }

    private func getList() {
        if Reachability.isConnectedToNetwork() {
            vm.getListData { [weak self] data in
                guard let self = self else { return }
                self.listAry = data
                DispatchQueue.main.async {
                    self.listTblView.reloadData()
                }

            } failure: { error in
                debugPrint("error is ",error?.result ?? "unknown")
            }
        }else{
            self.showNetworkError()
        }

    }

    private func goDetails(id: Int) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsVC") as? DetailsVC {
            vc.detailsVM = DetailVM(selectedIndex: id)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }


}

extension ListVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listAry.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ListViewCell
        cell.config(data: self.listAry[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 320)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedData = listAry[indexPath.row].id
        self.goDetails(id: selectedData)
    }
}
