cask "aurasnap" do
  version "3.2.138"
  sha256 "87d4a2ea57b5e6dbec0503e148eaf46273191f63ff7ba08dbef4fa5dbb0eb8f9"

  url "https://github.com/8wcznkmy6b-del/AuraSnap-PB/releases/download/v#{version}/AuraSnap-#{version}.dmg",
      verified: "github.com/8wcznkmy6b-del/AuraSnap-PB/"
  name "AuraSnap"
  desc "Screenshot, annotation, OCR, screen recording and clipboard manager"
  homepage "https://aurasnapapp.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "AuraSnap.app"

  # 应用为自签名、未经公证：去掉下载隔离标记，否则首次打开会被门禁拦下
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/AuraSnap.app"]
  end

  uninstall quit: "com.dochi.AuraSnap"

  zap trash: [
    "~/Library/Application Support/AuraSnap",
    "~/Library/Caches/AuraSnap",
    "~/Library/Caches/com.dochi.AuraSnap",
    "~/Library/Containers/com.dochi.AuraSnap.FinderSync",
    "~/Library/Group Containers/group.com.dochi.AuraSnap",
    "~/Library/HTTPStorages/com.dochi.AuraSnap",
    "~/Library/Logs/AuraSnap",
    "~/Library/Preferences/com.dochi.AuraSnap.plist",
  ]
end
