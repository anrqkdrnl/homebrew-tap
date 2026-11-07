cask "lms-checker" do
  version "2.0.0"
  sha256 "0c537be434a747b3497213478cf74845c8c3e981aabda8f1ec538993b4609dd9"

  url "https://github.com/anrqkdrnl/hyu-lms-checker/releases/download/v#{version}/LMSChecker.zip"
  name "LMS 체커"
  desc "Hanyang LMS unfinished lectures and assignments checker"
  homepage "https://github.com/anrqkdrnl/hyu-lms-checker"

  depends_on macos: ">= :sonoma"

  app "LMS 체커.app"

  # 애플 공증을 받지 않은 앱이라 Gatekeeper 격리 속성을 제거합니다.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/LMS 체커.app"],
                   must_succeed: false
  end

  uninstall launchctl: "com.seongsu.lmschecker.auto",
            quit:      "com.seongsu.lmschecker",
            delete:    "~/Library/LaunchAgents/com.seongsu.lmschecker.auto.plist"

  zap trash: [
    "~/Library/Application Support/LMS 체커",
    "~/Library/Preferences/com.seongsu.lmschecker.plist",
  ]

  caveats <<~EOS
    처음 실행하면 설정 마법사가 열립니다.
    키체인에 저장된 계정 정보는 삭제되지 않습니다. 완전히 지우려면:
      security delete-generic-password -s hyu-lms-id
      security delete-generic-password -s hyu-lms-pw
  EOS
end
