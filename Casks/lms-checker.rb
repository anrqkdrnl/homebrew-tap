cask "lms-checker" do
  version "2.2.0"
  sha256 "cfd27cfc44c5b1523e776787184990f9d584fc0b9420b8809cbfdf9aa0b0ae8d"

  url "https://github.com/anrqkdrnl/hyu-lms-checker/releases/download/v#{version}/LMSChecker.zip"
  name "LMS 체커"
  desc "Hanyang LMS unfinished lectures and assignments checker"
  homepage "https://github.com/anrqkdrnl/hyu-lms-checker"

  depends_on macos: :sonoma

  app "LMS 체커.app"

  # 애플 공증을 받지 않은 앱이라 Gatekeeper 격리 속성을 제거합니다.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/LMS 체커.app"],
        must_succeed: false
  end

  # 자동 실행(LaunchAgent)은 업데이트 때 지우지 않음: 앱이 삭제되면 스스로 등록을 정리함
  uninstall quit: "io.github.anrqkdrnl.lmschecker"

  zap launchctl: "io.github.anrqkdrnl.lmschecker.auto",
      trash:     [
        "~/Library/Application Support/LMS 체커",
        "~/Library/Preferences/io.github.anrqkdrnl.lmschecker.plist",
      ]

  caveats <<~EOS
    처음 실행하면 설정 마법사가 열립니다.
    키체인에 저장된 계정 정보는 삭제되지 않습니다. 완전히 지우려면:
      security delete-generic-password -s hyu-lms-id
      security delete-generic-password -s hyu-lms-pw
  EOS
end
