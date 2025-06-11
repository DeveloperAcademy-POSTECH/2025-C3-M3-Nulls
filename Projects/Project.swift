import ProjectDescription

let project = Project(
    name: "Projects",
    options: .options(
        defaultKnownRegions: ["ko"],
        developmentRegion: "ko"
    ),
    targets: [
        .target(
            name: "Medimo",
            destinations: .iOS,
            product: .app,
            bundleId: "org.nulls.medimo",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UIUserInterfaceStyle": "Light",
                    "UISupportedInterfaceOrientations": [
                        "UIInterfaceOrientationPortrait",
                    ],
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                    "UIAppFonts": [
                        "GmarketSansBold.otf",
                        "GmarketSansMedium.otf",
                        "SCDream5.otf",
                        "SCDream6.otf",
                        "SCDream7.otf",
                    ],
                    "UIBackgroundModes": ["remote-notification"],
                ]
            ),
            sources: ["Medimo/Sources/**"],
            resources: [
                "Medimo/Resources/**",
                "Medimo/Resources/**/*.xcdatamodeld",
            ],
            entitlements: "Medimo/Medimo.entitlements",
            dependencies: []
        ),
        .target(
            name: "MedimoTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "org.nulls.MedimoTests",
            infoPlist: .default,
            sources: ["Medimo/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Medimo")]
        ),
    ]
)
