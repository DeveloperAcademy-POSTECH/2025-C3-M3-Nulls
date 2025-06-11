//
//  VolumeHelper.swift
//  Projects
//
//  Created by 이서현 on 6/11/25.
//

import AVFAudio

struct VolumeHelper {
    static func checkVolumeAndPlay(
        spelling: String?,
        onTooLowVolume: @escaping () -> Void,
        onSuccess: @escaping () -> Void
    ) {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(true)
        } catch {
            onTooLowVolume()
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let volume = session.outputVolume
            if volume < 0.05 {
                onTooLowVolume()
            } else {
                if let spelling = spelling {
                    DictionaryDetailViewModel.sharedSpeak(spelling)
                }
                onSuccess()
            }
        }
    }
}
