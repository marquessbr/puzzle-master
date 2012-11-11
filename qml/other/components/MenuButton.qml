
// This file is part of Puzzle Master, a fun and addictive jigsaw puzzle game.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
//
// Copyright (C) 2010-2011, Timur Kristóf <venemo@fedoraproject.org>

import QtQuick 1.1
import "./style"

Button {
    text: ""

    Rectangle {
        color: "#fff"
        height: 3
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            leftMargin: 16
            rightMargin: 16
            verticalCenterOffset: -10
        }
    }

    Rectangle {
        color: "#fff"
        height: 3
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            leftMargin: 16
            rightMargin: 16
        }
    }

    Rectangle {
        color: "#fff"
        height: 3
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            leftMargin: 16
            rightMargin: 16
            verticalCenterOffset: 10
        }
    }
}
