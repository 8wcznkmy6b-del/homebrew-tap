cask "aurasnap" do
  version "3.2.147"
  sha256 "320b57125f0b7e7197536347676d3a0ea591510a8a1f11423318693b1cb1da55"

  url "https://github.com/8wcznkmy6b-del/AuraSnap-PB/releases/download/v#{version}/AuraSnap-#{version}.dmg"
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

  # 应用为自签名、未经公证：去掉下载隔离标记，否则首次打开会被门禁拦下。
  # 在暂存目录里去掉、再由 Homebrew 移进「应用程序」：不改 /Applications 里的应用，不会碰到「App 管理」权限拦截。
  # *_steps 是 Homebrew 7 起的声明式写法 (旧的 Ruby postflight 块已弃用)，Homebrew 安装前默认会先自动更新自身。
  preflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/AuraSnap.app"]
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
