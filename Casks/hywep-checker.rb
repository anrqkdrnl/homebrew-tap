cask "hywep-checker" do
  version "2.2.0"
  sha256 "5bd2f4b2c705d0ff1f94561ca64c64141d943995a16d5762e57dd9bf473c4e86"

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

  # 자동 실행(LaunchAgent)은 업데이트 때 지우지 않음: 앱이 삭제되면 스스로 등록을 정리함
  uninstall quit: "com.seongsu.hywepchecker"

  zap launchctl: "com.seongsu.hywepchecker.auto",
      trash:     [
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
