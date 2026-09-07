# 🛡️ Gemini Agent Performance & Guardrail Harness

AI 코딩 에이전트의 개발 성능을 극대화하고 예기치 않은 돌발 행동(임의 `git push` 등)을 방지하는 표준 하네스(Harness) 저장소입니다.

## 📋 포함된 하네스 규칙

1. **Git & Deployment Guardrails**: 사용자의 명시적 승인 없는 `git push` 및 태그 발행 원천 차단
2. **Self-Verification & TDD Loop**: 코드 수정 후 단위 테스트, 타입 체커, 린터 자가 검증 및 자동 에러 수정
3. **Minimal & Surgical Edits**: 요청 범위 외 불필요한 코드 리팩토링 및 포맷팅 변경 방지
4. **Think & Plan First**: 다중 파일 변경 시 단계별 구현 계획 사전 수립
5. **Generator-Critic / Adversarial Review Loop**: 완료 전 `git diff` 비평가 관점 자가 검토 및 보안/경계값 검증
6. **Reflexion & Episodic Memory**: 실패 원인 및 프로젝트 함정(Gotchas) 기록을 통한 반복 실수 방지 및 지속적 학습
7. **Grounding & Hallucination Prevention**: 자료 검색 시 엄격한 근거 기반 응답, 모름/불확실성 솔직한 명시, 가짜 출처(URL/논문) 날조 방지 및 다단계 사실 검증

## 🚀 다른 컴퓨터에서 사용하는 방법

새로운 컴퓨터에서 이 저장소를 클론한 후 설치 스크립트를 실행하면 전역 설정으로 자동 적용됩니다.

### Linux / macOS
```bash
# 1. 저장소 클론
git clone git@github.com:shinjju1209/GEMINI-HARNESS.git ~/GEMINI-HARNESS

# 2. 전역 설정 설치 (~/.gemini/config/ 에 자동 복사)
cd ~/GEMINI-HARNESS && ./install.sh
```

### Windows (PowerShell)
```powershell
# 1. 저장소 클론
git clone https://github.com/shinjju1209/GEMINI-HARNESS.git ~/GEMINI-HARNESS

# 2. 전역 설정 설치
cd ~/GEMINI-HARNESS
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

### 특정 프로젝트에만 개별 적용하고 싶을 때
해당 프로젝트의 루트 폴더에 `GEMINI.md` 또는 `AGENTS.md` 파일을 복사해 두면 프로젝트 단위로 우선 적용됩니다.

### Git Hook (물리적 Push 차단) 활성화
작업 중인 프로젝트의 `.git/hooks/pre-push`로 샘플 훅을 복사합니다:
```bash
cp hooks/pre-push.sample /path/to/project/.git/hooks/pre-push
chmod +x /path/to/project/.git/hooks/pre-push
```
