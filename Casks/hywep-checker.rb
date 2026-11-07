cask "hywep-checker" do
  version "2.0.0"
  sha256 "26a8a306fd1a4f26dfd17759217f2994e4f681eaf34a95d537d7fd331a8eaa58"

  url "https://github.com/anrqkdrnl/hywep-checker/releases/download/v#{version}/HywepChecker.zip"
  name "HY-WEP 체커"
  desc "Hanyang HY-WEP new internship posting checker"
  homepage "https://github.com/anrqkdrnl/hywep-checker"

  depends_on macos: :sonoma

  app "HY-WEP 체커.app"

  # 애플 공증을 받지 않은 앱이라 Gatekeeper 격리 속성을 제거합니다.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/HY-WEP 체커.app"],
        must_succeed: false
  end

  uninstall launchctl: "com.seongsu.hywepchecker.auto",
            quit:      "com.seongsu.hywepchecker"

  zap trash: [
    "~/Library/Application Support/HY-WEP 체커",
    "~/Library/Preferences/com.seongsu.hywepchecker.plist",
  ]

  caveats <<~EOS
    처음 실행하면 설정 마법사가 열립니다.
    키체인에 저장된 계정 정보는 삭제되지 않습니다. 완전히 지우려면:
      security delete-generic-password -s hyu-portal-id
      security delete-generic-password -s hyu-portal-pw
  EOS
end
