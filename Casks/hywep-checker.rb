cask "hywep-checker" do
  version "2.4.0"
  sha256 "37aa410efcc981256d2d198a460b8c313cead8bc5e5d3d06447134c96f8811f0"

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
  uninstall quit: "io.github.anrqkdrnl.hywepchecker"

  zap launchctl: "io.github.anrqkdrnl.hywepchecker.auto",
      trash:     [
        "~/Library/Application Support/HY-WEP 체커",
        "~/Library/Preferences/io.github.anrqkdrnl.hywepchecker.plist",
      ]

  caveats <<~EOS
    처음 실행하면 설정 마법사가 열립니다.
    키체인에 저장된 계정 정보는 삭제되지 않습니다. 완전히 지우려면:
      security delete-generic-password -s hyu-portal-id
      security delete-generic-password -s hyu-portal-pw
  EOS
end
