import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Services.SystemTray
import Quickshell.Services.Pipewire
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData

            screen: modelData
            anchors.top: true
            anchors.left: true
            anchors.right: true
            implicitHeight: 30
            color: "#000000"

            PwObjectTracker {
                id: sinkTracker
                objects: Pipewire.defaultAudioSink ? [Pipewire.defaultAudioSink] : []
            }

            Component.onCompleted: {
                if (Pipewire.defaultAudioSink)
                    sinkTracker.objects = [Pipewire.defaultAudioSink]
                // Garante uma checagem inicial ao carregar a barra
                updateFocusedProcess()
            }

            property var defaultSink: sinkTracker.objects[0]
            property real volume: defaultSink?.audio?.volume ?? 0
            property bool muted: defaultSink?.audio?.muted ?? false

            Connections {
                target: Pipewire
                function onDefaultAudioSinkChanged() {
                    sinkTracker.objects = [Pipewire.defaultAudioSink]
                }
            }

            property int cpuUsage: 0
            property int ramUsage: 0
            property int diskUsage: 0
            property var lastCpuIdle: 0
            property var lastCpuTotal: 0

            property string fontFamily: "JetBrainsMono Nerd Font"
            
            property string currentProcessDisplay: ""

		Process {
		    id: inspectProc
		    command: ["bash", "-c", "active_pid=$(hyprctl activewindow -j | jq '.pid'); if [ ! -z \"$active_pid\" ] && [ \"$active_pid\" -gt 0 ]; then current_pid=$active_pid; while true; do child_pid=$(pgrep -P $current_pid | tail -n 1); if [ -z \"$child_pid\" ]; then break; fi; current_pid=$child_pid; done; if [ \"$current_pid\" != \"$active_pid\" ]; then ps -o comm= -p $current_pid 2>/dev/null; fi; fi"]
		    stdout: SplitParser {
			onRead: data => {
			    if (!data) return
			    var proc = data.trim()
			    
			    if (proc && proc !== "bash" && proc !== "zsh" && proc !== "fish" && proc !== "sudo") {
				currentProcessDisplay = proc === "nvim" ? "Neovim" : proc
			    } else {
				currentProcessDisplay = Hyprland.activeToplevel ? Hyprland.activeToplevel.title : ""
			    }
			}
		    }
		}
            Connections {
                target: Hyprland
                function onActiveToplevelChanged() {
                    updateFocusedProcess()
                }
            }

            function updateFocusedProcess() {
                var win = Hyprland.activeToplevel
                if (!win) {
                    currentProcessDisplay = ""
                    return
                }

                var appId = (win.appId ?? "").toLowerCase()
                var winClass = (win.className ?? "").toLowerCase()

                if (appId === "alacritty" || appId === "kitty" || appId === "foot" || appId === "wezterm" || appId === "ghostty" ||
                    winClass === "alacritty" || winClass === "kitty" || winClass === "foot") {
                    inspectProc.running = true
                } else {
                    currentProcessDisplay = win.title ?? ""
                }
            }

            Process {
                id: cpuProc
                command: ["sh", "-c", "head -1 /proc/stat"]
                stdout: SplitParser {
                    onRead: data => {
                        if (!data) return
                        var p = data.trim().split(/\s+/)
                        var idle = parseInt(p[4]) + parseInt(p[5])
                        var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
                        if (lastCpuTotal > 0)
                            cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
                        lastCpuTotal = total
                        lastCpuIdle = idle
                    }
                }
            }

            Process {
                id: ramProc
                command: ["sh", "-c", "free | grep Mem"]
                stdout: SplitParser {
                    onRead: data => {
                        if (!data) return
                        var p = data.trim().split(/\s+/)
                        var total = parseInt(p[1]) || 1
                        var used = parseInt(p[2]) || 0
                        ramUsage = Math.round(100 * used / total)
                    }
                }
            }

            Process {
                id: diskProc
                command: ["sh", "-c", "df / | tail -1"]
                stdout: SplitParser {
                    onRead: data => {
                        if (!data) return
                        var p = data.trim().split(/\s+/)
                        diskUsage = parseInt(p[4]) || 0
                    }
                }
            }

            Timer {
                interval: 2000
                running: true
                repeat: true
                triggeredOnStart: true
                onTriggered: {
                    cpuProc.running = true
                    ramProc.running = true
                    diskProc.running = true
                }
            }

            Text {
                id: clock
                anchors.centerIn: parent
                color: "#FFFFFF"
                font { pixelSize: 14; bold: true; family: fontFamily }
                text: Qt.formatDateTime(new Date(), "hh:mm, dd/MM")
                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: clock.text = Qt.formatDateTime(new Date(), "hh:mm, dd/MM")
                }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8

                Repeater {
                    model: 9
                    Text {
                        property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                        property bool hasWindows: ws !== undefined
                        property bool alwaysVisible: index < 5
                        visible: alwaysVisible || isActive || hasWindows
                        text: index + 1
                        color: isActive ? "#FFFFFF" : (hasWindows ? "#9f9f9f" : "#272727")
                        font { pixelSize: 14; bold: true; family: fontFamily }
                        rightPadding: 6
                        MouseArea {
                            anchors.fill: parent
                            onClicked: Hyprland.dispatch("workspace " + (index + 1))
                        }
                    }
                }

                Rectangle {
                    width: 1; height: 16; color: "#333333"
                    Layout.alignment: Qt.AlignVCenter
                }

                Text {
                    text: currentProcessDisplay
                    color: "#9f9f9f"
                    font { pixelSize: 12; family: fontFamily }
                    elide: Text.ElideRight
                    Layout.maximumWidth: 300
                }

                Item { Layout.fillWidth: true }

                Repeater {
                    model: SystemTray.items
                    Item {
                        width: 20
                        height: 20
                        Layout.alignment: Qt.AlignVCenter
                        Image {
                            anchors.centerIn: parent
                            source: modelData.icon
                            width: 16
                            height: 16
                            smooth: true
                        }
                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked: mouse => {
                                if (mouse.button === Qt.RightButton)
                                    modelData.showContextMenu(this, Qt.point(mouseX, mouseY))
                                else
                                    modelData.activate()
                            }
                        }
                    }
                }

                Rectangle {
                    width: 1; height: 16; color: "#333333"
                    Layout.alignment: Qt.AlignVCenter
                }

                RowLayout {
                    spacing: 8
                    Layout.alignment: Qt.AlignVCenter

                    Text {
                        text: " CPU " + cpuUsage + "%"
                        color: cpuUsage > 80 ? "#ff5555" : cpuUsage > 50 ? "#ffb86c" : "#9f9f9f"
                        font { pixelSize: 12; bold: true; family: fontFamily }
                    }

                    Rectangle { width: 1; height: 16; color: "#333333" }

                    Text {
                        text: " RAM " + ramUsage + "%"
                        color: ramUsage > 80 ? "#ff5555" : ramUsage > 50 ? "#ffb86c" : "#9f9f9f"
                        font { pixelSize: 12; bold: true; family: fontFamily }
                    }

                    Rectangle { width: 1; height: 16; color: "#333333" }

                    Text {
                        text: " DSK " + diskUsage + "%"
                        color: diskUsage > 80 ? "#ff5555" : diskUsage > 50 ? "#ffb86c" : "#9f9f9f"
                        font { pixelSize: 12; bold: true; family: fontFamily }
                    }
                }

                Rectangle {
                    width: 1; height: 16; color: "#333333"
                    Layout.alignment: Qt.AlignVCenter
                }

                RowLayout {
                    spacing: 4
                    Layout.alignment: Qt.AlignVCenter

                    Text {
                        text: muted ? "󰖁" : (volume > 0.5 ? "󰕾" : (volume > 0 ? "󰖀" : "󰕿"))
                        color: muted ? "#9f9f9f" : "#FFFFFF"
                        font { pixelSize: 14; family: fontFamily }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (defaultSink?.audio)
                                    defaultSink.audio.muted = !defaultSink.audio.muted
                            }
                        }
                    }

                    Item {
                        width: 60
                        height: 16
                        Layout.alignment: Qt.AlignVCenter

                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width; height: 3; radius: 2
                            color: "#333333"
                        }
                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            width: volume * parent.width; height: 3; radius: 2
                            color: "#FFFFFF"
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: mouse => {
                                if (defaultSink?.audio)
                                    defaultSink.audio.volume = Math.max(0, Math.min(1, mouse.x / parent.width))
                            }
                            onWheel: wheel => {
                                if (defaultSink?.audio) {
                                    var delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05
                                    defaultSink.audio.volume = Math.max(0, Math.min(1, volume + delta))
                                }
                            }
                        }
                    }

                    Text {
                        text: Math.round(volume * 100) + "%"
                        color: "#9f9f9f"
                        font { pixelSize: 12; bold: true; family: fontFamily }
                    }
                }
            }
        }
    }
}
