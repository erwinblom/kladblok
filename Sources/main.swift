import AppKit

let red = NSColor(srgbRed: 225/255, green: 6/255, blue: 0, alpha: 1)
final class TargetLogo: NSView {
    override func draw(_ dirtyRect: NSRect) {
        let scale = min(bounds.width, bounds.height) / 320
        NSColor(srgbRed: 10/255, green: 10/255, blue: 10/255, alpha: 1).setFill()
        for r in [NSRect(x:135,y:0,width:50,height:110), NSRect(x:135,y:210,width:50,height:110), NSRect(x:0,y:135,width:110,height:50), NSRect(x:210,y:135,width:110,height:50)] {
            NSRect(x:r.minX*scale,y:r.minY*scale,width:r.width*scale,height:r.height*scale).fill()
        }
        red.setFill(); NSBezierPath(ovalIn: NSRect(x:131*scale,y:131*scale,width:58*scale,height:58*scale)).fill()
    }
}
final class App: NSObject, NSApplicationDelegate, NSTextViewDelegate, NSTextFieldDelegate, NSWindowDelegate {
    var status: NSStatusItem!
    var window: NSWindow!
    var escapeMonitor: Any?
    let destination = NSPopUpButton(frame:.zero, pullsDown:false)
    var saveButton: NSButton!
    let editor = NSTextView()
    let noteTitle = NSTextField()
    var noteID = "fmt-klad-" + UUID().uuidString.lowercased()
    var draftFile: URL { file.deletingLastPathComponent().appendingPathComponent("kladblok.json") }
    let info = NSTextField(labelWithString: "")
    let file = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0].appendingPathComponent("FMT Kladblok Open Source/kladblok.txt")
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        let menu = NSMenu()
        let appMenu = NSMenuItem(); menu.addItem(appMenu)
        appMenu.submenu = NSMenu()
        let hideItem = appMenu.submenu!.addItem(withTitle: "Verberg FMT Kladblok", action: #selector(hideWindow), keyEquivalent: "h")
        hideItem.target = self
        appMenu.submenu?.addItem(withTitle: "Stop FMT Kladblok", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        let edit = NSMenuItem(); menu.addItem(edit); edit.submenu = NSMenu(title: "Wijzig")
        for (title, action, key) in [("Herstel", "undo:", "z"), ("Knip", "cut:", "x"), ("Kopieer", "copy:", "c"), ("Plak", "paste:", "v"), ("Selecteer alles", "selectAll:", "a")] {
            edit.submenu?.addItem(withTitle: title, action: Selector(action), keyEquivalent: key)
        }
        NSApp.mainMenu = menu
        if !UserDefaults.standard.bool(forKey: "menuVisibilityRepairV1") {
            UserDefaults.standard.set(0, forKey: "NSStatusItem Preferred Position FMT Kladblok")
            UserDefaults.standard.set(true, forKey: "NSStatusItem Visible FMT Kladblok")
            UserDefaults.standard.set(true, forKey: "menuVisibilityRepairV1")
        }
        status = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        status.autosaveName = "FMT Kladblok"
        status.isVisible = true
        status.button?.title = ""
        status.button?.imagePosition = .imageLeading
        status.button?.font = NSFont.systemFont(ofSize: 12, weight: .semibold)
        status.button?.setAccessibilityLabel("FMT Kladblok — papier met pen")
        status.button?.image = NSImage(systemSymbolName: "square.and.pencil", accessibilityDescription: "FMT Kladblok")
        status.button?.toolTip = "FMT Kladblok — klik om te schrijven"
        status.button?.target = self; status.button?.action = #selector(toggle)
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 620, height: 540), styleMask: [.titled, .closable, .resizable, .miniaturizable], backing: .buffered, defer: false)
        window.title = "FMT Kladblok"; window.minSize = NSSize(width: 580, height: 420)
        window.isReleasedWhenClosed = false; window.delegate = self; window.center()
        window.backgroundColor = NSColor(srgbRed: 0.977, green: 0.973, blue: 0.961, alpha: 1)
        window.appearance = NSAppearance(named: .aqua)
        let root = window.contentView!
        let logo = TargetLogo()
        logo.setAccessibilityLabel("Fast Moving Targets logo")
        let brand = NSTextField(labelWithString: "FAST MOVING TARGETS")
        brand.font = NSFont(name: "Arial-BoldMT", size: 10)
        let title = NSTextField(labelWithString: "FMT KLADBLOK")
        title.font = NSFont(name: "Arial-BoldMT", size: 25)
        title.textColor = red
        let subtitle = NSTextField(labelWithString: "Eén plek voor even. Plak of schrijf maar.")
        subtitle.font = NSFont(name: "Arial", size: 13); subtitle.textColor = .secondaryLabelColor
        let scroll = NSScrollView(); scroll.hasVerticalScroller = true
        scroll.borderType = .noBorder; scroll.wantsLayer = true; scroll.layer?.borderWidth = 2; scroll.layer?.borderColor = NSColor.black.cgColor
        editor.isRichText = false; editor.allowsUndo = true; editor.font = NSFont(name: "Arial", size: 17)
        editor.textContainerInset = NSSize(width: 18, height: 18)
        editor.isVerticallyResizable = true; editor.isHorizontallyResizable = false
        editor.autoresizingMask = [.width]; editor.textContainer?.widthTracksTextView = true
        editor.minSize = .zero; editor.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        editor.delegate = self; editor.string = (try? String(contentsOf: file, encoding: .utf8)) ?? ""
        noteTitle.placeholderString = "Titel van je klad"; noteTitle.font = NSFont(name: "Arial", size: 16)
        noteTitle.delegate = self; noteTitle.setAccessibilityLabel("Titel van je klad")
        if let data = try? Data(contentsOf: draftFile), let draft = try? JSONSerialization.jsonObject(with: data) as? [String:String] {
            editor.string = draft["body"] ?? editor.string; noteTitle.stringValue = draft["title"] ?? ""
            noteID = draft["id"] ?? noteID
        }
        scroll.documentView = editor
        destination.addItems(withTitles:["Tekstbestand"])
        destination.selectItem(at:0); destination.setAccessibilityLabel("Bewaar als tekst")
        let online = button("Bewaar als tekst", #selector(saveOnline)); saveButton = online
        let copy = button("Kopieer alles", #selector(copyAll)); let clear = button("Wis", #selector(clearNote))
        let hide = button("Verberg", #selector(hideWindow)); let quit = button("Stop", #selector(quitApp))
        copy.contentTintColor = red
        info.lineBreakMode = .byWordWrapping; info.maximumNumberOfLines = 3
        info.font = NSFont(name: "Arial", size: 11); info.textColor = .secondaryLabelColor
        for view in [logo, brand, title, subtitle, noteTitle, scroll, destination, online, copy, clear, hide, quit, info] { view.translatesAutoresizingMaskIntoConstraints = false; root.addSubview(view) }
        NSLayoutConstraint.activate([
            logo.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 24), logo.topAnchor.constraint(equalTo: root.topAnchor, constant: 24), logo.widthAnchor.constraint(equalToConstant: 44), logo.heightAnchor.constraint(equalToConstant: 44),
            title.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 14), title.topAnchor.constraint(equalTo: root.topAnchor, constant: 20),
            brand.leadingAnchor.constraint(equalTo: title.leadingAnchor), brand.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2),
            subtitle.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 24), subtitle.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 15),
            noteTitle.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 16), noteTitle.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 24), noteTitle.trailingAnchor.constraint(equalTo: root.trailingAnchor, constant: -24), noteTitle.heightAnchor.constraint(equalToConstant: 32),
            scroll.topAnchor.constraint(equalTo: noteTitle.bottomAnchor, constant: 12), scroll.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 24), scroll.trailingAnchor.constraint(equalTo: root.trailingAnchor, constant: -24),
            online.topAnchor.constraint(equalTo: scroll.bottomAnchor, constant: 14), online.leadingAnchor.constraint(equalTo: destination.trailingAnchor, constant:12),
            destination.leadingAnchor.constraint(equalTo: scroll.leadingAnchor), destination.centerYAnchor.constraint(equalTo: online.centerYAnchor), destination.widthAnchor.constraint(equalToConstant:110),
            copy.topAnchor.constraint(equalTo: online.bottomAnchor, constant: 10), copy.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 24),
            clear.leadingAnchor.constraint(equalTo: copy.trailingAnchor, constant: 10), clear.centerYAnchor.constraint(equalTo: copy.centerYAnchor),
            quit.trailingAnchor.constraint(equalTo: scroll.trailingAnchor), quit.centerYAnchor.constraint(equalTo: copy.centerYAnchor), hide.trailingAnchor.constraint(equalTo: quit.leadingAnchor, constant: -8), hide.centerYAnchor.constraint(equalTo: copy.centerYAnchor),
            info.topAnchor.constraint(equalTo: copy.bottomAnchor, constant: 12), info.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 24), info.bottomAnchor.constraint(equalTo: root.bottomAnchor, constant: -18), info.trailingAnchor.constraint(equalTo: scroll.trailingAnchor)
        ])
        escapeMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            guard let self = self, event.keyCode == 53, event.window === self.window,
                  self.window.attachedSheet == nil, NSApp.modalWindow == nil else { return event }
            self.hideWindow(); return nil
        }
        updateInfo(); show()
    }
    func button(_ title: String, _ action: Selector) -> NSButton { let b = NSButton(title: title, target: self, action: action); b.bezelStyle = .rounded; b.font = NSFont(name: "Arial-BoldMT", size: 13); return b }
    func show() { NSApp.activate(ignoringOtherApps: true); window.makeKeyAndOrderFront(nil); window.makeFirstResponder(editor) }
    @objc func toggle() { if window.isVisible && NSApp.isActive { window.orderOut(nil) } else { show() } }
    @objc func hideWindow() { window.orderOut(nil) }
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool { show(); return false }
    @objc func quitApp() { NSApp.terminate(nil) }
    func windowShouldClose(_ sender: NSWindow) -> Bool { sender.orderOut(nil); return false }
    func updateInfo() { info.stringValue = "\(editor.string.count) tekens · Automatisch lokaal bewaard" }
    @discardableResult func save() -> Bool {
        do { try FileManager.default.createDirectory(at: file.deletingLastPathComponent(), withIntermediateDirectories: true); let data = try JSONSerialization.data(withJSONObject: ["id": noteID, "title": noteTitle.stringValue, "body": editor.string], options: [.sortedKeys])
            try data.write(to: draftFile, options: .atomic); updateInfo(); return true }
        catch { info.stringValue = "Bewaren mislukt — kopieer je tekst voor je afsluit"; return false }
    }
    func textDidChange(_ notification: Notification) { save() }
    func controlTextDidChange(_ obj: Notification) { save() }
    @objc func saveOnline() {
        guard save() else { return }
        let panel = NSSavePanel()
        panel.nameFieldStringValue = "Klad.txt"
        panel.title = "Bewaar je klad als tekst"
        guard panel.runModal() == .OK, let url = panel.url else { return }
        do {
            let text = [noteTitle.stringValue, editor.string].filter { !$0.isEmpty }.joined(separator: "\n\n")
            try text.write(to: url, atomically: true, encoding: .utf8)
            guard try String(contentsOf: url, encoding: .utf8) == text else { throw NSError(domain: "FMT", code: 1) }
            info.stringValue = "Tekstbestand bewaard · " + url.lastPathComponent
        } catch { info.stringValue = "Tekstbestand bewaren mislukt · je klad blijft lokaal" }
    }

    @objc func copyAll() { NSPasteboard.general.clearContents(); NSPasteboard.general.setString([noteTitle.stringValue, editor.string].filter { !$0.isEmpty }.joined(separator: "\n\n"), forType: .string); info.stringValue = "Alles gekopieerd · \(editor.string.count) tekens" }
    @objc func clearNote() {
        guard !editor.string.isEmpty || !noteTitle.stringValue.isEmpty else { return }
        let alert = NSAlert(); alert.messageText = "Kladblok leegmaken?"; alert.informativeText = "De gewiste tekst kun je tijdens deze sessie herstellen met ⌘Z. De titel wordt niet hersteld."; alert.addButton(withTitle: "Wis tekst"); alert.addButton(withTitle: "Annuleer")
        guard alert.runModal() == .alertFirstButtonReturn else { return }
        destination.selectItem(at:0)
        noteTitle.stringValue = ""; noteID = "fmt-klad-" + UUID().uuidString.lowercased()
        let range = NSRange(location: 0, length: editor.string.utf16.count)
        if editor.shouldChangeText(in: range, replacementString: "") { editor.replaceCharacters(in: range, with: ""); editor.didChangeText() }
        window.makeFirstResponder(editor)
    }
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply { save() ? .terminateNow : .terminateCancel }
}
let app = NSApplication.shared
let delegate = App(); app.delegate = delegate
app.run()
