//
//  AudioBannerViewPresenter.swift
//  Quran
//
//  Created by Mohamed Afifi on 5/8/16.
//  Copyright © 2016 Quran.com. All rights reserved.
//



protocol AudioBannerViewPresenterDelegate: class {
    func showQariListSelectionWithQari(qaris: [Qari], selectedIndex: Int)
    func highlightAyah(ayah: AyahNumber)
    func removeHighlighting()
    func currentPage() -> QuranPage?
}

protocol AudioBannerViewPresenter: AudioBannerViewDelegate {

    weak var delegate: AudioBannerViewPresenterDelegate? { get set }
    weak var view: AudioBannerView? { get set }

    func onViewDidLoad()
    func setQariIndex(index: Int)
}
