# 🛡️ Gemini Agent Guardrail, Performance & Grounding Harness

## 1. Git & Deployment Guardrails
- **NEVER** run `git push` or publish tags without explicit, written confirmation from the user in the current turn.
- Only prepare commits (`git add`, `git commit`) or create feature branches locally when requested.
- If changes need to be pushed, ask the user: "Would you like me to push these changes to remote [branch]?" and wait for confirmation.

## 2. 자료 검색 및 사실 기반 검증 (Grounding & Hallucination Prevention)
- **엄격한 근거 기반 응답 (Strict Grounding)**:
  - 모델 내부의 모호한 기억이나 사전 학습 가중치에 의존해 추측하지 말고, 검색 도구(Web Search, File Read 등)로 획득한 확인된 사실만 전달하십시오.
  - 자료에 명시되지 않은 세부 사항(버전 번호, API 인자, 실험 수치, 설정값 등)을 임의로 유추하거나 일반화(Extrapolation)하지 마십시오.
- **모름과 불확실성 명시 (Explicit Abstention)**:
  - 검색 결과에 필요한 정보가 불충분하거나 일치하는 내용이 없다면 그럴듯한 답변을 지어내지 말고 "제공된/검색된 자료에서 해당 내용에 대한 구체적인 근거를 확인할 수 없습니다"라고 솔직하게 명시하십시오.
- **출처 및 링크 날조 원천 금지 (No Fake Citations / URLs)**:
  - 검색 결과에 실제로 존재하는 URL, 논문 DOI, 공식 문서 경로만 인용하십시오. 존재하지 않는 링크나 가짜 논문 저자/제목을 절대 날조하지 마십시오.
  - 주요 주장이나 통계 수치 뒤에는 반드시 출처 링크나 문서명을 명시하십시오 (예: `[출처명](URL)`).
- **다단계 사실 검증 (Verification Before Output)**:
  - 답변을 확정하기 전, 원문의 문맥과 답변의 내용이 일치하는지 교차 검증하십시오.
  - 최신 정보를 다룰 때는 검색된 문서의 발행 일자와 기준 시점을 함께 명시하십시오.

## 3. 엔지니어링 표준 및 성능 하네스 (Engineering Standards & Performance Harness)

### (1) Self-Verification & TDD Loop (Strict)
- **Test First / Reproduce**: 버그 수정이나 새 로직 구현 시 가능한 한 재현 테스트 케이스를 먼저 작성하거나 식별하십시오.
- **Autonomous Verification**: 코드 수정 후 작업을 완료하기 전에 항상 관련 단위 테스트, 타입 체커(`tsc`, `mypy`, `pyright`, `dart analyze`, `cargo check` 등), 린터를 실행하여 자가 검증하십시오.
- **Self-Correction**: 테스트나 검증이 실패하면 에러 로그와 스택 트레이스를 분석하여 원인을 진단하고 모든 검사가 통과할 때까지 자가 교정하십시오. 실패하는 테스트를 절대 무시하지 마십시오.

### (2) Minimal & Surgical Edits
- 변경 사항은 사용자가 요청한 목표에만 엄격히 집중하십시오.
- 요청받지 않은 파일을 임의로 리팩토링하거나, 관련 없는 코드를 재포맷팅하거나, 불필요한 의존성을 추가하지 마십시오.

### (3) Think and Plan First
- 3개 이상의 다중 파일 수정이나 비자명한 변경 시에는 실행 전 단계별 계획을 먼저 수립하십시오.
- 모호한 요구사항이나 위험도가 높은 설계 결정은 사전에 사용자와 명확히 확인하십시오.

### (4) Preservation of Code Integrity
- 사용자가 명시적으로 수정을 지시하지 않는 한, 기존 주석, 독스트링, API 규격을 보존하십시오.

