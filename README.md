# anrqkdrnl/homebrew-tap

한양대학교 학생용 맥 앱을 [Homebrew](https://brew.sh)로 설치할 수 있게 해주는 tap입니다.

| 앱 | 설명 | 설치 |
|---|---|---|
| [LMS 체커](https://github.com/anrqkdrnl/hyu-lms-checker) | LMS 미완료 강의·미제출 과제 확인 | `brew install --cask anrqkdrnl/tap/lms-checker` |
| [HY-WEP 체커](https://github.com/anrqkdrnl/hywep-checker) | HY-WEP 새 현장실습 공고 확인 | `brew install --cask anrqkdrnl/tap/hywep-checker` |

```sh
# 업데이트
brew upgrade --cask lms-checker hywep-checker

# 삭제 (앱 + 자동 실행 해제)
brew uninstall --cask lms-checker
# 앱 데이터까지 삭제
brew uninstall --zap --cask lms-checker
```

macOS 14 (Sonoma) 이상, Apple Silicon·Intel 모두 지원합니다.
