/*
    SPDX-FileCopyrightText: 2014 Marco Martin <mart@kde.org>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

import QtQuick
import QtQuick.Controls
import org.kde.kirigami 2 as Kirigami

Rectangle {
    id: root
    color: "#151515"

    property int stage

    onStageChanged: {
        if (stage == 2) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        Image {
            id: logo
            //match SDDM/lockscreen avatar positioning
            readonly property real size: Kirigami.Units.gridUnit * 8
            anchors.centerIn: parent

            asynchronous: true
            source: "images/kalpa-logo.svgz"
            sourceSize.width: size
            sourceSize.height: size
        }

        // Image {
        //     id: busyIndicator
        //     //in the middle of the remaining space
        //     y: parent.height - (parent.height - logo.y) / 1.5 - height/2
        //     anchors.horizontalCenter: parent.horizontalCenter
        //     asynchronous: true
        //     source: "images/busywidget.svgz"
        //     sourceSize.height: Kirigami.Units.gridUnit * 2
        //     sourceSize.width: Kirigami.Units.gridUnit * 2
        //     RotationAnimator on rotation {
        //         id: rotationAnimator
        //         from: 0
        //         to: 360
        //         // Not using a standard duration value because we don't want the
        //         // animation to spin faster or slower based on the user's animation
        //         // scaling preferences; it doesn't make sense in this context
        //         duration: 1500 // Specify how fast do we want the spinner to be. The lower the value, the faster it spins.
        //         loops: Animation.Infinite
        //         // Don't want it to animate at all if the user has disabled animations
        //         running: Kirigami.Units.longDuration > 1
        //     }
        // }

        ProgressBar {
            id: progressBar
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.2
            indeterminate: true
            y: parent.height - (parent.height - logo.y) / 1.5 - height / 2
        }

        Row {
            spacing: Kirigami.Units.largeSpacing
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                margins: Kirigami.Units.gridUnit
            }
            Text {
                color: "#ffffff"
                // Work around Qt bug where NativeRendering breaks for non-integer scale factors
                // https://bugreports.qt.io/browse/QTBUG-67007
                // renderType: Screen.devicePixelRatio % 1 !== 0 ? Text.QtRendering : Text.NativeRendering
                font.pixelSize: Kirigami.Units.gridUnit * 1
                text: "Kalpa Desktop made by Kalpa contributors"
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: Kirigami.Units.veryLongDuration * 2
        easing.type: Easing.InOutQuad
    }
}