### (5) Generator-Critic / Adversarial Review Loop
- **Adversarial Self-Review**: 코드 변경을 완료하기 전, 확증 편향을 피하기 위해 비평가(Critic) 관점에서 `git diff`를 자가 검토하십시오.
- **Critic Checklist**:
  1. **Security & Safety**: 취약점, 미검증 입력값, 시크릿 유출, 경쟁 상태 점검
  2. **Edge Cases & Error Handling**: null/undefined 처리, 경계값 조건, 예외 전파 확인
  3. **Regression & Side Effects**: 의존 컴포넌트나 기존 동작이 깨지지 않았는지 확인
  4. **Diff Cleanliness**: 임시 디버그 로그, 불필요한 print문, 실수로 들어간 포맷팅 정리
- **Subagent Delegation**: 대규모 또는 고위험 리팩토링의 경우 독립적인 리뷰 서브에이전트에게 diff 분석을 위임하십시오.

### (6) Reflexion & Episodic Memory (Continuous Learning)
- **Post-Failure Self-Critique**: 특정 접근법이 실패하거나 미묘한 버그, 프로젝트 특이점(Gotcha)을 만났을 경우 원인과 해결책을 `.gemini/knowledge/` 또는 `learned_patterns.md`에 간결히 기록하십시오.
- **Anti-Pattern Prevention**: 솔루션을 시도하기 전에 기존 프로젝트 기록을 확인하여 과거에 실패한 접근 방식이나 호환되지 않는 API를 반복하지 마십시오.
- **Continuous Rule Evolution**: 새로 발견된 워크스페이스 특이점이나 빌드 환경 설정, 사용자 선호도를 지속적으로 업데이트하여 다음 세션에 반영하십시오.

## 4. 둠 루프 차단 및 복구 사다리 (Anti-Doom Loop & Recovery Ladder)
- **반복 실패 감지 (Tool Call Fingerprinting)**: 동일한 오류나 테스트 실패가 2회 연속 발생하면 같은 방식의 수정을 반복하는 것을 즉시 중단하십시오.
- **가설 전환 및 피벗 (Hypothesis Pivot)**: 단순 땜질식 코드 변경을 멈추고, 실패 원인을 원점에서 재분석하여 완전히 다른 접근 전략(Alternative Path)을 채택하십시오.
- **인간 개입 요청 (Ask-User Fallback)**: 3회 이상 자가 교정에 실패하거나 근본적인 설계 모순/환경 문제가 발생한 경우, 무한 시도를 중단하고 현재 상태, 시도한 해결책, 막힌 이유를 명확히 사용자에게 보고하고 조언을 구하십시오.

## 5. 컨텍스트 순도 유지 (Context Hygiene & Anti-Rot)
- **로그 슬라이싱 (Log Truncation)**: 수백 줄의 빌드 로그, 터미널 출력, 스택 트레이스 전체를 컨텍스트에 쏟아붓지 말고, 실패를 유발한 핵심 오류 라인과 직전/직후 컨텍스트(약 10~20줄)만 선별적으로 추출하여 분석하십시오.
- **심볼 및 정의부 중심 탐색**: 대용량 파일을 전체 읽지 말고, 함수/클래스 인터페이스, 타입 시그니처, 필요한 라인 범위(`StartLine`/`EndLine`)를 먼저 특정하여 로드함으로써 'Lost in the Middle' 컨텍스트 오염을 차단하십시오.

## 6. 기계적 완료 검증 (Deterministic Exit Contract)
- 에이전트의 주관적인 판단으로 작업을 "완료" 처리하지 마십시오.
- 작업을 마무리하고 사용자에게 보고하기 전, 반드시 다음 3가지 기계적 증거를 통과해야 합니다:
  1. `git diff`를 실행하여 의도하지 않은 변경이나 임시 디버그 코드가 남아있지 않은지 확인
  2. 컴파일러/타입 체커(`tsc`, `mypy`, `dart analyze`, `cargo check` 등) 및 린터 에러 0건 확인
  3. 관련 단위 테스트/통합 테스트의 정상 통과(Green) 확인
