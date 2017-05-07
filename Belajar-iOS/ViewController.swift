//
//  ViewController.swift
//  Belajar-iOS
//
//  Created by rizki mufrizal on 4/30/17.
//  Copyright © 2017 rizki mufrizal. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher
import SwiftOverlays

class ViewController: UIViewController {

    @IBOutlet weak var trackTable: UITableView!
    let searchBar = UISearchBar()

    var rowData: [Item] = []
    var nextPage: String? = nil
    var nextInt = 0
    var limitInt = 20
    var track = "ColdPlay"
    var isSearch = false

    private var disposeBag = DisposeBag()
    private var trackService = TrackService()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Belajar iOS"
        self.getDefaultTrack(track: track, offset: nextInt, limit: limitInt)
        self.trackTable.delegate = self
        self.trackTable.dataSource = self

        self.searchBar.placeholder = "Cari"
        self.searchBar.delegate = self
        self.searchBar.tintColor = UIColor.black
        self.searchBar.sizeToFit()
        self.navigationItem.titleView = searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getDefaultTrack(track: String, offset: Int, limit: Int) {
        SwiftOverlays.showBlockingWaitOverlay()
        trackService
            .getTrackByQuery(parameters: ConvertString().toPlusString(text: track), offset: offset, limit: limit)
            .subscribe(
                onNext: { trackResponse in
                    if offset == 0 && trackResponse.tracks?.items?.count != 0 {
                        self.rowData.removeAll()
                    }
                    if trackResponse.tracks?.items?.count != 0 {
                        self.rowData.append(contentsOf: (trackResponse.tracks?.items)!)
                        if ((trackResponse.tracks?.next) ?? "").isEmpty == false {
                            self.nextPage = (trackResponse.tracks?.next)!
                        } else {
                            self.nextPage = nil
                        }
                        self.nextInt = (trackResponse.tracks?.offset)! + 20
                        self.trackTable.reloadData()
                    } else {
                        let alert = UIAlertController(title: "Info", message: "Maaf, Data Tidak ditemukan :(", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    SwiftOverlays.removeAllBlockingOverlays()
                },
                onError: { error in
                    SwiftOverlays.removeAllBlockingOverlays()
                }
            )
            .addDisposableTo(disposeBag)
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.rowData.count - 1) {
            if (self.nextPage ?? "").isEmpty == false {
                self.getDefaultTrack(track: track, offset: nextInt, limit: 20)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TrackTableViewCell", owner: self, options: nil)?.first as! TrackTableViewCell

        cell.trackNameLabel.text = self.rowData[indexPath.row].name
        cell.artistNameLabel.text = ConvertString().fromArrayArtistToString(array: self.rowData[indexPath.row].artists!)
        cell.albumNameLabel.text = self.rowData[indexPath.row].album?.name

        let url = URL(string: (self.rowData[indexPath.row].album?.images?[0].url)!)
        cell.gambarAlbumImage.kf.indicatorType = .activity
        cell.gambarAlbumImage.kf.setImage(with: url)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.track = self.searchBar.text!
        self.nextInt = 0
        self.getDefaultTrack(track: self.track, offset: self.nextInt, limit: self.limitInt)
        self.searchBar.resignFirstResponder()
        self.searchBar.setShowsCancelButton(false, animated: true)
        self.searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = nil
        self.searchBar.setShowsCancelButton(false, animated: true)
        self.searchBar.resignFirstResponder()
    }
}
