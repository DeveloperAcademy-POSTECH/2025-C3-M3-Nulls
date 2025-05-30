import ProjectDescription

let project = Project(
    name: "Projects",
    targets: [
        .target(
            name: "Medimo",
            destinations: .iOS,
            product: .app,
            bundleId: "org.nulls.Medimo",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Medimo/Sources/**"],
            resources: [
                "Medimo/Resources/**",
                "Medimo/Resources/**/*.xcdatamodeld"
            ],
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
